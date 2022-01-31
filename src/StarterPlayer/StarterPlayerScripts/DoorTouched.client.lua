local Players = game:GetService("Players")

local player = Players.LocalPlayer

local COOLDOWN = 3

for _, door in ipairs(workspace.Doors:GetChildren()) do
	local debounce = false
	door.Touched:Connect(function(hit)
		if debounce then return	end
		debounce = true
		if hit.Parent.Name == door:GetAttribute("KeyName") then
			-- Only the key holder can pass through the door.
			if Players:GetPlayerFromCharacter(hit.Parent.Parent) == player then
				door.Transparency = 0.5
				door.CanCollide = false
				task.wait(COOLDOWN)
				door.Transparency = 0
				door.CanCollide = true
			end
		end
		debounce = false
	end)
end
