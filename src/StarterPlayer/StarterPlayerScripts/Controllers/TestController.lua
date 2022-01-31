local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local TestController = Knit.CreateController{
	Name = "TestController",
}

function TestController:KnitInit()
	print("Test Controller Initialized")
end

function TestController:KnitStart()
	print("Test Controller Started")
end

return TestController
