--Place in the Services folder in serverscriptstorage
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local ExampleService = Knit.CreateService{
	Name = "ExampleService",
	Client = {}
}

function ExampleService:KnitInit()
	-- The way I made this data manager allows me to access the functions in the Init function
	-- So...
	local Player = game.Players:GetPlayers()[1] or game.Players.PlayerAdded:Wait()-- Remember to always use GetService() this is just an example
	local DataService = Knit.GetService("DataService")
	-- Basically require but with extra steps then
	DataService:GetReplica(Player):andThen(function(PlayerDataReplica)--You can also just call this whatever you want I call it replica
		PlayerDataReplica:SetValue("Money", PlayerDataReplica.Data.Money + 10)
		print(PlayerDataReplica)-- This is what a player data looks like it's the structure of whatevery is in the SaveStructure located in DataService
	end)
end

function ExampleService:KnitStart()

end

return ExampleService
