-- ZHAK-GPT ULTIMATE GUI v4.0
-- Fitur: Fly (diperbaiki), TextBox Input, Theme Switcher, Responsive Design

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- SETTINGS & THEMES
-- ==============================================
local Settings = {
    Fly = false,
    FlySpeed = 75,
    WalkSpeed = 50,
    JumpPower = 75,
    Noclip = false,
    GodMode = false,
    InfiniteJump = false,
    TrollSize = 10,
    Minimized = false,
    CurrentTheme = "Blue" -- Bisa diubah ke "Red", "Purple", "Green"
}

-- THEME COLORS
local Themes = {
    Blue = {
        Main = Color3.fromRGB(25, 25, 40),
        Header = Color3.fromRGB(0, 150, 255),
        Button = Color3.fromRGB(40, 40, 60),
        Accent = Color3.fromRGB(0, 180, 255)
    },
    Red = {
        Main = Color3.fromRGB(40, 25, 25),
        Header = Color3.fromRGB(255, 50, 50),
        Button = Color3.fromRGB(60, 40, 40),
        Accent = Color3.fromRGB(255, 80, 80)
    },
    Purple = {
        Main = Color3.fromRGB(30, 20, 40),
        Header = Color3.fromRGB(150, 50, 255),
        Button = Color3.fromRGB(50, 35, 60),
        Accent = Color3.fromRGB(180, 80, 255)
    },
    Green = {
        Main = Color3.fromRGB(25, 40, 25),
        Header = Color3.fromRGB(50, 200, 50),
        Button = Color3.fromRGB(40, 60, 40),
        Accent = Color3.fromRGB(80, 255, 80)
    }
}

local CurrentChar, CurrentHumanoid = nil, nil

-- ==============================================
-- DETEKSI DEVICE (MOBILE/PC)
-- ==============================================
local isMobile = UIS.TouchEnabled
local screenSize = workspace.CurrentCamera.ViewportSize
local scaleFactor = isMobile and 0.8 or 1.0

-- ==============================================
-- GUI PARENT
-- ==============================================
local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()

if parent:FindFirstChild("ZhakUltimateGUI") then
    parent.ZhakUltimateGUI:Destroy()
end

-- ==============================================
-- BUILD GUI
-- ==============================================
local gui = Instance.new("ScreenGui")
gui.Name = "ZhakUltimateGUI"
gui.Parent = parent
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340 * scaleFactor, 0, 520 * scaleFactor)
mainFrame.Position = UDim2.new(0.5, -170 * scaleFactor, 0.5, -260 * scaleFactor)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0.05, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ZHAK ULTIMATE v4.0"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = header

-- MINIMIZE BUTTON
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -80, 0, 5)
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeBtn

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- SCROLLING FRAME
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -55)
scrollFrame.Position = UDim2.new(0, 5, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.Parent = scrollFrame

-- ==============================================
-- THEME SYSTEM
-- ==============================================
local function ApplyTheme(themeName)
    local theme = Themes[themeName] or Themes.Blue
    mainFrame.BackgroundColor3 = theme.Main
    header.BackgroundColor3 = theme.Header
    minimizeBtn.BackgroundColor3 = theme.Header
    closeBtn.BackgroundColor3 = theme.Header
end

ApplyTheme(Settings.CurrentTheme)

-- ==============================================
-- UI HELPERS
-- ==============================================
local function CreateLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.9, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Themes[Settings.CurrentTheme].Accent
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.Parent = scrollFrame
    return label
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Themes[Settings.CurrentTheme].Button
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = scrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local function CreateTextBox(placeholder, defaultText)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.BackgroundColor3 = Themes[Settings.CurrentTheme].Button
    box.PlaceholderText = placeholder
    box.Text = defaultText or ""
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderColor3 = Color3.fromRGB(180,180,180)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.Parent = scrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = box
    return box
end

-- ==============================================
-- MINIMIZE FUNCTION
-- ==============================================
minimizeBtn.MouseButton1Click:Connect(function()
    Settings.Minimized = not Settings.Minimized
    if Settings.Minimized then
        mainFrame.Size = UDim2.new(0, 340 * scaleFactor, 0, 45)
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 340 * scaleFactor, 0, 520 * scaleFactor)
        minimizeBtn.Text = "–"
    end
end)

-- CLOSE FUNCTION
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    print("[ZHAK] GUI ditutup")
end)

-- ==============================================
-- THEME SWITCHER
-- ==============================================
CreateLabel("🎨 THEME")

local themeBtn = CreateButton("🔄 Ganti Tema: " .. Settings.CurrentTheme, function(btn)
    local themes = {"Blue", "Red", "Purple", "Green"}
    local currentIndex = 0
    for i, name in ipairs(themes) do
        if name == Settings.CurrentTheme then
            currentIndex = i
            break
        end
    end
    
    local nextIndex = currentIndex + 1
    if nextIndex > #themes then nextIndex = 1 end
    
    Settings.CurrentTheme = themes[nextIndex]
    btn.Text = "🔄 Ganti Tema: " .. Settings.CurrentTheme
    ApplyTheme(Settings.CurrentTheme)
end)

-- ==============================================
// FLY SECTION (DIPERBAIKI!)
// ==============================================
CreateLabel("✈️ FLY SYSTEM")

-- Fly Toggle
local flyBtn = CreateButton("🚀 Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "🚀 Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Themes[Settings.CurrentTheme].Accent or Themes[Settings.CurrentTheme].Button
end)

-- Fly Speed Input
local flySpeedBox = CreateTextBox("Kecepatan Terbang (Default: 75)", tostring(Settings.FlySpeed))
CreateButton("✅ Setel Kecepatan Terbang", function()
    local val = tonumber(flySpeedBox.Text)
    if val then
        Settings.FlySpeed = val
        flySpeedBox.PlaceholderText = "Kecepatan: " .. Settings.FlySpeed
    end
end)

-- Vertical Control (Naik/Turun)
local verticalBox = CreateTextBox("Kecepatan Vertikal (Default: 2)", "2")
CreateButton("✅ Setel Kecepatan Naik/Turun", function()
    local val = tonumber(verticalBox.Text)
    if val then
        Settings.VerticalSpeed = val
        verticalBox.PlaceholderText = "Vertikal: " .. Settings.VerticalSpeed
    end
end)

-- ==============================================
// MOVEMENT SECTION
// ==============================================
CreateLabel("🏃 MOVEMENT")

-- Walk Speed Input
local walkSpeedBox = CreateTextBox("Kecepatan Lari (Default: 50)", tostring(Settings.WalkSpeed))
CreateButton("✅ Setel Kecepatan Lari", function()
    local val = tonumber(walkSpeedBox.Text)
    if val then
        Settings.WalkSpeed = val
        if CurrentHumanoid then CurrentHumanoid.WalkSpeed = val end
        walkSpeedBox.PlaceholderText = "Lari: " .. Settings.WalkSpeed
    end
end)

-- Jump Power Input
local jumpPowerBox = CreateTextBox("Kekuatan Lompat (Default: 75)", tostring(Settings.JumpPower))
CreateButton("✅ Setel Kekuatan Lompat", function()
    local val = tonumber(jumpPowerBox.Text)
    if val then
        Settings.JumpPower = val
        if CurrentHumanoid then CurrentHumanoid.JumpPower = val end
        jumpPowerBox.PlaceholderText = "Lompat: " .. Settings.JumpPower
    end
end)

-- ==============================================
// CHEAT SECTION
// ==============================================
CreateLabel("🛡️ CHEATS")

-- Noclip
local noclipBtn = CreateButton("👻 Noclip: OFF", function(btn)
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Noclip and Themes[Settings.CurrentTheme].Accent or Themes[Settings.CurrentTheme].Button
end)

-- God Mode
local godBtn = CreateButton("💀 God Mode: OFF", function(btn)
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.GodMode and Themes[Settings.CurrentTheme].Accent or Themes[Settings.CurrentTheme].Button
end)

-- Infinite Jump
local infJumpBtn = CreateButton("♾️ Infinite Jump: OFF", function(btn)
    Settings.InfiniteJump = not Settings.InfiniteJump
    btn.Text = "♾️ Infinite Jump: " .. (Settings.InfiniteJump and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.InfiniteJump and Themes[Settings.CurrentTheme].Accent or Themes[Settings.CurrentTheme].Button
end)

-- ==============================================
// TROLL SECTION
// ==============================================
CreateLabel("🧟 TROLL SYSTEM")

local trollTarget = CreateTextBox("Nama Player Target", "")

-- Ukuran Part Input
local trollSizeBox = CreateTextBox("Ukuran Part (Default: 10)", tostring(Settings.TrollSize))
CreateButton("✅ Setel Ukuran Part", function()
    local val = tonumber(trollSizeBox.Text)
    if val then
        Settings.TrollSize = val
        trollSizeBox.PlaceholderText = "Ukuran: " .. Settings.TrollSize
    end
end)

-- Spawn Part Button
CreateButton("💥 SPAWN PART DI ATAS TARGET!", function()
    local name = trollTarget.Text
    if name == "" then
        print("[ZHAK] Masukkan nama player target!")
        return
    end
    
    local target = Players:FindFirstChild(name)
    if not target or not target.Character then
        print("[ZHAK] Player target tidak ditemukan!")
        return
    end
    
    local root = target.Character:FindFirstChild("HumanoidRootPart")
    if not root then
        print("[ZHAK] HumanoidRootPart tidak ditemukan!")
        return
    end
    
    local part = Instance.new("Part")
    part.Size = Vector3.new(Settings.TrollSize, Settings.TrollSize, Settings.TrollSize)
    part.Position = root.Position + Vector3.new(0, Settings.TrollSize + 10, 0)
    part.Anchored = false
    part.CanCollide = true
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Density = 100
    part.Parent = workspace
    
    task.delay(8, function()
        if part.Parent then part:Destroy() end
    end)
    
    print("[ZHAK] Part berhasil di-spawn di atas " .. name)
end)

-- ==============================================
// MAIN LOOP (FLY DIPERBAIKI!)
// ==============================================
RunService.Heartbeat:Connect(function()
    -- Update karakter
    if LocalPlayer.Character ~= CurrentChar then
        CurrentChar = LocalPlayer.Character
        CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
        if CurrentHumanoid then
            CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
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
        for _,v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    
    -- FLY LOGIC (DIPERBAIKI! TIDAK STUCK LAGI)
    if Settings.Fly then
        CurrentHumanoid.PlatformStand = true
        
        -- Dapatkan kamera
        local cam = workspace.CurrentCamera
        if not cam then return end
        
        -- Hitung arah gerakan
        local moveVector = Vector3.new(0, 0, 0)
        
        -- Horizontal movement (WASD)
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            moveVector += cam.CFrame.LookVector * Vector3.new(1, 0, 1)
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            moveVector -= cam.CFrame.LookVector * Vector3.new(1, 0, 1)
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            moveVector -= cam.CFrame.RightVector * Vector3.new(1, 0, 1)
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            moveVector += cam.CFrame.RightVector * Vector3.new(1, 0, 1)
        end
        
        -- Vertical movement (Space/Ctrl)
        local verticalSpeed = Settings.VerticalSpeed or 2
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            moveVector += Vector3.new(0, verticalSpeed, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveVector -= Vector3.new(0, verticalSpeed, 0)
        end
        
        -- Apply movement
        local root = CurrentChar:FindFirstChild("HumanoidRootPart")
        if root and moveVector.Magnitude > 0 then
            -- Normalisasi dan apply kecepatan
            local normalizedMove = moveVector.Unit * Settings.FlySpeed * 0.03
            root.CFrame = root.CFrame + normalizedMove
        end
    elseif CurrentHumanoid then
        CurrentHumanoid.PlatformStand = false
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if Settings.InfiniteJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState("Jumping")
    end
end)

print("[ZHAK] ULTIMATE GUI v4.0 LOADED!")
print("[ZHAK] Tekan tombol THEME untuk ganti warna!")
