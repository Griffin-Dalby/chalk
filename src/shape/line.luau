--[[
    chalk Line Object
--]]

--]] Modules
local ChalkRoot = script.Parent.Parent
local ChalkTypes = require(ChalkRoot.types)

--]] Shape
local LineShape = {} :: ChalkTypes.ShapeImpl<index<ChalkTypes.ObjectArguments, "line">>

function LineShape.mount(ctx, args)
    local state = {}

    --> Create
    local line = Instance.new("Part")
    line.Anchored, line.CanCollide = true, false
    line.Parent = ctx.render.Parent

    state.part = line

    --> Style
    line.Material = ctx.render.Material
    line.Transparency = ctx.render.Transparency
    line.Color = ctx.render.Color

    --> Reconcile
    LineShape.reconcile(ctx, state, args)

    return { part = line }
end

function LineShape.reconcile(ctx, state, args)
    local part = state.part :: Part
    part.Size = (Vector3.new(1, 1, 0) * (args.thickness or .25))
              + Vector3.new(0, 0, (args.from-args.to).Magnitude)
    part.CFrame = CFrame.lookAt(args.from:lerp(args.to, .5), args.to)
end

function LineShape.unmount(ctx, state)
    state.part:Destroy()
end

return LineShape