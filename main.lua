-- Zhak-GPT Universal Exploit GUI 2025 + Mental Trolling
-- Work di semua executor & 99% game Roblox
-- Tekan Right Shift untuk toggle GUI

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local CurrentChar = nil
local CurrentHumanoid = nil

-- Settings
local Settings = {
    Fly = false,
    FlySpeed = 75,
    WalkSpeed = 50,
    JumpPower = 75,
    Noclip = false,
    InfiniteJump = false,
    GodMode = false,
    AutoSprint = false,
    TrollPartSize = 8
}

-- Create GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "ZhakUniversalGUI"
GUI.Parent = LocalPlayer.PlayerGui
GUI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 520)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = GUI

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
Header.Parent = MainFrame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, 0, 1, 0)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "📶 ZHAK UNIVERSAL EXPLOIT + MENTAL TROLL"
HeaderText.TextColor3 = Color3.new(1,1,1)
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextSize = 16
HeaderText.Parent = Header

-- Create Toggle Button Template
local function CreateToggle(text, yPos, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.92, 0, 0, 32)
    Btn.Position = UDim2.new(0.04, 0, yPos, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.Parent = MainFrame
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

-- Create Slider Template
local function CreateSlider(labelText, yPos, min, max, default, onChange)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, yPos, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText .. ": " .. default
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.Parent = MainFrame

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(0.92, 0, 0, 6)
    Slider.Position = UDim2.new(0.04, 0, yPos + 0.035, 0)
    Slider.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    Slider.Parent = MainFrame

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(default/max, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
    SliderFill.Parent = Slider

    local SliderBtn = Instance.new("TextButton")
    SliderBtn.Size = UDim2.new(0, 14, 0, 14)
    SliderBtn.Position = UDim2.new(default/max, -7, 0.5, -7)
    SliderBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
    SliderBtn.BorderSizePixel = 0
    SliderBtn.Parent = Slider
    SliderBtn.Draggable = true

    local dragging = false
    SliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

    RunService.Heartbeat:Connect(function()
        if dragging then
            local mousePos = UIS:GetMouseLocation()
            local relPos = (mousePos.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X
            relPos = math.clamp(relPos, 0, 1)
            local value = math.floor(relPos * max)
            SliderFill.Size = UDim2.new(relPos, 0, 1, 0)
            SliderBtn.Position = UDim2.new(relPos, -7, 0.5, -7)
            Label.Text = labelText .. ": " .. value
            onChange(value)
        end
    end)
end

-- Fly Toggle
local FlyBtn = CreateToggle("✈️ Fly: OFF", 0.12, function()
    Settings.Fly = not Settings.Fly
    FlyBtn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
end)

-- Sliders
CreateSlider("🚀 Fly Speed", 0.22, 0, 200, Settings.FlySpeed, function(val)
    Settings.FlySpeed = val
end)

CreateSlider("🏃 Walk Speed", 0.35, 0, 200, Settings.WalkSpeed, function(val)
    Settings.WalkSpeed = val
    if CurrentHumanoid then CurrentHumanoid.WalkSpeed = val end
end)

CreateSlider("🦘 Jump Power", 0.48, 0, 200, Settings.JumpPower, function(val)
    Settings.JumpPower = val
    if CurrentHumanoid then CurrentHumanoid.JumpPower = val end
end)

-- Extra Toggles
CreateToggle("👻 Noclip: OFF", 0.61, function()
    Settings.Noclip = not Settings.Noclip
    script.Parent.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
end)

CreateToggle("💀 God Mode: OFF", 0.71, function()
    Settings.GodMode = not Settings.GodMode
    script.Parent.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
end)

CreateToggle("♾️ Infinite Jump: OFF", 0.81, function()
    Settings.InfiniteJump = not Settings.InfiniteJump
    script.Parent.Text = "♾️ Infinite Jump: " .. (Settings.InfiniteJump and "ON" or "OFF")
end)

-- ==============================================
-- 🧟‍♂️ FITUR MENTAL TROLL BARU
-- ==============================================
local TrollLabel = Instance.new("TextLabel")
TrollLabel.Size = UDim2.new(1, 0, 0, 20)
TrollLabel.Position = UDim2.new(0, 0, 0.92, 0)
TrollLabel.BackgroundTransparency = 1
TrollLabel.Text = "🧟‍♂️ MENTAL TROLL SECTION"
TrollLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
TrollLabel.Font = Enum.Font.GothamBold
TrollLabel.TextSize = 14
TrollLabel.Parent = MainFrame

-- Player Dropdown
local PlayerDropdown = Instance.new("Frame")
PlayerDropdown.Size = UDim2.new(0.92, 0, 0, 30)
PlayerDropdown.Position = UDim2.new(0.04, 0, 0.97, 0)
PlayerDropdown.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
PlayerDropdown.Parent = MainFrame

local DropdownText = Instance.new("TextLabel")
DropdownText.Size = UDim2.new(0.3, 0, 1, 0)
DropdownText.BackgroundTransparency = 1
DropdownText.Text = "🎯 Target:"
DropdownText.TextColor3 = Color3.new(1,1,1)
DropdownText.Font = Enum.Font.Gotham
DropdownText.TextSize = 13
DropdownText.Parent = PlayerDropdown

local Dropdown = Instance.new("TextBox")
Dropdown.Size = UDim2.new(0.68, 0, 1, 0)
Dropdown.Position = UDim2.new(0.32, 0, 0, 0)
Dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
Dropdown.Text = "Ketik Nama Player"
Dropdown.TextColor3 = Color3.new(1,1,1)
Dropdown.Font = Enum.Font.Gotham
Dropdown.Parent = PlayerDropdown

-- Troll Part Size Slider
CreateSlider("📏 Ukuran Part Troll", 1.07, 1, 25, Settings.TrollPartSize, function(val)
    Settings.TrollPartSize = val
end)

-- Troll Button
local TrollBtn = Instance.new("TextButton")
TrollBtn.Size = UDim2.new(0.92, 0, 0, 35)
TrollBtn.Position = UDim2.new(0.04, 0, 1.20, 0)
TrollBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
TrollBtn.Text = "💥 SPAWN PART MENTAL!"
TrollBtn.TextColor3 = Color3.new(1,1,1)
TrollBtn.Font = Enum.Font.GothamBold
TrollBtn.TextSize = 15
TrollBtn.Parent = MainFrame

TrollBtn.MouseButton1Click:Connect(function()
    -- Cari player target
    local TargetPlayer = Players:FindFirstChild(Dropdown.Text)
    if not TargetPlayer or not TargetPlayer.Character then
        warn("❌ Player tidak ditemukan!")
        return
    end

    -- Spawn part tepat di atas kepala player
    local TargetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not TargetRoot then return end

    local TrollPart = Instance.new("Part")
    TrollPart.Size = Vector3.new(Settings.TrollPartSize, Settings.TrollPartSize, Settings.TrollPartSize)
    TrollPart.Position = TargetRoot.Position + Vector3.new(0, Settings.TrollPartSize + 5, 0)
    TrollPart.Anchored = false
    TrollPart.CanCollide = true
    TrollPart.Material = Enum.Material.Neon
    TrollPart.Color = Color3.fromRGB(255, 0, 0)
    TrollPart.Density = 50 -- Partnya SUPER BERAT
    TrollPart.Parent = workspace

    -- Hapus part setelah 5 detik biar ga bikin game lag
    task.wait(5)
    TrollPart:Destroy()
end)

-- Main Loop
RunService.Heartbeat:Connect(function()
    -- Update Current Character
    if LocalPlayer.Character and LocalPlayer.Character ~= CurrentChar then
        CurrentChar = LocalPlayer.Character
        CurrentHumanoid = CurrentChar:FindFirstChildOfClass("Humanoid")
        if CurrentHumanoid then
            CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
            CurrentHumanoid.JumpPower = Settings.JumpPower
        end
    end

    -- God Mode
    if Settings.GodMode and CurrentHumanoid then
        CurrentHumanoid.Health = CurrentHumanoid.MaxHealth
    end

    -- Noclip
    if Settings.Noclip and CurrentChar then
        for _,v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    -- Fly Logic
    if Settings.Fly and CurrentChar and CurrentHumanoid then
        CurrentHumanoid.PlatformStand = true
        local Cam = workspace.CurrentCamera
        local Dir = Vector3.new(0,0,0)

        -- Movement Keys
        if UIS:IsKeyDown(Enum.KeyCode.W) then Dir += Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then Dir -= Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then Dir -= Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then Dir += Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then Dir += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then Dir -= Vector3.new(0,1,0) end

        -- Normalize Direction
        if Dir.Magnitude > 0 then
            local Root = CurrentChar:FindFirstChild("HumanoidRootPart")
            if Root then Root.CFrame = Root.CFrame + (Dir.Unit * Settings.FlySpeed * 0.08) end
        end
    elseif CurrentHumanoid then
        CurrentHumanoid.PlatformStand = false
    end
end)

-- Infinite Jump Handler
UIS.JumpRequest:Connect(function()
    if Settings.InfiniteJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState("Jumping")
    end
end)

-- Toggle GUI with Right Shift
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("✅ Zhak Universal GUI Loaded! Tekan Right Shift untuk membuka GUI")
