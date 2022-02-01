local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Component = require(Knit.Util.Component)
local ReplicaController = require(Knit.Util.ReplicaController)

Knit.AddControllers(script.Parent:WaitForChild("Controllers"))

Component.Auto(script.Parent.Components)

ReplicaController.RequestData()
Knit.Start():andThen(function()
	warn("Client Started")
end):catch(warn)

local LeaderboardService = Knit.GetService("LeaderboardService")

LeaderboardService:GetPoints():andThen(function(points)
	print(points)
end)
