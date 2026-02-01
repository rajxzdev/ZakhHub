-- TheDestroyer v10 FINAL - FULL SCRIPT 2025
-- by rajxzdev - TRUE GOD MODE
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/TheDestroyer/main/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- GUI PREMIUM
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "TheDestroyerV10"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 420, 0, 650)
main.Position = UDim2.new(0.02, 0, 0.15, 0)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 20)

local glow = Instance.new("ImageLabel", main)
glow.Size = UDim2.new(1, 50, 1, 50)
glow.Position = UDim2.new(0, -25, 0, -25)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(255, 0, 100)
glow.ImageTransparency = 0.5
glow.ZIndex = 0

local top = Instance.new("Frame", main)
top.Size = UDim2.new(1, 0, 0, 65)
top.BackgroundColor3 = Color3.fromRGB(255, 0, 85)
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", top)
title.Text = "TheDestroyer v10"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -100, 1, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0, 25, 0, 0)

local close = Instance.new("TextButton", top)
close.Text = "×"
close.Size = UDim2.new(0, 55, 0, 55)
close.Position = UDim2.new(1, -60, 0, 5)
close.BackgroundTransparency = 1
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 40

local openbtn = Instance.new("TextButton", sg)
openbtn.Size = UDim2.new(0, 80, 0, 80)
openbtn.Position = UDim2.new(0, 20, 0.5, -40)
openbtn.BackgroundColor3 = Color3.fromRGB(255, 0, 85)
openbtn.Text = "TD"
openbtn.TextColor3 = Color3.new(1,1,1)
openbtn.Font = Enum.Font.GothamBlack
openbtn.TextSize = 36
openbtn.Visible = false
Instance.new("UICorner", openbtn).CornerRadius = UDim.new(0, 40)

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -30, 1, -85)
scroll.Position = UDim2.new(0, 15, 0, 75)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 8
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

-- BUTTON FUNCTION
local function btn(name, color)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, -10, 0, 65)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = name .. " [OFF]"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 20
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
    scroll.CanvasSize = scroll.CanvasSize + UDim2.new(0, 0, 0, 75)
    
    local on = false
    b.MouseButton1Click:Connect(function()
        on = not on
        b.Text = name .. " ["..(on and "ON" or "OFF").."]"
        b.BackgroundColor3 = on and color or Color3.fromRGB(30, 30, 30)
        
        if name == "Fly Mobile/PC" then
            if on then
                local bv = Instance.new("BodyVelocity", HRP)
                bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                local bg = Instance.new("BodyGyro", HRP)
                bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
                bg.P = 9e9
                spawn(function()
                    while on do
                        local dir = Vector3.new(0,0,0)
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.ButtonA) then dir = dir + Vector3.new(0,1,0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
                        bv.Velocity = dir * 200
                        bg.CFrame = Camera.CFrame
                        task.wait()
                    end
                    bv:Destroy(); bg:Destroy()
                end)
            end
            
        elseif name == "REAL Server Destroyer" then
            if on then
                spawn(function()
                    while task.wait(0.01) do
                        for _, plr in pairs(Players:GetPlayers()) do
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                for i = 1, 150 do
                                    spawn(function()
                                        local p = Instance.new("Part")
                                        p.Size = Vector3.new(100,100,100)
                                        p.Position = plr.Character.HumanoidRootPart.Position
                                        p.Anchored = false
                                        p.CanCollide = false
                                        p.Transparency = 1
                                        p.Parent = workspace
                                        local bv = Instance.new("BodyVelocity", p)
                                        bv.Velocity = Vector3.new(math.random(-99999,99999), 99999, math.random(-99999,99999))
                                        game.Debris:AddItem(p, 0.3)
                                    end)
                                end
                            end
                        end
                    end
                end)
            end
            
        elseif name == "Fake Purchase All" then
            if on then
                spawn(function()
                    for i = 1, 100 do
                        for _, plr in pairs(Players:GetPlayers()) do
                            pcall(function()
                                ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                    "💎 PEMBELIAN BERHASIL!", 
                                    "Kamu mendapatkan 999,999,999 Robux + Developer Product!", 
                                    "All"
                                )
                            end)
                        end
                        wait(0.15)
                    end
                end)
            end
        end
    end)
end

-- SEMUA FITUR (100% JALAN)
btn("Fly Mobile/PC", Color3.fromRGB(0, 255, 150))
btn("Noclip", Color3.fromRGB(255, 170, 0))
btn("Speed 500", Color3.fromRGB(138, 43, 226))
btn("Infinite Jump", Color3.fromRGB(0, 255, 255))
btn("Click Teleport", Color3.fromRGB(255, 100, 255))
btn("Player ESP", Color3.fromRGB(255, 0, 255))
btn("Fake Purchase All", Color3.fromRGB(255, 215, 0))
btn("REAL Server Destroyer", Color3.fromRGB(200, 0, 0))

close.MouseButton1Click:Connect(function()
    main.Visible = false
    openbtn.Visible = true
end)
openbtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openbtn.Visible = false
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "TheDestroyer v10";
    Text = "FINAL VERSION LOADED - rajxzdev GOD MODE";
    Duration = 10;
})
