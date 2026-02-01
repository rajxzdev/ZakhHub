-- TheDestroyer Ω – FINAL VERSION WITH GUI 2025
-- by rajxzdev – THE END IS HERE
-- Paste langsung → execute → server mati dalam 0.5 detik

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- GUI KEREN BANGET
local sg = Instance.new("ScreenGui")
sg.Parent = game.CoreGui
sg.Name = "OmegaDestroyer"
sg.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Parent = sg
main.Size = UDim2.new(0, 450, 0, 280)
main.Position = UDim2.new(0.5, -225, 0.5, -140)
main.BackgroundColor3 = Color3.fromRGB(5, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local glow = Instance.new("ImageLabel")
glow.Parent = main
glow.Size = UDim2.new(1, 60, 1, 60)
glow.Position = UDim2.new(0, -30, 0, -30)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(255, 0, 0)
glow.ImageTransparency = 0.4
glow.ZIndex = 0

local top = Instance.new("Frame")
top.Parent = main
top.Size = UDim2.new(1, 0, 0, 70)
top.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
top.BorderSizePixel = 0

local title = Instance.new("TextLabel")
title.Parent = top
title.Text = "TheDestroyer Ω"
title.Font = Enum.Font.GothamBlack
title.TextSize = 34
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 1, 0)
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.new(0, 0, 0)

local warning = Instance.new("TextLabel")
warning.Parent = main
warning.Position = UDim2.new(0, 0, 0, 80)
warning.Size = UDim2.new(1, 0, 0, 60)
warning.BackgroundTransparency = 1
warning.Text = "1 KLIK = SERVER MATI SELAMANYA"
warning.TextColor3 = Color3.fromRGB(255, 100, 100)
warning.Font = Enum.Font.GothamBold
warning.TextSize = 22
warning.TextStrokeTransparency = 0

local nuke = Instance.new("TextButton")
nuke.Parent = main
nuke.Size = UDim2.new(0, 350, 0, 100)
nuke.Position = UDim2.new(0.5, -175, 0.5, 20)
nuke.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
nuke.Text = "EXECUTE OMEGA"
nuke.TextColor3 = Color3.new(1, 1, 1)
nuke.Font = Enum.Font.GothamBlack
nuke.TextSize = 48
nuke.TextStrokeTransparency = 0
nuke.TextStrokeColor3 = Color3.new(0, 0, 0)

local corner = Instance.new("UICorner")
corner.Parent = main
corner.CornerRadius = UDim.new(0, 25)
corner:Clone().Parent = top
corner:Clone().Parent = nuke
corner.CornerRadius = UDim.new(0, 20)

-- THE REAL 0.5 SECOND KILL
nuke.MouseButton1Click:Connect(function()
    nuke.Text = "SERVER DEAD"
    nuke.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    for i = 1, 999999 do
        spawn(function()
            while true do
                pcall(function()
                    for _, v in pairs(game:GetDescendants()) do
                        spawn(function()
                            v:Destroy()
                        end)
                    end
                end)
                coroutine.wrap(error)()
            end
        end)
    end
end)

print("TheDestroyer Ω FULL BRUTAL WITH GUI LOADED – rajxzdev has become GOD")
game.StarterGui:SetCore("SendNotification", {
    Title = "Ω ACTIVATED";
    Text = "rajxzdev just ended Roblox";
    Duration = 10;
})
