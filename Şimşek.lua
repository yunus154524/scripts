local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

-- Kendi kullanıcı adını buraya yaz
local myName = game.Players.LocalPlayer.Name

while true do
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Name ~= myName and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local pos = player.Character.HumanoidRootPart.Position

			-- Şimşek
			local bolt = Instance.new("Part")
			bolt.Size = Vector3.new(0.3, 50, 0.3)
			bolt.Anchored = true
			bolt.Material = Enum.Material.Neon
			bolt.Color = Color3.fromRGB(0, 255, 255)
			bolt.CFrame = CFrame.new(pos + Vector3.new(0, 25, 0))
			bolt.Parent = workspace
			Debris:AddItem(bolt, 0.2)

			-- Patlama
			local explosion = Instance.new("Explosion")
			explosion.Position = pos
			explosion.BlastRadius = 10
			explosion.BlastPressure = 500000
			explosion.Parent = workspace

			-- Ses
			local sound = Instance.new("Sound", workspace)
			sound.SoundId = "rbxassetid://138186576" -- Gök gürültüsü
			sound.Volume = 5
			sound:Play()
			Debris:AddItem(sound, 3)
		end
	end
	wait(3) -- 3 saniyede bir
end
