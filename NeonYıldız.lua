local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

for _, player in ipairs(Players:GetPlayers()) do
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		for i = 1, 5 do
			local star = Instance.new("Part")
			star.Shape = Enum.PartType.Ball
			star.Size = Vector3.new(1,1,1)
			star.Material = Enum.Material.Neon
			star.Color = Color3.fromRGB(255, 255, 0)
			star.Anchored = true
			star.Parent = workspace
            star.CanCollide = false

			local angle = (i / 5) * math.pi * 2
			RunService.Heartbeat:Connect(function()
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local pos = player.Character.HumanoidRootPart.Position
					local x = math.cos(tick() + angle) * 3
					local z = math.sin(tick() + angle) * 3
					star.Position = pos + Vector3.new(x, 2, z)
				end
			end)
		end
	end
end
