local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local TestService = Knit.CreateService{
	Name = "TestService",
	Client = {}
}

function TestService:KnitInit()
	print("Test Service Initialized")
end

function TestService:KnitStart()
	print("Test Service Started")
end

return TestService
