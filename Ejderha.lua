local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

-- Senin adını LocalPlayer'dan alıyoruz (executor destekliyorsa)
local myName = game.Players.LocalPlayer.Name 

while true do
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Name ~= myName and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character.HumanoidRootPart
			-- Ejderha pozisyonu oyuncunun üstünde uçuyor
			local dragonPart = Instance.new("Part")
			dragonPart.Size = Vector3.new(10, 5, 10)
			dragonPart.Transparency = 1 -- görünmez
			dragonPart.Anchored = true
			dragonPart.CanCollide = false
			dragonPart.CFrame = hrp.CFrame * CFrame.new(0, 10, 0)
			dragonPart.Parent = workspace

			-- Ateş efekti
			local fire = Instance.new("Fire", dragonPart)
			fire.Heat = 25
			fire.Size = 10
			fire.Color = Color3.new(1, 0.3, 0)

			-- Ses efekti
			local sound = Instance.new("Sound", dragonPart)
			sound.SoundId = "rbxassetid://138186576" -- Gök gürültüsü
			sound.Volume = 4
			sound:Play()

			-- Hasar verme
			local humanoid = player.Character:FindFirstChild("Humanoid")
			if humanoid then
				humanoid:TakeDamage(40)
			end

			Debris:AddItem(dragonPart, 3)
		end
	end
	wait(5)
end
