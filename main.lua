-- rajxzdev - SILENT OMEGA FINAL FIX GUI 2025
-- GUI muncul 100% di semua executor

local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdevOmega"
gui.ResetOnSpawn = false

-- FIX GUI BIAR KELIHATAN DI SEMUA EXECUTOR
if syn then syn.protect_gui(gui) end
gui.Parent = (gethui and gethui() or game:GetService("CoreGui"))

local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0, 320, 0, 180)
f.Position = UDim2.new(0.5, -160, 0.5, -90)
f.BackgroundColor3 = Color3.fromRGB(8, 0, 0)
f.BorderSizePixel = 0
f.Active = true
f.Draggable = true

local c = Instance.new("UICorner", f)
c.CornerRadius = UDim.new(0, 18)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 50)
t.BackgroundTransparency = 1
t.Text = "rajxzdev"
t.TextColor3 = Color3.new(1, 1, 1)
t.Font = Enum.Font.GothamBlack
t.TextSize = 36
t.TextStrokeTransparency = 0

local b = Instance.new("TextButton", f)
b.Size = UDim2.new(0, 280, 0, 90)
b.Position = UDim2.new(0.5, -140, 0.5, 10)
b.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
b.Text = "KILL ALL"
b.TextColor3 = Color3.new(1, 1, 1)
b.Font = Enum.Font.GothamBlack
b.TextSize = 44
b.TextStrokeTransparency = 0
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)

b.MouseButton1Click:Connect(function()
    b.Text = "DONE"
    b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    spawn(function()
        while task.wait() do
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    for i = 1, 3000 do
                        spawn(function()
                            local p = Instance.new("Part", workspace)
                            p.Size = Vector3.new(999,999,999)
                            p.Position = plr.Character.HumanoidRootPart.Position
                            p.Anchored = false
                            p.CanCollide = false
                            p.Transparency = 1
                            local bv = Instance.new("BodyVelocity", p)
                            bv.Velocity = Vector3.new(9e9,9e9,9e9)
                            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                            local pe = Instance.new("ParticleEmitter", p)
                            pe.Rate = 999999
                            pe.Lifetime = NumberRange.new(999)
                            pe.Speed = NumberRange.new(99999)
                            game.Debris:AddItem(p, 0.01)
                        end)
                    end
                end
            end
        end
    end)
end)
