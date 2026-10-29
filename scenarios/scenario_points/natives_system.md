---
title: Scenario System Natives
category: Scenarios
tags:
  - scenario-points
  - natives
  - population
  - ai
framework:
  - redm
difficulty: advanced
last_updated: 2026-10-29
sources:
  - https://github.com/alloc8or/rdr3-nativedb-data
  - https://github.com/Halen84/RDR3-Native-Flags-And-Enums
  - C:/Users/Forza/AppData/Local/RedM/RedM.app/citizen/scripting/lua/rdr3_universal.lua
---

# Scenario System Natives

Scenario points are one part of a larger scenario system: ambient population density, scenario groups and types, blocking volumes, exit behaviour, containers and persistence. These are the natives that surround points.

## Scenario containers (ransack)

| Native | Signature | Notes |
|---|---|---|
| `SetScenarioContainerOpeningState`<br>`0x188F8071F244B9B8` | `(Entity entity, bool open) -> void` | Opens/closes containers: ChestDugUp |
| `GetScenarioContainerOpeningState`<br>`0xB219612B5568E9EC` | `(Entity entity) -> bool` | Returns m_eContainerState |
| `N_0x849791ebbdba0362` (unnamed)<br>`0x849791EBBDBA0362` | `(Entity entity) -> int` | Returns the number of currently open compartments for the specified scenario container entity. |
| `N_0x640a602946a8c972` (unnamed)<br>`0x640A602946A8C972` | `(Entity entity) -> int` | Returns the total number of compartments (drawers, lids, etc.) the specified scenario container entity has. |
| `N_0x01af8a3729231a43` (unnamed)<br>`0x01AF8A3729231A43` | `(Entity entity) -> int` | Returns the total number of lootable items currently inside the specified scenario container entity. |

---

## Ambient population, groups and types

| Native | Signature | Notes |
|---|---|---|
| `SetScenarioPedDensityMultiplierThisFrame`<br>`0x7A556143A1C03898` | `(float multiplier) -> void` | SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME |
| `SetScenarioPedDensityThisFrame`<br>`0x95423627A9CA598E` | `(hash configHash) -> void` | Sets the scenario ped density to the given config. |
| `SetScenarioPedRangeMultiplierThisFrame`<br>`0xA77FA7BE9312F8C0` | `(float multiplier) -> void` | _SET_SCENARIO_PED_RANGE_MULTIPLIER_THIS_FRAME |
| `SetScenarioAnimalDensityMultiplierThisFrame`<br>`0xDB48E99F8E064E56` | `(float multiplier) -> void` | _SET_SCENARIO_ANIMAL_DENSITY_MULTIPLIER_THIS_FRAME |
| `SetScenarioHumanDensityMultiplierThisFrame`<br>`0x28CB6391ACEDD9DB` | `(float multiplier) -> void` | _SET_SCENARIO_HUMAN_DENSITY_MULTIPLIER_THIS_FRAME |
| `N_0x9e3842e5dad69f80` (unnamed)<br>`0x9E3842E5DAD69F80` | `(Volume volume) -> void` | Registers the given volume with ped/scenario systems (stores a global ref). |
| `SetScenarioTypeEnabled`<br>`0xEB47EC4E34FB7EE1` | `(string scenarioType, bool toggle) -> void` | SET_SCENARIO_TYPE_ENABLED |
| `SetScenarioTypeEnabledHash`<br>`0xD00E50E673802D71` | `(hash scenarioType, bool toggle) -> void` | _SET_SCENARIO_TYPE_ENABLED_HASH |
| `IsScenarioTypeEnabled`<br>`0x3A815DB3EA088722` | `(string scenarioType) -> bool` | IS_SCENARIO_TYPE_ENABLED |
| `SetScenarioGroupEnabled`<br>`0x02C8E5B49848664E` | `(string scenarioGroup, bool toggle) -> void` | SET_SCENARIO_GROUP_ENABLED |
| `SetScenarioGroupEnabledHash`<br>`0x9925EDDB6EAB88CD` | `(hash scenarioGroup, bool toggle) -> void` | _SET_SCENARIO_GROUP_ENABLED_HASH |
| `IsScenarioGroupEnabled`<br>`0x367A09DED4E05B99` | `(string scenarioGroup) -> bool` | IS_SCENARIO_GROUP_ENABLED |
| `IsScenarioGroupEnabledHash`<br>`0xDCC374913DE6AAA6` | `(hash scenarioGroup) -> bool` | _IS_SCENARIO_GROUP_ENABLED_HASH |
| `DoesScenarioGroupExist`<br>`0xF9034C136C9E00D3` | `(string scenarioGroup) -> bool` | DOES_SCENARIO_GROUP_EXIST |
| `DoesScenarioGroupExistHash`<br>`0x76E98B52369A289C` | `(hash scenarioGroup) -> bool` | _DOES_SCENARIO_GROUP_EXIST_HASH |
| `ResetScenarioGroupsEnabled`<br>`0xDD902D0349AFAD3A` | `() -> void` |  |
| `ResetScenarioTypesEnabled`<br>`0x0D40EE2A7F2B2D6D` | `() -> void` |  |
| `ForceScenarioGroupPriority`<br>`0x444C910A5058E568` | `(any p0, any p1) -> void` | FORCE_SCENARIO_GROUP_PRIORITY |
| `RequestScenarioType`<br>`0x19A6BE7D9C6884D3` | `(hash scenarioType, int p1, hash entityModel, hash conditionalAnim) -> int` | entityModel can be 0 or using Hash or using GET_ENTITY_MODEL conditionalAnim can be 0 or using Hash also accepts GET_ACTIVE_DYNAMIC_SCENARIO. |
| `HasScenarioTypeLoaded`<br>`0x9427C94D2E4094A4` | `(hash scenarioType, bool p1) -> bool` | _HAS_SCENARIO_TYPE_LOADED |
| `RemoveScenarioAsset`<br>`0x4EDDD9E9CA5AF985` | `(hash scenarioType) -> any` | _REMOVE_SCENARIO_ASSET |
| `ForceRestScenario`<br>`0xE5A3DD2FF84E1A4B` | `(bool toggle) -> void` | NativeDB Introduced: v1232 |
| `ResetScenarioScript`<br>`0x5A40040BB5AE3EA2` | `(int scenario) -> void` | _RESET_SCENARIO_SCRIPT |

---

## Scenario blocking areas

| Native | Signature | Notes |
|---|---|---|
| `AddScenarioBlockingArea`<br>`0x1B5C85C612E5256E` | `(float x1, float y1, float z1, float x2, float y2, float z2, bool p6, int blockingFlags) -> int` | blockingFlags: https://github.com/Halen84/RDR3-Native-Flags-And-Enums/tree/main/eScenarioBlockingFlags |
| `AddScenarioBlockingVolume`<br>`0x4C39C95AE5DB1329` | `(Volume volume, bool p1, int flag) -> any` | flag: see ADD_SCENARIO_BLOCKING_AREA |
| `RemoveScenarioBlockingArea`<br>`0x31D16B74C6E29D66` | `(any p0, bool p1) -> void` | REMOVE_SCENARIO_BLOCKING_AREA |
| `RemoveScenarioBlockingAreas`<br>`0xD37401D78A929A49` | `() -> void` |  |
| `IsScenarioBlockingAreaValid`<br>`0x91A5F9CBEBB9D936` | `(any p0) -> bool` | _IS_SCENARIO_BLOCKING_AREA_VALID |

---

## Scenario exits

| Native | Signature | Notes |
|---|---|---|
| `SetPedPanicExitScenario`<br>`0xFE07FF6495D52E2A` | `(Ped ped, float x, float y, float z) -> bool` | SET_PED_PANIC_EXIT_SCENARIO |
| `SetPedShouldPlayDirectedNormalScenarioExit`<br>`0xEC6935EBE0847B90` | `(Ped ped, float x, float y, float z) -> bool` | Old name: _SET_PED_SHOULD_PLAY_DIRECTED_SCENARIO_EXIT |
| `SetPedShouldPlayNormalScenarioExit`<br>`0xA3A9299C4F2ADB98` | `(Ped ped) -> void` | SET_PED_SHOULD_PLAY_NORMAL_SCENARIO_EXIT |
| `SetPedShouldPlayImmediateScenarioExit`<br>`0xF1C03A5352243A30` | `(Ped ped) -> void` | SET_PED_SHOULD_PLAY_IMMEDIATE_SCENARIO_EXIT |
| `SetPedShouldPlayFleeScenarioExit`<br>`0xEEED8FAFEC331A70` | `(Ped ped, float x, float y, float z, int lookIntensity) -> bool` | lookIntensity: 0 - REACT_LOOK_NONE 1 - REACT_LOOK_LOW 2 - REACT_LOOK_MEDIUM 3 - REACT_LOOK_HIGH |
| `SetPedShouldPlayCombatScenarioExit`<br>`0x802092B07E3B1EEA` | `(Ped ped, float x, float y, float z, int lookIntensity) -> bool` | lookIntensity: see SET_PED_SHOULD_PLAY_FLEE_SCENARIO_EXIT |
| `SetPedShouldPlayEmotionalScenarioExit`<br>`0x62FDAD5E01D2DD47` | `(Ped ped, float x, float y, float z, int lookIntensity, bool p5) -> bool` | lookIntensity: see SET_PED_SHOULD_PLAY_FLEE_SCENARIO_EXIT |
| `SetPedShouldPlayQuickScenarioExit`<br>`0x463803429297117C` | `(Ped ped, float x, float y, float z, int lookIntensity, bool p5) -> bool` | lookIntensity: see SET_PED_SHOULD_PLAY_FLEE_SCENARIO_EXIT |

---

## Persistence and loot

| Native | Signature | Notes |
|---|---|---|
| `PersistenceAddScenarioLooted`<br>`0x8245C1F3262F4AC2` | `(int scenario) -> void` | PERSISTENCE_ADD_SCENARIO_LOOTED |
| `PersistenceIsScenarioMarkedAsLooted`<br>`0xFB7CF1DE938A3E22` | `(int scenario) -> bool` | _PERSISTENCE_IS_SCENARIO_MARKED_AS_LOOTED |
| `PersistenceIsScenarioMarkedAsLootedAtCoords`<br>`0xB6E1A185C2B9319A` | `(float x, float y, float z) -> bool` | _PERSISTENCE_IS_SCENARIO_MARKED_AS_LOOTED_AT_COORDS |
| `PersistenceIsScenarioMarkedAsLootedAtCoordsWithModel`<br>`0x188313616D184213` | `(float x, float y, float z, hash model) -> bool` | _PERSISTENCE_IS_SCENARIO_MARKED_AS_LOOTED_AT_COORDS_WITH_MODEL |


---

## When to use what

- **One scripted NPC at one chair** — use [natives_points.md](natives_points.md). Do not touch density or groups.
- **No ambient NPCs in a small area** — `AddScenarioBlockingArea` (and remove it on cleanup).
- **Disable a whole scenario type/group** — `SetScenarioTypeEnabled` / `SetScenarioGroupEnabled`, then reset when done.
- **Force a specific ped out of a scenario** — `SetPedShouldPlay*ScenarioExit` then clear the task.
- **Container/chest scenarios** — use the ransack container getters instead of guessing from the entity.

Global density multipliers are **this-frame** natives: call them every frame from a loop; they do not persist.
