--[[
    scenario_point_example.lua

    Dependency-free client example.

    Behaviour:
      - only spawns the NPC while the player is seated near the opposite chair
      - reuses a baked scenario point when one exists
      - creates and owns a point only when no baked point is found
      - walks the NPC to the point and lets the stock scenario play
      - freezes only after the enter/sit animation had time to finish
      - deletes the ped and any owned point on resource stop

    Change NPC.coords to your chair. Everything else is optional tuning.
]]

local NPC = {
    model = "rcsp_beauandpenelope1_females_01",
    scenario = "PROP_HUMAN_SEAT_CHAIR_DRINKING",

    -- Types accepted as "the chair". The first one is the preferred type.
    bakedScenarios = {
        "PROP_HUMAN_SEAT_CHAIR_DRINKING",
        "PROP_HUMAN_SEAT_CHAIR",
        "PROP_HUMAN_SEAT_CHAIR_TABLE_DRINKING",
    },

    -- The chair opposite the player. X, Y, Z, heading.
    coords = { x = -244.0550, y = 772.1157, z = 116.5846, h = 199.8500 },

    -- Only used when the script creates a point. Baked points keep their own Z.
    zOffset = 0.0,

    -- Spawn behind the chair and walk onto the point.
    spawnOffset = 1.2,

    -- Baked point search.
    pointSearchRadius = 2.0,
    pointScanRadius = 6.0,

    -- Seated trigger.
    playerSitRadius = 4.0,
    playerMinDistance = 0.8,
    leaveDelay = 5000,
}

local POINT_SCAN_MAX = 10
local POINT_SCAN_RADIUS = 4.0
local MAX_DRIFT = 5.0
local FREEZE_AFTER_MS = 8000

local npc = nil
local npcPoint = nil
local npcPointIsOurs = false

local function LoadModel(model)
    if HasModelLoaded(model) then
        return true
    end

    RequestModel(model, false)

    local deadline = GetGameTimer() + 10000

    while not HasModelLoaded(model) do
        if GetGameTimer() > deadline then
            return false
        end

        Wait(0)
    end

    return true
end

local function HashToString(hash)
    hash = tonumber(hash) or 0

    if hash < 0 then
        hash = hash + 4294967296
    end

    return string.format("0x%08X", hash)
end

-- The Lua wrapper hides the output array, so call the raw hash and pass a
-- DataView buffer. Entries are 8 bytes wide; the handle is in the low 32 bits.
local function GetScenarioPoints(coords, radius)
    local buffer = DataView.ArrayBuffer(256 * 4)

    Citizen.InvokeNative(
        0x345EC3B7EBDE1CB5,
        coords.x, coords.y, coords.z,
        radius,
        buffer:Buffer(),
        POINT_SCAN_MAX
    )

    local points = {}

    for i = 1, POINT_SCAN_MAX do
        local point = buffer:GetInt32(8 * i)

        if point ~= 0 then
            points[#points + 1] = point
        end
    end

    return points
end

-- True while the player is sitting on a chair near the configured chair.
local function IsPlayerSeatedNear(cfg)
    local player = PlayerPedId()
    local target = vector3(cfg.coords.x, cfg.coords.y, cfg.coords.z)
    local distance = #(GetEntityCoords(player) - target)
    local radius = cfg.playerSitRadius or 4.0
    local minDistance = cfg.playerMinDistance or 0.8

    -- Too far away, or sitting on the NPC's own chair.
    if distance < minDistance or distance > radius then
        return false
    end

    local point = GetScenarioPointPedIsUsing(player, true)

    if point and point ~= 0 then
        local pointCoords = GetScenarioPointCoords(point, true)

        if #(pointCoords - target) <= radius then
            return true
        end
    end

    -- Fallback for custom sit tasks that do not expose a scenario point.
    return IsPedUsingAnyScenario(player)
end

local function FindBakedScenarioPoint(cfg)
    local accepted = {}

    for _, name in ipairs(cfg.bakedScenarios or { cfg.scenario }) do
        accepted[GetHashKey(name)] = true
    end

    local origin = vector3(cfg.coords.x, cfg.coords.y, cfg.coords.z + (cfg.zOffset or 0.0))
    local best, bestDistance = nil, (cfg.pointSearchRadius or 2.0)

    for _, point in ipairs(GetScenarioPoints(origin, POINT_SCAN_RADIUS)) do
        if accepted[GetScenarioPointType(point)] then
            local pointCoords = GetScenarioPointCoords(point, true)
            local distance = #(pointCoords - origin)

            if distance <= bestDistance then
                best, bestDistance = point, distance
            end
        end
    end

    return best
end

local function CreateChairScenarioPoint(cfg)
    local point = CreateScenarioPointHash(
        GetHashKey(cfg.scenario),
        cfg.coords.x,
        cfg.coords.y,
        cfg.coords.z + (cfg.zOffset or 0.0),
        cfg.coords.h,
        0,
        0,
        true
    )

    if point and point ~= 0 then
        SetScenarioPointActive(point, true)
    end

    return point
end

local function RemoveNpc()
    if npc and DoesEntityExist(npc) then
        DeleteEntity(npc)
    end

    npc = nil

    -- Never delete baked points. Only delete a point this script created.
    if npcPointIsOurs and npcPoint and DoesScenarioPointExist(npcPoint) then
        DeleteScenarioPoint(npcPoint)
    end

    npcPoint = nil
    npcPointIsOurs = false
end

local function SpawnNpc()
    if npc and DoesEntityExist(npc) then
        return
    end

    local model = GetHashKey(NPC.model)

    if not LoadModel(model) then
        print("[scenario_point_example] Model failed to load.")
        return
    end

    -- Spawn behind the chair, not in the seat. The task walks the ped in.
    local rad = math.rad(NPC.coords.h)
    local offset = NPC.spawnOffset or 1.2
    local spawnX = NPC.coords.x - math.sin(rad) * offset
    local spawnY = NPC.coords.y + math.cos(rad) * offset
    local spawnZ = NPC.coords.z + 0.2

    local ped = CreatePed(
        model,
        spawnX, spawnY, spawnZ,
        NPC.coords.h + 180.0,
        false, false, false, false
    )

    if not ped or ped == 0 then
        print("[scenario_point_example] CreatePed failed.")
        return
    end

    npc = ped
    repeat Wait(0) until DoesEntityExist(npc)

    SetEntityAsMissionEntity(npc, true, true)
    SetEntityVisible(npc, true)
    SetRandomOutfitVariation(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetPedKeepTask(npc, true)
    SetPedCanBeTargetted(npc, false)
    SetEntityInvincible(npc, true)
    SetPedFleeAttributes(npc, 0, false)

    local point = FindBakedScenarioPoint(NPC)

    if point then
        print(("[scenario_point_example] Using baked point %s (%s)."):format(
            tostring(point),
            HashToString(GetScenarioPointType(point))
        ))
    else
        point = CreateChairScenarioPoint(NPC)
        npcPointIsOurs = point ~= nil and point ~= 0
        print("[scenario_point_example] No baked point found; created one.")
    end

    if point and point ~= 0 then
        npcPoint = point
        TaskUseScenarioPoint(npc, point, "", -1.0, true, false, 0, false, -1.0, true)
    else
        print("[scenario_point_example] Scenario point API failed; using in-place fallback.")
        FreezeEntityPosition(npc, true)
        TaskStartScenarioInPlaceHash(npc, GetHashKey(NPC.scenario), -1, true, 0, 0, false)
    end

    CreateThread(function()
        Wait(FREEZE_AFTER_MS)

        if npc ~= ped or not DoesEntityExist(ped) then
            return
        end

        if GetScenarioPointTypePedIsUsing(ped) ~= 0 then
            FreezeEntityPosition(ped, true)
        else
            print("[scenario_point_example] Ped did not start the scenario.")
        end
    end)
end

CreateThread(function()
    local target = vector3(NPC.coords.x, NPC.coords.y, NPC.coords.z)
    local leaveAt = 0

    while true do
        Wait(1000)

        local seated = IsPlayerSeatedNear(NPC)

        if seated then
            leaveAt = 0

            if not npc or not DoesEntityExist(npc) then
                SpawnNpc()
            elseif #(GetEntityCoords(npc) - target) > MAX_DRIFT then
                RemoveNpc()
                SpawnNpc()
            end
        elseif npc and DoesEntityExist(npc) then
            if leaveAt == 0 then
                leaveAt = GetGameTimer() + (NPC.leaveDelay or 5000)
            elseif GetGameTimer() >= leaveAt then
                RemoveNpc()
                leaveAt = 0
            end
        end
    end
end)

RegisterCommand("npcscen", function()
    local origin = vector3(NPC.coords.x, NPC.coords.y, NPC.coords.z + (NPC.zOffset or 0.0))
    local radius = NPC.pointScanRadius or 6.0
    local points = GetScenarioPoints(origin, radius)

    print(("[scenario_point_example] %d point(s) within %.1fm:"):format(#points, radius))

    for _, point in ipairs(points) do
        local pointCoords = GetScenarioPointCoords(point, true)

        print(("  point=%s type=%s dist=%.2f at %.2f, %.2f, %.2f"):format(
            tostring(point),
            HashToString(GetScenarioPointType(point)),
            #(pointCoords - origin),
            pointCoords.x,
            pointCoords.y,
            pointCoords.z
        ))
    end
end, false)

RegisterCommand("npcstate", function()
    local player = PlayerPedId()
    local target = vector3(NPC.coords.x, NPC.coords.y, NPC.coords.z)
    local coords = GetEntityCoords(player)
    local point = GetScenarioPointPedIsUsing(player, true)

    print(("[scenario_point_example] player %.2f, %.2f, %.2f | dist %.2f"):format(
        coords.x, coords.y, coords.z, #(coords - target)
    ))

    print(("[scenario_point_example] anyScenario=%s point=%s type=%s seatedNear=%s"):format(
        tostring(IsPedUsingAnyScenario(player)),
        tostring(point),
        HashToString(GetScenarioPointTypePedIsUsing(player)),
        tostring(IsPlayerSeatedNear(NPC))
    ))
end, false)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    RemoveNpc()
end)
