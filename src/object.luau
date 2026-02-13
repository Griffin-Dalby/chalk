--!strict
--[[
    chalk Debug Object

    Base primitive for chalk's debug objects.
--]]

--]] Services
local HTTPS = game:GetService("HttpService")

--]] Modules
local ChalkRegistry = require(script.Parent.registry)
local ChalkConfig = require(script.Parent.config)
local ChalkTypes = require(script.Parent.types)

local FShapes = script.Parent.shape
local Shapes = {
    sphere = require(FShapes.sphere),
    line = require(FShapes.line),
    label = require(FShapes.label)
    -- box    = require(FShapes.)
} :: {[string]: ChalkTypes.ShapeImpl<any>}

--]] Settings

--]] Constants
--]] Variables
--]] Functions
--]] Module
local Object = {} :: ChalkTypes.methods_object<ChalkTypes.ObjectShapes>
Object.__index = Object

--=============--
-- CONSTRUCTOR --
--=============--

--// TODO: Write Documentation
function Object.new(config: ChalkTypes.DebugObjectConfig) 
    local self = setmetatable(
        {} :: ChalkTypes.fields_object<ChalkTypes.ObjectShapes>, 
        Object)

    --> Create Shape
    self.config = config.config
    self.id = `{config.shape}-{HTTPS:GenerateGUID(false)}`

    local ctx: ChalkTypes.ShapeContext = {
        render = ChalkConfig.fetch().Render,
        debug_id = self.id,
    }

    local shape_behavior = Shapes[config.shape]
    assert(shape_behavior, `[{script.Name}] Failed to find ShapeBehavior for "{config.shape}"!`)
    
    self.shape = shape_behavior.mount(ctx, config.config)
    self.shape.part.Name = self.id

    --> Internal Behavior
    self._reconcile = function(args)
        shape_behavior.reconcile(ctx, self.shape, args)
    end

    self._unmount = function()
        shape_behavior.unmount(ctx, self.shape)
    end
    
    --> Register
    ChalkRegistry.get():Register(self)
    return self
end

--// TODO: Write Documentation
function Object.compose(shape: ChalkTypes.ObjectShapes)
    return function(data)
        return Object.new{
            shape = shape,
            config = data
        }
    end
end

--=========--
-- METHODS --
--=========--
--] Primary
function Object:Update(config)
    self.config = config
    self._reconcile(config)
end

function Object:Destroy()
    ChalkRegistry.get():Unregister(self.id)
    self._unmount()
end

--] Helper
--// TODO: Allow these to take in other Objects for origins
function Object:Line(to: Vector3, thickness: number?)
    local new_line = Object.new{
        shape = "line",
        config = { 
            from = (self.shape.part :: Part).Position, 
            to = to, 
            thickness = thickness }
    }

    return new_line
end

function Object:Label(label: string)
    local new_label = Object.new{
        shape = "label",
        config = {
            position = (self.shape.part :: Part).Position,
            text = label
        }
    }

    return new_label
end

--===========--
-- ACCESSORS --
--===========--

return Object