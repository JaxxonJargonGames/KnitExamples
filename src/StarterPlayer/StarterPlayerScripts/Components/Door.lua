local Players = game:GetService("Players")

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Component = require(Knit.Util.Component)

local COOLDOWN = 3

local Door = {}
Door.__index = Door
Door.Tag = "Door"

function Door.new(instance)
	local self = setmetatable({}, Door)
	return self
end

function Door:Init()
	local debounce = false
	self.touchedConnection = self.Instance.Touched:Connect(function(hit)
		if debounce then return	end
		debounce = true
		if hit.Parent.Name == self.Instance:GetAttribute("KeyName") then
			-- Only the key holder can pass through the door.
			if Players:GetPlayerFromCharacter(hit.Parent.Parent) == Players.LocalPlayer then
				self.Instance.Transparency = 0.5
				self.Instance.CanCollide = false
				task.wait(COOLDOWN)
				self.Instance.Transparency = 0
				self.Instance.CanCollide = true
			end
		end
		debounce = false
	end)
end        

function Door:Destroy()
	self.touchedConnection:Disconnect()
end

return Door
