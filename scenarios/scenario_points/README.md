---
title: Scenario Points
category: Scenarios
tags:
  - scenario-points
  - ai
  - tasks
  - seating
  - world
framework:
  - redm
difficulty: intermediate
last_updated: 2026-10-29
sources:
  - C:/Users/Forza/AppData/Local/RedM/RedM.app/citizen/scripting/lua/rdr3_universal.lua
  - C:/Users/Forza/AppData/Local/RedM/RedM.app/citizen/clr2/lib/mono/4.5/v2/Native/ref/CitizenFX.RedM.Native.xml
  - https://github.com/alloc8or/rdr3-nativedb-data
  - https://github.com/Halen84/RDR3-Native-Flags-And-Enums
  - https://github.com/femga/rdr3_discoveries
  - C:/redmWorkspace/txData/VORPCore_E22B79.base/resources/[VORP]/vorp_barbershop/client/client.lua
  - C:/redmWorkspace/txData/VORPCore_E22B79.base/resources/[forza]/coi_art_rob/client/client.lua
---

# Scenario Points

A **scenario point** is a world marker that tells the AI *where* a scenario may happen. Stock towns are full of baked points: chairs, benches, campfires, lean-walls, card tables, wagons, fishing spots. When the game spawns an ambient ped, the scenario system picks a nearby point and the ped walks to it, plays the scenario's **enter** animation, loops the **base** animation, and plays an **exit** animation when it leaves.

You do **not** play the sitting/drinking animation yourself. You ask the AI to use a point and the game plays the correct animation, prop, and transition for that ped.

## The three layers

| Layer | Example | What it controls |
|---|---|---|
| Scenario type | `PROP_HUMAN_SEAT_CHAIR_DRINKING` | The activity family: sit and drink. |
| Conditional anim | `PROP_HUMAN_SEAT_CHAIR_DRINKING_MALE_A` | The exact clip set. Selected by conditions such as gender, prop, time, or ped commands. |
| Scenario point | a handle returned by `GetScenarioPointsInArea` or `CreateScenarioPointHash` | The location, heading, radius, flags, and ownership of one usable spot. |

A point has a **type** (`GetScenarioPointType(point)`). `TaskUseScenarioPoint` only works when the point type matches the activity you want. A point with type `PROP_HUMAN_SEAT_CHAIR` will not play the drinking variant just because you asked for drinking.

See [../../animations/scenarios/README.md](../../animations/scenarios/README.md) for the scenario → conditional anim → enter/base/exit structure, and [chair_scenarios.md](chair_scenarios.md) for the full chair/bench scenario list.

## How a stock NPC uses a point

1. **Enumerate** points around the target with `GetScenarioPointsInArea` (raw hash `0x345EC3B7EBDE1CB5`).
2. **Filter** by `GetScenarioPointType(point) == GetHashKey("PROP_HUMAN_SEAT_CHAIR_DRINKING")`.
3. **Pick** the nearest point within your search radius.
4. **Task** the ped with `TaskUseScenarioPoint(ped, point, "", -1.0, true, false, 0, false, -1.0, true)`.
5. **Wait** for the enter animation to finish before freezing or repositioning the ped.
6. **Verify** with `GetScenarioPointTypePedIsUsing(ped) ~= 0`.
7. **Clean up** only the points you created with `CreateScenarioPointHash`; never delete baked map points.

## Reading points: 8-byte slots

The Lua wrapper for `GetScenarioPointsInArea` hides the output array, so call the raw hash and pass a `DataView` buffer. The native writes **8-byte entries**; the point handle is in the low 32 bits.

```lua
local POINT_SCAN_MAX = 10
local buffer = DataView.ArrayBuffer(256 * 4)

Citizen.InvokeNative(
    0x345EC3B7EBDE1CB5,
    x, y, z, 4.0,       -- centre and search radius
    buffer:Buffer(),     -- output array
    POINT_SCAN_MAX
)

for i = 1, POINT_SCAN_MAX do
    local point = buffer:GetInt32(8 * i) -- 8-byte stride, 1-based slot
    if point ~= 0 then
        local pointType = GetScenarioPointType(point)
        local pointCoords = GetScenarioPointCoords(point, true)
        -- use point
    end
end
```

This is the proven pattern in `vorp_barbershop`. `DataView.ArrayBuffer` is client-only.

## Baked points vs created points

| | Baked map point | Created by script |
|---|---|---|
| Source | Shipped in the map/interior | `CreateScenarioPointHash` / `CreateScenarioPointHashAttachedToEntity` |
| Ownership | Game | Your script |
| Delete | **Never** call `DeleteScenarioPoint` | Call `DeleteScenarioPoint` on cleanup |
| Z position | Already correct for the furniture | You supply it; tune with a Z offset |
| Best use | Stock chairs, tables, campfires | Custom props, moved furniture, modded interiors |

Prefer a baked point when one exists. Only create a point if the search finds nothing.

```lua
local point = CreateScenarioPointHash(
    GetHashKey("PROP_HUMAN_SEAT_CHAIR_DRINKING"),
    x, y, z, heading,
    0, 0, true
)

if point and point ~= 0 then
    SetScenarioPointActive(point, true)
end
```

`CreateScenarioPointHashAttachedToEntity` is the variant to use when the prop can move. The point follows the entity.

## Tasking the ped

The proven parameter set from `vorp_barbershop` and `coi_art_rob`:

```lua
TaskUseScenarioPoint(
    ped,
    point,
    "",       -- conditional anim; "" = let the scenario choose a valid one
    -1.0,     -- duration (-1 = forever)
    true,     -- play the enter animation
    false,
    0,
    false,
    -1.0,
    true
)
```

- Keep `conditionalAnim = ""` unless you deliberately want one exact variant. Many variants are gender- or prop-gated; forcing the wrong one makes the ped ignore the scenario or get stuck.
- The ped must be able to reach the point on the navmesh.
- Spawn the ped **near but not inside** the furniture, then let `TaskUseScenarioPoint` walk it in. Dropping a ped directly into the seat usually makes it slide or fall through the floor.

## Freeze timing

`FreezeEntityPosition` is a safety net, not the sit. Freeze only after the enter animation has finished:

```lua
CreateThread(function()
    Wait(8000) -- proven delay in vorp_barbershop and coi_art_rob

    if DoesEntityExist(ped) and GetScenarioPointTypePedIsUsing(ped) ~= 0 then
        FreezeEntityPosition(ped, true)
    end
end)
```

If you freeze on the same frame you call `TaskUseScenarioPoint`, the ped stops before it reaches the chair. If you never freeze, a ped can be pushed or slide off the seat.

## Spawning for interiors

If the chair is inside an interior (the Valentine saloon is `val_saloon2_int`), the interior must be streamed before the ped spawns. Spawning from far away makes the ped fall through the floor.

A simple distance gate:

- spawn when the player is within **20 m**
- despawn when the player is beyond **35 m**
- respawn if the NPC drifts more than **5 m** from the target

The player being seated already implies they are close, so a seated trigger can spawn immediately. The distance gate is still useful as a fallback and for the despawn side.

## Triggering while the player is seated

The stock saloon chairs are scenario points. The cheapest reliable trigger is:

1. player is within `playerSitRadius` of the NPC chair (but not on the NPC's own chair),
2. the player is using a scenario point, or `IsPedUsingAnyScenario(player)` is true,
3. the player's point is also near the target.

```lua
local function IsPlayerSeatedNear(cfg)
    local player = PlayerPedId()
    local target = vector3(cfg.coords.x, cfg.coords.y, cfg.coords.z)
    local distance = #(GetEntityCoords(player) - target)

    if distance < (cfg.playerMinDistance or 0.8)
        or distance > (cfg.playerSitRadius or 4.0) then
        return false
    end

    local point = GetScenarioPointPedIsUsing(player, true)

    if point and point ~= 0 then
        local pointCoords = GetScenarioPointCoords(point, true)

        if #(pointCoords - target) <= (cfg.playerSitRadius or 4.0) then
            return true
        end
    end

    return IsPedUsingAnyScenario(player)
end
```

Then run the spawn/despawn loop on that boolean instead of raw distance. See [examples.lua](examples.lua) for a complete, dependency-free client script.

## Common failure modes

| Symptom | Likely cause | Fix |
|---|---|---|
| NPC never appears | Player is not detected as seated | Run `/npcstate`; check `anyScenario`, `point`, `type`, `seatedNear` |
| NPC appears but stands next to the chair | Wrong point type, or the point is too far / unreachable | Run `/npcscen`; compare `type` with `GetHashKey(cfg.scenario)`; narrow `pointSearchRadius` |
| NPC sits but floats or sinks | Created point Z is wrong, or a baked point is being reused with a bad offset | Tune `zOffset`; baked points should normally need no offset |
| NPC sits, then slides off | Freeze happened before the enter animation finished | Increase the delay (8 s is the proven value) |
| NPC ignores the scenario | Forced a conditional anim whose gender/prop conditions are not met | Pass `""` for `conditionalAnim` |
| NPC sits on the wrong chair | Search radius catches multiple chair points | Lower `pointSearchRadius`; filter by exact type |
| Nothing is found near a custom chair | No baked point exists there | Let the script create a point with `CreateScenarioPointHash` |
| Chair is occupied by an ambient ped | Stock AI is already using the point | Check `GetPedUsingScenarioPoint(point)`; wait or pick another point |

## Files in this folder

| File | Contents |
|---|---|
| [natives_points.md](natives_points.md) | Every scenario-point native, with hash, Lua alias, signature, and notes |
| [natives_system.md](natives_system.md) | Surrounding scenario system: density, groups, types, blocking, exits, containers |
| [chair_scenarios.md](chair_scenarios.md) | 118 chair/bench scenarios and their conditional anim variants |
| [scenario_point_flags.md](scenario_point_flags.md) | Full `CScenarioPointFlags` enum and seating flags |
| [props.md](props.md) | Scenario-attached prop strings and how to give/remove them |
| [examples.lua](examples.lua) | Complete dependency-free client example: seated trigger, baked point, create fallback, cleanup |
| [local_evidence.md](local_evidence.md) | What was verified on this machine, source fingerprints, and the 7 hash-only natives |

## Related pages

- [Scenarios index](../README.md)
- [Animations: scenarios](../../animations/scenarios/README.md)
- [Tasks API](../../docs/natives/tasks/api.md)
- [Native overview](../../docs/natives/overview.md)
- [Machine-readable native dataset](../../datasets/scenario_points_natives.json)
- [Scenario → conditional anim dataset](../../datasets/scenario_conditional_anims.json)
- [Attached prop dataset](../../datasets/scenario_attached_props.json)

## Sources

- Local RedM Lua wrappers: `citizen/scripting/lua/rdr3_universal.lua`
- Local RedM native docs: `citizen/clr2/lib/mono/4.5/v2/Native/ref/CitizenFX.RedM.Native.xml`
- alloc8or RDR3 native DB: https://github.com/alloc8or/rdr3-nativedb-data
- Halen84 flags and enums: https://github.com/Halen84/RDR3-Native-Flags-And-Enums
- femga discoveries: https://github.com/femga/rdr3_discoveries
- Proven local resources: `vorp_barbershop`, `coi_art_rob`
