local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local myName = game.Players.LocalPlayer.Name

while true do
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Name ~= myName and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local pos = player.Character.HumanoidRootPart.Position

			-- Renkli top
			local ball = Instance.new("Part")
			ball.Shape = Enum.PartType.Ball
			ball.Material = Enum.Material.Neon
			ball.Size = Vector3.new(5,5,5)
			ball.Anchored = true
			ball.CanCollide = false
			ball.CFrame = CFrame.new(pos)
			ball.Parent = workspace
			ball.Color = Color3.fromHSV(math.random(), 1, 1)

			-- Tween ile büyütme ve saydamlaştırma
			local tween = TweenService:Create(ball, TweenInfo.new(1), {Size = Vector3.new(20,20,20), Transparency = 1})
			tween:Play()

			Debris:AddItem(ball, 1)

			-- Patlama sesi
			local sound = Instance.new("Sound", workspace)
			sound.SoundId = "rbxassetid://12222030" -- Patlama sesi
			sound.Volume = 3
			sound:Play()
			Debris:AddItem(sound, 2)
		end
	end
	wait(3)
end
