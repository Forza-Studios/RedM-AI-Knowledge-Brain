local currentObjective = 0
local objectiveBinds = {}

local rootContainer = DatabindingAddDataContainerFromPath("", "ObjectiveSequence")
local enabled = DatabindingAddDataBool(rootContainer, "Enabled", false)
local objectives = DatabindingAddUiItemList(rootContainer, "Objectives")
DatabindingClearBindingArray(objectives)

function SetEnabled(state)
    DatabindingWriteDataBool(enabled, state)
end

function ClearObjectives()
    DatabindingClearBindingArray(objectives)
    currentObjective = 0
    objectiveBinds = {}
end

function AddObjective(index)
    local container = DatabindingAddDataContainer(rootContainer, "Objective" .. index)
    DatabindingAddDataBool(container, "IsCurrent", false)
    DatabindingAddDataBool(container, "Failed", false)
    DatabindingInsertUiItemToListFromContextStringAlias(objectives, index, "objective_breadcrumb", container)
    objectiveBinds[index] = container
end

function SetCurrentObjective(index)
    for i, container in pairs(objectiveBinds) do
        DatabindingWriteDataBoolFromParent(container, "IsCurrent", i == index)
        DatabindingWriteDataBoolFromParent(container, "Failed", i == currentObjective and index < currentObjective)
    end

    currentObjective = index
end

function PostObjective(text, duration)
    ClearObjective()

    local textStr = VarString(10, "LITERAL_STRING", text)

    local config = DataView.ArrayBuffer(1 * 8)
    config:SetInt32(0 * 8, duration or -1)

    local display = DataView.ArrayBuffer(2 * 8)
    display:SetInt64(1 * 8, textStr or 0)

    -- UIFEED::_UI_FEED_POST_OBJECTIVE
    Citizen.InvokeNative(0xCEDBF17EFCC0E4A4, config:Buffer(), display:Buffer(), true)
end

function ClearObjective()
    UiFeedClearChannel(3, true, false)
end

--[[
--------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                        --
--                                                                EXAMPLE USAGE                                                           --
--                                                                                                                                        --
--------------------------------------------------------------------------------------------------------------------------------------------
]]

ClearObjective()
ClearObjectives()

-- Populate the objectives list with objectives
for i = 1, 3 do
    AddObjective(i)
end

-- Make the breadcrumbs visible
SetEnabled(true)

-- Simulate a sequence of objectives being posted, with the current objective changing over time
for i = 1, 3 do
    PostObjective("This is test objective " .. i, -1)
    SetCurrentObjective(i)
    Wait(2500)
end

-- Simulate failing the last objective and then reverting back to the previous objective
-- Finally, simulate completing the objective again
for i = 2, 3 do
    PostObjective("This is test objective " .. i, -1)
    SetCurrentObjective(i)
    Wait(2500)
end

Wait(5000)

SetEnabled(false)
ClearObjective()
ClearObjectives()
