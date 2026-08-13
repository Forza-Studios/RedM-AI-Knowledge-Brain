--[[
--------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                        --
--                                                                EVENTS SYSTEM                                                           --
--                                                Requires using dataview by Gottfriedleibniz                                             --
--                                                                                                                                        --
--------------------------------------------------------------------------------------------------------------------------------------------
]]

local open, fireOpen = false, false
local currentWheel = nil
local currentItem, previousItem = 0, 0

local PARAMETERS <const> = {
    -- Wheels
    [`WEAPON_WHEEL`]              = "WEAPON_WHEEL",
    [`SATCHEL_ITEM_WHEEL`]        = "SATCHEL_ITEM_WHEEL",
    [`SATCHEL_HORSE_ITEM_WHEEL`]  = "SATCHEL_HORSE_ITEM_WHEEL",
    [`FISHING_WHEEL`]             = "FISHING_WHEEL",

    -- Actions
    [`FLOW_LAUNCHED`]             = "FLOW_LAUNCHED",
    [`PUT_AWAY_FISHING_ROD`]      = "PUT_AWAY_FISHING_ROD",

    -- Slots
    [`DUAL_WIELD`]                = "WEAPONS_DUAL_WIELD",
    [`WEAPONS_LONGARMS_AND_BOWS`] = "WEAPONS_LONGARMS_AND_BOWS",
    [`WEAPONS_MELEE_NO_UNARMED`]  = "WEAPONS_MELEE_NO_UNARMED",
    [`OFFHAND`]                   = "WEAPONS_OFFHAND",
    [`WEAPONS_SIDEARMS_LEFT`]     = "WEAPONS_SIDEARMS_LEFT",
    [`WEAPONS_SIDEARMS_RIGHT`]    = "WEAPONS_SIDEARMS_RIGHT",
    [`WEAPONS_SIDEARMS`]          = "WEAPONS_SIDEARMS",
    [`WEAPONS_THROWN`]            = "WEAPONS_THROWN",
    [`WEAPONS_UNARMED`]           = "WEAPONS_UNARMED",
}

local function getState(index, parameter)
    return {
        open = open,                 -- Whether the UI is currently open
        index = index,               -- The UI index of the slot or item
        parameter = parameter,       -- The parameter sent by the UI, such as the item or type
        wheel = currentWheel,        -- The currently focused wheel
        item = currentItem,          -- The currently focused item (0 if none, or the item hash)
        previousItem = previousItem, -- The previously focused item (0 if none, or the item hash)
    }
end

CreateThread(function()
    while true do
        -- Feel free to tweak if needed, 0 is also a valid option but not needed
        Wait(10)

        -- Update the currently selected item while (and only while) the wheel is open
        if open then
            -- HUD::_HUD_GET_INVENTORY_WHEEL_CURRENTLY_HIGHLIGHTED
            currentItem = Citizen.InvokeNative(0x9C409BBC492CB5B1) or 0
            previousItem = currentItem ~= 0 and currentItem or previousItem
        end

        -- Bulk process all pending event in this thread tick instead of one at a time
        while EventsUiIsPending(`hud_quick_select`) do
            local data = DataView.ArrayBuffer(8 * 4)

            if (Citizen.InvokeNative(0x90237103F27F7937, `hud_quick_select`, data:Buffer()) ~= 0) then -- EVENTS_UI_PEEK_MESSAGE
                local event = data:GetInt32(0)
                local index = data:GetInt32(8)
                local parameter = data:GetInt32(16)

                parameter = PARAMETERS[parameter] or parameter

                if event == `ITEM_FOCUSED` then
                    if parameter == "WEAPON_WHEEL" then
                        currentWheel = parameter
                        TriggerEvent("wheel:focus_weapon", getState(index, parameter))
                    elseif parameter == "SATCHEL_ITEM_WHEEL" then
                        currentWheel = parameter
                        TriggerEvent("wheel:focus_item", getState(index, parameter))
                    elseif parameter == "SATCHEL_HORSE_ITEM_WHEEL" then
                        currentWheel = parameter
                        TriggerEvent("wheel:focus_horse", getState(index, parameter))
                    elseif parameter == "FISHING_WHEEL" then
                        currentWheel = parameter
                        TriggerEvent("wheel:focus_fishing", getState(index, parameter))
                    else
                        TriggerEvent("wheel:focus_slot", getState(index, parameter))
                    end
                elseif event == `ITEM_UNFOCUSED` then
                    if parameter == "WEAPON_WHEEL" then
                        TriggerEvent("wheel:unfocus_weapon", getState(index, parameter))
                        previousItem = 0
                    elseif parameter == "SATCHEL_ITEM_WHEEL" then
                        TriggerEvent("wheel:unfocus_item", getState(index, parameter))
                        previousItem = 0
                    elseif parameter == "SATCHEL_HORSE_ITEM_WHEEL" then
                        TriggerEvent("wheel:unfocus_horse", getState(index, parameter))
                        previousItem = 0
                    elseif parameter == "FISHING_WHEEL" then
                        TriggerEvent("wheel:unfocus_fishing", getState(index, parameter))
                        previousItem = 0
                    else
                        TriggerEvent("wheel:unfocus_slot", getState(index, parameter))
                    end

                    -- Prevents the item attribute preview (RPG stats) from sticking
                    StopItemPreview()
                elseif event == `ITEM_SELECTED` then
                    if parameter == "FLOW_LAUNCHED" then
                        open, fireOpen = true, true
                    elseif parameter == "SATCHEL_HORSE_ITEM_WHEEL" then
                        TriggerEvent("wheel:action_horse_item", getState(index, parameter))
                    elseif parameter == "PUT_AWAY_FISHING_ROD" then
                        TriggerEvent("wheel:action_put_away", getState(index, parameter))

                        -- The UI doesn't automatically close after this action
                        CloseUiappByHash(`hud_quick_select`)
                    else
                        TriggerEvent("wheel:action_slot", getState(index, parameter))
                    end
                end
            end

            EventsUiPopMessage(`hud_quick_select`)
        end

        -- Only fire the opened event once
        if fireOpen then
            TriggerEvent("wheel:opened", getState())
            fireOpen = false
        end

        -- Check if we are closed and properly fire the closed event, as well as reset the state
        if open and IsControlReleased(0, `INPUT_OPEN_WHEEL_MENU`) then
            TriggerEvent("wheel:closed", getState())

            open, fireOpen = false, false
            currentWheel = nil
            currentItem, previousItem = 0, 0
        end
    end
end)

--[[
--------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                        --
--                                                                EXAMPLE USAGE                                                           --
--                                                                                                                                        --
--------------------------------------------------------------------------------------------------------------------------------------------
]]

AddEventHandler("wheel:opened", function(data)
    -- Note: Due to UI bugs (yes, multiple), the starting wheel isn't always accurate
    print("Wheel Opened", json.encode(data))
end)

AddEventHandler("wheel:closed", function(data)
    print("Wheel Closed", json.encode(data))
end)

AddEventHandler("wheel:action_horse_item", function(data)
    print("Select Horse Item", json.encode(data))
end)

AddEventHandler("wheel:action_put_away", function(data)
    print("Put Away Fishing Rod", json.encode(data))
end)

AddEventHandler("wheel:action_slot", function(data)
    print("Select Slot", json.encode(data))
end)

-- Omitted unfocus and focus events for brevity, but they work the same as the above
-- wheel:focus_weapon, wheel:focus_item, wheel:focus_horse, wheel:focus_fishing
-- wheel:focus_slot, wheel:unfocus_weapon, wheel:unfocus_item, wheel:unfocus_horse
-- wheel:unfocus_fishing, wheel:unfocus_slot
