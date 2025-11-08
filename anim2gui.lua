game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "YunusLo1545 Animations GUI",
	Text = "Made by YunusLo1545", 
	Icon = ""
})

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid",5)

-- Animasyon ID ve İsimler
local animationIDs = {126498284392270,88859617281337,94396433692515,87158692222427,91099861360307,
111428721005568,106352638060551,139409458073355,91077746625220,126672040102655,
100768189512415,85599557795628,114545830846750,106345408237539,99971950863689,
88425531063616,122814100170962,116578970554242,131563088003247,121936817462716,
138671863009472,112661109226148,74601470677586,92118471015650,106008592717540,
106108579985347,91088300046420,103394529293468,76622684003043}

local animationNames = {"Giant Hand Head Pat","WOOF BARK WOOF","Big Hand Point","Big hand come here","Holding Head in Hands Levitation",
"Big Hand L","Chill Aura Farming","Floating Giant","Big Hand Come Here","Tall Giant","Giant hand grab",
"Dislike Hand","Giant Blocky Point","Sukuna Aura Farming","Crazy Jumping Spider","Stylish Floating",
"Obby Head - Emote","Cute Sit","Little Obby","Race Car","Finger-Gun","67","Become Tall","67 ! Six Seven",
"Luffy Gear 5 Laugh","GEAR 5 Luffy Transformation","Railgun","NEW FASTEST SPEED GLITCH","Become Tall V2"}

-- GUI
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = playerGui:FindFirstChild("AnimationsGUI") or Instance.new("ScreenGui")
screenGui.Name = "AnimationsGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0,60,0,60)
toggleButton.Position = UDim2.new(0,15,0,15)
toggleButton.Text = "Anim"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.BackgroundColor3 = Color3.fromRGB(45,45,60)
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.Parent = screenGui
toggleButton.BorderSizePixel = 0

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,250,0,600)
frame.Position = UDim2.new(0,90,0,15)
frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
frame.Parent = screenGui
frame.ClipsDescendants = true
frame.BorderSizePixel = 0

local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(40,40,60)), ColorSequenceKeypoint.new(1,Color3.fromRGB(60,50,80))}
gradient.Rotation = 45

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Animations GUI"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local minimizeButton = Instance.new("TextButton", frame)
minimizeButton.Size = UDim2.new(0,30,0,30)
minimizeButton.Position = UDim2.new(1,-35,0,5)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 20
minimizeButton.BackgroundColor3 = Color3.fromRGB(70,70,100)
minimizeButton.TextColor3 = Color3.fromRGB(255,255,255)
minimizeButton.BorderSizePixel = 0

local minimized = false

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Size = UDim2.new(1,0,1,-40)
scrollFrame.Position = UDim2.new(0,0,0,40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0,5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local animationTracks = {}

local function toggleAnimation(id, button)
    local trackData = animationTracks[id]
    if trackData and trackData.Track.IsPlaying then
        pcall(function() trackData.Track:Stop() end)
        button.Indicator.BackgroundColor3 = Color3.fromRGB(255,0,0)
    else
        local animInstance
        local ok, objs = pcall(function() return game:GetObjects("rbxassetid://"..tostring(id)) end)
        if ok and objs and #objs>0 and objs[1]:IsA("Animation") then
            animInstance = objs[1]
        else
            animInstance = Instance.new("Animation")
            animInstance.AnimationId = "rbxassetid://"..tostring(id)
        end

        local success, trackOrErr = pcall(function() return humanoid:LoadAnimation(animInstance) end)
        if not success or not trackOrErr then return end

        trackOrErr.Priority = Enum.AnimationPriority.Action
        trackOrErr.Looped = true
        pcall(function() trackOrErr:Play() end)
        animationTracks[id] = {Track = trackOrErr}

        button.Indicator.BackgroundColor3 = Color3.fromRGB(0,255,0)
    end
end

for i, animId in ipairs(animationIDs) do
    local btnFrame = Instance.new("Frame", scrollFrame)
    btnFrame.Size = UDim2.new(0.95,0,0,35)
    btnFrame.BackgroundTransparency = 1

    local indicator = Instance.new("Frame", btnFrame)
    indicator.Size = UDim2.new(0,10,1,0)
    indicator.Position = UDim2.new(0,0,0,0)
    indicator.BackgroundColor3 = Color3.fromRGB(255,0,0)
    indicator.Name = "Indicator"

    local btn = Instance.new("TextButton", btnFrame)
    btn.Size = UDim2.new(1,-15,1,0)
    btn.Position = UDim2.new(0,15,0,0)
    btn.Text = animationNames[i] or ("Animation "..i)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,90)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.BorderSizePixel = 0

    btn.MouseButton1Click:Connect(function()
        toggleAnimation(animId, btnFrame)
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(90,90,110)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(70,70,90)}):Play()
    end)
end

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    scrollFrame.Visible = not minimized
    frame.Size = minimized and UDim2.new(0,250,0,50) or UDim2.new(0,250,0,600)
end)

-- **İlk sürükleme sistemi (çalışan)**
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Target:IsDescendantOf(scrollFrame) or input.Target:IsA("TextButton") then return end
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
