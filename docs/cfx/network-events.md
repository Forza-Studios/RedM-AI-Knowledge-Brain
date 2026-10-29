---
title: RedM Network Events
category: Cfx
tags:
  - redm
  - cfx
  - events
  - networking
  - security
framework: []
difficulty: intermediate
last_updated: 2026-10-29
sources:
  - https://docs.fivem.net/docs/scripting-manual/working-with-events/
  - https://docs.fivem.net/docs/scripting-manual/working-with-events/listening-for-events/
  - https://docs.fivem.net/docs/scripting-manual/working-with-events/triggering-events/
  - https://docs.fivem.net/docs/developers/server-security/
---

# RedM Network Events

Events are the standard Cfx boundary between client and server scripts. Treat every client-to-server event as an untrusted request: the server must validate identity, state, distance, permissions, item ownership, and every supplied value before changing game state.

## Local versus networked events

Use `AddEventHandler` for an event that remains in the current runtime context (client-to-client or server-to-server). Use `RegisterNetEvent` only when an event must cross the client/server boundary. Registering a network event does not prevent code in the same context from triggering it.

```lua
-- server/main.lua: local-only internal event
AddEventHandler('my_resource:saveCharacter', function(characterId)
  -- only server-side code can reach this through TriggerEvent
end)

-- server/main.lua: a request allowed from a client
RegisterNetEvent('my_resource:requestPurchase', function(itemId)
  local playerSource = source -- capture it before any Wait or async work
  -- validate playerSource and itemId here
end)
```

`source` is a global supplied to the current server event handler. Capture it in a local variable before `Wait`, callbacks, or other asynchronous work; it is only guaranteed for the initial handler invocation.

## Direction and trigger functions

| Intent | Call from | Lua function |
| --- | --- | --- |
| Invoke an event in the same context | client or server | `TriggerEvent(name, ...)` |
| Request server work | client | `TriggerServerEvent(name, ...)` |
| Notify one client | server | `TriggerClientEvent(name, target, ...)` |
| Notify every client | server | `TriggerClientEvent(name, -1, ...)` |
| Send a large payload without monopolizing the network channel | client or server | `TriggerLatentServerEvent` / `TriggerLatentClientEvent` |

Client events can be handled only in client scripts; server events can be handled only in server scripts. A server can trigger client events, while a client uses `TriggerServerEvent` to contact the server.

## Safe server handler pattern

```lua
RegisterNetEvent('my_resource:requestPurchase', function(itemId, quantity)
  local playerSource = source

  if type(itemId) ~= 'string' or type(quantity) ~= 'number' then return end
  if quantity < 1 or quantity > 10 or quantity % 1 ~= 0 then return end

  local player = GetPlayerPed(playerSource)
  if player == 0 then return end

  local item = Catalog[itemId]
  if not item then return end
  if not PlayerCanAfford(playerSource, item.price * quantity) then return end
  if not PlayerIsNearShop(playerSource) then return end

  ChargePlayer(playerSource, item.price * quantity)
  GiveItem(playerSource, itemId, quantity)
end)
```

Never accept client-provided money totals, inventory counts, job roles, coordinates, rewards, or another player ID as proof. Recalculate or query authoritative state on the server. Client checks improve usability but are not a security boundary.

## Payload sizing

For data in the multiple-kilobyte range, use latent events so a normal network event does not block the channel. Their `bps` argument sets bytes per second; `0` or `-1` uses the documented default of 25,000 B/s. For a broadcast, that limit applies per target, so effective server traffic is approximately `bps × recipient count`. Keep event payloads small where possible and prefer IDs or paginated responses over whole inventories.

```lua
-- server: send a larger, non-urgent response to one player
TriggerLatentClientEvent('my_resource:syncCatalog', playerSource, 25000, catalogChunk)
```

## Lifecycle cleanup

Resource restart events are useful for clearing caches and releasing resource-owned state. Always check the resource name so another resource’s lifecycle does not reset yours.

```lua
AddEventHandler('onResourceStop', function(resourceName)
  if resourceName ~= GetCurrentResourceName() then return end
  ActiveSessions = {}
end)
```

## Related pages

- [Resource structure](../getting-started/resource-structure.md)
- [fxmanifest.lua](../getting-started/fxmanifest.md)
- [Lua patterns](../lua/patterns.md)

