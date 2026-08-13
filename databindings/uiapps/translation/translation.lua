-- No need to edit the config or keys, this is all you get. The UI determines these limits and keys.
local CONFIG <const> = {
    journal = {
        path = "Journal",
        text = { 0, 15 },
        divider = { 0, 14 },
    },
    catalogue = {
        path = "Translate.Catalogue",
        text = { 0, 24 },
        divider = { 0, 24 },
    },
    newspaper = {
        path = "Newspaper",
        heading = { 1, 1 },
        subheading = { 1, 4 },
        body = { 1, 10 },
    },
    generic = {
        path = "Translate.Generic",
        text = { 0, 23 },
        strike = { 0, 23 },
    }
}

local KEYS <const> = {
    text = "textField%d",
    strike = "textField%dStrike",
    divider = "divider%d",
    heading = "ArticleHeading",
    subheading = "ArticleSubHeading%d",
    body = "ArticleBody%d",
}

function GetTranslationText(entry, key, text)
    if not entry or not key or not text then return "" end
    if entry == "catalogue" then return text end
    AddTextEntry(key, text)
    return key
end

function ShowTranslationOverlay(entry, data)
    if type(data) ~= "table" then return end

    local config = CONFIG[entry]
    if not config then return end

    local parentContainer = nil
    if config.path:find("Translate") then
        local rootContainer = DatabindingAddDataContainerFromPath("", "Translate")
        parentContainer = DatabindingAddDataContainer(rootContainer, config.path:sub(11))
    else
        parentContainer = DatabindingAddDataContainerFromPath("", config.path)
    end

    local counter = {}
    for _, value in ipairs(data) do
        local limits = config[value.type]
        if not limits then
            print("Invalid type: " .. tostring(value.type))
            goto continue
        end

        if not counter[value.type] then counter[value.type] = limits[1] end
        if counter[value.type] > limits[2] then
            print("Exceeded limit for type: " .. tostring(value.type))
            goto continue
        end

        local key = KEYS[value.type]
        if not key then
            print("Invalid key for type: " .. tostring(value.type))
            goto continue
        end

        if value.style and (value.style < 0 or value.style > 6) then
            print("Invalid style for type: " .. tostring(value.type))
            goto continue
        end

        if value.text and type(value.text) ~= "string" then
            print("Invalid text for type: " .. tostring(value.type))
            goto continue
        end

        if value.visible ~= nil and type(value.visible) ~= "boolean" then
            print("Invalid visible flag for type: " .. tostring(value.type))
            goto continue
        end

        local index = counter[value.type]
        local itemKey = string.format(key, index)
        local container = DatabindingAddDataContainer(parentContainer, itemKey)

        if value.type == "heading" or value.type == "subheading" or value.type == "body" then
            DatabindingAddDataString(container, "text", GetTranslationText(entry, itemKey, value.text))
            DatabindingAddDataInt(container, "style", value.style or -1)
            DatabindingAddDataBool(container, "isVisible", value.visible ~= false)
        elseif value.type == "text" or value.type == "strike" then
            DatabindingAddDataString(container, "text", GetTranslationText(entry, itemKey, value.text))
            DatabindingAddDataInt(container, "style", value.style or -1)
        elseif value.type == "divider" then
            DatabindingAddDataBool(container, "isVisible", value.visible ~= false)
        end

        counter[value.type] = counter[value.type] + 1

        ::continue::
    end

    LaunchUiappByHashWithEntry("translation_overlay", entry)
end

function HideTranslationOverlay()
    CloseUiappByHash("translation_overlay")
end

--[[
--------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                        --
--                                                                EXAMPLE USAGE                                                           --
--                                                                                                                                        --
--------------------------------------------------------------------------------------------------------------------------------------------
]]

-- These are just helpers, feel free to not use them
local HEADER <const> = 0                  -- Title, centered, multiline
local SUB_HEADER <const> = 1              -- Subtitle, centered, multiline
local BODY_LEFT <const> = 2               -- Body, left aligned, multiline
local BODY_CENTER <const> = 3             -- Body, centered, multiline
local BODY_JUSTIFY <const> = 4            -- Body, justified, multiline
local BODY_LEFT_AUTO_LENGTH <const> = 5   -- Body, left aligned, single line
local BODY_CENTER_AUTO_LENGTH <const> = 6 -- Body, centered, single line

local example = {
    { type = "text", style = HEADER,      text = "Explosive Express Cartridge" },
    { type = "text", style = BODY_LEFT,   text = "It's a well-known fact that rendered fat from a bear is delicious but it also provides the best waterproofing for boots. ~n~~n~Another use is to add explosive capability to pistol, rifle or repeater ammunition which is sure to provide an ebullient and very startled reaction from friend or foe on the business end of it." },
    { type = "text", style = SUB_HEADER,  text = "The Frontiersman's Requirements" },
    { type = "text", style = BODY_CENTER, text = "Express Cartridge (from a Pistol, Repeater, Revolver or Rifle)~n~~n~Animal Fat" },
    { type = "text", style = SUB_HEADER,  text = "How To Prepare" },
    { type = "text", style = BODY_LEFT,   text = "I.    Render animal fat (a.), let solidify.~n~~n~II.    Pack into a cartridge (b.) before sealing well.~n~~n~III.    Store in a dry place." },
}

ShowTranslationOverlay("generic", example)
