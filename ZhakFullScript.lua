-- ZHAK-GPT | FAIL-SAFE SCRIPT (PASTI MUNCUL)
-- Panel pink akan langsung muncul di tengah layar.

print("🔥 [ZHAK] Memulai Fail-Safe Script...")

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- PENGATURAN DASAR
-- ==============================================
local Settings = {
    Fly = false, FlySpeed = 75,
    WalkSpeed = 16, JumpPower = 50,
    Noclip = false, GodMode = false, InfJump = false
}
local CurrentChar, CurrentHumanoid = nil, nil

-- ==============================================
-- MEMBUAT GUI DENGAN CARA PALING AMAN
-- ==============================================
local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()
if parent:FindFirstChild("ZhakFailSafe") then parent.ZhakFailSafe:Destroy() end

local screen = Instance.new("ScreenGui")
screen.Name = "ZhakFailSafe"
screen.Parent = parent
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 480)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 30) -- Warna dasar gelap
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 127) -- Border PINK
mainFrame.BorderSizePixel = 3
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screen
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(255, 0, 127) -- Header PINK
header.Text = "✅ FAIL-SAFE PANEL"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function() screen:Destroy() end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -45)
scrollFrame.Position = UDim2.new(0, 0, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
scrollFrame.Parent = mainFrame
local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.Padding = UDim.new(0, 8)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ==============================================
-- FUNGSI MEMBUAT ELEMEN UI
-- ==============================================
local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 45)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.Parent = scrollFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    if callback then btn.MouseButton1Click:Connect(function() callback(btn) end) end
    return btn
end

local function CreateTextBox(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.BackgroundColor3 = Color3.fromRGB(20, 10, 15)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.Parent = scrollFrame
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    return box
end

-- ==============================================
-- MEMBUAT SEMUA TOMBOL FITUR
-- ==============================================
print("✅ Membuat tombol...")

-- MOVEMENT
local flyBtn = CreateButton("✈️ Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(200, 0, 100) or Color3.fromRGB(60, 30, 45)
end)
local flySpeedBox = CreateTextBox("Fly Speed (Default: 75)")
local walkSpeedBox = CreateTextBox("Walk Speed (Default: 16)")
local jumpPowerBox = CreateTextBox("Jump Power (Default: 50)")

CreateButton("SET ALL SPEEDS", function()
    Settings.FlySpeed = tonumber(flySpeedBox.Text) or 75
    Settings.WalkSpeed = tonumber(walkSpeedBox.Text) or 16
    Settings.JumpPower = tonumber(jumpPowerBox.Text) or 50
    
    if CurrentHumanoid then
        CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
        CurrentHumanoid.JumpPower = Settings.JumpPower
    end
    print("Kecepatan di-set!")
end)

-- CHEATS
CreateButton("👻 Noclip: OFF", function(btn)
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
end)
CreateButton("💀 God Mode: OFF", function(btn)
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
end)
CreateButton("♾️ Infinite Jump: OFF", function(btn)
    Settings.InfJump = not Settings.InfJump
    btn.Text = "♾️ Infinite Jump: " .. (Settings.InfJump and "ON" or "OFF")
end)

print("✅ Tombol berhasil dibuat.")

-- ==============================================
-- LOOP UTAMA (LOGIKA FITUR)
-- ==============================================
print("🔥 Memulai loop utama...")

RunService.Heartbeat:Connect(function()
    -- Selalu update referensi karakter
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        CurrentChar = LocalPlayer.Character
        CurrentHumanoid = CurrentChar.Humanoid
    else
        CurrentChar = nil
        CurrentHumanoid = nil
        return
    end

    -- GOD MODE
    if Settings.GodMode then
        CurrentHumanoid.Health = CurrentHumanoid.MaxHealth
    end

    -- NOCLIP
    if Settings.Noclip then
        for _, part in pairs(CurrentChar:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- FLY LOGIC (FIXED)
    if Settings.Fly then
        CurrentHumanoid.PlatformStand = true
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end
        
        local root = CurrentChar.HumanoidRootPart
        -- Menggunakan Velocity agar tidak stuck di objek transparan
        root.Velocity = moveDir.Unit * Settings.FlySpeed
    else
        if CurrentHumanoid.PlatformStand then
            CurrentHumanoid.PlatformStand = false
        end
        if CurrentChar.HumanoidRootPart.Velocity.Magnitude > 0.1 and not Settings.Fly then
            -- Hanya reset velocity jika fly baru saja dimatikan
            task.spawn(function()
                if not Settings.Fly then CurrentChar.HumanoidRootPart.Velocity = Vector3.new(0,0,0) end
            end)
        end
    end
end)

-- INFINITE JUMP
UIS.JumpRequest:Connect(function()
    if Settings.InfJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("✅ ZHAK FAIL-SAFE SCRIPT LOADED!")
print("PANEL PINK SEHARUSNYA SUDAH MUNCUL DI TENGAH LAYAR.")
