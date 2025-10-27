local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

local meteorCount = 5
local spawnHeight = 100
local fallSpeed = 100
local meteorLifetimeAfterHit = 6

local immunePlayers = {
    ["mertcanlo153727"] = true,
    ["INC0MING_1"] = true,
}

local function createMeteor(position)
    local meteor = Instance.new("Part")
    meteor.Shape = Enum.PartType.Ball
    meteor.Size = Vector3.new(4, 4, 4)
    meteor.Position = position + Vector3.new(math.random(-20,20), spawnHeight, math.random(-20,20))
    meteor.BrickColor = BrickColor.new("Really red")
    meteor.Material = Enum.Material.Neon
    meteor.Anchored = false
    meteor.CanCollide = true
    meteor.Name = "Meteor"
    meteor.Parent = Workspace

    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.Velocity = Vector3.new(0, -fallSpeed, 0)
    bodyVel.Parent = meteor

    local touchedConnection
    touchedConnection = meteor.Touched:Connect(function(hit)
        if not meteor or not meteor.Parent then
            touchedConnection:Disconnect()
            return
        end

        -- Eğer meteora çarpan oyuncuysa ve bağışık değilse öldür
        local character = hit.Parent
        local player = Players:GetPlayerFromCharacter(character)
        if player and not immunePlayers[player.Name] then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                humanoid.Health = 0
            end
        end

        -- Meteor yere veya başka bir şeye çarptığında
        if hit:IsDescendantOf(Workspace) and meteor and meteor.Parent then
            -- Ateş efekti
            local fire = Instance.new("Fire")
            fire.Size = 15
            fire.Heat = 50
            fire.Parent = meteor

            -- Meteor sabit kalsın
            bodyVel.Velocity = Vector3.new(0,0,0)
            bodyVel:Destroy()
            meteor.Anchored = true

            -- Bağlantıyı kes
            touchedConnection:Disconnect()

            -- 6 saniye sonra meteor yok olsun
            Debris:AddItem(meteor, meteorLifetimeAfterHit)
        end
    end)
end

local function spawnMeteorsNearPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            for i = 1, meteorCount do
                createMeteor(hrp.Position)
            end
        end
    end
end

while true do
    spawnMeteorsNearPlayers()
    wait(5)
end
