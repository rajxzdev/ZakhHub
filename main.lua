-- ZHAK-GPT UNIVERSAL SCRIPT v2.1 (HOSTING READY)
-- Paste ke Pastebin/GitHub Gist → Jalankan via: loadstring(game:HttpGet("URL_RAW_KAMU"))()
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Settings = {Fly=false, FlySpeed=75, WalkSpeed=50, JumpPower=75, Noclip=false, GodMode=false, InfiniteJump=false, TrollSize=10}
local CurrentChar, CurrentHumanoid = nil, nil

local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    local success2, getHui = pcall(function() return gethui() end)
    if success2 and getHui then return getHui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local TargetParent = GetGuiParent()
if TargetParent:FindFirstChild("ZhakUniversal") then TargetParent.ZhakUniversal:Destroy() end

local Screen = Instance.new("ScreenGui")
Screen.Name = "ZhakUniversal"
Screen.Parent = TargetParent
Screen.IgnoreGuiInset = true
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(0, 320, 0, 480)
MainPanel.Position = UDim2.new(0.5, -160, 0.5, -240)
MainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainPanel.Draggable = true
MainPanel.Active = true
MainPanel.Visible = true
MainPanel.Parent = Screen
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 10)

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
Header.Text = "✅ ZHAK UNIVERSAL v2.1"
Header.TextColor3 = Color3.new(1,1,1)
Header.Font = Enum.Font.GothamBold
Header.TextSize = 16
Header.Parent = MainPanel
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn)
CloseBtn.MouseButton1Click:Connect(function() Screen:Destroy() print("✅ GUI ditutup") end)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -55)
ScrollFrame.Position = UDim2.new(0, 5, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 650)
ScrollFrame.Parent = MainPanel
Instance.new("UIListLayout", ScrollFrame).Padding = UDim.new(0, 8)

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = ScrollFrame
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local function CreateTextBox(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 30)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    box.PlaceholderText = placeholder
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderColor3 = Color3.fromRGB(150,150,150)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.Parent = ScrollFrame
    Instance.new("UICorner", box)
    return box
end

local function CreateLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.9, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 200, 120)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = ScrollFrame
    return label
end

-- FITUR UTAMA
CreateLabel("⚡ MOVEMENT")
CreateButton("✈️ Fly: OFF", function(btn) Settings.Fly = not Settings.Fly btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF") btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(0,150,100) or Color3.fromRGB(40,40,45) end)
CreateButton("🚀 Fly Speed: 75", function(btn) Settings.FlySpeed = math.min(200, Settings.FlySpeed + 25) if Settings.FlySpeed > 200 then Settings.FlySpeed = 25 end btn.Text = "🚀 Fly Speed: " .. Settings.FlySpeed end)
CreateButton("🏃 Walk Speed: 50", function(btn) Settings.WalkSpeed = math.min(200, Settings.WalkSpeed + 25) if Settings.WalkSpeed > 200 then Settings.WalkSpeed = 16 end btn.Text = "🏃 Walk Speed: " .. Settings.WalkSpeed if CurrentHumanoid then CurrentHumanoid.WalkSpeed = Settings.WalkSpeed end end)
CreateButton("🦘 Jump Power: 75", function(btn) Settings.JumpPower = math.min(200, Settings.JumpPower + 25) if Settings.JumpPower > 200 then Settings.JumpPower = 50 end btn.Text = "🦘 Jump Power: " .. Settings.JumpPower if CurrentHumanoid then CurrentHumanoid.JumpPower = Settings.JumpPower end end)

CreateLabel("🛡️ CHEAT")
CreateButton("👻 Noclip: OFF", function(btn) Settings.Noclip = not Settings.Noclip btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF") btn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0,150,100) or Color3.fromRGB(40,40,45) end)
CreateButton("💀 God Mode: OFF", function(btn) Settings.GodMode = not Settings.GodMode btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF") btn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(0,150,100) or Color3.fromRGB(40,40,45) end)
CreateButton("♾️ Infinite Jump: OFF", function(btn) Settings.InfiniteJump = not Settings.InfiniteJump btn.Text = "♾️ Infinite Jump: " .. (Settings.InfiniteJump and "ON" or "OFF") btn.BackgroundColor3 = Settings.InfiniteJump and Color3.fromRGB(0,150,100) or Color3.fromRGB(40,40,45) end)

CreateLabel("🧟 TROLL")
local TrollBox = CreateTextBox("Nama player target")
CreateButton("📏 Part Size: 10", function(btn) Settings.TrollSize = math.min(30, Settings.TrollSize + 5) if Settings.TrollSize > 30 then Settings.TrollSize = 5 end btn.Text = "📏 Part Size: " .. Settings.TrollSize end)
CreateButton("💥 Spawn Part di Atas Target", function(btn)
    local tgt = Players:FindFirstChild(TrollBox.Text)
    if not tgt or not tgt.Character then btn.Text = "❌ Player tidak ada!" task.wait(1) btn.Text = "💥 Spawn Part di Atas Target" return end
    local root = tgt.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local p = Instance.new("Part", workspace)
    p.Size = Vector3.new(Settings.TrollSize, Settings.TrollSize, Settings.TrollSize)
    p.Position = root.Position + Vector3.new(0, Settings.TrollSize + 10, 0)
    p.Anchored, p.CanCollide, p.Material, p.Color, p.Density = false, true, Enum.Material.Neon, Color3.new(1,0,0), 100
    btn.Text = "✅ Part dijatuhkan!"
    task.wait(1) btn.Text = "💥 Spawn Part di Atas Target"
    task.delay(8, function() if p.Parent then p:Destroy() end end)
end)

-- MAIN LOOP
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character ~= CurrentChar then
        CurrentChar = LocalPlayer.Character
        CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
        if CurrentHumanoid then
            CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
            CurrentHumanoid.JumpPower = Settings.JumpPower
        end
    end
    if Settings.GodMode and CurrentHumanoid then CurrentHumanoid.Health = CurrentHumanoid.MaxHealth end
    if Settings.Noclip and CurrentChar then
        for _,v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    if Settings.Fly and CurrentChar and CurrentHumanoid then
        CurrentHumanoid.PlatformStand = true
        local cam = workspace.CurrentCamera
        local dir = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
        if dir.Magnitude > 0 and CurrentChar:FindFirstChild("HumanoidRootPart") then
            CurrentChar.HumanoidRootPart.CFrame = CurrentChar.HumanoidRootPart.CFrame + (dir.Unit * Settings.FlySpeed * 0.08)
        end
    elseif CurrentHumanoid then
        CurrentHumanoid.PlatformStand = false
    end
end)

UIS.JumpRequest:Connect(function()
    if Settings.InfiniteJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState("Jumping")
    end
end)

print("✅ ZHAK UNIVERSAL v2.1 LOADED!")
print("📱 Panel hijau aktif di tengah layar")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZHAK SCRIPT", 
    Text = "Panel hijau muncul! Geser untuk posisi nyaman.", 
    Duration = 5
})
