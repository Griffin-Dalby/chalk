--[[
    chalk Configuration

    Configuration options for the chalk library.
--]]

--====================--
-- USER CONFIGURATION --
--====================--
local ChalkTypes = require(script.Parent.types)
local CONFIG = {
    Render = {
        Parent = workspace.Terrain.chalk,

        Material = Enum.Material.Neon,
        Transparency = .5,
        Color = Color3.new(0, 1, 0)
    }
} :: ChalkTypes.ChalkConfig

--==============--
-- INTERNAL API --
--==============--
local ConfigAPI = {}

ConfigAPI.fetch = function() : ChalkTypes.ChalkConfig
    return CONFIG
end

return ConfigAPI