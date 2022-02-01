local DataStoreService = game:GetService("DataStoreService")

local PlayerPoints = DataStoreService:GetDataStore("PlayerPoints")

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local STARTING_POINTS = 0

local LeaderboardService = Knit.CreateService {
	Name = "LeaderboardService",
	Client = {}
}

local function setupLeaderboard(player)
	local folder = Instance.new("Folder")
	local points = Instance.new("IntValue")
	folder.Name = "leaderstats"
	folder.Parent = player
	points.Name = "Points"
	points.Value = STARTING_POINTS
	points.Parent = folder
	local success, savedPlayerPoints = pcall(function()
		return PlayerPoints:GetAsync(player.UserId)
	end)
	if success then
		if savedPlayerPoints then
			points.Value = savedPlayerPoints
		else
			points.Value = STARTING_POINTS
		end
	end
end

game.Players.PlayerAdded:Connect(setupLeaderboard)

local function saveLeaderboard(player)
	local success, errorMessage = pcall(function()
		PlayerPoints:SetAsync(player.UserId, player.leaderstats.Points.Value)
	end)
	if not success then
		warn(errorMessage)
	end
end

game.Players.PlayerRemoving:Connect(saveLeaderboard)

function LeaderboardService:KnitInit()
	print("Leaderboard Service Initialized")
end

function LeaderboardService:KnitStart()
	print("Leaderboard Service Started")
end

function LeaderboardService:GetPoints(player)
	return player.leaderstats.Points.Value
end

function LeaderboardService:GivePoints(player, points)
	player.leaderstats.Points.Value += points
end

function LeaderboardService.Client:GetPoints(player)
	return self.Server:GetPoints(player)
end

function LeaderboardService.Client:GivePoints(player, points)
	return self.Server:GivePoints(player, points)
end

return LeaderboardService
