--[[
    chalk Test Runner

    Runs chalk tests with TestEZ.
--]]

--]] Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--]] Modules
local TestEZ = require(ReplicatedStorage.Packages.testez)

--]] Run Tests
return function ()
    for _, descendant in ipairs(script:GetDescendants()) do
        if descendant:IsA("ModuleScript") then
            print(`[{script.Name}] Checking Test Integrity: {descendant.Name}`)
            local ok, result = pcall(require, descendant)
            if not ok then
                warn(`[{script.Name}] TEST MODULE FAILED! {descendant.Name}`)
                warn(result)
            end
        end
    end

    print(`[{script.Name}] Running Tests...`)
    TestEZ.TestBootstrap:run({script.core})
end