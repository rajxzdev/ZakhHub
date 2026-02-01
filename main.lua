-- ZHAK DELTA MOD 2025/2026 EDITION
-- Auto-detect Delta Mod environment

local Delta = getgenv and getgenv().Delta or {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Check if Delta Mod
if Delta.Version then
    print("✅ Delta Mod " .. Delta.Version .. " detected!")
end

-- Create floating button (Delta Mod style)
local function CreateDeltaUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZhakDelta2026"
    gui.ResetOnSpawn = false
    
    -- Try multiple parent methods for Delta Mod
    pcall(function() gui.Parent = game.CoreGui end)
    if not gui.Parent then
        pcall(function() gui.Parent = gethui() end)
    end
    if not gui.Parent then
        gui.Parent = LocalPlayer.PlayerGui
    end
    
    -- Floating button
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 60)
    btn.Position = UDim2.new(0, 10, 0.3, 0)
    btn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    btn.Text = "ZHAK"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = gui
    
    -- Round corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = btn
    
    -- Menu panel
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 250, 0, 300)
    menu.Position = UDim2.new(0.5, -125, 0.5, -150)
    menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    menu.Visible = false
    menu.Parent = gui
    
    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 10)
    menuCorner.Parent = menu
    
    -- Toggle menu
    btn.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
    end)
    
    return menu
end

-- Create UI
local menu = CreateDeltaUI()

-- Add buttons to menu
local yOffset = 10
local function AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = menu
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    yOffset = yOffset + 40
    return btn
end

-- Features
local flying = false
local noclip = false
local speed = 50

AddButton("✈️ Toggle Fly", function()
    flying = not flying
    LocalPlayer.Character.Humanoid.PlatformStand = flying
end)

AddButton("👻 Toggle Noclip", function()
    noclip = not noclip
end)

AddButton("⚡ Speed: 50", function(btn)
    speed = speed + 25
    if speed > 200 then speed = 25 end
    btn.Text = "⚡ Speed: " .. speed
    LocalPlayer.Character.Humanoid.WalkSpeed = speed
end)

AddButton("🎯 Teleport to Spawn", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
end)

AddButton("💀 Reset Character", function()
    LocalPlayer.Character:BreakJoints()
end)

-- Main loop
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not root then return end
    
    -- Fly
    if flying then
        local cam = workspace.CurrentCamera
        local moveVector = humanoid.MoveVector
        local camCF = cam.CFrame
        
        root.Velocity = Vector3.new(0, 0, 0)
        root.CFrame = root.CFrame + 
            (camCF.LookVector * moveVector.Z + 
             camCF.RightVector * moveVector.X) * (speed/50)
        
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            root.CFrame = root.CFrame + Vector3.new(0, speed/50, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            root.CFrame = root.CFrame - Vector3.new(0, speed/50, 0)
        end
    end
    
    -- Noclip
    if noclip then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Delta Mod notification
game.StarterGui:SetCore("SendNotification", {
    Title = "ZHAK 2026",
    Text = "Script loaded! Tap orange button to open menu",
    Duration = 5
})

print("✅ ZHAK DELTA MOD 2026 LOADED!")
print("📱 Tap orange ZHAK button on left side")
