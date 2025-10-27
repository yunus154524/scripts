local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local function CreateCrackPart(position, rotation)
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.3, 0.05, 3)
    part.Anchored = true
    part.CanCollide = false
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(100, 100, 100)
    part.Transparency = 0.6
    part.CFrame = CFrame.new(position) * CFrame.Angles(0, rotation, 0)
    part.Parent = workspace

    local fire = Instance.new("Fire")
    fire.Size = 5
    fire.Heat = 10
    fire.Color = Color3.fromRGB(255, 140, 0)
    fire.Parent = part

    Debris:AddItem(part, 6) -- 6 saniyede sil

    return part
end

local function SpawnCracks(centerPosition)
    for i = 1, 8 do
        local angle = math.rad((i-1) * 45)
        local offset = Vector3.new(math.cos(angle), 0, math.sin(angle)) * 5
        CreateCrackPart(centerPosition + offset + Vector3.new(0, 0.05, 0), angle)
    end
end

while true do
    wait(10)
    local players = Players:GetPlayers()
    if #players > 0 then
        local plr = players[math.random(1, #players)]
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            SpawnCracks(plr.Character.HumanoidRootPart.Position)
        end
    end
end
