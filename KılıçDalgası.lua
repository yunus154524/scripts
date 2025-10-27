local Players = game:GetService("Players")

while true do
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local wave = Instance.new("Part")
			wave.Size = Vector3.new(1,1,1)
			wave.Anchored = true
			wave.CanCollide = false
			wave.Material = Enum.Material.Neon
			wave.Color = Color3.fromRGB(0, 255, 255)
			wave.CFrame = player.Character.HumanoidRootPart.CFrame
			wave.Parent = workspace

			game:GetService("TweenService"):Create(wave, TweenInfo.new(1), {Size = Vector3.new(50,0.5,50), Transparency = 1}):Play()

			game:GetService("Debris"):AddItem(wave, 1)
		end
	end
	wait(3)
end
