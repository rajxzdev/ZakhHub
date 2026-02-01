-- ==============================================================
--  ZHAK-GPT v4.1 | 100% BUTTON VISIBILITY GUARANTEED
--  - GUI selalu muncul (debug prints untuk verifikasi)
--  - Tidak ada layout conflict
--  - Ukuran eksplisit untuk semua elemen
--  - Mobile fly support dengan virtual joystick
-- ==============================================================

print("🔥 [ZHAK] MEMULAI SCRIPT v4.1 - DEBUG MODE AKTIF")

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- DEBUG HELPER
-- ==============================================
local function debugPrint(...)
    print("[ZHAK DEBUG]", ...)
end

-- ==============================================
-- SETTINGS & STATE
-- ==============================================
local Settings = {
    Fly = false, FlySpeed = 75,
    WalkSpeed = 16, JumpPower = 50,
    Noclip = false, GodMode = false, InfJump = false
}
local FlyBodyVelocity = nil
local MobileFlyUp = false
local MobileFlyDown = false
local CurrentChar, CurrentHumanoid = nil, nil

-- ==============================================
-- MEMBUAT GUI DENGAN UKURAN EKSPLISIT (TANPA LAYOUT CONFLIK)
-- ==============================================
debugPrint("Membuat GUI...")

local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()
if parent:FindFirstChild("ZhakFinalGUI") then
    debugPrint("Menghapus GUI lama")
    parent.ZhakFinalGUI:Destroy()
end

-- ScreenGui
local screen = Instance.new("ScreenGui")
screen.Name = "ZhakFinalGUI"
screen.Parent = parent
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
debugPrint("ScreenGui dibuat")

-- Main Frame (Ukuran FIXED untuk mobile)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 480, 0, 260) -- Lebar 480, Tinggi 260 (lebih pendek dari sebelumnya)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -130) -- Sesuaikan dengan ukuran baru
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 20, 40)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 150)
mainFrame.BorderSizePixel = 2
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screen
debugPrint("MainFrame dibuat, ukuran:", mainFrame.Size)

-- Header
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
header.Text = "✅ ZHAK MOBILE FIX v4.1"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 15
header.Parent = mainFrame
debugPrint("Header dibuat")

-- Tombol Close
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Parent = header
debugPrint("Close button dibuat")

closeBtn.MouseButton1Click:Connect(function()
    screen:Destroy()
    debugPrint("GUI ditutup oleh user")
end)

-- Container untuk tombol (TANPA LAYOUT KOMPLEKS)
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, -20, 1, -50) -- Padding 10 di kiri/kanan, 45 untuk header+spacing
buttonContainer.Position = UDim2.new(0, 10, 0, 45)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame
debugPrint("Button container dibuat, ukuran:", buttonContainer.Size)

-- Daftar semua tombol yang akan dibuat (untuk debug)
local allElements = {}

-- Fungsi bikin tombol dengan UKURAN EKSPLISIT
local function CreateButton(text, callback, row, col)
    debugPrint("Membuat tombol:", text, "di baris", row, "kolom", col)
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 35) -- UKURAN EKSPLISIT (untuk grid 2 kolom)
    btn.BackgroundColor3 = Color3.fromRGB(50, 30, 45)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Parent = buttonContainer
    
    -- Posisi eksplisit (tanpa layout conflict)
    btn.Position = UDim2.new(0, (col-1) * 145 + 5, 0, (row-1) * 40 + 5)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    if callback then
        btn.MouseButton1Click:Connect(function() callback(btn) end)
    end
    
    table.insert(allElements, btn)
    return btn
end

-- Fungsi bikin textbox
local function CreateTextBox(placeholder, row, col)
    debugPrint("Membuat textbox:", placeholder)
    
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 140, 0, 35)
    box.BackgroundColor3 = Color3.fromRGB(20, 10, 15)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.Parent = buttonContainer
    
    box.Position = UDim2.new(0, (col-1) * 145 + 5, 0, (row-1) * 40 + 5)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = box
    
    table.insert(allElements, box)
    return box
end

-- ==============================================
-- TOMBOL VIRTUAL UNTUK MOBILE (NAIK/TURUN)
-- ==============================================
debugPrint("Membuat virtual joystick untuk mobile...")
local MobileFlyPad = Instance.new("Frame")
MobileFlyPad.Size = UDim2.new(0, 70, 0, 150)
MobileFlyPad.Position = UDim2.new(1, -85, 1, -170) -- Sedikit lebih dalam dari tepi
MobileFlyPad.BackgroundTransparency = 1
MobileFlyPad.Visible = false
MobileFlyPad.Parent = screen
debugPrint("MobileFlyPad dibuat, ukuran:", MobileFlyPad.Size)

local function CreateFlyPadButton(text, yPos, action)
    debugPrint("Membuat tombol virtual:", text, "pos:", yPos)
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 70)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.5
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 32
    btn.Parent = MobileFlyPad
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    btn.MouseButton1Down:Connect(function() action(true) end)
    btn.MouseButton1Up:Connect(function() action(false) end)
    btn.TouchTapIn:Connect(function() action(true) end)
    btn.TouchTapOut:Connect(function() action(false) end)
    
    table.insert(allElements, btn)
    return btn
end

CreateFlyPadButton("▲", 0, function(state) MobileFlyUp = state end)
CreateFlyPadButton("▼", 75, function(state) MobileFlyDown = state end)

-- ==============================================
-- BUAT SEMUA ELEMEN DENGAN Posisi EKSPLISIT (TANPA LAYOUT)
-- ==============================================
debugPrint("Membuat semua tombol dengan posisi eksplisit...")

-- Baris 1: Fly Controls
local flyBtn = CreateButton("✈️ Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(200, 0, 100) or Color3.fromRGB(50, 30, 45)
    
    MobileFlyPad.Visible = Settings.Fly -- Tampilkan tombol virtual HP
    
    if Settings.Fly then
        if CurrentChar and not FlyBodyVelocity then
            FlyBodyVelocity = Instance.new("BodyVelocity")
            FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            FlyBodyVelocity.P = 5000
            FlyBodyVelocity.Parent = CurrentChar.HumanRootPart or CurrentChar.HumanoidRootPart
        end
    else
        if FlyBodyVelocity then FlyBodyVelocity:Destroy(); FlyBodyVelocity = nil end
        if CurrentHumanoid then CurrentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
end, 1, 1)

local flySpeedBox = CreateTextBox("Fly Speed: 75", 1, 2)
local walkSpeedBox = CreateTextBox("Walk Speed: 16", 2, 1)
local jumpPowerBox = CreateTextBox("Jump Power: 50", 2, 2)

CreateButton("SET SPEEDS", function()
    Settings.FlySpeed = tonumber(flySpeedBox.Text) or 75
    Settings.WalkSpeed = tonumber(walkSpeedBox.Text) or 16
    Settings.JumpPower = tonumber(jumpPowerBox.Text) or 50
    
    if CurrentHumanoid then
        CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
        CurrentHumanoid.JumpPower = Settings.JumpPower
    end
    debugPrint("Kecepatan di-set! Fly:", Settings.FlySpeed, "Walk:", Settings.WalkSpeed, "Jump:", Settings.JumpPower)
end, 3, 1)

-- Baris 2: Cheats
CreateButton("👻 Noclip: OFF", function(btn) 
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 30, 45)
end, 3, 2)

CreateButton("💀 God Mode: OFF", function(btn) 
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 30, 45)
end, 4, 1)

CreateButton("♾️ Inf Jump: OFF", function(btn) 
    Settings.InfJump = not Settings.InfJump
    btn.Text = "♾️ Inf Jump: " .. (Settings.InfJump and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.InfJump and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 30, 45)
end, 4, 2)

-- ==============================================
-- DEBUG: TAMPILKAN STATUS SEMUA ELEMEN
-- ==============================================
task.delay(0.5, function() -- Delay sedikit untuk pastikan semua elemen terbuat
    debugPrint("===== DEBUG STATUS =====")
    debugPrint("Jumlah elemen dibuat:", #allElements)
    
    for i, elem in ipairs(allElements) do
        debugPrint("Elem", i, "| Name:", elem.Name or "N/A", 
                  "| Size:", elem.Size, 
                  "| Position:", elem.Position, 
                  "| Visible:", elem.Visible,
                  "| Parent:", elem.Parent and elem.Parent.Name or "NIL")
    end
    
    debugPrint("MainFrame Visible:", mainFrame.Visible)
    debugPrint("ButtonContainer Visible:", buttonContainer.Visible)
    debugPrint("MobileFlyPad Visible:", MobileFlyPad.Visible)
    debugPrint("========================")
    
    -- Jika tidak ada elemen, buat satu tombol tes merah
    if #allElements == 0 then
        debugPrint("TIDAK ADA ELEMEN YANG DIBUAT! Membuat tombol tes...")
        local testBtn = Instance.new("TextButton")
        testBtn.Size = UDim2.new(0, 200, 0, 100)
        testBtn.Position = UDim2.new(0.5, -100, 0.5, -50)
        testBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        testBtn.Text = "TES BUTTON - JIKA INI MUNCUL, SCRIPT BEKERJA"
        testBtn.TextColor3 = Color3.new(1, 1, 1)
        testBtn.Font = Enum.Font.GothamBold
        testBtn.Size = UDim2.new(0, 200, 0, 100)
        testBtn.Parent = mainFrame
        debugPrint("Tombol tes dibuat!")
    end
end)

-- ==============================================
-- MAIN LOOP (FIXED FLIP & CHEATS)
-- ==============================================
RunService.Heartbeat:Connect(function()
    -- Update karakter
    CurrentChar = LocalPlayer.Character
    CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
    if not CurrentChar or not CurrentHumanoid then return end

    -- God Mode
    if Settings.GodMode then CurrentHumanoid.Health = CurrentHumanoid.MaxHealth end

    -- Noclip
    if Settings.Noclip then
        for _, part in pairs(CurrentChar:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- FLY LOGIC (PC + MOBILE HYBRID)
    if Settings.Fly and FlyBodyVelocity then
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        -- Horizontal movement (joystick HP atau keyboard PC)
        local moveX, moveZ = 0, 0
        
        -- Coba joystick dulu (untuk mobile)
        local moveXjoy, moveZjoy = 0, 0
        if CurrentHumanoid then
            moveXjoy, moveZjoy = -CurrentHumanoid.MoveDirection.Z, CurrentHumanoid.MoveDirection.X
        end
        
        if math.abs(moveXjoy) > 0.1 or math.abs(moveZjoy) > 0.1 then
            moveDir += cam.CFrame.RightVector * moveXjoy + cam.CFrame.LookVector * moveZjoy
        else -- Jika joystick tidak aktif, gunakan keyboard PC
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        end
        
        -- Vertical movement
        if MobileFlyUp or UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if MobileFlyDown or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end
        
        -- Apply velocity
        if moveDir.Magnitude > 0.1 then
            FlyBodyVelocity.Velocity = moveDir.Unit * Settings.FlySpeed
        else
            FlyBodyVelocity.Velocity = Vector3.new(0, FlyBodyVelocity.Velocity.Y, 0) -- Pertahankan kecepatan vertikal
        end
    else
        -- Saat fly dimatikan, pastikan Humanoid tidak dalam mode "PlatformStand"
        if CurrentHumanoid and CurrentHumanoid.PlatformStand then
            CurrentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if Settings.InfJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

debugPrint("✅ SEMUA COMPONENT TELAH DIBUAT. CEK OUTPUT UNTUK STATUS DETAIL.")
print("✅ JIKA ANDA LIAT 'Debug Status' DI ATAS, SEMUA ELEMEN SUDAH DIBUAT DENGAN UKURAN EKSPLISIT.")
print("✅ JIKA MASIH TIDAK LIHAT, CEK UNTUK ERROR DI OUTPUT (UKURAN 0, PARENT NIL, dll).")
