--!strict
--[[
    chalk Adhesive

    Adhesive library for chalk.
--]]

--]] Services
local HTTPS = game:GetService("HttpService")

--]] Modules
local ChalkTypes = require(script.Parent.types)

--]] Settings
--]] Constants
--]] Variables
--]] Import Types
type BroadObject = ChalkTypes.DebugObject<ChalkTypes.ObjectShapes>

--]] Functions
local function CheckObjectInConnections(
        object: BroadObject, 
        connections: { BroadObject }
    )

    local exists = false
    for _, connection in ipairs(connections) do
        if connection.id == object.id then
            exists = true
            break
        end
    end
    
    return exists
end

--]] Module

--=============--
-- CONSTRUCTOR --
--=============--

local Adhesive = {} :: ChalkTypes.methods_adhesive
Adhesive.__index = Adhesive

function Adhesive.new()
    local self = setmetatable({} :: ChalkTypes.fields_adhesive, Adhesive)

    self.id = `adhesive-{HTTPS:GenerateGUID(false)}`

    self.connections = {}

    return self
end

--=========--
-- METHODS --
--=========--

function Adhesive:Add( object: ChalkTypes.DebugObject<ChalkTypes.ObjectShapes> )
    if CheckObjectInConnections(object, self.connections) then return end
    table.insert(self.connections, object)
end

-- function Adhesive:

--// TODO: Type Definitions
--// TODO: Constructor
--> This is going to allow different objects to connect together
--> When rendering shapes:
-->     Make list of all shapes in registry
-->     Search through all adhesive objects
-->     Render those first
-->     Remove all Object ID's from the Registry
-->     Search through the new list
-->     Render those

return Adhesive