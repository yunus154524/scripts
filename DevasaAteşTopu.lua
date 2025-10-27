    local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

while true do
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local pos = player.Character.HumanoidRootPart.Position
			local fireball = Instance.new("Part")
			fireball.Shape = Enum.PartType.Ball
			fireball.Color = Color3.fromRGB(255, 80, 0)
			fireball.Material = Enum.Material.Neon
			fireball.Size = Vector3.new(5,5,5)
			fireball.Anchored = false
			fireball.Position = pos + Vector3.new(math.random(-10,10), 50, math.random(-10,10))
			fireball.Parent = workspace

			local fire = Instance.new("Fire", fireball)
			fire.Size = 8
			fire.Heat = 10

			local bv = Instance.new("BodyVelocity", fireball)
			bv.Velocity = Vector3.new(0, -50, 0)

			fireball.Touched:Connect(function(hit)
				local hum = hit.Parent:FindFirstChild("Humanoid")
				if hum then
					hum:TakeDamage(50)
				end
			end)

			Debris:AddItem(fireball, 10)
		end
	end
	wait(5)
end
