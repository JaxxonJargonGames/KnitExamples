local ServerStorage = game:GetService("ServerStorage")

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local TableUtil =require(Knit.Util.TableUtil)

local Plates = ServerStorage.Islands:GetDescendants()

Plates = TableUtil.Filter(Plates, function(Value: Instance, Key:number)
	return Value:IsA("BasePart")
end)

return setmetatable({}, {
	__index = function(Table, SearchKey)
		local Plate = TableUtil.Find(Plates, function(Plate)
			return Plate.Name == SearchKey
		end)
		return Plate
	end,
})
