--You need to have the tag editor plugin here is the link https://www.roblox.com/library/948084095/Tag-Editor

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Component = require(Knit.Util.Component)

local MyComponent = {}
MyComponent.__index = MyComponent
MyComponent.Tag = "MyComponent"

-- CONSTRUCTOR
function MyComponent.new(instance)
	local self = setmetatable({}, MyComponent)
	-- Add more properties to self before returning like self.TimeCreated = tick()
	self.TimeCreated = tick()
	return self
end

-- OPTIONAL LIFECYCLE HOOKS
function MyComponent:Init()--> Called right after constructor
	local instance:Part = self.Instance
	instance.Color = Color3.fromRGB(51, 255, 0)
	print(MyComponent.Tag, "has been applied to", self.Instance.Name, "at", self.TimeCreated, "on the client.")
	-- Self.Instance --> instance with tag 
end        

function MyComponent:Deinit()--> Called right before deconstructor
	-- Self.Instance --> instance with tag 
end                   

function MyComponent:HeartbeatUpdate(DeltaTime)  end    --> Updates every heartbeat
function MyComponent:SteppedUpdate(DeltaTime)  end      --> Updates every physics step
function MyComponent:RenderUpdate(DeltaTime)  end       --> Updates every render step

-- DESTRUCTOR
function MyComponent:Destroy()
	--> Clean up connections or better yet use trove in the knit util folder
end

return MyComponent