-- ZhakFullScript.lua
-- ==============================================================
--  ZHAK UNIVERSAL – ONE‑FILE EXECUTOR‑AGNOSTIC SCRIPT
--  Works on Delta (2025+), Codex, Fluxus, Electron, etc.
--  No external libraries – pure Roblox‑Lua.
-- ==============================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-------------------------------------------------
-- SETTINGS
-------------------------------------------------
local Settings = {
    Fly = false,
    FlySpeed = 75,
    WalkSpeed = 50,
    JumpPower = 75,
    Noclip = false,
    GodMode = false,
    InfiniteJump = false,
    TrollSize = 10,
}

local CurrentChar, CurrentHumanoid = nil, nil

-------------------------------------------------
-- HELPERS
-------------------------------------------------
local function GetGuiParent()
    -- Try the safest parent first, fall back if blocked
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    local success2, getHui = pcall(function() return gethui() end)
    if success2 and getHui then return getHui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function CreateButton(txt, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.Text = txt
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = scrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function() cb(btn) end)
    return btn
end

local function CreateLabel(txt)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.9, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = txt
    lbl.TextColor3 = Color3.fromRGB(0, 200, 120)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.Parent = scrollFrame
    return lbl
end

-------------------------------------------------
-- CREATE GUI (auto‑show, no extra “open” button)
-------------------------------------------------
local parent = GetGuiParent()
if parent:FindFirstChild("ZhakFullScript") then parent.ZhakFullScript:Destroy() end

local screen = Instance.new("ScreenGui")
screen.Name = "ZhakFullScript"
screen.Parent = parent
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 320, 0, 480)
panel.Position = UDim2.new(0.5, -160, 0.5, -240)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
panel.Draggable = true
panel.Active = true
panel.Visible = true
panel.Parent = screen

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 8)
panelCorner.Parent = panel

-- Header
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
header.Text = "✅ ZHAK UNIVERSAL SCRIPT"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.Parent = panel

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screen:Destroy()
    print("[ZHAK] GUI closed")
end)

-- Scrollable area for all controls
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -55)
scrollFrame.Position = UDim2.new(0, 5, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
scrollFrame.Parent = panel

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = scrollFrame

-- ==============================================================
-- UI ELEMENTS (buttons, textboxes, etc.)
-- ==============================================================

CreateLabel("⚡ MOVEMENT")

-- Fly toggle
local flyBtn = CreateButton("✈️ Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

-- Increase Fly Speed
CreateButton("🚀 ↑ Fly Speed", function()
    Settings.FlySpeed = Settings.FlySpeed + 25
    if Settings.FlySpeed > 200 then Settings.FlySpeed = 25 end
    print("[ZHAK] Fly Speed →", Settings.FlySpeed)
end)

-- Walk Speed
CreateButton("🏃 ↑ Walk Speed", function()
    Settings.WalkSpeed = Settings.WalkSpeed + 25
    if Settings.WalkSpeed > 200 then Settings.WalkSpeed = 16 end
    if CurrentHumanoid then CurrentHumanoid.WalkSpeed = Settings.WalkSpeed end
    print("[ZHAK] Walk Speed →", Settings.WalkSpeed)
end)

-- Jump Power
CreateButton("🦘 ↑ Jump Power", function()
    Settings.JumpPower = Settings.JumpPower + 25
    if Settings.JumpPower > 200 then Settings.JumpPower = 50 end
    if CurrentHumanoid then CurrentHumanoid.JumpPower = Settings.JumpPower end
    print("[ZHAK] Jump Power →", Settings.JumpPower)
end)

CreateLabel("🛡️ CHEATS")

-- Noclip
CreateButton("👻 Noclip: OFF", function(btn)
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

-- God Mode
CreateButton("💀 God Mode: OFF", function(btn)
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

-- Infinite Jump
CreateButton("♾️ Infinite Jump: OFF", function(btn)
    Settings.InfiniteJump = not Settings.InfiniteJump
    btn.Text = "♾️ Infinite Jump: " .. (Settings.InfiniteJump and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.InfiniteJump and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

CreateLabel("🧟 TROLL")

local trollTarget = CreateTextBox("Ketik nama target troll")

CreateButton("📏 Ukuran Part: 10", function()
    Settings.TrollSize = Settings.TrollSize + 5
    if Settings.TrollSize > 30 then Settings.TrollSize = 5 end
    print("[ZHAK] Troll Part Size →", Settings.TrollSize)
end)

CreateButton("💥 Spawn Part di Atas Target", function()
    local target = Players:FindFirstChild(trollTarget.Text)
    if not target or not target.Character then
        print("[ZHAK] Target tidak valid")
        return
    end
    local root = target.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

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
end)

-- ==============================================================
-- MAIN LOOP (Fly, Noclip, God, etc.)
-- ==============================================================

RunService.Heartbeat:Connect(function()
    -- Keep character reference up‑to‑date
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
        for _, v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    -- Fly handling
    if Settings.Fly then
        CurrentHumanoid.PlatformStand = true
        local cam = workspace.CurrentCamera
        local move = Vector3.new(0, 0, 0)

        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end

        if move.Magnitude > 0 then
            local root = CurrentChar:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + (move.Unit * Settings.FlySpeed * 0.08)
            end
        end
    elseif CurrentHumanoid then
        CurrentHumanoid.PlatformStand = false
    end
end)

-- Infinite Jump handler
UIS.JumpRequest:Connect(function()
    if Settings.InfiniteJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState("Jumping")
    end
end)

print("[ZHAK] SCRIPT LOADED – panel should be visible")
