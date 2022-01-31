--Place in the client's controllers folder
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ReplicaController = require(Knit.Util.ReplicaController)
	
local ExampleService = Knit.CreateController{
	Name = "ExampleController",
	Client = {}
}

function ExampleService:KnitInit()
	ReplicaController.ReplicaOfClassCreated("PlayerData", function(PlayerDataReplica)
		if PlayerDataReplica.Tags.Player == Knit.Player then
			print(PlayerDataReplica)
			-- And just like that you have the player's data on the client without a single remote event 
		end
	end)
end

function ExampleService:KnitStart()

end

return ExampleService
