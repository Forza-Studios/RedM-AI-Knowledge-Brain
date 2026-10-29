---
title: RedM Resource Dependencies and Constraints
category: Cfx
tags:
  - redm
  - cfx
  - resources
  - dependencies
  - fxmanifest
framework: []
difficulty: intermediate
last_updated: 2026-10-29
sources:
  - https://docs.fivem.net/docs/scripting-reference/resource-manifest/
  - https://docs.fivem.net/docs/scripting-manual/introduction/introduction-to-resources/
---

# RedM Resource Dependencies and Constraints

Declare hard runtime requirements in `fxmanifest.lua` so Cfx starts prerequisite resources before the consumer and rejects incompatible server capabilities early. This makes failures visible at startup instead of surfacing later as missing exports or nil framework objects.

## Resource ordering

Use `dependency` for one prerequisite and `dependencies` for several. The named resources must exist and start before the current resource.

```lua
fx_version 'cerulean'
game 'rdr3'

dependencies {
  'vorp_core',
  'my_inventory'
}

shared_script 'shared/config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'
```

This describes a hard requirement, not an optional integration. If a resource can work without another resource, do not list it as a manifest dependency; detect it at runtime with `GetResourceState` and keep that feature isolated.

```lua
local function hasOptionalTarget()
  return GetResourceState('my_target') == 'started'
end
```

## Runtime capability constraints

The `dependencies` list can also express Cfx runtime requirements. These are prefixed with `/` and are checked when the resource starts.

```lua
dependencies {
  '/onesync',             -- requires state awareness
  '/server:4500',         -- minimum server build
  '/gameBuild:1436',      -- require at least a selected game build
  '/native:0xE27C97A0'    -- require one server native hash
}
```

Supported constraint categories are `server`, `policy`, `onesync`, `gameBuild`, and `native`. Use only constraints your resource truly needs; overly broad requirements make deployment and reuse harder.

## Server-only resources

Use `server_only 'yes'` for a resource that has no client-delivered content, such as a database adapter, permission service, or server administration utility. This prevents clients from downloading the resource.

```lua
fx_version 'cerulean'
game 'rdr3'

server_only 'yes'
server_script 'server/main.lua'
```

Do not mark a resource server-only if client scripts, streamed assets, shared files, or a NUI page are needed by players.

## Replacements with `provide`

`provide` allows a resource to satisfy another resource's dependency name. This is useful for a deliberate compatibility replacement, but it creates a contract: the replacement must implement the API and behavior expected by consumers.

```lua
-- compatibility resource only; document its supported API surface
provide 'legacy_inventory'
```

Avoid using `provide` merely to silence dependency errors. Prefer an adapter resource or migrate consumers to the new dependency name.

## Load-order checklist

- Put framework/database/inventory prerequisites in `dependencies`.
- Start a provider before its consumers in `server.cfg`; the manifest protects the relationship but a clear server order remains easier to operate.
- Subscribe to resource stop events if the consumer caches provider state.
- Keep optional integrations behind an availability check and a small adapter module.
- Use `game 'rdr3'` for a RedM-only resource.

## Related pages

- [fxmanifest.lua](../getting-started/fxmanifest.md)
- [Resource exports](resource-exports.md)
- [Network events](network-events.md)

