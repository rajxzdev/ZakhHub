-- ZHAK FINAL SCRIPT (2025) - FIXED FLY & THEMES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==============================================
// DEVICE DETECTOR (MOBILE/PC)
// ==============================================
local isMobile = UIS.TouchEnabled
local screenSize = workspace.CurrentCamera.ViewportSize
local scaleFactor = isMobile and 0.8 or 1.0

-- ==============================================
// SETTINGS
// ==============================================
local Settings = {
    Fly = false,
    FlySpeed = 50,
    WalkSpeed = 16,
    JumpPower = 50,
    FlyHeight = 5,      -- Ketinggian terbang
    Noclip = false,
    GodMode = false,
    InfiniteJump = false,
    TrollSize = 10,
    Minimized = false,
    Theme = 1           -- 1=Dark, 2=Light, 3=Green, 4=Blue
}

local CurrentChar, CurrentHumanoid = nil, nil
local FlyVelocity = nil

-- ==============================================
// THEMES
// ==============================================
local Themes = {
    [1] = {  -- Dark
        Main = Color3.fromRGB(25, 25, 30),
        Header = Color3.fromRGB(0, 180, 90),
        Button = Color3.fromRGB(40, 40, 45),
        Text = Color3.new(1,1,1)
    },
    [2] = {  -- Light
        Main = Color3.fromRGB(240, 240, 245),
        Header = Color3.fromRGB(100, 180, 255),
        Button = Color3.fromRGB(220, 220, 230),
        Text = Color3.new(0,0,0)
    },
    [3] = {  -- Green
        Main = Color3.fromRGB(30, 50, 30),
        Header = Color3.fromRGB(100, 255, 100),
        Button = Color3.fromRGB(50, 80, 50),
        Text = Color3.new(1,1,1)
    },
    [4] = {  -- Blue
        Main = Color3.fromRGB(30, 30, 60),
        Header = Color3.fromRGB(100, 150, 255),
        Button = Color3.fromRGB(50, 70, 120),
        Text = Color3.new(1,1,1)
    }
}

-- ==============================================
// GUI UTAMA
// ==============================================
local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()
if parent:FindFirstChild("ZhakFinalGUI") then parent.ZhakFinalGUI:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "ZhakFinalGUI"
gui.Parent = parent
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME (Ukuran otomatis)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320 * scaleFactor, 0, 480 * scaleFactor)
mainFrame.Position = UDim2.new(0.5, -160 * scaleFactor, 0.5, -240 * scaleFactor)
mainFrame.BackgroundColor3 = Themes[Settings.Theme].Main
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Themes[Settings.Theme].Header
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0.05, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🚀 ZHAK FINAL"
title.TextColor3 = Themes[Settings.Theme].Text
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = header

-- TOMBOL MINIMIZE
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- TOMBOL CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- SCROLLING FRAME
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -55)
scrollFrame.Position = UDim2.new(0, 5, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = scrollFrame

-- ==============================================
// FUNGSI TOMBOL
// ==============================================
local function CreateLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.9, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Themes[Settings.Theme].Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = scrollFrame
    return label
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Themes[Settings.Theme].Button
    btn.Text = text
    btn.TextColor3 = Themes[Settings.Theme].Text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = scrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function CreateTextBox(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Themes[Settings.Theme].Text
    box.PlaceholderColor3 = Color3.fromRGB(150,150,150)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.Parent = scrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = box
    return box
end

-- ==============================================
// TOMBOL MINIMIZE/CLOSE (FUNGSI)
// ==============================================
minimizeBtn.MouseButton1Click:Connect(function()
    Settings.Minimized = not Settings.Minimized
    if Settings.Minimized then
        mainFrame.Size = UDim2.new(0, 320 * scaleFactor, 0, 40)
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 320 * scaleFactor, 0, 480 * scaleFactor)
        minimizeBtn.Text = "–"
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ==============================================
// FITUR
// ==============================================
CreateLabel("✈️ FLY SETTINGS")

-- Fly Toggle
local flyBtn = CreateButton("✈️ Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
    
    if Settings.Fly then
        -- Buat BodyVelocity untuk fly yang stabil
        if CurrentChar and CurrentChar:FindFirstChild("HumanoidRootPart") then
            if FlyVelocity then FlyVelocity:Destroy() end
            FlyVelocity = Instance.new("BodyVelocity")
            FlyVelocity.Velocity = Vector3.new(0, 0, 0)
            FlyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            FlyVelocity.P = 3000
            FlyVelocity.Parent = CurrentChar.HumanoidRootPart
        end
    else
        if FlyVelocity then
            FlyVelocity:Destroy()
            FlyVelocity = nil
        end
    end
end)

-- Fly Speed TextBox
local flySpeedBox = CreateTextBox("Fly Speed (50)")
CreateButton("Set Fly Speed", function()
    local speed = tonumber(flySpeedBox.Text) or 50
    Settings.FlySpeed = speed
    if FlyVelocity then
        FlyVelocity.Velocity = FlyVelocity.Velocity * Vector3.new(1, 0, 1) + (CurrentChar.HumanoidRootPart.CFrame.LookVector * speed)
    end
end)

-- Fly Height TextBox
local flyHeightBox = CreateTextBox("Fly Height (5)")
CreateButton("Set Height", function()
    Settings.FlyHeight = tonumber(flyHeightBox.Text) or 5
    if CurrentChar and CurrentChar:FindFirstChild("HumanoidRootPart") then
        CurrentChar.HumanoidRootPart.CFrame = CFrame.new(CurrentChar.HumanoidRootPart.Position.X, CurrentChar.HumanoidRootPart.Position.Y + Settings.FlyHeight, CurrentChar.HumanoidRootPart.Position.Z)
    end
end)

CreateLabel("🏃 WALK SETTINGS")

-- Walk Speed TextBox
local walkSpeedBox = CreateTextBox("Walk Speed (16)")
CreateButton("Set Walk Speed", function()
    Settings.WalkSpeed = tonumber(walkSpeedBox.Text) or 16
    if CurrentHumanoid then
        CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
    end
end)

-- Jump Power TextBox
local jumpPowerBox = CreateTextBox("Jump Power (50)")
CreateButton("Set Jump Power", function()
    Settings.JumpPower = tonumber(jumpPowerBox.Text) or 50
    if CurrentHumanoid then
        CurrentHumanoid.JumpPower = Settings.JumpPower
    end
end)

CreateLabel("🛡️ CHEATS")

-- Noclip
local noclipBtn = CreateButton("👻 Noclip: OFF", function(btn)
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
end)

-- God Mode
local godBtn = CreateButton("💀 God Mode: OFF", function(btn)
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
end)

-- Infinite Jump
local infJumpBtn = CreateButton("♾️ Infinite Jump: OFF", function(btn)
    Settings.InfiniteJump = not Settings.InfiniteJump
    btn.Text = "♾️ Infinite Jump: " .. (Settings.InfiniteJump and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.InfiniteJump and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
end)

CreateLabel("🎨 THEME")

-- Theme Selector
CreateButton("🔄 Ganti Tema", function()
    Settings.Theme = Settings.Theme % 4 + 1
    mainFrame.BackgroundColor3 = Themes[Settings.Theme].Main
    header.BackgroundColor3 = Themes[Settings.Theme].Header
    flyBtn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
    noclipBtn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
    godBtn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
    infJumpBtn.BackgroundColor3 = Settings.InfiniteJump and Color3.fromRGB(0, 150, 100) or Themes[Settings.Theme].Button
    title.TextColor3 = Themes[Settings.Theme].Text
    for _, v in pairs(scrollFrame:GetChildren()) do
        if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
            v.TextColor3 = Themes[Settings.Theme].Text
        end
    end
end)

-- ==============================================
// MAIN LOOP (FIXED FLY & CHEATS)
// ==============================================
RunService.Heartbeat:Connect(function()
    -- Update karakter
    if LocalPlayer.Character ~= CurrentChar then
        CurrentChar = LocalPlayer.Character
        CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
        if Settings.WalkSpeed and CurrentHumanoid then
            CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
        end
        if Settings.JumpPower and CurrentHumanoid then
            CurrentHumanoid.JumpPower = Settings.JumpPower
        end
    end
    if not CurrentChar or not CurrentHumanoid then return end

    -- God Mode
    if Settings.GodMode then
        CurrentHumanoid.Health = CurrentHumanoid.MaxHealth
    end

    -- Noclip
    if Settings.Noclip then
        for _, v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end

    -- Fly Logic (Dengan BodyVelocity)
    if Settings.Fly and FlyVelocity then
        local root = CurrentChar:FindFirstChild("HumanoidRootPart")
        if root then
            -- Update arah terbang berdasarkan kamera
            local cam = workspace.CurrentCamera
            local moveDirection = cam.CFrame.LookVector * Settings.FlySpeed
            FlyVelocity.Velocity = Vector3.new(moveDirection.X, FlyVelocity.Velocity.Y, moveDirection.Z)
            
            -- Pertahankan ketinggian
            local currentHeight = root.Position.Y
            local targetHeight = CurrentChar:GetPivot().Position.Y + Settings.FlyHeight
            local heightDiff = targetHeight - currentHeight
            
            -- Jika terlalu rendah/tinggi, koreksi
            if math.abs(heightDiff) > 0.5 then
                FlyVelocity.Velocity = FlyVelocity.Velocity + Vector3.new(0, heightDiff * 5, 0)
            end
        end
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if Settings.InfiniteJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState("Jumping")
    end
end)

print("[ZHAK] Script berhasil dimuat! GUI sudah muncul.")
