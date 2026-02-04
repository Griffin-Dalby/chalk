--[[
    chalk Sphere Object
]]

--]] Modules
local ChalkRoot = script.Parent.Parent
local ChalkTypes = require(ChalkRoot.types)

--]] Shape
local SphereShape = {} :: ChalkTypes.ShapeImpl<index<ChalkTypes.ObjectArguments, "sphere">>

function SphereShape.mount(ctx, args)
    local state = {}

    --> Create
    local sphere = Instance.new("Part")
    sphere.Shape = Enum.PartType.Ball
    sphere.Anchored, sphere.CanCollide = true, false
    sphere.Parent = ctx.render.Parent

    state.part = sphere

    --> Style
    sphere.Material = ctx.render.Material
    sphere.Transparency = ctx.render.Transparency
    sphere.Color = ctx.render.Color

    --> Reconcile
    SphereShape.reconcile(ctx, state, args)

    return { part = sphere }
end

function SphereShape.reconcile(ctx, state, args)
    state.part.Size = Vector3.new(1, 1, 1) * (args.radius or 1) * 2
    state.part.CFrame = CFrame.new(args.position)
end

function SphereShape.unmount(ctx, state)
    state.part:Destroy()
end

return SphereShape