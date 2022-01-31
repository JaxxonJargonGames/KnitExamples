local textLabel = script.Parent

local function updateEggCount()
	local eggs = workspace.FoundEggs:GetChildren()
	textLabel.Text = "Found Eggs: " .. #eggs
end

updateEggCount()

workspace.FoundEggs.ChildAdded:Connect(function()
	updateEggCount()
end)

workspace.FoundEggs.ChildRemoved:Connect(function()
	updateEggCount()
end)
