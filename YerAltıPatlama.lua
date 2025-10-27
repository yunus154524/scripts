local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

while true do
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            local explosion = Instance.new("Explosion")
            explosion.Position = pos - Vector3.new(0,3,0)
            explosion.BlastRadius = 8
            explosion.BlastPressure = 300000
            explosion.Parent = workspace
        end
    end
    wait(10)
end
