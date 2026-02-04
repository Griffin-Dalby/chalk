--[[
    chalk Label Object
--]]

--]] Modules
local ChalkRoot = script.Parent.Parent
local ChalkTypes = require(ChalkRoot.types)

--]] Shape
local LabelShape = {} :: ChalkTypes.ShapeImpl<index<ChalkTypes.ObjectArguments, "label">>

function LabelShape.mount(ctx, args)
    local state = {}
    
    --> Create
    local base = Instance.new("Part")
    base.Anchored, base.CanCollide = true, false
    base.Parent = ctx.render.Parent
    base.Transparency = 1

    state.base = base

    local label = Instance.new("BillboardGui")
    label.Size = UDim2.new(12, 0, .75, 0)
    label.AlwaysOnTop = true
    label.Parent = base

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextScaled = true
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Parent = label

    local stroke = Instance.new("UIStroke")
    stroke.Thickness, stroke.Transparency = 2, .25
    stroke.Parent = text

    state.text = text

    --> Reconcile
    LabelShape.reconcile(ctx, state, args)
end

function LabelShape.reconcile(ctx, state, args)
    state.text.Text = args.text
    state.base.CFrame = CFrame.new(args.position)
end

function LabelShape.unmount(ctx, state)
    state.part:Destroy()
end

return LabelShape