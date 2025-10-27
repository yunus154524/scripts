local Players = game:GetService("Players")
local myName = game.Players.LocalPlayer.Name -- kendi kullanıcı adın

local function kickOthers()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name ~= myName then
            player:Kick("YOU FUCKED BY " .. myName )
        end
    end
end

-- Başlangıçta at
kickOthers()

-- Her oyuncu geldiğinde at
Players.PlayerAdded:Connect(function(player)
    if player.Name ~= myName then
        player:Kick("YOU FUCKED BY " .. myName )
    end
end)

-- Sürekli periyodik kontrol, eğer sunucuda kalırlarsa hemen atar
while true do
    kickOthers()
    wait(5) -- 5 saniyede bir kontrol eder, istersen azaltabilirsin
end
