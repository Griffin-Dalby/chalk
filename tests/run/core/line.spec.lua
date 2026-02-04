--!nocheck
--[[
    chalk Line Tests
--]]

--]] Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--]] Tests
return function()
    local Chalk = require(ReplicatedStorage.chalk)

    Chalk.sphere{position = Vector3.new(0, 5, 0), 4}
end