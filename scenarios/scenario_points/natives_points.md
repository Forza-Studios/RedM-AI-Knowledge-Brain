---
title: Scenario Point Natives
category: Scenarios
tags:
  - scenario-points
  - natives
  - task
  - ai
framework:
  - redm
difficulty: advanced
last_updated: 2026-10-29
sources:
  - https://github.com/alloc8or/rdr3-nativedb-data
  - https://github.com/Halen84/RDR3-Native-Flags-And-Enums
  - C:/Users/Forza/AppData/Local/RedM/RedM.app/citizen/scripting/lua/rdr3_universal.lua
  - C:/Users/Forza/AppData/Local/RedM/RedM.app/citizen/clr2/lib/mono/4.5/v2/Native/ref/CitizenFX.RedM.Native.xml
---

# Scenario Point Natives

Every scenario point native is listed below with its canonical hash, local Lua alias, C signature and the note shipped with the native database.

- **Lua alias** — call it directly when the local build exposes it (e.g. `TaskUseScenarioPoint(...)`).
- **Hash** — always works through `Citizen.InvokeNative(hash, ...)`, even when no alias exists.
- A dash (—) means the native has no named Lua wrapper in this build.

> Scenario point handles are 32-bit values. `GetScenarioPointsInArea` stores them in **8-byte slots** (low 32 bits hold the handle). This is why the array must be 8-byte aligned.

---

## Enumerate and inspect points

| Native | Signature | Notes |
|---|---|---|
| `GetScenarioPointsInArea`<br>`0x345EC3B7EBDE1CB5` | `(float posX, float posY, float posZ, float radius, any* scenariosInRadius, int size) -> int` | Note: scenariosInRadius is an array, and its size and values should be aligned to 8 bytes. |
| `GetScenarioPointType`<br>`0xA92450B5AE687AAF` | `(int scenario) -> hash` | _GET_SCENARIO_POINT_TYPE |
| `GetScenarioPointCoords`<br>`0xA8452DD321607029` | `(int scenario, bool p1) -> Vector3` | Params: p1 is always true in R* Scripts |
| `GetScenarioPointHeading`<br>`0xB93EA7184BAA85C3` | `(int scenario, bool p1) -> float` | Params: p1 is always true in R* Scripts |
| `GetScenarioPointRadius`<br>`0x6718F40313A2B5A6` | `(int scenario) -> float` | _GET_SCENARIO_POINT_RADIUS |
| `GetScenarioPointEntity`<br>`0x7467165EE97D3C68` | `(int scenario) -> Entity` | Note: The current name for this native is the old name of 0x295514F198EFD0CA Old name for this native: _GET_ENTITY_SCENARIO_POINT_IS_ATTACHED_TO |
| `DoesScenarioPointExist`<br>`0x841475AC96E794D1` | `(int scenario) -> bool` | DOES_SCENARIO_POINT_EXIST |
| `IsScenarioPointActive`<br>`0x0CC36D4156006509` | `(int scenario) -> bool` | _IS_SCENARIO_POINT_ACTIVE |
| `IsScenarioPointFlagSet`<br>`0x8569C38D2FB80650` | `(int scenario, int flag) -> bool` | _IS_SCENARIO_POINT_FLAG_SET |
| `DoesScenarioPointHaveProps`<br>`0xEA31F199A73801D3` | `(int scenario) -> bool` | _DOES_SCENARIO_POINT_HAVE_PROPS |
| `GetPropForScenarioPoint`<br>`0x295514F198EFD0CA` | `(int scenarioPoint, string name) -> Entity` | Old name: _GET_SCENARIO_POINT_ENTITY |
| `GetIndexedScenarioPointIndexInItemset`<br>`0x9FC3CDB5CE815901` | `(int index, ItemSet itemset) -> any` | GET_INDEXED_SCENARIO_POINT_INDEX_IN_ITEMSET |
| `UiPromptGetGroupIdForScenarioPoint`<br>`0xCB73D7521E7103F0` | `(any p0, int p1) -> int` | _UI_PROMPT_GET_GROUP_ID_FOR_SCENARIO_POINT |
| `FindScenarioOfTypeHash`<br>`0xF533D68FF970D190` | `(float xPos, float yPos, float zPos, hash scenarioType, float distance, any p5, bool p6) -> int` | FIND_SCENARIO_OF_TYPE_HASH |
| `DoesScenarioOfTypeExistInAreaHash`<br>`0x6EEAD6AF637DA752` | `(float x, float y, float z, hash typeHash, float radius, bool p5) -> bool` | DOES_SCENARIO_OF_TYPE_EXIST_IN_AREA_HASH |
| `DoesScenarioExistInArea`<br>`0x5A59271FFADD33C1` | `(float x, float y, float z, float radius, bool p4, any p5, bool p6) -> bool` | DOES_SCENARIO_EXIST_IN_AREA |
| `IsScenarioOccupied`<br>`0x788756D73AC2E07C` | `(float p0, float p1, float p2, float p3, bool p4) -> bool` | IS_SCENARIO_OCCUPIED |
| `N_0x1acbc313966c21f3` (unnamed)<br>`0x1ACBC313966C21F3` | `(int scenario) -> bool` | Checks whether a specified scenario is currently being used (actively played) by any entity (player or ped). |

---

## Create, mutate and delete

| Native | Signature | Notes |
|---|---|---|
| `CreateScenarioPointHash`<br>`0x94B745CE41DB58A1` | `(hash scenarioHash, float x, float y, float z, float heading, any p5, any p6, bool p7) -> int` | Returns scenario |
| `CreateScenarioPointHashAttachedToEntity`<br>`0x794AB1379A74064D` | `(Entity entity, hash scenarioHash, float x, float y, float z, float heading, any p6, any p7, bool p8) -> int` | Returns scenario |
| `DeleteScenarioPoint`<br>`0x81948DFE4F5A0283` | `(int scenario) -> void` | _DELETE_SCENARIO_POINT |
| `SetScenarioPointActive`<br>`0xEEE4829304F93EEE` | `(int scenario, bool active) -> void` | _SET_SCENARIO_POINT_ACTIVE |
| `SetScenarioPointCoords`<br>`0x2056AB38DF06825C` | `(int scenario, float xPos, float yPos, float zPos, bool p4) -> void` | _SET_SCENARIO_POINT_COORDS |
| `SetScenarioPointHeading`<br>`0xD3A0DA8F91612C6E` | `(int scenario, float heading, bool p2) -> void` | _SET_SCENARIO_POINT_HEADING |
| `SetScenarioPointRadius`<br>`0xC47D9080A9A8856A` | `(int scenario, float radius) -> void` | _SET_SCENARIO_POINT_RADIUS |
| `SetScenarioPointFlag`<br>`0x5AF19B6CC2115D34` | `(int scenario, int flag, bool value) -> void` | flag: https://github.com/Halen84/RDR3-Native-Flags-And-Enums/tree/main/CScenarioPointFlags__Flags |
| `ResetScenarioForEntity`<br>`0x2E20878FD208A68E` | `(int scenario, Entity entity) -> void` | _RESET_SCENARIO_FOR_ENTITY |

---

## Use a point (tasks)

| Native | Signature | Notes |
|---|---|---|
| `TaskUseScenarioPoint`<br>`0xCCDAE6324B6A821C` | `(Ped ped, int scenario, string conditionalAnim, int p3, bool p4, bool p5, hash p6, bool p7, float p8, bool p9) -> void` | TASK_USE_SCENARIO_POINT |
| `TaskUseScenarioPoint_2`<br>`0x0F6641449DD86FBE` | `(Ped ped, Ped ped2, any p2, string p3, int p4, hash p5, float p6, bool p7) -> void` | _TASK_USE_SCENARIO_POINT_2 |
| `TaskStartScenarioInPlace_2`<br>`0xA917E39F2CEFD215` | `(Ped ped, any p1, string p2, int p3, bool p4, float p5, bool p6) -> void` | Takes scenario point handle instead of hash |
| `TaskUseNearestScenarioToCoord`<br>`0x322BFDEA666E2B0E` | `(Ped ped, float x, float y, float z, float distance, int duration, bool p6, bool p7, bool p8, bool p9) -> void` | _TASK_USE_NEAREST_SCENARIO_TO_COORD |
| `TaskUseNearestScenarioToCoordWarp`<br>`0x58E2E0F23F6B76C3` | `(Ped ped, float x, float y, float z, float distance, int duration, bool p6, bool p7, bool p8, bool p9) -> void` | TASK_USE_NEAREST_SCENARIO_TO_COORD_WARP |
| `TaskUseNearestScenarioChainToCoord`<br>`0x9FDA1B3D7E7028B3` | `(Ped ped, float x, float y, float z, float distance, bool p5, bool p6, bool p7, bool p8) -> void` | TASK_USE_NEAREST_SCENARIO_CHAIN_TO_COORD |
| `TaskUseNearestScenarioChainToCoordWarp`<br>`0x97A28E63F0BA5631` | `(Ped ped, float x, float y, float z, float distance, bool p5, bool p6, bool p7, bool p8) -> void` | TASK_USE_NEAREST_SCENARIO_CHAIN_TO_COORD_WARP |
| `TaskUseNearestTrainScenarioToCoordWarp`<br>`0x3774B03456DD6106` | `(Ped ped, float x, float y, float z, float distance) -> void` | TASK_USE_NEAREST_TRAIN_SCENARIO_TO_COORD_WARP |
| `TaskUseRandomScenarioInGroup`<br>`0x14747F4A5971DE4E` | `(Ped ped, any p1, any p2, any p3, any p4) -> void` | TASK_USE_RANDOM_SCENARIO_IN_GROUP |
| `TaskStartScenarioAtPosition`<br>`0x4D1F61FC34AF3CD1` | `(Ped ped, hash scenarioHash, float x, float y, float z, float heading, int duration, bool sittingScenario, bool teleport, string p9, float p10, bool p11) -> void` | TASK_START_SCENARIO_AT_POSITION |
| `TaskStartScenarioInPlaceHash`<br>`0x524B54361229154F` | `(Ped ped, hash scenarioHash, int duration, bool playEnterAnim, hash conditionalHash, float heading, bool p6) -> void` | https://github.com/femga/rdr3_discoveries/blob/master/animations/scenarios Params: duration in milliseconds conditionalHash (optionally): 0 = play random conditional ani… |

---

## Ped and point state

| Native | Signature | Notes |
|---|---|---|
| `GetPedUsingScenarioPoint`<br>`0x5BA659955369B0E2` | `(int scenario) -> Ped` | _GET_PED_USING_SCENARIO_POINT |
| `GetScenarioPointPedIsUsing`<br>`0xDF7993356F52359A` | `(Ped ped, bool p1) -> int` | _GET_SCENARIO_POINT_PED_IS_USING |
| `GetScenarioPointTypePedIsUsing`<br>`0x2D0571BB55879DA2` | `(Ped ped) -> int` | _GET_SCENARIO_POINT_TYPE_PED_IS_USING |
| `GetRansackScenarioPointPedIsUsing`<br>`0xD04241BBF6D03A5E` | `(Ped ped) -> any` | GET_RANSACK_SCENARIO_POINT_PED_IS_USING |
| `CanPedUseScenarioPoint`<br>`0xAB643407D0B26F07` | `(Ped ped, int scenario, any p2, any p3, any p4) -> bool` | p2 is always 0, p3 is always 0, p4 is always 1 |
| `IsPedUsingScenarioHash`<br>`0x34D6AC1157C8226C` | `(Ped ped, hash scenarioHash) -> bool` | Equivalent to IS_PED_USING_SCENARIO from V but takes a hash instead of a string. |
| `IsPedUsingAnyScenario`<br>`0x57AB4A3080F85143` | `(Ped ped) -> bool` | IS_PED_USING_ANY_SCENARIO |
| `IsPedUsingThisScenario`<br>`0x9C54041BB66BCF9E` | `(Ped ped, int scenario) -> bool` | IS_PED_USING_THIS_SCENARIO |
| `IsPedActiveInScenario`<br>`0xAA135F9482C82CC3` | `(Ped ped, int scenario) -> bool` | IS_PED_ACTIVE_IN_SCENARIO |
| `IsPedExitingScenario`<br>`0x0C3CB2E600C8977D` | `(Ped ped, bool p1) -> bool` | IS_PED_EXITING_SCENARIO |
| `IsPedDoingScenarioTransition`<br>`0xC488B8C0E52560D8` | `(Ped ped) -> bool` | _IS_PED_DOING_SCENARIO_TRANSITION |
| `PedHasUseScenarioTask`<br>`0x295E3CCEC879CCD7` | `(Ped ped) -> bool` | PED_HAS_USE_SCENARIO_TASK |
| `GetActiveDynamicScenario`<br>`0x569F1E1237508DEB` | `(Ped ped) -> hash` | Returns kneeling, sitting, squating, and sleeping scenario hashes |
| `GetActiveDynamicScenario_2`<br>`0xC22AA08A8ADB87D4` | `(Ped ped) -> hash` | Returns kneeling, sitting, squating, and sleeping scenario hashes |
| `PedIsInScenarioBase`<br>`0x02EBBB3989B7E695` | `(Ped ped) -> bool` | _PED_IS_IN_SCENARIO_BASE |
| `IsPedScenarioReactLooking`<br>`0x916B8E075ABC8B4E` | `(Ped ped, bool p1) -> bool` | IS_PED_SCENARIO_REACT_LOOKING |
| `ToggleScenarioPedCowerInPlace`<br>`0x9A77DFD295E29B09` | `(Ped ped, bool toggle) -> void` | If toggle is true, when the ped is using a scenario he will stop it and become scared If toggle is false, the ped will not be scared anymore and continue his scenario Ol… |

---

## Scenario props

| Native | Signature | Notes |
|---|---|---|
| `AssociatePropWithScenario`<br>`0x8360C47380B6F351` | `(int scenario, Entity entity, string propName, bool p3) -> bool` | _ASSOCIATE_PROP_WITH_SCENARIO |
| `DisassociatePropFromScenario`<br>`0x6EF4E31B4D5D2DA0` | `(int scenario, string propName) -> bool` | _DISASSOCIATE_PROP_FROM_SCENARIO |
| `GivePedScenarioProp`<br>`0x3BBDD6143FF16F98` | `(Ped ped, Object object, string conditionalAnim, string p3, string p4, bool p5) -> bool` | _GIVE_PED_SCENARIO_PROP |
| `GivePedHashScenarioProp`<br>`0x2B02DB082258625F` | `(Ped ped, Object object, string conditionalAnim, hash scenarioType, hash p4, bool p5) -> bool` | GIVE_PED_HASH_SCENARIO_PROP |
| `GivePedScenarioPropDynamic`<br>`0xA0774E388CE4A679` | `(Ped ped, Object object, string p2, string p3, bool p4) -> bool` | Only used in SP R* Script rcm_jack2 |
| `RequestPropScenarioPed`<br>`0xBEC65C6049B3219D` | `(Ped ped, Object object, string p2, string p3, string p4, bool p5) -> any` | _REQUEST_PROP_SCENARIO_PED |
| `RequestPedForScenarioType`<br>`0xBDED916A9F9B0604` | `(Ped ped, Object object, string p2, hash scenarioType, string p4, bool p5) -> any` | _REQUEST_PED_FOR_SCENARIO_TYPE |

---

## Linked points and transitions

| Native | Signature | Notes |
|---|---|---|
| `N_0xe7bbc4e56b989449` (unnamed)<br>`0xE7BBC4E56B989449` | `(int scenarioPoint, int* outPoints, int maxPoints) -> int` | Fills an output array with scenario points linked ("chained") to a given parent scenario point. |
| `N_0x79197f7d2bb5e73a` (unnamed)<br>`0x79197F7D2BB5E73A` | `(Ped ped, int scenarioPoint, string clipsetDict, string clipName, string fromConditionalAnim, int flags) -> bool` | Requests an authored transition for a ped that is currently using a scenario point, switching into a specific conditional/clipset branch defined for that scenario. |
| `AddScenarioTransition`<br>`0x6D07B371E9439019` | `(Ped ped) -> void` | Forces transition now, called together with 0xD65FDC686A031C83 |
| `PlayAnimOnRunningScenario`<br>`0x748040460F8DF5DC` | `(Ped ped, string animDict, string animName) -> void` | PLAY_ANIM_ON_RUNNING_SCENARIO |


---

## Parameter notes that are not in the native DB

### GetScenarioPointsInArea

The generated Lua wrapper (`GetScenarioPointsInArea(posX, posY, posZ, radius, size)`) hides the output array behind an internal pointer argument, so it cannot fill a Lua buffer. Call the raw hash instead:

```lua
local buffer = DataView.ArrayBuffer(256 * 4)

-- x, y, z, radius, output buffer, max entries
local count = Citizen.InvokeNative(
    0x345EC3B7EBDE1CB5,
    x, y, z, radius,
    buffer:Buffer(),
    10
)

-- Proven local read pattern (vorp_barbershop): 1-based, 8-byte stride.
for i = 1, 10 do
    local point = buffer:GetInt32(8 * i)
    if point ~= 0 then
        -- point is a valid scenario point handle
    end
end
```

Notes:

- `DataView.ArrayBuffer` is client-only.
- The barbershop reads slots `1..10` with `GetInt32(8 * i)` and skips zero handles. This is the proven pattern in this server.
- The native returns an integer (entry count in practice). The local proven code does not rely on it; it scans all requested slots and ignores zeros.
- Filter by `GetScenarioPointType(point) == GetHashKey("PROP_HUMAN_SEAT_CHAIR_DRINKING")`.

### CreateScenarioPointHash

```lua
local point = CreateScenarioPointHash(
    GetHashKey("PROP_HUMAN_SEAT_CHAIR_DRINKING"),
    x, y, z, heading,
    0,      -- p5: 0 in community usage
    0,      -- p6: 0 in community usage
    true    -- p7: true in community usage
)
```

- Returns a scenario point handle, not a scenario hash.
- Created points belong to the script. Delete them with `DeleteScenarioPoint` when the owning entity is removed.
- If the point does not behave as active, call `SetScenarioPointActive(point, true)`.

### CreateScenarioPointHashAttachedToEntity

```lua
local point = CreateScenarioPointHashAttachedToEntity(
    chairEntity,
    GetHashKey("PROP_HUMAN_SEAT_CHAIR_DRINKING"),
    0.0, 0.0, 0.0,   -- offset relative to the entity
    heading,
    0, 0, true
)
```

Use this when the prop can move (spooner object, moving wagon, repositioned furniture). The point follows the entity.

### TaskUseScenarioPoint

Proven parameter set from `vorp_barbershop` and `coi_art_rob`:

```lua
TaskUseScenarioPoint(
    ped,
    point,
    "",       -- conditional anim name; "" = random allowed conditional anim
    -1.0,     -- p3
    true,     -- p4
    false,    -- p5
    0,        -- p6
    false,    -- p7
    -1.0,     -- p8
    true      -- p9
)
```

What it does: creates the stock "use this point" task. The ped walks to the point, plays the scenario's **enter** animation, then the base loop (sit, drink, work). You do **not** play an animation hash yourself.

- `conditionalAnim = ""` lets the scenario pick a valid conditional anim (male/female/prop variants included).
- The remaining numeric/boolean arguments are undocumented. Use the proven set above.
- The ped must be on, or able to reach, the navmesh. Spawn 1-2 m in front of the chair, not inside the collider.
- Do not freeze the ped before the enter animation has finished.

### TaskStartScenarioInPlace_2

Same idea as `TaskUseScenarioPoint` but takes a point handle and starts the scenario without walking to it:

```lua
Citizen.InvokeNative(0xA917E39F2CEFD215, ped, point, "", -1, true, -1.0, false)
```

Use it when the ped is already positioned by other logic.

### GetScenarioPointTypePedIsUsing

```lua
local scenarioType = GetScenarioPointTypePedIsUsing(ped)
if scenarioType ~= 0 then
    -- ped is actively using a scenario point; scenarioType is its scenario hash
end
```

This is the cheapest runtime check that the task actually started.

### Linked points

`_GET_LINKED_SCENARIO_POINTS` (0xE7BBC4E56B989449) is not aliased in the local Lua build, but exists. It fills an int array with points chained to a parent point (for example chair + table + put-down chains):

```lua
local buffer = DataView.ArrayBuffer(16 * 4)
local count = Citizen.InvokeNative(0xE7BBC4E56B989449, parentPoint, buffer:Buffer(), 16)

for i = 0, count - 1 do
    local linked = buffer:GetInt32(4 * i)
end
```

---

## Complete point-native index

The same natives also exist in machine-readable form in [datasets/scenario_points_natives.json](../../../datasets/scenario_points_natives.json).
