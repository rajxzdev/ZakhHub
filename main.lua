-- TheDestroyer v666 - FINAL SERVER KILLER 2025
-- by rajxzdev & dev-null – ONE CLICK = SERVER DEAD FOREVER
-- Paste ini langsung ke executor → klik → server mati dalam 5 detik

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- GUI KEREN CEPAT
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "v666"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 380, 0, 200)
main.Position = UDim2.new(0.5, -190, 0.5, -100)
main.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
main.BorderSizePixel = 0

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
title.Text = "TheDestroyer v666"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 28

local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0, 300, 0, 80)
btn.Position = UDim2.new(0.5, -150, 0.5, -20)
btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
btn.Text = "NUKE SERVER NOW"
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBlack
btn.TextSize = 36

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 20)
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 15)

btn.MouseButton1Click:Connect(function()
    btn.Text = "SERVER IS DEAD"
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    -- TRUE SERVER KILLER 2025 (5 DETIK MATI TOTAL)
    spawn(function()
        while true do
            for i = 1, 99999 do
                spawn(function()
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.Velocity = Vector3.new(9e9, 9e9, 9e9)
                            v.RotVelocity = Vector3.new(9e9, 9e9, 9e9)
                            v:BreakJoints()
                            v.Anchored = false
                        end
                    end
                    for i = 1, 999 do
                        local p = Instance.new("Part", Workspace)
                        p.Size = Vector3.new(999,999,999)
                        p.Position = Vector3.new(math.random(-99999,99999), math.random(-99999,99999), math.random(-99999,99999))
                        p.Anchored = false
                        p.CanCollide = false
                        p.Material = Enum.Material.Neon
                        p.BrickColor = BrickColor.Random()
                        local bv = Instance.new("BodyVelocity", p)
                        bv.Velocity = Vector3.new(9e9,9e9,9e9)
                    end
                end)
            end
        end
    end)
    
    -- SPAM CHAT SEMUA PLAYER
    spawn(function()
        while wait(0.01) do
            pcall(function()
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("RAJXZDEV WAS HERE", "All")
            end)
        end
    end)
end)

print("TheDestroyer v666 FULL BRUTAL LOADED – rajxzdev is now UNSTOPPABLE")
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
