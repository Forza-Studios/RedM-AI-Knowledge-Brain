# Blip Modifiers

- [Skip to Usage](#usage)
- [Skip to Details](#details)
- [Skip to Examples](#examples)

## Usage

```lua
local function CreateBlip(style, coords, modifiers, name)
  -- The blip's style is the base styling which can then be overridden by modifiers and natives
  local blip = BlipAddForCoords(style, coords.x, coords.y, coords.z)

  -- The modifier actions are applied in order, with natives respecting that order
  -- In this case, we are applying modifiers in order and then overriding the name below
  for _, modifier in ipairs(modifiers) do
    BlipAddModifier(blip, modifier)
  end

  -- Always override the blip name last after applying modifiers
  SetBlipName(blip, name)
end

-- Don't forget to remove the blip after you're done!
CreateBlip(
  `BLIP_STYLE_SHOP`,
  vector3(2508.1557, -1450.2551, 44.6105),
  { `BLIP_MODIFIER_TOD_DAYTIME_ONLY` },
  "Stables"
)
```

## Details

Hashname | Actions
--- | ---
BLIP_MODIFIER_ANIMAL_SKINNED | **Alpha**:&nbsp;0.65<br>**Range**:&nbsp;Zoom Level
BLIP_MODIFIER_AREA | **Alpha**:&nbsp;0.55 (for area layer)<br>**Category**:&nbsp;`OBJECTIVE_AREA`<br>**Conditional&nbsp;Style**:&nbsp;When entity inside blip area for 100ms:<br>- Apply `AUTO_MODIFIER_AREA_DIM_WHEN_INSIDE`<br>**Inverted&nbsp;State**:&nbsp;No
BLIP_MODIFIER_AREA_ACCURATE | **Alpha**:&nbsp;0.55 (for area layer)<br>**Area&nbsp;Style**:&nbsp;`AREA_ACCURATE`
BLIP_MODIFIER_AREA_CLAMPED_PULSE | **Alpha&nbsp;Pulse**:&nbsp;Pulse 100 times<br>- Duration: 4,000ms, Alpha: 0.5-1, Transition: Smooth
BLIP_MODIFIER_AREA_CONTESTED | **Alpha&nbsp;Pulse**:&nbsp;Pulse 100 times<br>- Duration: 0ms, Transition: Smooth
BLIP_MODIFIER_AREA_DIRECTIONAL | **Alpha**:&nbsp;0.55 (for area layer)<br>**Conditional&nbsp;Style**:&nbsp;When entity inside blip area for 100ms:<br>- Apply `AUTO_MODIFIER_AREA_DIM_WHEN_INSIDE`<br>**Directional&nbsp;Edge&nbsp;Pointer**:&nbsp;Yes<br>**Sprite**:&nbsp;`BLIP_RADAR_EDGE_ARROW`<br>**Visibility**:&nbsp;Hidden on `Legend`
BLIP_MODIFIER_AREA_HIDE_ON_INSIDE | **Alpha**:&nbsp;0.55 (for area layer)<br>**Category**:&nbsp;`OBJECTIVE_AREA`<br>**Conditional&nbsp;Visibility**:&nbsp;Toggle visibility when **NOT** entity inside blip area<br>**Inverted&nbsp;State**:&nbsp;No
BLIP_MODIFIER_AREA_HIDE_ON_OUTSIDE | **Alpha**:&nbsp;0.55 (for area layer)<br>**Category**:&nbsp;`OBJECTIVE_AREA`<br>**Conditional&nbsp;Visibility**:&nbsp;Toggle visibility when entity inside blip area<br>**Inverted&nbsp;State**:&nbsp;No
BLIP_MODIFIER_AREA_NO_BLIP | **Alpha**:&nbsp;0.55 (for area layer)<br>**Conditional&nbsp;Style**:&nbsp;When entity inside blip area for 100ms:<br>- Apply `AUTO_MODIFIER_AREA_DIM_WHEN_INSIDE`<br>**Directional&nbsp;Edge&nbsp;Pointer**:&nbsp;Yes<br>**Sprite**:&nbsp;`BLIP_NULL`<br>**Visibility**:&nbsp;Hidden on `Legend`
BLIP_MODIFIER_AREA_OUT_OF_BOUNDS | **Color**:&nbsp;`COLOR_RED`
BLIP_MODIFIER_AREA_PULSE | **Alpha&nbsp;Pulse**:&nbsp;Pulse 100 times<br>- Duration: 4,000ms, Transition: Smooth
BLIP_MODIFIER_AREA_TAKEOVER | **Alpha&nbsp;Pulse**:&nbsp;Pulse 100 times<br>- Duration: 1,000ms, Transition: Smooth
BLIP_MODIFIER_ATTENTION | **Overlay**:&nbsp;`BLIP_ATTENTION` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_BOUNTY_TARGET_INCAPACITATED | **Range**:&nbsp;Always<br>**Threat&nbsp;Indicator**:&nbsp;No
BLIP_MODIFIER_CAMP_NOT_READY | **Color**:&nbsp;`COLOR_LOW_PRIORITY`<br>**Sprite**:&nbsp;`BLIP_AMBIENT_CORPSE`
BLIP_MODIFIER_CHASE | **Conditional&nbsp;Removal**:&nbsp;Remove blip when has escaped (instantly)<br>**Conditional&nbsp;Style**:&nbsp;When has escaped:<br>- Apply `BLIP_MODIFIER_URGENT`
BLIP_MODIFIER_COLLECTIBLE_FULL | **Range**:&nbsp;150m
BLIP_MODIFIER_COMPANION_ACTIVITY | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_WHITE`<br>**Scale**:&nbsp;1.15
BLIP_MODIFIER_COMPANION_CONVERSATION | **Color**:&nbsp;`COLOR_RADAR_WRONG_TOD`<br>**Overlay**:&nbsp;`BLIP_ATTENTION` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_COMPANION_DOG | **Scale**:&nbsp;0.8
BLIP_MODIFIER_COMPANION_OBJECTIVE | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_OBJECTIVE`<br>**Scale**:&nbsp;1.15
BLIP_MODIFIER_COMPANION_WOUNDED | **Overlay**:&nbsp;`BLIP_OVERLAY_REVIVE` (with color `COLOR_WHITE`)
BLIP_MODIFIER_COMPASS_OBJECTIVE | **Objective**:&nbsp;Objective marker shown on Minimal radar, hidden when within 35m
BLIP_MODIFIER_CREATOR_FOCUS | **Category**:&nbsp;`CREATOR`
BLIP_MODIFIER_CULL_ON_DEATH | **Conditional&nbsp;Removal**:&nbsp;Remove blip when target is dead (instantly)
BLIP_MODIFIER_DEBUG_BLUE | **Category**:&nbsp;`ENEMY`<br>**Color**:&nbsp;`COLOR_BLUE`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_ENEMY`<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_AMBIENT_NPC`
BLIP_MODIFIER_DEBUG_GREEN | **Category**:&nbsp;`ENEMY`<br>**Color**:&nbsp;`COLOR_GREEN`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_ENEMY`<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_AMBIENT_NPC`
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_50 | **Range**:&nbsp;50m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_60 | **Range**:&nbsp;60m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_70 | **Range**:&nbsp;70m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_80 | **Range**:&nbsp;80m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_90 | **Range**:&nbsp;90m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_100 | **Range**:&nbsp;100m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_110 | **Range**:&nbsp;110m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_120 | **Range**:&nbsp;120m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_130 | **Range**:&nbsp;130m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_140 | **Range**:&nbsp;140m
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_150 | **Range**:&nbsp;150m
BLIP_MODIFIER_DEBUG_PINK | **Category**:&nbsp;`ENEMY`<br>**Color**:&nbsp;`COLOR_PINK`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_ENEMY`<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_AMBIENT_NPC`
BLIP_MODIFIER_DEBUG_RED | **Category**:&nbsp;`ENEMY`<br>**Color**:&nbsp;`COLOR_RED`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_ENEMY`<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_AMBIENT_NPC`
BLIP_MODIFIER_DEBUG_YELLOW | **Category**:&nbsp;`ENEMY`<br>**Color**:&nbsp;`COLOR_YELLOW`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_ENEMY`<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_AMBIENT_NPC`
BLIP_MODIFIER_DIRECTION_ONLY | **GPS&nbsp;Path**:&nbsp;Disabled<br>**Objective**:&nbsp;Objective marker shown on Minimal, Standard, Expanded radar<br>**Visibility**:&nbsp;Always hidden
BLIP_MODIFIER_DISTANCE_FADE_LONG | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 600m, Rate: 0.005, Minimum alpha: 0.5
BLIP_MODIFIER_DISTANCE_FADE_MEDIUM | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 300m, Rate: 0.005, Minimum alpha: 0.5
BLIP_MODIFIER_DISTANCE_FADE_SHORT | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 150m, Rate: 0.005, Minimum alpha: 0.5
BLIP_MODIFIER_EAGLE_EYE | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 20m, Rate: 0.05, Minimum alpha: 0.027<br>**Range**:&nbsp;75m
BLIP_MODIFIER_ENEMY | **Color**:&nbsp;`COLOR_ENEMY`<br>**Heading&nbsp;Type**:&nbsp;Off<br>**Height&nbsp;Indicator**:&nbsp;Yes
BLIP_MODIFIER_ENEMY_AQUATIC | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when enemy behavior<br>- Fade-in: 0ms, Stay: 1,000ms, Fade-out: 750ms
BLIP_MODIFIER_ENEMY_CONFRONTING | **Color**:&nbsp;`COLOR_REDDARK`
BLIP_MODIFIER_ENEMY_DISAPPEARING | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when enemy behavior<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_ENEMY_DISAPPEARING_NO_FLEE_CHECKS | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when enemy behavior (ignoring fleeing)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_ENEMY_DISAPPEARING_NO_SCREEN_CHECKS | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when enemy behavior (ignoring screen checks)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_ENEMY_FLEEING | **Conditional&nbsp;Style**:&nbsp;When fleeing (with flashing):<br>- Apply `AUTO_ENEMY_FLEEING`
BLIP_MODIFIER_ENEMY_GUNSHOTS_FADE_ON_START | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when gunshots heard<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms<br>- Applies to first appearance
BLIP_MODIFIER_ENEMY_GUNSHOTS_ONLY | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when gunshots heard<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_ENEMY_GUNSHOTS_ONLY_DONT_SHOW_LAST | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when gunshots heard (hiding last person)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_ENEMY_IMPORTANT | **Heading&nbsp;Type**:&nbsp;Off<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Range**:&nbsp;Always<br>**Scale&nbsp;Pulse**:&nbsp;Pulse 4 times
BLIP_MODIFIER_ENEMY_IS_ALERTED | **Color**:&nbsp;`COLOR_ENEMY`<br>**Heading&nbsp;Type**:&nbsp;Cone
BLIP_MODIFIER_ENEMY_LOWER_AWARENESS | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when enemy behavior (lowered awareness)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_ENEMY_MUST_AGGRO | **Color**:&nbsp;`COLOR_FRIENDLY`<br>**Conditional&nbsp;Styles**:&nbsp;When becoming hostile:<br>  - Apply `BLIP_MODIFIER_ENEMY`<br>  - Remove `BLIP_MODIFIER_ENEMY_MUST_AGGRO`
BLIP_MODIFIER_ENEMY_OBJECTIVE | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_ENEMY`<br>**Heading&nbsp;Type**:&nbsp;Off<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Range**:&nbsp;Always<br>**Scale&nbsp;Pulse**:&nbsp;Pulse 4 times<br>**Sprite**:&nbsp;`BLIP_OBJECTIVE`
BLIP_MODIFIER_ENEMY_ON_GUARD | **Color**:&nbsp;`COLOR_ENEMY_UNALERTED`<br>**Conditional&nbsp;Style**:&nbsp;When becoming hostile:<br>- Apply `AUTO_ENEMY_ANGRY`<br>**Heading&nbsp;Type**:&nbsp;Cone (with color `COLOR_WHITE`)
BLIP_MODIFIER_ENEMY_ON_GUARD_DISAPPEARING | **Color**:&nbsp;`COLOR_ENEMY_UNALERTED`<br>**Conditional&nbsp;Style**:&nbsp;When becoming hostile:<br>- Apply `AUTO_ENEMY_ANGRY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when enemy behavior<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms<br>**Heading&nbsp;Type**:&nbsp;Cone (with color `COLOR_WHITE`)
BLIP_MODIFIER_ENEMY_ON_GUARD_NO_CONE | **Color**:&nbsp;`COLOR_ENEMY_UNALERTED`<br>**Conditional&nbsp;Style**:&nbsp;When becoming hostile:<br>- Apply `AUTO_ENEMY_ANGRY`
BLIP_MODIFIER_ENEMY_STEALTH_KILL | **Color**:&nbsp;`COLOR_ENEMY_UNALERTED`<br>**Heading&nbsp;Type**:&nbsp;Cone (with color `COLOR_WHITE`)
BLIP_MODIFIER_ENEMY_TARGETED_ONLY | **Color**:&nbsp;`COLOR_ENEMY`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when being targeted<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_FADE | **Fade&nbsp;Effect&nbsp;2**:&nbsp;Triggers when style/modifier is removed:<br>- Fade-in: 1,000ms, Fade-out: 1,000ms
BLIP_MODIFIER_FADE_IN | **Fade&nbsp;Effect&nbsp;1**:&nbsp;Fade-in effect:<br>- Duration: 500ms
BLIP_MODIFIER_FADE_OUT_AND_DIE | **Conditional&nbsp;Removal**:&nbsp;Remove blip (fades over 1,500ms)
BLIP_MODIFIER_FADE_OUT_SLOW | **Fade&nbsp;Effect&nbsp;2**:&nbsp;Triggers when style/modifier is removed:<br>- Fade-in: 150ms, Fade-out: 5,000ms
BLIP_MODIFIER_FETCH_ESCAPING | **Distance&nbsp;Fade**:&nbsp;Fade only when on radar edge:<br>- Starts at 150m, Rate: 0.04, Minimum alpha: 0.5
BLIP_MODIFIER_FETCH_VIP | **Sprite**:&nbsp;`BLIP_AMBIENT_VIP`
BLIP_MODIFIER_FISHING_SPOT_LEGENDARY | **Range**:&nbsp;Map: Always, Radar: 50m
BLIP_MODIFIER_FISHING_SPOT_NORMAL | **Range**:&nbsp;50m
BLIP_MODIFIER_FLASH_FOREVER | **Flash&nbsp;Effect**:&nbsp;Flash forever
BLIP_MODIFIER_FLASH_LONG | **Flash&nbsp;Effect**:&nbsp;Flash 10 times
BLIP_MODIFIER_FLASH_MEDIUM | **Flash&nbsp;Effect**:&nbsp;Flash 5 times
BLIP_MODIFIER_FLASH_SHORT | **Flash&nbsp;Effect**:&nbsp;Flash 3 times
BLIP_MODIFIER_FOR_SALE | **Color**:&nbsp;`COLOR_RADAR_WRONG_TOD`<br>**Overlay**:&nbsp;`BLIP_FOR_SALE` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_FORCE_GPS | **GPS&nbsp;Path**:&nbsp;Enabled<br>- Auto-hide distance: 15m
BLIP_MODIFIER_FORCE_GPS_HORSE_ONLY | **Conditional&nbsp;Style**:&nbsp;When player is on horseback for 50ms:<br>- Apply `BLIP_MODIFIER_FORCE_GPS`
BLIP_MODIFIER_FRIENDLY | **Color**:&nbsp;`COLOR_FRIENDLY`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_FRIEND`
BLIP_MODIFIER_FRIENDLY_OBJECTIVE | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_OBJECTIVE`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_FRIEND`<br>**Scale**:&nbsp;Default: 1.1, Edge: 0.9
BLIP_MODIFIER_GROUPING_ANNESBURG_FOLLOWER | **Grouping**:&nbsp;Follower of `ANNESBURG` group
BLIP_MODIFIER_GROUPING_ANNESBURG_LEADER | **Grouping**:&nbsp;Leader of `ANNESBURG` group
BLIP_MODIFIER_GROUPING_ARMADILLO_FOLLOWER | **Grouping**:&nbsp;Follower of `ARMADILLO` group
BLIP_MODIFIER_GROUPING_ARMADILLO_LEADER | **Grouping**:&nbsp;Leader of `ARMADILLO` group
BLIP_MODIFIER_GROUPING_BLACKWATER_FOLLOWER | **Grouping**:&nbsp;Follower of `BLACKWATER` group
BLIP_MODIFIER_GROUPING_BLACKWATER_LEADER | **Grouping**:&nbsp;Leader of `BLACKWATER` group
BLIP_MODIFIER_GROUPING_CAMP_GROUP_FOLLOWER | **Grouping**:&nbsp;Follower of `CAMP` group
BLIP_MODIFIER_GROUPING_CAMP_GROUP_LEADER | **Grouping**:&nbsp;Leader of `CAMP` group
BLIP_MODIFIER_GROUPING_EMERALD_RANCH_FOLLOWER | **Grouping**:&nbsp;Follower of `EMERALD_RANCH` group
BLIP_MODIFIER_GROUPING_EMERALD_RANCH_LEADER | **Grouping**:&nbsp;Leader of `EMERALD_RANCH` group
BLIP_MODIFIER_GROUPING_LAGRAS_FOLLOWER | **Grouping**:&nbsp;Follower of `LAGRAS` group
BLIP_MODIFIER_GROUPING_LAGRAS_LEADER | **Grouping**:&nbsp;Leader of `LAGRAS` group
BLIP_MODIFIER_GROUPING_RHODES_FOLLOWER | **Grouping**:&nbsp;Follower of `RHODES` group
BLIP_MODIFIER_GROUPING_RHODES_LEADER | **Grouping**:&nbsp;Leader of `RHODES` group
BLIP_MODIFIER_GROUPING_SAINT_DENIS_FOLLOWER | **Grouping**:&nbsp;Follower of `SAINT_DENIS` group
BLIP_MODIFIER_GROUPING_SAINT_DENIS_LEADER | **Grouping**:&nbsp;Leader of `SAINT_DENIS` group
BLIP_MODIFIER_GROUPING_STRAWBERRY_FOLLOWER | **Grouping**:&nbsp;Follower of `STRAWBERRY` group
BLIP_MODIFIER_GROUPING_STRAWBERRY_LEADER | **Grouping**:&nbsp;Leader of `STRAWBERRY` group
BLIP_MODIFIER_GROUPING_THIEVES_LANDING_FOLLOWER | **Grouping**:&nbsp;Follower of `THIEVES_LANDING` group
BLIP_MODIFIER_GROUPING_THIEVES_LANDING_LEADER | **Grouping**:&nbsp;Leader of `THIEVES_LANDING` group
BLIP_MODIFIER_GROUPING_TUMBLEWEED_FOLLOWER | **Grouping**:&nbsp;Follower of `TUMBLEWEED` group
BLIP_MODIFIER_GROUPING_TUMBLEWEED_LEADER | **Grouping**:&nbsp;Leader of `TUMBLEWEED` group
BLIP_MODIFIER_GROUPING_VALENTINE_FOLLOWER | **Grouping**:&nbsp;Follower of `VALENTINE` group
BLIP_MODIFIER_GROUPING_VALENTINE_LEADER | **Grouping**:&nbsp;Leader of `VALENTINE` group
BLIP_MODIFIER_GROUPING_VAN_HORN_FOLLOWER | **Grouping**:&nbsp;Follower of `VAN_HORN` group
BLIP_MODIFIER_GROUPING_VAN_HORN_LEADER | **Grouping**:&nbsp;Leader of `VAN_HORN` group
BLIP_MODIFIER_HERB_NORMAL | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 20m, Rate: 0.15, Minimum alpha: 0.027<br>**Range**:&nbsp;31m
BLIP_MODIFIER_HERB_SHORT_RANGE | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 8m, Rate: 0.15, Minimum alpha: 0.027<br>**Range**:&nbsp;15m
BLIP_MODIFIER_HERB_SURVIVALIST | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 60m, Rate: 0.15, Minimum alpha: 0.027<br>**Range**:&nbsp;75m
BLIP_MODIFIER_HIDDEN | **Visibility**:&nbsp;Always hidden
BLIP_MODIFIER_HIDE_HEIGHT_MARKER | **Height&nbsp;Indicator**:&nbsp;No
BLIP_MODIFIER_HIDEOUT_ABANDONED | **Color**:&nbsp;`COLOR_RADAR_WRONG_TOD`<br>**Overlay**:&nbsp;`BLIP_TIME_OF_DAY` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_HIGH_CATEGORY | **Category**:&nbsp;`MISSION_ACTIVE`
BLIP_MODIFIER_HORSE_REVIVE | **Overlay**:&nbsp;`BLIP_OVERLAY_HORSE_REVIVE` (with color `COLOR_RED`)<br>**Scale&nbsp;Pulse**:&nbsp;Pulse 4 times
BLIP_MODIFIER_HORSE_REVIVE_2 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 2,500ms, Transition: Smooth<br>**Overlay**:&nbsp;`BLIP_OVERLAY_HORSE_REVIVE` (with color `COLOR_RED`)
BLIP_MODIFIER_HORSE_REVIVE_3 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 1,000ms, Transition: Smooth<br>**Overlay**:&nbsp;`BLIP_OVERLAY_HORSE_REVIVE` (with color `COLOR_RED`)
BLIP_MODIFIER_HORSE_REVIVE_4 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 500ms, Transition: Smooth<br>**Overlay**:&nbsp;`BLIP_OVERLAY_HORSE_REVIVE` (with color `COLOR_RED`)
BLIP_MODIFIER_HORSE_STOLEN | **Color**:&nbsp;`COLOR_ENEMY`
BLIP_MODIFIER_HOSTILITY_COLOR_1 | **Color**:&nbsp;`COLOR_NOTORIETY_LOW`
BLIP_MODIFIER_HOSTILITY_COLOR_2 | **Color**:&nbsp;`COLOR_NOTORIETY_MEDIUM`
BLIP_MODIFIER_HOSTILITY_COLOR_3 | **Color**:&nbsp;`COLOR_NOTORIETY_HIGH`
BLIP_MODIFIER_HOSTILITY_VISIBILITY_1 | **Category**:&nbsp;`OTHER_PLAYER`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when free roam player<br>- Fade-in: 150ms, Stay: 10,000ms, Fade-out: 1,000ms<br>**Range**:&nbsp;300m
BLIP_MODIFIER_HOSTILITY_VISIBILITY_2 | **Category**:&nbsp;`NOTORIETY_PLAYER_MEDIUM`<br>**Distance&nbsp;Fade**:&nbsp;Fade only when on radar edge:<br>- Starts at 280m, Rate: 0.05, Minimum alpha: 0.001<br>**Range**:&nbsp;300m
BLIP_MODIFIER_HOSTILITY_VISIBILITY_3 | **Category**:&nbsp;`NOTORIETY_PLAYER_HIGH`<br>**Distance&nbsp;Fade**:&nbsp;Fade only when on radar edge:<br>- Starts at 480m, Rate: 0.05, Minimum alpha: 0.001<br>**Range**:&nbsp;500m
BLIP_MODIFIER_HOSTILITY_VISIBILITY_4 | **Category**:&nbsp;`NOTORIETY_PLAYER_HIGH`<br>**Distance&nbsp;Fade**:&nbsp;Fade only when on radar edge:<br>- Starts at 480m, Rate: 0.05, Minimum alpha: 0.001<br>**Range**:&nbsp;Map: Always, Radar: 500m
BLIP_MODIFIER_JOB | **Overlay**:&nbsp;`BLIP_JOB` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_BILL | **Overlay**:&nbsp;`BLIP_OVERLAY_BILL` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_CHARLES | **Overlay**:&nbsp;`BLIP_OVERLAY_CHARLES` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_HOSEA | **Overlay**:&nbsp;`BLIP_OVERLAY_HOSEA` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_JAVIER | **Overlay**:&nbsp;`BLIP_OVERLAY_JAVIER` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_JOHN | **Overlay**:&nbsp;`BLIP_OVERLAY_JOHN` (with color `COLOR_OBJECTIVE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_KAREN | **Overlay**:&nbsp;`BLIP_OVERLAY_KAREN` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_KIERAN | **Overlay**:&nbsp;`BLIP_OVERLAY_KIERAN` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_LENNY | **Overlay**:&nbsp;`BLIP_OVERLAY_LENNY` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_LOANSHARK | **Overlay**:&nbsp;`BLIP_OVERLAY_LOANSHARK` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_MICAH | **Overlay**:&nbsp;`BLIP_OVERLAY_MICAH` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_PEARSON | **Overlay**:&nbsp;`BLIP_OVERLAY_PEARSON` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_SEAN | **Overlay**:&nbsp;`BLIP_OVERLAY_SEAN` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_STRAUSS | **Overlay**:&nbsp;`BLIP_OVERLAY_STRAUSS` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_TILLY | **Overlay**:&nbsp;`BLIP_OVERLAY_TILLY` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_JOB_UNCLE | **Overlay**:&nbsp;`BLIP_OVERLAY_UNCLE` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_KEY_JOB | **Overlay**:&nbsp;`BLIP_JOB` (with color `COLOR_OBJECTIVE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_KEY_MISSION | **Color**:&nbsp;`COLOR_OBJECTIVE`
BLIP_MODIFIER_KEY_MISSION_OBJECT | **Color**:&nbsp;`COLOR_OBJECTIVE`<br>**Inverted&nbsp;State**:&nbsp;No
BLIP_MODIFIER_LAW_ORDER | **Conditional&nbsp;Style**:&nbsp;When law location unknown:<br>- Apply `AUTO_MODIFIER_COP_SEARCH_CONE`<br>**Conditional&nbsp;Styles**:&nbsp;When known criminal identified:<br>  - Apply `AUTO_MODIFIER_COP_CRIMINAL_KNOWN`<br>  - Remove `AUTO_MODIFIER_COP_CRIMINAL_UNKNOWN`<br>Otherwise:<br>  - Apply `AUTO_MODIFIER_COP_CRIMINAL_UNKNOWN`<br>  - Remove `AUTO_MODIFIER_COP_CRIMINAL_KNOWN`<br>**Range**:&nbsp;Map: 300m, Radar: Zoom Level<br>**Threat&nbsp;Indicator**:&nbsp;Up to 200m
BLIP_MODIFIER_LEGENDARY | **Color**:&nbsp;`COLOR_YELLOWLIGHT`<br>**Range**:&nbsp;Map: Always, Radar: 150m
BLIP_MODIFIER_LOCAL_PLAYER_FOLLOWING_OBJECTIVE | **Color**:&nbsp;`COLOR_OBJECTIVE`
BLIP_MODIFIER_LOCAL_PLAYER_HOSTILITY_HIGH | **Flash&nbsp;Effect**:&nbsp;Flash 3 times<br>**Overlay**:&nbsp;`BLIP_CODE_CENTER_GLOW` (with color `COLOR_NOTORIETY_HIGH`)
BLIP_MODIFIER_LOCAL_PLAYER_HOSTILITY_MEDIUM | **Flash&nbsp;Effect**:&nbsp;Flash 3 times<br>**Overlay**:&nbsp;`BLIP_CODE_CENTER_GLOW_ALPHA` (with color `COLOR_NOTORIETY_HIGH`)
BLIP_MODIFIER_LOCAL_PLAYER_MADE_VISIBLE | **Flash&nbsp;Effect**:&nbsp;Flash forever
BLIP_MODIFIER_LOCAL_PLAYER_OWNED | **Color**:&nbsp;`COLOR_LOCAL_PLAYER`
BLIP_MODIFIER_LOCKED | **Alpha**:&nbsp;0.1 (for area layer)<br>**Color**:&nbsp;`COLOR_LOW_PRIORITY`<br>**Overlay**:&nbsp;`BLIP_LOCKED` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_LOOTED | **Alpha**:&nbsp;0.65
BLIP_MODIFIER_LOS_DISAPPEARING | **Conditional&nbsp;Visibility**:&nbsp;Fade when person in line of sight<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MC_STEALTH_LENIENT | **Conditional&nbsp;Visibility**:&nbsp;Fade when stealth detection (lenient)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MC_STEALTH_MEDIUM | **Conditional&nbsp;Visibility**:&nbsp;Fade when stealth detection (medium)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 150ms
BLIP_MODIFIER_MC_STEALTH_STRICT | **Conditional&nbsp;Visibility**:&nbsp;Fade when stealth detection (strict)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MC_STEALTH_VERY_LENIENT | **Conditional&nbsp;Visibility**:&nbsp;Fade when stealth detection (very lenient)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MC_STEALTH_VERY_STRICT | **Conditional&nbsp;Visibility**:&nbsp;Fade when stealth detection (very strict)<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MISSION_UNAVAILABLE | **Color**:&nbsp;`COLOR_RADAR_WRONG_TOD`<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_MP_COLOR_1 | **Color**:&nbsp;`COLOR_NET_PLAYER1`
BLIP_MODIFIER_MP_COLOR_2 | **Color**:&nbsp;`COLOR_NET_PLAYER2`
BLIP_MODIFIER_MP_COLOR_3 | **Color**:&nbsp;`COLOR_NET_PLAYER3`
BLIP_MODIFIER_MP_COLOR_4 | **Color**:&nbsp;`COLOR_NET_PLAYER4`
BLIP_MODIFIER_MP_COLOR_5 | **Color**:&nbsp;`COLOR_NET_PLAYER5`
BLIP_MODIFIER_MP_COLOR_6 | **Color**:&nbsp;`COLOR_NET_PLAYER6`
BLIP_MODIFIER_MP_COLOR_7 | **Color**:&nbsp;`COLOR_NET_PLAYER7`
BLIP_MODIFIER_MP_COLOR_8 | **Color**:&nbsp;`COLOR_NET_PLAYER8`
BLIP_MODIFIER_MP_COLOR_9 | **Color**:&nbsp;`COLOR_NET_PLAYER9`
BLIP_MODIFIER_MP_COLOR_10 | **Color**:&nbsp;`COLOR_NET_PLAYER10`
BLIP_MODIFIER_MP_COLOR_11 | **Color**:&nbsp;`COLOR_NET_PLAYER11`
BLIP_MODIFIER_MP_COLOR_12 | **Color**:&nbsp;`COLOR_NET_PLAYER12`
BLIP_MODIFIER_MP_COLOR_13 | **Color**:&nbsp;`COLOR_NET_PLAYER13`
BLIP_MODIFIER_MP_COLOR_14 | **Color**:&nbsp;`COLOR_NET_PLAYER14`
BLIP_MODIFIER_MP_COLOR_15 | **Color**:&nbsp;`COLOR_NET_PLAYER15`
BLIP_MODIFIER_MP_COLOR_16 | **Color**:&nbsp;`COLOR_NET_PLAYER16`
BLIP_MODIFIER_MP_COLOR_17 | **Color**:&nbsp;`COLOR_NET_PLAYER17`
BLIP_MODIFIER_MP_COLOR_18 | **Color**:&nbsp;`COLOR_NET_PLAYER18`
BLIP_MODIFIER_MP_COLOR_19 | **Color**:&nbsp;`COLOR_NET_PLAYER19`
BLIP_MODIFIER_MP_COLOR_20 | **Color**:&nbsp;`COLOR_NET_PLAYER20`
BLIP_MODIFIER_MP_COLOR_21 | **Color**:&nbsp;`COLOR_NET_PLAYER21`
BLIP_MODIFIER_MP_COLOR_22 | **Color**:&nbsp;`COLOR_NET_PLAYER22`
BLIP_MODIFIER_MP_COLOR_23 | **Color**:&nbsp;`COLOR_NET_PLAYER23`
BLIP_MODIFIER_MP_COLOR_24 | **Color**:&nbsp;`COLOR_NET_PLAYER24`
BLIP_MODIFIER_MP_COLOR_25 | **Color**:&nbsp;`COLOR_NET_PLAYER25`
BLIP_MODIFIER_MP_COLOR_26 | **Color**:&nbsp;`COLOR_NET_PLAYER26`
BLIP_MODIFIER_MP_COLOR_27 | **Color**:&nbsp;`COLOR_NET_PLAYER27`
BLIP_MODIFIER_MP_COLOR_28 | **Color**:&nbsp;`COLOR_NET_PLAYER28`
BLIP_MODIFIER_MP_COLOR_29 | **Color**:&nbsp;`COLOR_NET_PLAYER29`
BLIP_MODIFIER_MP_COLOR_30 | **Color**:&nbsp;`COLOR_NET_PLAYER30`
BLIP_MODIFIER_MP_COLOR_31 | **Color**:&nbsp;`COLOR_NET_PLAYER31`
BLIP_MODIFIER_MP_COLOR_32 | **Color**:&nbsp;`COLOR_NET_PLAYER32`
BLIP_MODIFIER_MP_DEADEYE | **Sprite**:&nbsp;`BLIP_MP_DEADEYE`
BLIP_MODIFIER_MP_DOWNED | **Category**:&nbsp;`MISSION_ACTIVE`<br>**Range**:&nbsp;Zoom Level<br>**Scale**:&nbsp;1.2<br>**Sprite**:&nbsp;`BLIP_AMBIENT_PED_DOWNED`
BLIP_MODIFIER_MP_ENEMY_HOLDING | **Color**:&nbsp;`COLOR_ENEMY`
BLIP_MODIFIER_MP_FREE_ROAM_EE_PLAYER_DISAPPEARING | **Conditional&nbsp;Visibility**:&nbsp;Fade when free roam player (EE)<br>- Fade-in: 150ms, Stay: 5,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MP_FREE_ROAM_MISSION_PLAYER_DISAPPEARING | **Conditional&nbsp;Visibility**:&nbsp;Fade when free roam player (mission)<br>- Fade-in: 150ms, Stay: 5,000ms, Fade-out: 2,000ms
BLIP_MODIFIER_MP_FREE_ROAM_PLAYER_DISAPPEARING | **Conditional&nbsp;Visibility**:&nbsp;Fade when free roam player<br>- Fade-in: 150ms, Stay: 5,000ms, Fade-out: 1,000ms
BLIP_MODIFIER_MP_FRIENDLY_HOLDING | **Color**:&nbsp;`COLOR_NET_PLAYER1`
BLIP_MODIFIER_MP_HOT_BLIP | **Color**:&nbsp;`COLOR_ORANGE`<br>**Range**:&nbsp;Always
BLIP_MODIFIER_MP_HUNTER | **Sprite**:&nbsp;`BLIP_AMBIENT_HUNTER`
BLIP_MODIFIER_MP_JOB_PLAYER_FADE | **Conditional&nbsp;Visibility**:&nbsp;Fade when enemy in deathmatch<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MP_JOB_PLAYER_FADE_THREAT | **Conditional&nbsp;Visibility**:&nbsp;Fade when enemy in deathmatch<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms<br>**Range**:&nbsp;Map: Always, Radar: Zoom Level<br>**Threat&nbsp;Indicator**:&nbsp;Up to 200m
BLIP_MODIFIER_MP_MARKED_FOR_DEATH | **Color**:&nbsp;`COLOR_ENEMY`<br>**Sprite**:&nbsp;`BLIP_AMBIENT_MARKED_FOR_DEATH`
BLIP_MODIFIER_MP_NEUTRAL | **Color**:&nbsp;`COLOR_MP_OBJECTIVE_NEUTRAL`
BLIP_MODIFIER_MP_OBJECTIVE | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_MP_OBJECTIVE`<br>**Range**:&nbsp;Always
BLIP_MODIFIER_MP_OBJECTIVE_ENEMY | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_MP_OBJECTIVE_ENEMY`<br>**Range**:&nbsp;Always
BLIP_MODIFIER_MP_OBJECTIVE_FRIENDLY | **Category**:&nbsp;`VIP`<br>**Color**:&nbsp;`COLOR_MP_OBJECTIVE_FRIENDLY`<br>**Range**:&nbsp;Always
BLIP_MODIFIER_MP_OBJECTIVE_NEUTRAL | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_MP_OBJECTIVE_NEUTRAL`<br>**Range**:&nbsp;Always
BLIP_MODIFIER_MP_OVERLAY_ANIMAL | **Overlay**:&nbsp;`BLIP_OVERLAY_ANIMAL` (with color `COLOR_YELLOWLIGHT`)
BLIP_MODIFIER_MP_OVERLAY_SEDATED | **Overlay**:&nbsp;`BLIP_OVERLAY_SEDATIVE` (with color `COLOR_WHITE`)
BLIP_MODIFIER_MP_PLAYER | _No actions_
BLIP_MODIFIER_MP_PLAYER_AGGRESSION | **Category**:&nbsp;`AGGRESSIVE_PLAYER`<br>**Color**:&nbsp;`COLOR_POSSE_ENEMY`
BLIP_MODIFIER_MP_PLAYER_ALLY | **Color**:&nbsp;`COLOR_NET_PLAYER1`
BLIP_MODIFIER_MP_PLAYER_ALLY_WOUNDED | **Overlay**:&nbsp;`BLIP_OVERLAY_REVIVE` (with color `COLOR_WHITE`)
BLIP_MODIFIER_MP_PLAYER_BAG | **Sprite**:&nbsp;`BLIP_CASH_BAG`
BLIP_MODIFIER_MP_PLAYER_CONTROL | **Category**:&nbsp;`OBJECTIVE`<br>**Scale**:&nbsp;1.2<br>**Scale&nbsp;Pulse**:&nbsp;Pulse 4 times
BLIP_MODIFIER_MP_PLAYER_COOP | **Color**:&nbsp;`COLOR_CO_OP_PLAYER`
BLIP_MODIFIER_MP_PLAYER_DISAPPEARING | **Conditional&nbsp;Visibility**:&nbsp;Fade when AIBlips_MP<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MP_PLAYER_ENEMY | **Color**:&nbsp;`COLOR_ENEMY`<br>**Range**:&nbsp;Zoom Level<br>**Threat&nbsp;Indicator**:&nbsp;Up to 200m
BLIP_MODIFIER_MP_PLAYER_FORCE_BLIPPED | **Conditional&nbsp;Style**:&nbsp;When PlayerOutOfThreatRange for 100ms:<br>- Apply `AUTO_MODIFIER_MAP_ONLY`
BLIP_MODIFIER_MP_PLAYER_KING | **Sprite**:&nbsp;`BLIP_AMBIENT_KING`
BLIP_MODIFIER_MP_PLAYER_LOS_ONLY | **Conditional&nbsp;Visibility**:&nbsp;Fade when person in line of sight<br>- Fade-in: 150ms, Stay: 2,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_MP_PLAYER_NEUTRAL | **Color**:&nbsp;`COLOR_LOW_PRIORITY`
BLIP_MODIFIER_MP_PLAYER_SOCIAL | **Range**:&nbsp;Map: Always
BLIP_MODIFIER_MP_PLAYER_UNAVAILABLE | **Alpha**:&nbsp;0.5
BLIP_MODIFIER_MP_PLAYER_WINNING | **Color**:&nbsp;`COLOR_WINNING_PLAYER`
BLIP_MODIFIER_MP_PLAYER_WITH_BOUNTY | **Color**:&nbsp;`COLOR_ENEMY`<br>**Sprite**:&nbsp;`BLIP_AMBIENT_BOUNTY_TARGET`
BLIP_MODIFIER_MP_REVIVE | **Overlay**:&nbsp;`BLIP_OVERLAY_REVIVE` (with color `COLOR_WHITE`)
BLIP_MODIFIER_MP_RIVAL_RACER | **Color**:&nbsp;`COLOR_ENEMY`
BLIP_MODIFIER_MP_SUPPLIES_BASE_1 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_1`
BLIP_MODIFIER_MP_SUPPLIES_BASE_2 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_2`
BLIP_MODIFIER_MP_SUPPLIES_BASE_3 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_3`
BLIP_MODIFIER_MP_SUPPLIES_BASE_4 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_4`
BLIP_MODIFIER_MP_SUPPLIES_BASE_5 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_5`
BLIP_MODIFIER_MP_SUPPLIES_BASE_6 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_6`
BLIP_MODIFIER_MP_SUPPLIES_BASE_7 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_7`
BLIP_MODIFIER_MP_SUPPLIES_BASE_8 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_8`
BLIP_MODIFIER_MP_SUPPLIES_BASE_9 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_9`
BLIP_MODIFIER_MP_SUPPLIES_BASE_10 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_10`
BLIP_MODIFIER_MP_SUPPLIES_BASE_11 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_11`
BLIP_MODIFIER_MP_SUPPLIES_BASE_12 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_12`
BLIP_MODIFIER_MP_SUPPLIES_BASE_13 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_13`
BLIP_MODIFIER_MP_SUPPLIES_BASE_14 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_14`
BLIP_MODIFIER_MP_SUPPLIES_BASE_15 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_15`
BLIP_MODIFIER_MP_SUPPLIES_BASE_16 | **Sprite**:&nbsp;`BLIP_MP_SUPPLIES_BASE_16`
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_1 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER1`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_2 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER2`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_3 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER3`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_4 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER4`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_5 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER5`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_6 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER6`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_7 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER7`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_8 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER8`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_9 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER9`)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_10 | **Overlay**:&nbsp;`BLIP_MP_SUPPLIES_OUTLINE` (with color `COLOR_NET_PLAYER10`)
BLIP_MODIFIER_MP_TEAM_COLOR_1 | **Color**:&nbsp;`COLOR_NET_PLAYER3`
BLIP_MODIFIER_MP_TEAM_COLOR_2 | **Color**:&nbsp;`COLOR_NET_PLAYER4`
BLIP_MODIFIER_MP_TEAM_COLOR_3 | **Color**:&nbsp;`COLOR_NET_PLAYER5`
BLIP_MODIFIER_MP_TEAM_COLOR_4 | **Color**:&nbsp;`COLOR_NET_PLAYER6`
BLIP_MODIFIER_MP_TEAM_COLOR_5 | **Color**:&nbsp;`COLOR_NET_PLAYER7`
BLIP_MODIFIER_MP_TEAM_COLOR_6 | **Color**:&nbsp;`COLOR_NET_PLAYER8`
BLIP_MODIFIER_MP_TEAM_COLOR_7 | **Color**:&nbsp;`COLOR_NET_PLAYER9`
BLIP_MODIFIER_MP_TEAM_COLOR_8 | **Color**:&nbsp;`COLOR_NET_PLAYER10`
BLIP_MODIFIER_MP_WHITE_FLAG | **Overlay**:&nbsp;`BLIP_OVERLAY_FLAG` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_NEUTRAL_AREA_ON_SNOW | **Alpha**:&nbsp;0.8 (for area layer)<br>**Category**:&nbsp;`COMPANION`<br>**Color**:&nbsp;`COLOR_PURE_WHITE`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_FRIEND`<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_AMBIENT_PED_MEDIUM`
BLIP_MODIFIER_NEUTRAL_ON_GUARD | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_OBJECTIVE`<br>**Heading&nbsp;Type**:&nbsp;Cone (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;1.1
BLIP_MODIFIER_OBJECTIVE | **Category**:&nbsp;`OBJECTIVE`<br>**Color**:&nbsp;`COLOR_OBJECTIVE`<br>**GPS&nbsp;Path**:&nbsp;Disabled<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Range**:&nbsp;Always
BLIP_MODIFIER_OBJECTIVE_GET_CLOSE | _No actions_
BLIP_MODIFIER_OBJECTIVE_LOW_CATEGORY | **Category**:&nbsp;`OBJECTIVE_AREA`
BLIP_MODIFIER_OPEN_RACE_CHECKPOINT | **Distance&nbsp;Fade**:&nbsp;Fade only when on radar edge:<br>- Starts at 100m, Rate: 0.005, Minimum alpha: 0.5
BLIP_MODIFIER_OUTSIDE_TOD | **Color**:&nbsp;`COLOR_RADAR_WRONG_TOD`<br>**Overlay**:&nbsp;`BLIP_TIME_OF_DAY` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_1 | **Overlay**:&nbsp;`BLIP_OVERLAY_1` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_2 | **Overlay**:&nbsp;`BLIP_OVERLAY_2` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_3 | **Overlay**:&nbsp;`BLIP_OVERLAY_3` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_4 | **Overlay**:&nbsp;`BLIP_OVERLAY_4` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_5 | **Overlay**:&nbsp;`BLIP_OVERLAY_5` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_6 | **Overlay**:&nbsp;`BLIP_OVERLAY_6` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_1 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER1`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_2 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER2`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_3 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER3`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_4 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER4`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_5 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER5`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_6 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER6`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_7 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER7`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_8 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER8`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_9 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER9`)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_10 | **Overlay**:&nbsp;`BLIP_OVERLAY_RING` (with color `COLOR_NET_PLAYER10`)
BLIP_MODIFIER_OVERLAY_SADDLE | **Overlay**:&nbsp;`BLIP_OVERLAY_SADDLE` (with color `COLOR_WHITE`)
BLIP_MODIFIER_OVERLAY_SADDLE_STOLEN | **Overlay**:&nbsp;`BLIP_OVERLAY_SADDLE` (with color `COLOR_ENEMY`)
BLIP_MODIFIER_OVERLAY_WHITE_1 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_1` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_2 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_2` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_3 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_3` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_4 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_4` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_5 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_5` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_6 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_6` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_7 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_7` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_8 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_8` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_9 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_9` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_10 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_10` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_11 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_11` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_12 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_12` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_13 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_13` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_14 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_14` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_15 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_15` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_OVERLAY_WHITE_16 | **Overlay**:&nbsp;`BLIP_OVERLAY_WHITE_16` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_PARTY | **Overlay**:&nbsp;`BLIP_OVERLAY_PARTY` (with color `COLOR_WHITE`)<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_PICKUP_NEW | **Overlay**:&nbsp;`BLIP_AMBIENT_NEW` (with color `COLOR_WHITE`)
BLIP_MODIFIER_PICKUP_PLACEMENT | **Conditional&nbsp;Style**:&nbsp;When pickup location has pickup for 100ms:<br>- Apply `BLIP_MODIFIER_HIDDEN`
BLIP_MODIFIER_PICKUP_SURVIVAL_MODES | **Range**:&nbsp;50m
BLIP_MODIFIER_PICKUP_UNAVAILABLE | **Alpha**:&nbsp;0.5
BLIP_MODIFIER_PICKUP_WEAPON_LEGENDARY | **Category**:&nbsp;`PICKUPS`<br>**Color**:&nbsp;`COLOR_YELLOWLIGHT`
BLIP_MODIFIER_PICKUP_WEAPON_NEW | **Category**:&nbsp;`PICKUPS`<br>**Color**:&nbsp;`COLOR_WHITE`<br>**Height&nbsp;Indicator**:&nbsp;Yes<br>**Label**:&nbsp;`BLIP_WEAPON`<br>**Range**:&nbsp;Map: Zoom Level, Radar: Zoom Level<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_WEAPON`
BLIP_MODIFIER_PICKUP_WEAPON_OF_CHOICE | **Color**:&nbsp;`COLOR_OBJECTIVE`
BLIP_MODIFIER_PICKUP_WEAPON_OWNED | **Category**:&nbsp;`PICKUPS`<br>**Color**:&nbsp;`COLOR_WHITE`
BLIP_MODIFIER_PICKUP_WEAPON_RARE | **Category**:&nbsp;`PICKUPS`<br>**Color**:&nbsp;`COLOR_BLUE`
BLIP_MODIFIER_PING_GUNSHOT | **Conditional&nbsp;Style**:&nbsp;When gunshots heard:<br>- Apply `AUTO_MODIFIER_PING_GUNSHOT`
BLIP_MODIFIER_PLAYER_HORSE_HITCHED | **Sprite**:&nbsp;`BLIP_HORSE_OWNED_HITCHED`
BLIP_MODIFIER_PLAYER_HORSE_IN_RANGE | **Color**:&nbsp;`COLOR_WHITE`
BLIP_MODIFIER_PLAYER_HORSE_IN_RANGE_WHISTLE | **Scale&nbsp;Pulse**:&nbsp;Pulse 4 times
BLIP_MODIFIER_PLAYER_HORSE_INACTIVE | **Color**:&nbsp;`COLOR_LOW_PRIORITY`
BLIP_MODIFIER_PLAYER_HORSE_OUT_OF_RANGE | **Color**:&nbsp;`COLOR_LOW_PRIORITY`
BLIP_MODIFIER_PLAYER_HORSE_OUT_OF_RANGE_WHISTLE | **Flash&nbsp;Effect**:&nbsp;Flash 4 times
BLIP_MODIFIER_POSSE_ALLY | **Alpha**:&nbsp;1<br>**Category**:&nbsp;`OTHER_PLAYER_FRIENDLY`<br>**Color**:&nbsp;`COLOR_POSSE_ALLY`<br>**Range**:&nbsp;Always
BLIP_MODIFIER_POSSE_ALLY_OWNED | **Color**:&nbsp;`COLOR_POSSE_ALLY`
BLIP_MODIFIER_POSSE_ENEMY | **Category**:&nbsp;`ENEMY`<br>**Color**:&nbsp;`COLOR_POSSE_ENEMY`<br>**Range**:&nbsp;Map: 300m, Radar: Zoom Level<br>**Threat&nbsp;Indicator**:&nbsp;Up to 300m
BLIP_MODIFIER_POSSE_ENEMY_OWNED | **Color**:&nbsp;`COLOR_POSSE_ENEMY`
BLIP_MODIFIER_POSSE_NEUTRAL | **Category**:&nbsp;`OTHER_PLAYER`<br>**Color**:&nbsp;`COLOR_POSSE_NEUTRAL`<br>**Distance&nbsp;Fade**:&nbsp;Fade only when on radar edge:<br>- Starts at 350m, Rate: 0.005, Minimum alpha: 0.001
BLIP_MODIFIER_POSSE_NEUTRAL_OWNED | **Color**:&nbsp;`COLOR_POSSE_NEUTRAL`
BLIP_MODIFIER_PREDATOR | **Conditional&nbsp;Visibility**:&nbsp;Fade when predator is damaged<br>- Fade-in: 150ms, Stay: 7,500ms, Fade-out: 1,500ms<br>**Sprite**:&nbsp;`BLIP_PREDATOR`
BLIP_MODIFIER_PREDATOR_5 | **Conditional&nbsp;Visibility**:&nbsp;Fade when predator is damaged<br>- Fade-in: 150ms, Stay: 5,000ms, Fade-out: 1,500ms<br>**Sprite**:&nbsp;`BLIP_PREDATOR`
BLIP_MODIFIER_PREDATOR_10 | **Conditional&nbsp;Visibility**:&nbsp;Fade when predator is damaged<br>- Fade-in: 150ms, Stay: 10,000ms, Fade-out: 1,500ms<br>**Sprite**:&nbsp;`BLIP_PREDATOR`
BLIP_MODIFIER_PULSE_FOREVER | **Scale&nbsp;Pulse**:&nbsp;Pulse forever
BLIP_MODIFIER_PULSE_THREE_TIMES | **Scale&nbsp;Pulse**:&nbsp;Pulse 3 times
BLIP_MODIFIER_PVP_TARGET | **Conditional&nbsp;Styles**:&nbsp;When PvP target tracked:<br>  - Apply `BLIP_MODIFIER_PVP_TARGET_TRACKED`<br>  - Remove `BLIP_MODIFIER_PVP_TARGET`<br>**Conditional&nbsp;Visibility**:&nbsp;Fade when PvP target seen<br>- Fade-in: 150ms, Stay: 20,000ms, Fade-out: 1,500ms
BLIP_MODIFIER_PVP_TARGET_TRACKED | **Conditional&nbsp;Styles**:&nbsp;When PvP target tracked:<br>None<br>Otherwise:<br>  - Apply `BLIP_MODIFIER_PVP_TARGET`<br>  - Remove `BLIP_MODIFIER_PVP_TARGET_TRACKED`
BLIP_MODIFIER_RACE_CHECKPOINT_ALT | **Color**:&nbsp;`COLOR_ORANGE`
BLIP_MODIFIER_RADAR_EDGE_ALWAYS | **Range**:&nbsp;Always
BLIP_MODIFIER_RADAR_EDGE_NEVER | **Range**:&nbsp;Zoom Level
BLIP_MODIFIER_RADAR_EDGE_PAUSE_MAP_NEVER | **Range**:&nbsp;Zoom Level<br>**Visibility**:&nbsp;Hidden on `PauseMap`, `Legend`
BLIP_MODIFIER_SCALE_1 | **Scale**:&nbsp;1.2
BLIP_MODIFIER_SCALE_2 | **Scale**:&nbsp;1.5
BLIP_MODIFIER_SELECTED_UP_SCALE | **Scale**:&nbsp;1.5
BLIP_MODIFIER_SHOP_UNAVAILABLE | **Color**:&nbsp;`COLOR_RADAR_WRONG_TOD`
BLIP_MODIFIER_SHOW_HEIGHT | **Height&nbsp;Indicator**:&nbsp;Yes
BLIP_MODIFIER_SHRINK_WARNING_1 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 1,000ms, Transition: Abrupt
BLIP_MODIFIER_SHRINK_WARNING_2 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 500ms, Transition: Abrupt
BLIP_MODIFIER_SP_DOWNED | **Category**:&nbsp;`LOOT`<br>**Color**:&nbsp;`COLOR_BLACK`<br>**Conditional&nbsp;Style**:&nbsp;When carrying an object:<br>- Apply `BLIP_MODIFIER_HIDDEN`<br>**Range**:&nbsp;Zoom Level<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_AMBIENT_CORPSE`
BLIP_MODIFIER_TEMP_HORSE_HITCHED | **Sprite**:&nbsp;`BLIP_HORSE_TEMP_HITCHED`
BLIP_MODIFIER_TEST_GPS_MODULE | **GPS&nbsp;Path**:&nbsp;Enabled<br>- Flags: Ignore one-way roads, Custom proximity logic
BLIP_MODIFIER_TEXT_ONLY | **Color**:&nbsp;`COLOR_GREY`<br>**Scale**:&nbsp;1<br>**Sprite**:&nbsp;`BLIP_CODE_LEVEL`<br>**Visibility**:&nbsp;Visible on `Embedded`
BLIP_MODIFIER_TOD_DAYTIME_ONLY | **Conditional&nbsp;Style**:&nbsp;When between 18:00 and 6:00:<br>- Apply `BLIP_MODIFIER_OUTSIDE_TOD`<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_TOD_NIGHTTIME_ONLY | **Conditional&nbsp;Style**:&nbsp;When between 7:00 and 17:00:<br>- Apply `BLIP_MODIFIER_OUTSIDE_TOD`<br>**Scale**:&nbsp;Default: 1, Edge: 0.9, Embedded: 0.9
BLIP_MODIFIER_TOWN_POSSE_MEMBER | **Range**:&nbsp;Zoom Level
BLIP_MODIFIER_TRACKING | **Tracking**:&nbsp;Tracking enabled<br>- Interval: 1,500ms, Style: `BLIP_STYLE_TRACKING_DOT`
BLIP_MODIFIER_TRAIN_MISSION | **Range**:&nbsp;Always
BLIP_MODIFIER_UNDISCOVERED | **Color**:&nbsp;`COLOR_RADAR_UNDISCOVERED`
BLIP_MODIFIER_URGENT | **Scale&nbsp;Pulse**:&nbsp;Pulse forever
BLIP_MODIFIER_URGENT_ALERT | **Timed&nbsp;Style**:&nbsp;Apply `BLIP_MODIFIER_URGENT_ALERT_INTERNAL` for 11,500ms
BLIP_MODIFIER_URGENT_ALERT_INTERNAL | **Category**:&nbsp;`OBJECTIVE`<br>**Range**:&nbsp;Always<br>**Scale&nbsp;Pulse**:&nbsp;Pulse 5 times
BLIP_MODIFIER_VERYHIGH_CATEGORY | **Category**:&nbsp;`VIP`
BLIP_MODIFIER_WANTED_PULSE_1 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 2,500ms, Alpha: 0.5-1, Transition: Abrupt
BLIP_MODIFIER_WANTED_PULSE_2 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 2,000ms, Alpha: 0.5-1, Transition: Abrupt
BLIP_MODIFIER_WANTED_PULSE_3 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 1,500ms, Alpha: 0.5-1, Transition: Abrupt
BLIP_MODIFIER_WANTED_PULSE_4 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 1,000ms, Alpha: 0.5-1, Transition: Abrupt
BLIP_MODIFIER_WANTED_PULSE_5 | **Alpha&nbsp;Pulse**:&nbsp;Pulse forever<br>- Duration: 500ms, Alpha: 0.5-1, Transition: Abrupt
BLIP_MODIFIER_WILDERNESS_CHEST_LONG | **Distance&nbsp;Fade**:&nbsp;Fade on distance:<br>- Starts at 20m, Rate: 0.15, Minimum alpha: 0.027<br>**Range**:&nbsp;30m
BLIP_MODIFIER_WITNESS_IDENTIFIED | **Color**:&nbsp;`COLOR_WITNESS_IDENTIFIED`
BLIP_MODIFIER_WITNESS_INVESTIGATING | **Color**:&nbsp;`COLOR_WITNESS_INVESTIGATING`<br>**Scale&nbsp;Pulse**:&nbsp;Pulse 4 times
BLIP_MODIFIER_WITNESS_UNIDENTIFIED | **Color**:&nbsp;`COLOR_WITNESS_UNIDENTIFIED`

### Conditional/Auto Modifiers

Hashname | Actions
--- | ---
AUTO_ENEMY_ANGRY | **Color**:&nbsp;`COLOR_ENEMY`<br>**Heading&nbsp;Type**:&nbsp;Off
AUTO_ENEMY_FLEEING | **Color**:&nbsp;`COLOR_WHITE`
AUTO_MODIFIER_AREA_DIM_WHEN_INSIDE | **Alpha**:&nbsp;0.45 (for area layer)
AUTO_MODIFIER_AREA_HIDE_WHEN_INSIDE | **Alpha**:&nbsp;0 (for area layer)
AUTO_MODIFIER_CENTER_HIDDEN | **Color**:&nbsp;`COLOR_LOW_PRIORITY`
AUTO_MODIFIER_CENTER_ON_HORSE | **Sprite**:&nbsp;`BLIP_CODE_CENTER_ON_HORSE`
AUTO_MODIFIER_COP_CRIMINAL_KNOWN | **Color**:&nbsp;`COLOR_RADAR_POLICE_RED`
AUTO_MODIFIER_COP_CRIMINAL_UNKNOWN | **Conditional&nbsp;Styles**:&nbsp;When potential suspect identified:<br>  - Apply `AUTO_MODIFIER_COP_POTENTIAL_SUSPECT`<br>  - Remove `AUTO_MODIFIER_COP_INVESTIGATING`<br>Otherwise:<br>  - Apply `AUTO_MODIFIER_COP_INVESTIGATING`<br>  - Remove `AUTO_MODIFIER_COP_POTENTIAL_SUSPECT`
AUTO_MODIFIER_COP_INVESTIGATING | **Color**:&nbsp;`COLOR_WHITE`
AUTO_MODIFIER_COP_POTENTIAL_SUSPECT | **Color**:&nbsp;`COLOR_RADAR_POLICE_LOOKING`
AUTO_MODIFIER_COP_SEARCH_CONE | **Heading&nbsp;Type**:&nbsp;Cone (with color `COLOR_WHITE`)
AUTO_MODIFIER_MAP_ONLY | **Visibility**:&nbsp;Hidden on `Radar`
AUTO_MODIFIER_MOONSHINE_AREA_DIM_WHEN_INSIDE | **Alpha**:&nbsp;0.25 (for area layer)
AUTO_MODIFIER_MP_PLAYER_ATTACKING | **Scale&nbsp;Pulse**:&nbsp;Pulse forever
AUTO_MODIFIER_MP_PLAYER_ATTACKING_FTB | **Color**:&nbsp;`COLOR_ENEMY`<br>**Scale&nbsp;Pulse**:&nbsp;Pulse forever
AUTO_MODIFIER_PING_GUNSHOT | **Range**:&nbsp;Always<br>**Sonar&nbsp;Pulse**:&nbsp;Pulse 1 time<br>- Radius: 70m, Duration: 1,200ms
AUTO_MODIFIER_SAFE_AREA_DIM_WHEN_INSIDE | **Alpha**:&nbsp;0.3 (for area layer)<br>**Color**:&nbsp;`COLOR_WHITE`
AUTO_MODIFIER_WANTED_FLASH | **Alpha**:&nbsp;0.9 (for area layer)<br>**Color**:&nbsp;`COLOR_WHITE` (for area layer)<br>**Sonar&nbsp;Pulse**:&nbsp;Pulse 1 time<br>- Radius: 100m, Duration: 800ms
AUTO_MODIFIER_WITNESS_IDENTIFIED | **Color**:&nbsp;`COLOR_WITNESS_IDENTIFIED`
AUTO_MODIFIER_WITNESS_INVESTIGATING | **Color**:&nbsp;`COLOR_WITNESS_INVESTIGATING`<br>**Scale&nbsp;Pulse**:&nbsp;Pulse 4 times
AUTO_MODIFIER_WITNESS_LAW | **Heading&nbsp;Type**:&nbsp;Cone (with color `COLOR_WHITE`)<br>**Sprite**:&nbsp;`BLIP_AMBIENT_LAW`
AUTO_MODIFIER_WITNESS_UNIDENTIFIED | **Color**:&nbsp;`COLOR_WITNESS_UNIDENTIFIED`

## Examples

Hashname | Examples
------------ | ----------------
BLIP_MODIFIER_ANIMAL_SKINNED<br>BLIP_MODIFIER_AREA<br>BLIP_MODIFIER_AREA_ACCURATE<br>BLIP_MODIFIER_AREA_CLAMPED_PULSE<br>BLIP_MODIFIER_AREA_CONTESTED<br>BLIP_MODIFIER_AREA_DIRECTIONAL<br>BLIP_MODIFIER_AREA_HIDE_ON_INSIDE<br>BLIP_MODIFIER_AREA_HIDE_ON_OUTSIDE<br>BLIP_MODIFIER_AREA_NO_BLIP<br>BLIP_MODIFIER_AREA_OUT_OF_BOUNDS | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_001.jpeg)
BLIP_MODIFIER_AREA_PULSE<br>BLIP_MODIFIER_AREA_TAKEOVER<br>BLIP_MODIFIER_ATTENTION<br>BLIP_MODIFIER_BOUNTY_TARGET_INCAPACITATED<br>BLIP_MODIFIER_CAMP_NOT_READY<br>BLIP_MODIFIER_CHASE<br>BLIP_MODIFIER_COLLECTIBLE_FULL<br>BLIP_MODIFIER_COMPANION_ACTIVITY<br>BLIP_MODIFIER_COMPANION_CONVERSATION<br>BLIP_MODIFIER_COMPANION_DOG | ![screen_2.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_002.jpeg)
BLIP_MODIFIER_COMPANION_OBJECTIVE<br>BLIP_MODIFIER_COMPANION_WOUNDED<br>BLIP_MODIFIER_COMPASS_OBJECTIVE<br>BLIP_MODIFIER_CREATOR_FOCUS<br>BLIP_MODIFIER_CULL_ON_DEATH<br>BLIP_MODIFIER_DEBUG_BLUE<br>BLIP_MODIFIER_DEBUG_GREEN<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_50<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_60<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_70 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_003.jpeg)
BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_80<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_90<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_100<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_110<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_120<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_130<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_140<br>BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_150<br>BLIP_MODIFIER_DEBUG_PINK<br>BLIP_MODIFIER_DEBUG_RED | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_004.jpeg)
BLIP_MODIFIER_DEBUG_YELLOW<br>BLIP_MODIFIER_DIRECTION_ONLY<br>BLIP_MODIFIER_DISTANCE_FADE_LONG<br>BLIP_MODIFIER_DISTANCE_FADE_MEDIUM<br>BLIP_MODIFIER_DISTANCE_FADE_SHORT<br>BLIP_MODIFIER_EAGLE_EYE<br>BLIP_MODIFIER_ENEMY<br>BLIP_MODIFIER_ENEMY_AQUATIC<br>BLIP_MODIFIER_ENEMY_CONFRONTING<br>BLIP_MODIFIER_ENEMY_DISAPPEARING | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_005.jpeg)
BLIP_MODIFIER_ENEMY_DISAPPEARING_NO_FLEE_CHECKS<br>BLIP_MODIFIER_ENEMY_DISAPPEARING_NO_SCREEN_CHECKS<br>BLIP_MODIFIER_ENEMY_FLEEING<br>BLIP_MODIFIER_ENEMY_GUNSHOTS_FADE_ON_START<br>BLIP_MODIFIER_ENEMY_GUNSHOTS_ONLY<br>BLIP_MODIFIER_ENEMY_GUNSHOTS_ONLY_DONT_SHOW_LAST<br>BLIP_MODIFIER_ENEMY_IMPORTANT<br>BLIP_MODIFIER_ENEMY_IS_ALERTED<br>BLIP_MODIFIER_ENEMY_LOWER_AWARENESS<br>BLIP_MODIFIER_ENEMY_MUST_AGGRO | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_006.jpeg)
BLIP_MODIFIER_ENEMY_OBJECTIVE<br>BLIP_MODIFIER_ENEMY_ON_GUARD<br>BLIP_MODIFIER_ENEMY_ON_GUARD_DISAPPEARING<br>BLIP_MODIFIER_ENEMY_ON_GUARD_NO_CONE<br>BLIP_MODIFIER_ENEMY_STEALTH_KILL<br>BLIP_MODIFIER_ENEMY_TARGETED_ONLY<br>BLIP_MODIFIER_FADE<br>BLIP_MODIFIER_FADE_IN<br>BLIP_MODIFIER_FADE_OUT_AND_DIE<br>BLIP_MODIFIER_FADE_OUT_SLOW | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_007.jpeg)
BLIP_MODIFIER_FETCH_ESCAPING<br>BLIP_MODIFIER_FETCH_VIP<br>BLIP_MODIFIER_FISHING_SPOT_LEGENDARY<br>BLIP_MODIFIER_FISHING_SPOT_NORMAL<br>BLIP_MODIFIER_FLASH_FOREVER<br>BLIP_MODIFIER_FLASH_LONG<br>BLIP_MODIFIER_FLASH_MEDIUM<br>BLIP_MODIFIER_FLASH_SHORT<br>BLIP_MODIFIER_FORCE_GPS<br>BLIP_MODIFIER_FORCE_GPS_HORSE_ONLY | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_008.jpeg)
BLIP_MODIFIER_FOR_SALE<br>BLIP_MODIFIER_FRIENDLY<br>BLIP_MODIFIER_FRIENDLY_OBJECTIVE<br>BLIP_MODIFIER_GROUPING_ANNESBURG_FOLLOWER<br>BLIP_MODIFIER_GROUPING_ANNESBURG_LEADER<br>BLIP_MODIFIER_GROUPING_ARMADILLO_FOLLOWER<br>BLIP_MODIFIER_GROUPING_ARMADILLO_LEADER<br>BLIP_MODIFIER_GROUPING_BLACKWATER_FOLLOWER<br>BLIP_MODIFIER_GROUPING_BLACKWATER_LEADER<br>BLIP_MODIFIER_GROUPING_CAMP_GROUP_FOLLOWER | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_009.jpeg)
BLIP_MODIFIER_GROUPING_CAMP_GROUP_LEADER<br>BLIP_MODIFIER_GROUPING_EMERALD_RANCH_FOLLOWER<br>BLIP_MODIFIER_GROUPING_EMERALD_RANCH_LEADER<br>BLIP_MODIFIER_GROUPING_LAGRAS_FOLLOWER<br>BLIP_MODIFIER_GROUPING_LAGRAS_LEADER<br>BLIP_MODIFIER_GROUPING_RHODES_FOLLOWER<br>BLIP_MODIFIER_GROUPING_RHODES_LEADER<br>BLIP_MODIFIER_GROUPING_SAINT_DENIS_FOLLOWER<br>BLIP_MODIFIER_GROUPING_SAINT_DENIS_LEADER<br>BLIP_MODIFIER_GROUPING_STRAWBERRY_FOLLOWER | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_010.jpeg)
BLIP_MODIFIER_GROUPING_STRAWBERRY_LEADER<br>BLIP_MODIFIER_GROUPING_THIEVES_LANDING_FOLLOWER<br>BLIP_MODIFIER_GROUPING_THIEVES_LANDING_LEADER<br>BLIP_MODIFIER_GROUPING_TUMBLEWEED_FOLLOWER<br>BLIP_MODIFIER_GROUPING_TUMBLEWEED_LEADER<br>BLIP_MODIFIER_GROUPING_VALENTINE_FOLLOWER<br>BLIP_MODIFIER_GROUPING_VALENTINE_LEADER<br>BLIP_MODIFIER_GROUPING_VAN_HORN_FOLLOWER<br>BLIP_MODIFIER_GROUPING_VAN_HORN_LEADER<br>BLIP_MODIFIER_HERB_NORMAL | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_011.jpeg)
BLIP_MODIFIER_HERB_SHORT_RANGE<br>BLIP_MODIFIER_HERB_SURVIVALIST<br>BLIP_MODIFIER_HIDDEN<br>BLIP_MODIFIER_HIDEOUT_ABANDONED<br>BLIP_MODIFIER_HIDE_HEIGHT_MARKER<br>BLIP_MODIFIER_HIGH_CATEGORY<br>BLIP_MODIFIER_HORSE_REVIVE<br>BLIP_MODIFIER_HORSE_REVIVE_2<br>BLIP_MODIFIER_HORSE_REVIVE_3<br>BLIP_MODIFIER_HORSE_REVIVE_4 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_012.jpeg)
BLIP_MODIFIER_HORSE_STOLEN<br>BLIP_MODIFIER_HOSTILITY_COLOR_1<br>BLIP_MODIFIER_HOSTILITY_COLOR_2<br>BLIP_MODIFIER_HOSTILITY_COLOR_3<br>BLIP_MODIFIER_HOSTILITY_VISIBILITY_1<br>BLIP_MODIFIER_HOSTILITY_VISIBILITY_2<br>BLIP_MODIFIER_HOSTILITY_VISIBILITY_3<br>BLIP_MODIFIER_HOSTILITY_VISIBILITY_4<br>BLIP_MODIFIER_JOB<br>BLIP_MODIFIER_JOB_BILL | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_013.jpeg)
BLIP_MODIFIER_JOB_CHARLES<br>BLIP_MODIFIER_JOB_HOSEA<br>BLIP_MODIFIER_JOB_JAVIER<br>BLIP_MODIFIER_JOB_JOHN<br>BLIP_MODIFIER_JOB_KAREN<br>BLIP_MODIFIER_JOB_KIERAN<br>BLIP_MODIFIER_JOB_LENNY<br>BLIP_MODIFIER_JOB_LOANSHARK<br>BLIP_MODIFIER_JOB_MICAH<br>BLIP_MODIFIER_JOB_PEARSON | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_014.jpeg)
BLIP_MODIFIER_JOB_SEAN<br>BLIP_MODIFIER_JOB_STRAUSS<br>BLIP_MODIFIER_JOB_TILLY<br>BLIP_MODIFIER_JOB_UNCLE<br>BLIP_MODIFIER_KEY_JOB<br>BLIP_MODIFIER_KEY_MISSION<br>BLIP_MODIFIER_KEY_MISSION_OBJECT<br>BLIP_MODIFIER_LAW_ORDER<br>BLIP_MODIFIER_LEGENDARY<br>BLIP_MODIFIER_LOCAL_PLAYER_FOLLOWING_OBJECTIVE | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_015.jpeg)
BLIP_MODIFIER_LOCAL_PLAYER_HOSTILITY_HIGH<br>BLIP_MODIFIER_LOCAL_PLAYER_HOSTILITY_MEDIUM<br>BLIP_MODIFIER_LOCAL_PLAYER_MADE_VISIBLE<br>BLIP_MODIFIER_LOCAL_PLAYER_OWNED<br>BLIP_MODIFIER_LOCKED<br>BLIP_MODIFIER_LOOTED<br>BLIP_MODIFIER_LOS_DISAPPEARING<br>BLIP_MODIFIER_MC_STEALTH_LENIENT<br>BLIP_MODIFIER_MC_STEALTH_MEDIUM<br>BLIP_MODIFIER_MC_STEALTH_STRICT | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_016.jpeg)
BLIP_MODIFIER_MC_STEALTH_VERY_LENIENT<br>BLIP_MODIFIER_MC_STEALTH_VERY_STRICT<br>BLIP_MODIFIER_MISSION_UNAVAILABLE<br>BLIP_MODIFIER_MP_COLOR_1<br>BLIP_MODIFIER_MP_COLOR_2<br>BLIP_MODIFIER_MP_COLOR_3<br>BLIP_MODIFIER_MP_COLOR_4<br>BLIP_MODIFIER_MP_COLOR_5<br>BLIP_MODIFIER_MP_COLOR_6<br>BLIP_MODIFIER_MP_COLOR_7 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_017.jpeg)
BLIP_MODIFIER_MP_COLOR_8<br>BLIP_MODIFIER_MP_COLOR_9<br>BLIP_MODIFIER_MP_COLOR_10<br>BLIP_MODIFIER_MP_COLOR_11<br>BLIP_MODIFIER_MP_COLOR_12<br>BLIP_MODIFIER_MP_COLOR_13<br>BLIP_MODIFIER_MP_COLOR_14<br>BLIP_MODIFIER_MP_COLOR_15<br>BLIP_MODIFIER_MP_COLOR_16<br>BLIP_MODIFIER_MP_COLOR_17 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_018.jpeg)
BLIP_MODIFIER_MP_COLOR_18<br>BLIP_MODIFIER_MP_COLOR_19<br>BLIP_MODIFIER_MP_COLOR_20<br>BLIP_MODIFIER_MP_COLOR_21<br>BLIP_MODIFIER_MP_COLOR_22<br>BLIP_MODIFIER_MP_COLOR_23<br>BLIP_MODIFIER_MP_COLOR_24<br>BLIP_MODIFIER_MP_COLOR_25<br>BLIP_MODIFIER_MP_COLOR_26<br>BLIP_MODIFIER_MP_COLOR_27 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_019.jpeg)
BLIP_MODIFIER_MP_COLOR_28<br>BLIP_MODIFIER_MP_COLOR_29<br>BLIP_MODIFIER_MP_COLOR_30<br>BLIP_MODIFIER_MP_COLOR_31<br>BLIP_MODIFIER_MP_COLOR_32<br>BLIP_MODIFIER_MP_DEADEYE<br>BLIP_MODIFIER_MP_DOWNED<br>BLIP_MODIFIER_MP_ENEMY_HOLDING<br>BLIP_MODIFIER_MP_FREE_ROAM_EE_PLAYER_DISAPPEARING<br>BLIP_MODIFIER_MP_FREE_ROAM_MISSION_PLAYER_DISAPPEARING | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_020.jpeg)
BLIP_MODIFIER_MP_FREE_ROAM_PLAYER_DISAPPEARING<br>BLIP_MODIFIER_MP_FRIENDLY_HOLDING<br>BLIP_MODIFIER_MP_HOT_BLIP<br>BLIP_MODIFIER_MP_HUNTER<br>BLIP_MODIFIER_MP_JOB_PLAYER_FADE<br>BLIP_MODIFIER_MP_JOB_PLAYER_FADE_THREAT<br>BLIP_MODIFIER_MP_MARKED_FOR_DEATH<br>BLIP_MODIFIER_MP_NEUTRAL<br>BLIP_MODIFIER_MP_OBJECTIVE<br>BLIP_MODIFIER_MP_OBJECTIVE_ENEMY | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_021.jpeg)
BLIP_MODIFIER_MP_OBJECTIVE_FRIENDLY<br>BLIP_MODIFIER_MP_OBJECTIVE_NEUTRAL<br>BLIP_MODIFIER_MP_OVERLAY_ANIMAL<br>BLIP_MODIFIER_MP_OVERLAY_SEDATED<br>BLIP_MODIFIER_MP_PLAYER<br>BLIP_MODIFIER_MP_PLAYER_AGGRESSION<br>BLIP_MODIFIER_MP_PLAYER_ALLY<br>BLIP_MODIFIER_MP_PLAYER_ALLY_WOUNDED<br>BLIP_MODIFIER_MP_PLAYER_BAG<br>BLIP_MODIFIER_MP_PLAYER_CONTROL | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_022.jpeg)
BLIP_MODIFIER_MP_PLAYER_COOP<br>BLIP_MODIFIER_MP_PLAYER_DISAPPEARING<br>BLIP_MODIFIER_MP_PLAYER_ENEMY<br>BLIP_MODIFIER_MP_PLAYER_FORCE_BLIPPED<br>BLIP_MODIFIER_MP_PLAYER_KING<br>BLIP_MODIFIER_MP_PLAYER_LOS_ONLY<br>BLIP_MODIFIER_MP_PLAYER_NEUTRAL<br>BLIP_MODIFIER_MP_PLAYER_SOCIAL<br>BLIP_MODIFIER_MP_PLAYER_UNAVAILABLE<br>BLIP_MODIFIER_MP_PLAYER_WINNING | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_023.jpeg)
BLIP_MODIFIER_MP_PLAYER_WITH_BOUNTY<br>BLIP_MODIFIER_MP_REVIVE<br>BLIP_MODIFIER_MP_RIVAL_RACER<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_1<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_2<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_3<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_4<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_5<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_6<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_7 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_024.jpeg)
BLIP_MODIFIER_MP_SUPPLIES_BASE_8<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_9<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_10<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_11<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_12<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_13<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_14<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_15<br>BLIP_MODIFIER_MP_SUPPLIES_BASE_16<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_1 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_025.jpeg)
BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_2<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_3<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_4<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_5<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_6<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_7<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_8<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_9<br>BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_10<br>BLIP_MODIFIER_MP_TEAM_COLOR_1 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_026.jpeg)
BLIP_MODIFIER_MP_TEAM_COLOR_2<br>BLIP_MODIFIER_MP_TEAM_COLOR_3<br>BLIP_MODIFIER_MP_TEAM_COLOR_4<br>BLIP_MODIFIER_MP_TEAM_COLOR_5<br>BLIP_MODIFIER_MP_TEAM_COLOR_6<br>BLIP_MODIFIER_MP_TEAM_COLOR_7<br>BLIP_MODIFIER_MP_TEAM_COLOR_8<br>BLIP_MODIFIER_MP_WHITE_FLAG<br>BLIP_MODIFIER_NEUTRAL_AREA_ON_SNOW<br>BLIP_MODIFIER_NEUTRAL_ON_GUARD | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_027.jpeg)
BLIP_MODIFIER_OBJECTIVE<br>BLIP_MODIFIER_OBJECTIVE_GET_CLOSE<br>BLIP_MODIFIER_OBJECTIVE_LOW_CATEGORY<br>BLIP_MODIFIER_OPEN_RACE_CHECKPOINT<br>BLIP_MODIFIER_OUTSIDE_TOD<br>BLIP_MODIFIER_OVERLAY_1<br>BLIP_MODIFIER_OVERLAY_2<br>BLIP_MODIFIER_OVERLAY_3<br>BLIP_MODIFIER_OVERLAY_4<br>BLIP_MODIFIER_OVERLAY_5 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_028.jpeg)
BLIP_MODIFIER_OVERLAY_6<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_1<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_2<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_3<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_4<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_5<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_6<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_7<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_8<br>BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_9 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_029.jpeg)
BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_10<br>BLIP_MODIFIER_OVERLAY_SADDLE<br>BLIP_MODIFIER_OVERLAY_SADDLE_STOLEN<br>BLIP_MODIFIER_OVERLAY_WHITE_1<br>BLIP_MODIFIER_OVERLAY_WHITE_2<br>BLIP_MODIFIER_OVERLAY_WHITE_3<br>BLIP_MODIFIER_OVERLAY_WHITE_4<br>BLIP_MODIFIER_OVERLAY_WHITE_5<br>BLIP_MODIFIER_OVERLAY_WHITE_6<br>BLIP_MODIFIER_OVERLAY_WHITE_7 | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_030.jpeg)
BLIP_MODIFIER_OVERLAY_WHITE_8<br>BLIP_MODIFIER_OVERLAY_WHITE_9<br>BLIP_MODIFIER_OVERLAY_WHITE_10<br>BLIP_MODIFIER_OVERLAY_WHITE_11<br>BLIP_MODIFIER_OVERLAY_WHITE_12<br>BLIP_MODIFIER_OVERLAY_WHITE_13<br>BLIP_MODIFIER_OVERLAY_WHITE_14<br>BLIP_MODIFIER_OVERLAY_WHITE_15<br>BLIP_MODIFIER_OVERLAY_WHITE_16<br>BLIP_MODIFIER_PARTY | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_031.jpeg)
BLIP_MODIFIER_PICKUP_NEW<br>BLIP_MODIFIER_PICKUP_PLACEMENT<br>BLIP_MODIFIER_PICKUP_SURVIVAL_MODES<br>BLIP_MODIFIER_PICKUP_UNAVAILABLE<br>BLIP_MODIFIER_PICKUP_WEAPON_LEGENDARY<br>BLIP_MODIFIER_PICKUP_WEAPON_NEW<br>BLIP_MODIFIER_PICKUP_WEAPON_OF_CHOICE<br>BLIP_MODIFIER_PICKUP_WEAPON_OWNED<br>BLIP_MODIFIER_PICKUP_WEAPON_RARE<br>BLIP_MODIFIER_PING_GUNSHOT | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_032.jpeg)
BLIP_MODIFIER_PLAYER_HORSE_HITCHED<br>BLIP_MODIFIER_PLAYER_HORSE_INACTIVE<br>BLIP_MODIFIER_PLAYER_HORSE_IN_RANGE<br>BLIP_MODIFIER_PLAYER_HORSE_IN_RANGE_WHISTLE<br>BLIP_MODIFIER_PLAYER_HORSE_OUT_OF_RANGE<br>BLIP_MODIFIER_PLAYER_HORSE_OUT_OF_RANGE_WHISTLE<br>BLIP_MODIFIER_POSSE_ALLY<br>BLIP_MODIFIER_POSSE_ALLY_OWNED<br>BLIP_MODIFIER_POSSE_ENEMY<br>BLIP_MODIFIER_POSSE_ENEMY_OWNED | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_033.jpeg)
BLIP_MODIFIER_POSSE_NEUTRAL_OWNED<br>BLIP_MODIFIER_PREDATOR<br>BLIP_MODIFIER_PREDATOR_5<br>BLIP_MODIFIER_PREDATOR_10<br>BLIP_MODIFIER_PULSE_FOREVER<br>BLIP_MODIFIER_PULSE_THREE_TIMES<br>BLIP_MODIFIER_PVP_TARGET<br>BLIP_MODIFIER_PVP_TARGET_TRACKED<br>BLIP_MODIFIER_RACE_CHECKPOINT_ALT<br>BLIP_MODIFIER_RADAR_EDGE_ALWAYS | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_034.jpeg)
BLIP_MODIFIER_RADAR_EDGE_NEVER<br>BLIP_MODIFIER_RADAR_EDGE_PAUSE_MAP_NEVER<br>BLIP_MODIFIER_SCALE_1<br>BLIP_MODIFIER_SCALE_2<br>BLIP_MODIFIER_SELECTED_UP_SCALE<br>BLIP_MODIFIER_SHOP_UNAVAILABLE<br>BLIP_MODIFIER_SHOW_HEIGHT<br>BLIP_MODIFIER_SHRINK_WARNING_1<br>BLIP_MODIFIER_SHRINK_WARNING_2<br>BLIP_MODIFIER_SP_DOWNED | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_035.jpeg)
BLIP_MODIFIER_TEMP_HORSE_HITCHED<br>BLIP_MODIFIER_TEST_GPS_MODULE<br>BLIP_MODIFIER_TEXT_ONLY<br>BLIP_MODIFIER_TOD_DAYTIME_ONLY<br>BLIP_MODIFIER_TOD_NIGHTTIME_ONLY<br>BLIP_MODIFIER_TOWN_POSSE_MEMBER<br>BLIP_MODIFIER_TRACKING<br>BLIP_MODIFIER_TRAIN_MISSION<br>BLIP_MODIFIER_UNDISCOVERED<br>BLIP_MODIFIER_URGENT | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_036.jpeg)
BLIP_MODIFIER_URGENT_ALERT<br>BLIP_MODIFIER_URGENT_ALERT_INTERNAL<br>BLIP_MODIFIER_VERYHIGH_CATEGORY<br>BLIP_MODIFIER_WANTED_PULSE_1<br>BLIP_MODIFIER_WANTED_PULSE_2<br>BLIP_MODIFIER_WANTED_PULSE_3<br>BLIP_MODIFIER_WANTED_PULSE_4<br>BLIP_MODIFIER_WANTED_PULSE_5<br>BLIP_MODIFIER_WILDERNESS_CHEST_LONG<br>BLIP_MODIFIER_WITNESS_IDENTIFIED | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_037.jpeg)
BLIP_MODIFIER_WITNESS_INVESTIGATING<br>BLIP_MODIFIER_WITNESS_UNIDENTIFIED | ![screen_1.png](https://femga.com:8080/images/samples/blip_modifiers/blip_modifier_038.jpeg)
