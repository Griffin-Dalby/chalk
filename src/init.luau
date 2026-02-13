--!strict
--[[
    chalk - Visual debugging library for Roblox

    Copyright 2025 Griffin Dalby
    Licensed under Apache 2.0
--]]

--]] Modules
local ChalkRegistry = require(script.registry)
local ChalkAdhesive = require(script.adhesive)
local ChalkObject = require(script.object)
local ChalkTypes = require(script.types)

--]] Chalk
local Chalk = {}
Chalk.registry = ChalkRegistry.get()

--> Core drawing primitives
type export_type<shape = ChalkTypes.ObjectShapes> = (data: index<ChalkTypes.ObjectArguments, shape>) -> ChalkTypes.DebugObject<shape>
Chalk.sphere = ChalkObject.compose("sphere") :: export_type<"sphere">
Chalk.box    = ChalkObject.compose("box")    :: export_type<"box">
Chalk.line   = ChalkObject.compose("line")   :: export_type<"line">
Chalk.ray    = ChalkObject.compose("ray")    :: export_type<"ray">
Chalk.point  = ChalkObject.compose("point")  :: export_type<"point">
Chalk.arrow  = ChalkObject.compose("arrow")  :: export_type<"arrow">
Chalk.label  = ChalkObject.compose("label")  :: export_type<"label">
Chalk.axes   = ChalkObject.compose("axes")   :: export_type<"axes">

--> Adhesive
Chalk.adhere = function()
    local new_adhesive = ChalkAdhesive.new()
    Chalk.registry:RegisterAdhesive(new_adhesive)

    return new_adhesive
end

return Chalk