local SoundService = game:GetService("SoundService")

local applauseSound = Instance.new("Sound")
applauseSound.SoundId = "rbxassetid://1869741275"
applauseSound.Volume = 5

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

for _, egg in ipairs(workspace.HiddenEggs:GetChildren()) do
	local attachment = Instance.new("Attachment")
	local explosion = getExplosion()
	local prompt = Instance.new("ProximityPrompt")
	local natureSound = Instance.new("Sound")
	attachment.Position = Vector3.new(0, 3, 0)
	attachment.Parent = egg
	explosion.Parent = egg
	egg.Anchored = true
	natureSound.Looped = true
	natureSound.RollOffMaxDistance = 20
	natureSound.SoundId = "rbxassetid://169736440" -- ForestAmbienceVar2
	natureSound.Volume = 3
	natureSound.Parent = egg
	natureSound:Play()
	prompt.ActionText = "Collect"
	prompt.ObjectText = tostring(egg.BrickColor) .. " egg"
	prompt.Parent = attachment
	prompt.Triggered:Connect(function(player)
		explosion:Emit(300)
		egg.Transparency = 1
		egg.Parent = workspace.FoundEggs
		natureSound:Stop()
		prompt.Enabled = false
		applauseSound.Parent = egg
		applauseSound:Play()
		applauseSound.Parent = SoundService
	end)
end
