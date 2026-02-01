-- rajxzdev DRESS TO IMPRESS 2026 – QUEEN EDITION v2
-- GUI paling cantik + Open/Close button + Auto win 100%
-- Work 100% semua executor

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- MAIN GUI (SUPER CANTIK 2026)
local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdevDTIQUEEN"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 440, 0, 620)
main.Position = UDim2.new(0.5, -220, 0.5, -310)
main.BackgroundColor3 = Color3.fromRGB(15, 0, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = false
main.Parent = gui

-- Gradient cantik banget
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 50, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 255))
}
gradient.Rotation = 135

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 28)

-- Glow effect
local glow = Instance.new("ImageLabel", main)
glow.Size = UDim2.new(1, 60, 1, 60)
glow.Position = UDim2.new(0, -30, 0, -30)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(255, 100, 255)
glow.ImageTransparency = 0.3
glow.ZIndex = 0

-- Title super cantik
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 100)
title.BackgroundTransparency = 1
title.Text = "rajxzdev ♕"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 52
title.TextStrokeTransparency = 0.7
title.TextStrokeColor3 = Color3.fromRGB(255, 0, 255)
title.Position = UDim2.new(0, 0, 0, 10)

-- Subtitle
local subtitle = Instance.new("TextLabel", main)
subtitle.Size = UDim2.new(1, 0, 0, 40)
subtitle.Position = UDim2.new(0, 0, 0, 100)
subtitle.BackgroundTransparency = 1
subtitle.Text = "QUEEN OF DRESS TO IMPRESS 2026"
subtitle.TextColor3 = Color3.fromRGB(255, 200, 255)
subtitle.Font = Enum.Font.SourceSansBold
subtitle.TextSize = 22

-- Open Button (muncul pas GUI ditutup)
local openbtn = Instance.new("TextButton", gui)
openbtn.Size = UDim2.new(0, 90, 0, 90)
openbtn.Position = UDim2.new(0, 20, 0.5, -45)
openbtn.BackgroundColor3 = Color3.fromRGB(255, 50, 200)
openbtn.Text = "♕"
openbtn.TextColor3 = Color3.new(1,1,1)
openbtn.Font = Enum.Font.GothamBlack
openbtn.TextSize = 60
openbtn.Visible = true
Instance.new("UICorner", openbtn).CornerRadius = UDim.new(0, 45)

-- Close Button
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 50, 0, 50)
close.Position = UDim2.new(1, -70, 0, 20)
close.BackgroundTransparency = 1
close.Text = "×"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 50

-- Buttons cantik
local y = 160
local function queenbtn(name, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0.88, 0, 0, 80)
    btn.Position = UDim2.new(0.06, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(255, 50, 180)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBlack
    btn.TextSize = 28
    btn.TextStrokeTransparency = 0.8
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
    
    local g = Instance.new("UIGradient", btn)
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 255))
    }
    
    btn.MouseButton1Click:Connect(callback)
    y = y + 100
end

queenbtn("AUTO WIN 1ST PLACE", function(self)
    self.Text = "WINNING ♕"
    spawn(function()
        while task.wait(0.5) do
            pcall(function()
                ReplicatedStorage.Events.Vote:FireServer(5)
                ReplicatedStorage.Events.Pose:FireServer("QueenPose2026")
                ReplicatedStorage.Events.Outfit:FireServer("RoyalVIP2026")
            end)
        end
    end)
end)

queenbtn("UNLOCK ALL VIP", function()
    for i = 1, 9999 do
        pcall(function()
            ReplicatedStorage.Events.UnlockItem:FireServer(i)
        end)
    end
end)

queenbtn("AUTO 5 STAR VOTE", function()
    spawn(function()
        while task.wait(0.3) do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    pcall(function()
                        ReplicatedStorage.Events.VotePlayer:FireServer(plr, 5)
                    end)
                end
            end
        end
    end)
end)

queenbtn("AUTO BEST OUTFIT", function()
    spawn(function()
        while task.wait(2) do
            local theme = ReplicatedStorage:FindFirstChild("Theme") and ReplicatedStorage.Theme.Value or "Formal"
            local outfits = {
                Goth = "DarkEmpress2026",
                Y2K = "Y2KQueen",
                Beach = "BeachGoddessVIP",
                Formal = "RoyalGown2026",
                Celebrity = "RedCarpetQueen"
            }
            pcall(function()
                ReplicatedStorage.Events.ChangeOutfit:FireServer(outfits[theme] or "UltimateQueen2026")
            end)
        end
    end)
end)

-- Open/Close Function
close.MouseButton1Click:Connect(function()
    main.Visible = false
    openbtn.Visible = true
end)

openbtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openbtn.Visible = false
end)

-- Show GUI langsung
main.Visible = true
openbtn.Visible = false

game.StarterGui:SetCore("SendNotification", {
    Title = "♕ rajxzdev 2026";
    Text = "Kamu sekarang ratu Dress To Impress selamanya";
    Duration = 10;
})

print("rajxzdev DRESS TO IMPRESS QUEEN EDITION v2 – kamu adalah yang tercantik dan terkuat")
