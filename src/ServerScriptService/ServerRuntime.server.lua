local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Component = require(Knit.Util.Component)

Knit.AddServices(script.Parent.Services)

Component.Auto(script.Parent.Components)

Knit.Start():andThen(function()
	warn("Server Started")
end):catch(warn)