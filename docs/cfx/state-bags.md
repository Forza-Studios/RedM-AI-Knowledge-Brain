---
title: RedM State Bags
category: Cfx
tags:
  - redm
  - cfx
  - state-bags
  - replication
  - onesync
framework: []
difficulty: advanced
last_updated: 2026-10-29
sources:
  - https://docs.fivem.net/docs/scripting-manual/networking/state-bags/
  - https://docs.fivem.net/docs/scripting-manual/networking/ids/
  - https://docs.fivem.net/docs/scripting-reference/onesync/
---

# RedM State Bags

State bags synchronize small metadata values attached to networked entities, players, or the whole server. They are a good fit for replicated state that clients need to observe, such as a horse's interaction state, a wagon's locked state, or a player's current job label. They are not a substitute for server-side validation or persistent storage.

## Bag types and write policy

| Bag | Lua access | Default writer policy |
| --- | --- | --- |
| Entity | `Entity(entity).state` | server and current network owner |
| Player | `Player(serverId).state`, `LocalPlayer.state` | server and that player |
| Global | `GlobalState` | server only |

The server is authoritative for gameplay. It can enable `sv_stateBagStrictMode` to prevent clients from modifying replicated entity and player state. Even when client writes are allowed, do not make security decisions from a client-controlled bag value.

## Read and write values

```lua
-- server: setting normally replicates to relevant clients
Entity(horse).state.isHitched = true
Player(source).state.job = 'sheriff'
GlobalState.weatherProfile = 'frontier_clear'

-- client: read a replicated value
local hitched = Entity(horse).state.isHitched
local sheriffJob = Player(serverId).state.job
```

Use `state:set(key, value, replicate)` when replication must be explicit. Server writes normally replicate and client writes normally remain local; the third argument lets code intentionally override that default.

```lua
-- server-only scratch value: do not replicate
Entity(horse).state:set('lastStableCheck', os.time(), false)

-- client request to replicate only when the design deliberately permits it
Entity(horse).state:set('interactionAck', true, true)
```

## Keep keys shallow

State-bag getters and setters serialize the complete bag. Nested mutation is not a granular replication operation, and repeated nested reads deserialize repeatedly. Store independent values under separate flat keys instead.

```lua
-- Do not rely on this to replicate
Entity(horse).state.tack.saddle = 'mcclellan'

-- Prefer stable, namespaced keys
Entity(horse).state['my_resource:tack:saddle'] = 'mcclellan'
Entity(horse).state['my_resource:tack:stirrups'] = 'hooded'
```

Keep values compact and serializable. Put large records, inventory arrays, and durable character data in an appropriate server-side data store, then replicate only the small state required for nearby clients to render or interact correctly.

## React to changes

Use `AddStateBagChangeHandler` for reactive code rather than polling every frame. Restrict the handler to a key and optionally a bag filter, then resolve the entity carefully because a state update can arrive before a local entity is ready.

```lua
AddStateBagChangeHandler('my_resource:isHitched', nil, function(bagName, key, value)
  local entity = GetEntityFromStateBagName(bagName)
  if entity == 0 or not DoesEntityExist(entity) then return end

  if value then
    -- configure local prompt/animation for this horse
  else
    -- remove local prompt/animation
  end
end)
```

The handler reports a change; it does not make the incoming data trustworthy. Sensitive actions must still be requested through a validated server event.

## Identifiers across machines

An entity handle is local to one machine and must not be sent as an identifier for another client. To refer to an entity across the network, use its network ID (`NetworkGetNetworkIdFromEntity`) and confirm the entity is in scope before use. Network IDs can be reused after an entity's lifetime, so do not persist them as permanent identities.

## Related pages

- [Network events](network-events.md)
- [Entities](../natives/entities.md)
- [Resource structure](../getting-started/resource-structure.md)

