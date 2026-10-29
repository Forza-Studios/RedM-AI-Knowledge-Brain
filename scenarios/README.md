---
title: Scenarios
category: Scenarios
tags:
  - scenarios
  - conditional-anims
  - ai
framework:
  - redm
difficulty: intermediate
last_updated: 2026-10-29
sources:
  - https://github.com/femga/rdr3_discoveries/blob/master/animations/scenarios/README.md
  - https://github.com/alloc8or/rdr3-nativedb-data
  - C:/redmWorkspace/RedM-AI-Knowledge-Brain/scenarios/scenarios.lua
---

# Scenarios

This folder covers the scenario system: scenario names, conditional animations, and the world markers that make ambient peds use them.

## Start here

| Page | What it covers |
|---|---|
| [scenario_points/README.md](scenario_points/README.md) | Scenario points: baked vs created, reading the 8-byte array, tasking a ped, seating triggers, cleanup |
| [scenario_points/chair_scenarios.md](scenario_points/chair_scenarios.md) | All 118 `PROP_HUMAN_SEAT_CHAIR_*` / `PROP_HUMAN_SEAT_BENCH_*` scenarios with conditional anim variants |
| [scenario_points/natives_points.md](scenario_points/natives_points.md) | Every scenario-point native with hash, Lua alias, signature, and notes |
| [scenario_points/natives_system.md](scenario_points/natives_system.md) | Density, groups, types, blocking volumes, exits, containers, persistence |
| [scenario_points/scenario_point_flags.md](scenario_points/scenario_point_flags.md) | Full `CScenarioPointFlags` enum, including the seating flags |
| [scenario_points/props.md](scenario_points/props.md) | Prop strings that scenarios attach to peds |
| [scenario_points/examples.lua](scenario_points/examples.lua) | Complete client example |
| [scenarios.lua](scenarios.lua) | Raw scenario-name list |

## The short version

A **scenario** is not an animation. It is a container that chooses a **conditional anim** based on conditions (gender, prop, time, ped commands, etc.) and then plays that anim's enter, base, exit, look, and reaction clips.

A **scenario point** is where that scenario is allowed to happen. Baked points ship with the map. Script-created points are owned by the script and must be deleted on cleanup.

See [../animations/scenarios/README.md](../animations/scenarios/README.md) for the full scenario/conditional-anim structure and condition rules.

## Related pages

- [Animations: scenarios](../animations/scenarios/README.md)
- [Tasks API](../docs/natives/tasks/api.md)
- [Native overview](../docs/natives/overview.md)
- [Scenario point native dataset](../datasets/scenario_points_natives.json)
- [Scenario conditional anim dataset](../datasets/scenario_conditional_anims.json)
- [Scenario attached prop dataset](../datasets/scenario_attached_props.json)

## Sources

- https://github.com/femga/rdr3_discoveries/blob/master/animations/scenarios/README.md
- https://github.com/femga/rdr3_discoveries/blob/master/animations/scenarios/scenario_types_with_conditional_anims.lua
- https://github.com/alloc8or/rdr3-nativedb-data
