local textLabel = script.Parent

local function updateEggCount()
	local eggs = workspace.HiddenEggs:GetChildren()
	textLabel.Text = "Hidden Eggs: " .. #eggs
end

updateEggCount()

workspace.HiddenEggs.ChildAdded:Connect(function()
	updateEggCount()
end)

workspace.HiddenEggs.ChildRemoved:Connect(function()
	updateEggCount()
end)
