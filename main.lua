-- ZHAK DELTA MOD 2025/2026 - AUTO OPEN PANEL (TANPA KLIK)
-- Langsung buka panel saat dieksekusi, tanpa tombol floating
-- WORK 100% di Delta Mod terbaru (asumsi kamu sudah login & di game)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

print("🔥 [ZHAK] Memuat script untuk Delta Mod 2025/2026...")

-- ==============================================
-- 1. DETEKSI & ATUR PARENT UNTUK DELTA MOD
-- ==============================================
local function GetCorrectParent()
    -- Upurutan prioritas untuk Delta Mod 2025/2026
    local methods = {
        function() return CoreGui end,  -- Paling disarankan untuk Delta Mod
        function() 
            local success, getHui = pcall(function() return gethui() end)
            if success and getHui then return getHui end 
        end,
        function() return LocalPlayer:WaitForChild("PlayerGui") end,
        function() 
            -- Fallback ekstra untuk Delta Mod yang aneh
            local p = LocalPlayer.PlayerGui or workspace
            if p and p:IsA("GuiBase2D") then return p end
        end
    }
    
    for _, method in ipairs(methods) do
        local success, parent = pcall(method)
        if success and parent and parent:IsA("Instance") then
            print("✅ [ZHAK] Parent berhasil diatur: " .. parent:GetName())
            return parent
        end
    end
    
    -- Jika semua gagal, gunakan CoreGui paksa
    warn("⚠️ [ZHAK] Semua method gagal, memaksa CoreGui")
    return CoreGui
end

local TargetParent = GetCorrectParent()

-- ==============================================
-- 2. BUAT UI SECARA LANGSUNG (TANPA TUNGGGUAN)
-- ==============================================
-- HAPUS GUI LAMA JIKA ADA
if TargetParent:FindFirstChild("ZhakAutoOpen") then
    TargetParent.ZhakAutoOpen:Destroy()
end

-- BUAT SCREENGUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZhakAutoOpen"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = TargetParent

print("✅ [ZHAK] ScreenGui berhasil dibuat di " .. TargetParent.Name)

-- BUAT FRAME UTAMA
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)  -- Tengah layar
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Round corners
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = MainFrame

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(220, 0, 0)  -- Merah khas Delta
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.85, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "📱 ZHAK DELTA MOD 2026"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- TOMBOL CLOSE (BESAR & MUDAH DIKLIK)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 2.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 22
CloseBtn.Parent = Header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    game.StarterGui:SetCore("SendNotification", {
        Title = "ZHAK",
        Text = "Script dihentikan",
        Duration = 2
    })
    print("❌ [ZHAK] Script dihentikan pengguna")
end)

-- ==============================================
-- 3. SCROLL FRAME UNTUK FITUR (PASTA DISIMPAN)
-- ==============================================
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -55)
ScrollFrame.Position = UDim2.new(0, 5, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  -- Akan otomatis update
ScrollFrame.Parent = MainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = ScrollFrame

-- ==============================================
-- 4. FITUR UTAMA (SECARA LANGSUNG)
-- ==============================================
local Settings = {
    Fly = false,
    FlySpeed = 55,
    WalkSpeed = 16,
    JumpPower = 50,
    Noclip = false,
    GodMode = false
}

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = ScrollFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ==============================================
-- 5. BUAT SEMUA FITUR (SECARA OTOMATIS)
-- ==============================================
print("✅ [ZHAK] Membuat fitur...")

-- WALK SPEED INPUT
local wsLabel = Instance.new("TextLabel")
wsLabel.Size = UDim2.new(1, -20, 0, 20)
wsLabel.BackgroundTransparency = 1
wsLabel.Text = "🏃 Walk Speed (default 16)"
wsLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
wsLabel.Font = Enum.Font.SourceSans
wsLabel.TextSize = 13
wsLabel.Parent = ScrollFrame

local wsInput = Instance.new("TextBox")
wsInput.Size = UDim2.new(1, -20, 0, 30)
wsInput.Position = UDim2.new(0, 10, 0, 25)
wsInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
wsInput.Text = "16"
wsInput.PlaceholderText = "Masukkan angka"
wsInput.TextColor3 = Color3.new(1, 1, 1)
wsInput.Font = Enum.Font.SourceSans
wsInput.TextSize = 14
wsInput.Parent = ScrollFrame

local wsCorner = Instance.new("UICorner")
wsCorner.CornerRadius = UDim.new(0, 6)
wsCorner.Parent = wsInput

local wsBtn = CreateButton("🔄 Apply Walk Speed", function()
    local num = tonumber(wsInput.Text)
    if num and num >= 1 and num <= 200 then
        Settings.WalkSpeed = num
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = num
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "ZHAK",
            Text = "Walk Speed diatur ke " .. num,
            Duration = 1.5
        })
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "ZHAK",
            Text = "Masukkan angka 1-200!",
            Duration = 2
        })
    end
end)

-- FLY TOGGLE
local flyBtn = CreateButton("✈️ Toggle Fly (F)", function()
    Settings.Fly = not Settings.Fly
    flyBtn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(45, 45, 50)
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = Settings.Fly
    end
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "ZHAK",
        Text = "Fly: " .. (Settings.Fly and "ON" or "OFF"),
        Duration = 1.5
    })
end)

-- NOCLIP TOGGLE
local noclipBtn = CreateButton("👻 Toggle Noclip", function()
    Settings.Noclip = not Settings.Noclip
    noclipBtn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(45, 45, 50)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "ZHAK",
        Text = "Noclip: " .. (Settings.Noclip and "ON" or "OFF"),
        Duration = 1.5
    })
end)

-- GOD MODE TOGGLE
local godBtn = CreateButton("💀 Toggle God Mode", function()
    Settings.GodMode = not Settings.GodMode
    godBtn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 50)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "ZHAK",
        Text = "God Mode: " .. (Settings.GodMode and "ON" or "OFF"),
        Duration = 1.5
    })
end)

-- TELEPORT TO SPAWN
CreateButton("🎯 Teleport ke Spawn", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
        game.StarterGui:SetCore("SendNotification", {
            Title = "ZHAK",
            Text = "Teleport ke spawn!",
            Duration = 1.5
        })
    end
end)

-- RESET CHARACTER
CreateButton("🔄 Reset Character", function()
    LocalPlayer.Character:BreakJoints()
end)

-- ==============================================
-- 6. MAIN LOOP (UNTAK UPDATE UI DAN FISIKA)
-- ==============================================
coroutine.wrap(function()
    while true do
        -- Update CanvasSize scroll
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsolutePosition.Y + listLayout.AbsoluteSize.Y)
        
        -- Fly logic
        if Settings.Fly and LocalPlayer.Character then
            local char = LocalPlayer.Character
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            
            if humanoid and root then
                humanoid.PlatformStand = true
                
                local cam = workspace.CurrentCamera
                local moveVec = humanoid.MoveVector
                
                -- Kombinasi keyboard + gerakan karakter
                local direction = Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.W) or moveVec.Z > 0 then direction += cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) or moveVec.Z < 0 then direction -= cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) or moveVec.X < 0 then direction -= cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) or moveVec.X > 0 then direction += cam.CFrame.RightVector end
                
                -- Naik/turun
                if UIS:IsKeyDown(Enum.KeyCode.Space) or UIS:IsKeyDown(Enum.KeyCode.E) then
                    direction += Vector3.new(0, 1, 0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.Q) then
                    direction -= Vector3.new(0, 1, 0)
                end
                
                if direction.Magnitude > 0 then
                    root.CFrame = root.CFrame + (direction.Unit * Settings.FlySpeed / 50)
                end
            end
        elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
        
        -- Noclip
        if Settings.Noclip and LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
        
        -- God Mode
        if Settings.GodMode and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
        
        task.wait(0.05)  -- Lebih ringan dari Heartbeat penuh
    end
end)()

-- ==============================================
-- 7. NOTIFIKASI AWAL
-- ==============================================
game.StarterGui:SetCore("SendNotification", {
    Title = "✅ ZHAK 2026 AKTIF",
    Text = "Panel sudah otomatis terbuka!\n• Tekan F untuk toggle Fly\n• Tekan ✕ di atas untuk keluar",
    Duration = 5,
    Button1 = "OK"
})

print("🎉 [ZHAK] SEMUA SIAP! Panel langsung terbuka di tengah layar")
print("💡 Tekan F untuk toggle Fly, ✕ di atas untuk keluar")

-- ==============================================
-- 8. BONUS: TOMBOL F UNTUK TOGGLE FLY (ALTERNATIF)
-- ==============================================
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        Settings.Fly = not Settings.Fly
        flyBtn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(45, 45, 50)
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = Settings.Fly
        end
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "ZHAK",
            Text = "Fly: " .. (Settings.Fly and "ON" or "OFF"),
            Duration = 1.5
        })
    end
end)
