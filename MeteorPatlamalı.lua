local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

while true do
	local meteor = Instance.new("Part")
	meteor.Shape = Enum.PartType.Ball
	meteor.Size = Vector3.new(10, 10, 10)
	meteor.Material = Enum.Material.Neon
	meteor.Color = Color3.fromRGB(255, 100, 0)
	meteor.Anchored = false
	meteor.Parent = workspace
	meteor.Position = Vector3.new(math.random(-100, 100), 80, math.random(-100, 100))

	local fire = Instance.new("Fire", meteor)
	fire.Size = 15
	fire.Heat = 20

	local bv = Instance.new("BodyVelocity", meteor)
	bv.Velocity = Vector3.new(0, -60, 0)

	meteor.Touched:Connect(function(hit)
		local hum = hit.Parent:FindFirstChild("Humanoid")
		if hum then
			hum:TakeDamage(80)
		end
		local explosion = Instance.new("Explosion", workspace)
		explosion.Position = meteor.Position
		explosion.BlastRadius = 12
		explosion.BlastPressure = 500000
		meteor:Destroy()
	end)

	Debris:AddItem(meteor, 8)
	wait(2)
end
