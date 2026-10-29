---
title: Scenario Point Flags
category: Scenarios
tags:
  - scenario-points
  - flags
  - seating
  - ai
framework:
  - redm
difficulty: intermediate
last_updated: 2026-10-29
sources:
  - https://github.com/Halen84/RDR3-Native-Flags-And-Enums/tree/main/CScenarioPointFlags__Flags
  - C:/Users/Forza/AppData/Local/RedM/RedM.app/citizen/scripting/lua/rdr3_universal.lua
---

# Scenario Point Flags

Scenario points carry a `CScenarioPointFlags` bitset. The ambient scenario system reads these flags when it decides whether a point can spawn a ped, how far away it can be used, whether it is a seat, and how the ped should behave.

Set and read them with:

```lua
-- _SET_SCENARIO_POINT_FLAG
SetScenarioPointFlag(point, flag, true)

-- _IS_SCENARIO_POINT_FLAG_SET
local enabled = IsScenarioPointFlagSet(point, flag)
```

| Native | Hash |
|---|---|
| `SetScenarioPointFlag` | `0x5AF19B6CC2115D34` |
| `IsScenarioPointFlagSet` | `0x8569C38D2FB80650` |

## Seating flags

| Value | Flag | Use |
|---:|---|---|
| 58 | `SeatedChair` | A normal chair with a back. |
| 59 | `SeatedBench` | A bench. |
| 60 | `SeatedAtTable` | Seated at a table (used by table/drinking scenarios). |
| 61 | `SeatedNoBack` | A stool or backless seat. |

These are the flags to consider when you create a point for a custom chair:

```lua
local point = CreateScenarioPointHash(
    GetHashKey("PROP_HUMAN_SEAT_CHAIR_DRINKING"),
    x, y, z, heading,
    0, 0, true
)

SetScenarioPointFlag(point, 58, true) -- SeatedChair
```

The flag is **not required** for `TaskUseScenarioPoint` to work. It tells the ambient scenario system what kind of furniture the point represents, which matters if you also want stock peds to use it or if you want the point to attract ambient peds.

## Full enum

| Value | Flag | Notes |
|---:|---|---|
| 0 | `_0x27B31061` | Name not recovered. |
| 1 | `PreventPedFromGettingOffTrains` |  |
| 2 | `AggressiveVehicleDriving` |  |
| 3 | `_0x06BC63F2` | Name not recovered. |
| 4 | `_0x5AA3BE00` | Name not recovered. |
| 5 | `ClusterLeader` |  |
| 6 | `ConversePoint` |  |
| 7 | `_0xE83E339C` | Name not recovered. |
| 8 | `DisablePlayerUse` | Player cannot use this point. |
| 9 | `DisableWitnessBehaviour` |  |
| 10 | `EndScenarioIfPlayerWithinRadius` |  |
| 11 | `EventsInRadiusTriggerDisputes` |  |
| 12 | `EventsInRadiusTriggerThreatResponse` |  |
| 13 | `ExtendedRange` |  |
| 14 | `HighPriority` |  |
| 15 | `HubNode` |  |
| 16 | `IgnoreLoitering` |  |
| 17 | `IgnoreMaxInRange` |  |
| 18 | `IgnoreThreatsIfLosNotClear` |  |
| 19 | `IgnoreWeatherRestrictions` |  |
| 20 | `InWater` |  |
| 21 | `LandVehicleOnArrival` |  |
| 22 | `MissionCritical` |  |
| 23 | `NoAttraction` |  |
| 24 | `NoRespawnUntilStreamedOut` |  |
| 25 | `NoSpawn` | Ambient spawner will not spawn here. |
| 26 | `NoVehicleSpawnMaxDistance` |  |
| 27 | `OnlySpawnInSameInterior` |  |
| 28 | `OpenDoor` |  |
| 29 | `PavementNode` |  |
| 30 | `PreciseUseTime` |  |
| 31 | `ResetNoCollisionOnCleanUp` |  |
| 32 | `SetPedDrunk` |  |
| 33 | `ShortRange` |  |
| 34 | `SpawnedPedIsArrestable` |  |
| 35 | `StationaryReactions` |  |
| 36 | `CanBeUsedByAmbientPedsToGetOnTrain` |  |
| 37 | `TerritorialScenario` |  |
| 38 | `UseHeadOrientationForPerception` |  |
| 39 | `UseLoSChecks` |  |
| 40 | `UseSearchlight` |  |
| 41 | `UseVehicleFrontForArrival` |  |
| 42 | `_0xDBCF4713` | Name not recovered. |
| 43 | `_0xAE9CDEC4` | Name not recovered. |
| 44 | `CampfireScenario` |  |
| 45 | `_0x6F1EF279` | Name not recovered. |
| 46 | `CanConverseThenLeave` |  |
| 47 | `VegVolume` |  |
| 48 | `_0xED924097` | Name not recovered. |
| 49 | `_0xB1D91209` | Name not recovered. |
| 50 | `Isolated` |  |
| 51 | `ExcludeFromDynamicSearch` |  |
| 52 | `_0x51040B88` | Name not recovered. |
| 53 | `_0xB3EB0FA6` | Name not recovered. |
| 54 | `_0x30A8DCC6` | Name not recovered. |
| 55 | `_0xDEE6B943` | Name not recovered. |
| 56 | `_0xC5CC870F` | Name not recovered. |
| 57 | `_0xFBEEC8B2` | Name not recovered. |
| 58 | `SeatedChair` | Chair with a back. |
| 59 | `SeatedBench` | Bench. |
| 60 | `SeatedAtTable` | Seated at a table. |
| 61 | `SeatedNoBack` | Stool / backless seat. |
| 62 | `_0x9030FA20` | Name not recovered. |
| 63 | `_0x7C44D036` | Name not recovered. |

## Notes

- Flags are **bit values**, not a separate enum field. Use the numeric value with the two natives above.
- Do not copy a random point's flags onto a created point. Flags such as `NoSpawn`, `NoAttraction`, `MissionCritical`, or `DisablePlayerUse` change how the ambient spawner treats the point.
- `SetScenarioPointFlag` is a script-owned change. Baked points are reset when the map/interior reloads; created points are deleted with `DeleteScenarioPoint`.
- The unnamed values are preserved from Halen84's extraction. They are safe to use numerically, but their behaviour is not documented here.

## Related pages

- [Scenario points overview](README.md)
- [Scenario point natives](natives_points.md)
- [Chair and bench scenarios](chair_scenarios.md)

## Sources

- https://github.com/Halen84/RDR3-Native-Flags-And-Enums/tree/main/CScenarioPointFlags__Flags
- Local Lua wrapper: `SetScenarioPointFlag`, `IsScenarioPointFlagSet`
