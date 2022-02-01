local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Component = require(Knit.Util.Component)

local Egg = {}
Egg.__index = Egg
Egg.Tag = "Egg"

local function getApplauseSound()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://1869741275"
	sound.Volume = 5
	return sound
end

local function getExplosion()
	local explosion = Instance.new("ParticleEmitter")
	explosion.Enabled = false
	explosion.Texture = "rbxassetid://6101261905"
	explosion.Drag = 10
	explosion.Lifetime = NumberRange.new(0.2, 0.6)
	explosion.Speed = NumberRange.new(20, 40)
	explosion.SpreadAngle = Vector2.new(180, 180)
	return explosion
end

local function getNatureSound()
	local sound = Instance.new("Sound")
	sound.Looped = true
	sound.RollOffMaxDistance = 20
	sound.SoundId = "rbxassetid://169736440" -- ForestAmbienceVar2
	sound.Volume = 3
	return sound
end

function Egg.new(instance)
	local self = setmetatable({}, Egg)
	return self
end

function Egg:Init()
	local attachment = Instance.new("Attachment")
	local explosion = getExplosion()
	local natureSound = getNatureSound()
	local prompt = Instance.new("ProximityPrompt")
	self.Instance.Anchored = true
	attachment.Position = Vector3.new(0, 3, 0)
	attachment.Parent = self.Instance
	explosion.Parent = self.Instance
	natureSound.Parent = self.Instance
	natureSound:Play()
	prompt.ActionText = "Collect"
	prompt.ObjectText = tostring(self.Instance.BrickColor) .. " egg"
	prompt.Parent = attachment
	prompt.Triggered:Connect(function(player)
		explosion:Emit(300)
		self.Instance.Transparency = 1
		self.Instance.Parent = workspace.FoundEggs
		natureSound:Stop()
		prompt.Enabled = false
		local applauseSound = getApplauseSound()
		applauseSound.Parent = self.Instance
		applauseSound:Play()
		applauseSound.Parent = SoundService
	end)
end        

function Egg:Destroy()
end

return Egg
