--!strict
--[[
    chalk Debug Object Registry

    Performant Object Registry with custom options.
--]]

--]] Modules
local ChalkTypes = require(script.Parent.types)

--]] Settings
local ERRORS = {
    Register = {
        Conflict = "Attempt was made to register object \"%s\", but it's already registered!",
        Conflict_Adhesive = "Attempt was made to register adhesive \"%s\", but it's already registered!"
    },

    Unregister = {
        Failure = "Atempt was made to unregister object \"%s\", but it isn't registered!",
        Failure_Adhesive = "Attempt was made to unregister adhesive \"%s\", but it isn't registered!"
    }
}

--]] Module
local Registry = {} :: ChalkTypes.methods_registry
Registry.__index = Registry

--// TODO: Write Documentation
function Registry.get()
    if Registry.instance then
        return Registry.instance end

    --> Initalize
    local self = setmetatable({} :: ChalkTypes.fields_registry, Registry)

    self.objects = {}
    self.adhesives = {}

    Registry.instance = self
    return self
end

--=========--
-- METHODS --
--=========--
function Registry:Register(object)
    --> Extract ID
    local object_id = object.id
    local truncated_id = `{object_id:split("-")[1]}-{object_id:split("-")[2]:sub(1,18)}`

    --> Conflict Check
    if self.objects[object_id] then
        error((ERRORS.Register.Conflict::any):format(truncated_id)) end
        
    --> Commit
    self.objects[object_id] = object
    print(`[{script.Name}] Registered ID: {truncated_id}`)
end

function Registry:Unregister(object_id)
    --> Truncate ID
    local truncated_id = `{object_id:split("-")[1]}-{object_id:split("-")[2]:sub(1,18)}`

    --> Existence Check
    if not self.objects[object_id] then
        error((ERRORS.Unregister.Failure::any):format(truncated_id)) end

    --> Commit
    self.objects[object_id] = nil
end

function Registry:RegisterAdhesive(adhesive)
    --> Extract ID
    local adhesive_id = adhesive.id

    --> Conflict Check
    if self.adhesives[adhesive_id] then
            error((ERRORS.Register.Conflict_Adhesive::any):format(adhesive_id)) end
    
    --> Commit
    self.adhesives[adhesive_id] = adhesive
end

function Registry:UnregisterAdhesive(adhesive_id)
    --> Existence Check
    if not self.adhesives[adhesive_id] then
        error((ERRORS.Unregister.Failure_Adhesive::any):format(adhesive_id)) end

    --> Commit
    self.adhesives[adhesive_id] = nil
end

--===========--
-- ACCESSORS --
--===========--


return Registry