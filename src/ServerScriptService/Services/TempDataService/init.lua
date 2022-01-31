--!strict
local Players = game:GetService("Players")

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local SaveStructure = require(script.SaveStructure)
local TableUtil = require(Knit.Util.TableUtil)
local Promise = require(Knit.Util.Promise)
local ReplicaService = require(Knit.Util.ReplicaService)

local TempProfiles = {}
local TempReplicas = {}

local TempDataService = Knit.CreateService {
	Name = "TempDataService",
	PlayerRoundInfos = {},
	Client = {},
}

function PlayerAdded(Player:Player)
	local StartTime = tick()

	local Data = TableUtil.Copy(SaveStructure)

	local Replica = ReplicaService.NewReplica({
		ClassToken = ReplicaService.NewClassToken("TempDataReplica_"..tostring(Player.UserId)),
		Data = Data,
		Replication = Player
	})

	TempProfiles[Player] = Data
	TempReplicas[Player] = Replica
	
	--warn(Player.Name.. "'s temp has been loaded. ".."("..string.sub(tostring(tick()-StartTime),1,5)..")")
end

function PlayerRemoving(Player:Player)
	TempProfiles[Players] = nil

	local Replica = TempReplicas[Player]

	if Replica then
		task.defer(function()
			Replica:Destroy()
			TempReplicas[Player] = nil
		end,3)
	end
end

function TempDataService:GetReplica(Player:Player)
	return Promise.new(function(Resolve, Reject)
		
		if not TempProfiles[Player] and not TempReplicas[Player] then
			repeat 
				if Player then
					wait()
				else
					Reject("Player left the game")
				end
			until TempProfiles[Player] and TempReplicas[Player]
		end
		assert(typeof(Player) == "Instance" and Player:IsDescendantOf(Players), "Value passed is not a valid player")

		local Replica = TempReplicas[Player]

		if Replica then
			Resolve(Replica)
		else
			Reject("Replica is nil")
		end
	end)
end

function TempDataService:KnitInit()

	for i, Player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			PlayerAdded(Player)
		end)
	end

	Players.PlayerAdded:Connect(PlayerAdded)

	Players.PlayerRemoving:Connect(PlayerRemoving)
end

return TempDataService