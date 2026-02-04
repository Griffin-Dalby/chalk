--!strict
--[[
    chalk Type Definitions

    Type defintions for chalk objects.
--]]

local t = {}

--========--
-- CONFIG --
--========--
--#region

export type ChalkConfig = {
    Render: {
        Parent: Folder,

        Material: Enum.Material,
        Transparency: number,
        Color: Color3,
    }
}

--#endregion

--============--
-- PRIMITIVES --
--============--
--#region

export type ObjectShapes = "sphere" |
                           "box" |
                           "line" |
                           "ray" |
                           "point" |
                           "arrow" |
                           "label" |
                           "axes"

export type ObjectArguments = {
    box: {cframe: CFrame, size: Vector3?},
    axes: {cframe: CFrame, scale: number?},
    point: {position: Vector3, size: number?},
    sphere: {position: Vector3, radius: number?},

    line: {from: Vector3, to: Vector3, thickness: number?},
    arrow: {from: Vector3, to: Vector3},
    ray: {origin: Vector3, direction: Vector3},

    label: {position: Vector3, text: string},
}

--#endregion

--========--
-- SHAPES --
--========--
--#region

export type ShapeContext = {
    render: index<ChalkConfig, "Render">,
    debug_id: string,
}

export type ShapeState = {

}

export type ShapeImpl<args> = {
    mount: (ctx: ShapeContext, args: args) -> ShapeState,
    reconcile: (ctx: ShapeContext, state: ShapeState, args: args) -> (),
    unmount: (ctx: ShapeContext, state: ShapeState) -> (),
}

--#endregion

--========--
-- OBJECT --
--========--
--#region
export type DebugObjectConfig = {
    shape: ObjectShapes,
    config: index<ObjectArguments, ObjectShapes>
}

export type methods_object<shape = ObjectArguments|any?> = {
    __index: methods_object<shape>,

    --[[ CONSTRUCTOR ]]--

    --// TODO: Write Documentation
    new: (config: DebugObjectConfig) -> DebugObject<shape>,

    --// TODO: Write Documentation
    compose: (shape: ObjectShapes) -> ((data: index<ObjectArguments, shape>) -> DebugObject<shape>),

    --[[ METHODS ]]--
    Update: (self: DebugObject<shape>, config: index<ObjectArguments, shape>) -> (),
    Destroy: () -> (),

    --[[ ACCESSORS ]]--

}
export type fields_object<shape> = {
    --> Parameters
    config: index<ObjectArguments, ObjectShapes>,
    id: string,
    shape: ShapeState,

    --> Internal Behavior
    _reconcile: (args: index<ObjectArguments, ObjectShapes>) -> (),
    _unmount: () -> (),
}

export type DebugObject<shape = ObjectShapes?> = typeof(setmetatable({} :: fields_object<shape>, {} :: methods_object<shape>))

--#endregion

--==========--
-- REGISTRY --
--==========--
--#region
export type methods_registry = {
    __index: methods_registry,
    instance: ChalkRegistry?,

    --[[ CONSTRUCTOR ]]--

    --// TODO: Write Documentation
    get: () -> ChalkRegistry,

    --[[ METHODS ]]--

    --// TODO: Write Documentation
    Register: (self: ChalkRegistry, object: DebugObject<ObjectShapes>) -> (),

    --// TODO: Write Documentation
    Unregister: (self: ChalkRegistry, object_id: string) -> ()

    --[[ ACCESSORS ]]--
}
export type fields_registry = {
    objects: { [string]: DebugObject<ObjectShapes> },
}

export type ChalkRegistry = typeof(setmetatable({} :: fields_registry, {} :: methods_registry))

--#endregion

return t