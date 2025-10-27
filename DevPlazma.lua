local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local PLASMA_SIZE = 30
local PLASMA_HEIGHT = 200
local PULL_RADIUS = 40
local PULL_STRENGTH = 50
local DESCENT_SPEED = 80
local ENERGY_DURATION = 5

-- Plasma küresi yaratma
local function CreatePlasmaSphere(position)
    local sphere = Instance.new("Part")
    sphere.Shape = Enum.PartType.Ball
    sphere.Material = Enum.Material.Neon
    sphere.BrickColor = BrickColor.new("Royal purple")
    sphere.Anchored = true
    sphere.CanCollide = false
    sphere.Size = Vector3.new(PLASMA_SIZE, PLASMA_SIZE, PLASMA_SIZE)
    sphere.Position = position + Vector3.new(0, PLASMA_HEIGHT, 0)
    sphere.Name = "PlasmaSphere"
    sphere.Parent = workspace

    local light = Instance.new("PointLight", sphere)
    light.Color = Color3.new(0.5, 0, 0.5)
    light.Brightness = 15
    light.Range = 50

    return sphere
end

-- Oyuncuları çekme fonksiyonu
local function PullPlayersTowards(position, radius, strength, excludeNames)
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not excludeNames[player.Name] then
                local hrp = player.Character.HumanoidRootPart
                local direction = (position - hrp.Position)
                local distance = direction.Magnitude
                if distance < radius and distance > 1 then
                    local pullVector = direction.Unit * (strength * (radius - distance) / radius)
                    hrp.Velocity = hrp.Velocity + pullVector
                end
            end
        end
    end
end

-- Plazma inişi ve çekme işlemi
local function StartPlasmaSequence(targetPos, excludeNames)
    local plasma = CreatePlasmaSphere(targetPos)
    local targetY = targetPos.Y + 5
    local descending = true

    local connection
    connection = RunService.Heartbeat:Connect(function(dt)
        if descending then
            local newY = plasma.Position.Y - DESCENT_SPEED * dt
            if newY <= targetY then
                plasma.Position = Vector3.new(targetPos.X, targetY, targetPos.Z)
                descending = false
            else
                plasma.Position = Vector3.new(targetPos.X, newY, targetPos.Z)
            end
        else
            -- İniş tamamlandı, oyuncuları çek
            PullPlayersTowards(plasma.Position, PULL_RADIUS, PULL_STRENGTH, excludeNames)
        end
    end)

    --  Enerji patlaması ve temizleme
    delay(ENERGY_DURATION, function()
        connection:Disconnect()

        -- Patlama efekti
        local explosion = Instance.new("Explosion")
        explosion.Position = plasma.Position
        explosion.BlastRadius = 20
        explosion.BlastPressure = 100000
        explosion.Parent = workspace

        -- Küreyi yok et
        plasma:Destroy()
    end)
end

-- Kullanıcı dışındakileri çekme örneği
local allowedPlayers = {
    ["mertcanlo153727"] = true,
    ["INC0MING_1"] = true
}

-- Ana döngü (3 saniyede bir oyunculara plazma bırak)
while true do
    wait(3)
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            StartPlasmaSequence(player.Character.HumanoidRootPart.Position, allowedPlayers)
        end
    end
end
