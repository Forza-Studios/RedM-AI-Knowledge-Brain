---
title: RedM Resource Exports
category: Cfx
tags:
  - redm
  - cfx
  - resources
  - exports
  - lua
framework: []
difficulty: intermediate
last_updated: 2026-10-29
sources:
  - https://docs.fivem.net/docs/scripting-manual/runtimes/lua/
  - https://docs.fivem.net/docs/scripting-reference/resource-manifest/
  - https://docs.fivem.net/docs/scripting-manual/introduction/introduction-to-resources/
---

# RedM Resource Exports

Exports are direct function calls between resources running in the same Cfx context. Use them for a stable, small API such as `GetCharacter`, `CanUseItem`, or `OpenStable`; use events when the interaction is asynchronous or crosses client/server contexts.

## Define an export in Lua

The function-based form is the preferred modern pattern. It keeps the implementation local and makes the public API explicit.

```lua
-- server/api.lua
exports('GetStableHorseCount', function(playerSource)
  local stable = GetStableForPlayer(playerSource)
  return stable and #stable.horses or 0
end)
```

Call it from another server resource with colon syntax:

```lua
local count = exports.my_stable:GetStableHorseCount(source)
```

The resource name is the resource folder name as Cfx recognizes it, not necessarily its display name. The resource providing the export must be started before a consumer calls it.

## Client and server boundaries

An export is available in the context in which it was registered:

- an export registered by a client script is consumed by other client scripts;
- an export registered by a server script is consumed by other server scripts;
- an export does not itself carry a call from client to server.

For a client request that needs server authority, expose a server export to server-side callers and use a validated network event or framework callback for the client/server boundary.

## Manifest-declared exports

`export` and `server_export` in `fxmanifest.lua` support older explicit export declarations. The exported function must be global, and manifest-declared exports are available only after the first scheduler tick. Prefer the `exports('name', function)` form for new Lua code.

```lua
-- fxmanifest.lua (legacy-compatible style)
server_script 'server/api.lua'
server_export 'GetStableHorseCount'
```

```lua
-- server/api.lua
function GetStableHorseCount(playerSource)
  return 0
end
```

## API design rules

- Export narrow, intentional operations rather than internal tables or mutable state.
- Validate all arguments at the public boundary, especially source IDs and identifiers received from another resource.
- Return plain Lua values with documented shapes; avoid leaking framework-specific objects unless the dependency is intentional.
- Keep exports synchronous and quick. Do database work or large data loading behind an asynchronous callback/event interface.
- Namespace names by purpose and preserve compatibility when other resources depend on them.
- Guard optional dependencies with `GetResourceState` before calling their export.

```lua
local function hasInventory()
  return GetResourceState('my_inventory') == 'started'
end

if hasInventory() then
  local canCarry = exports.my_inventory:CanCarryItem(source, itemName, amount)
  if not canCarry then return false end
end
```

## Lifecycle considerations

Resources can start, stop, and restart independently. Do not cache returned resource-owned objects across a resource restart unless the provider documents that they remain valid. Consumers should either resolve current data per operation or clear cached references on `onResourceStop`.

## Related pages

- [Resource structure](../getting-started/resource-structure.md)
- [fxmanifest.lua](../getting-started/fxmanifest.md)
- [Network events](network-events.md)

