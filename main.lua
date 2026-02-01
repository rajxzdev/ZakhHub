-- TheDestroyer v6 - FINAL GOD MODE 2025
-- by rajxzdev (official god creator)
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/TheDestroyer/main/main.lua"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- MAIN GUI PREMIUM KELAS DUNIA
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TheDestroyerV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 380, 0, 580)
Main.Position = UDim2.new(0.02, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 16)

local Glow = Instance.new("ImageLabel", Main)
Glow.Size = UDim2.new(1, 30, 1, 30)
Glow.Position = UDim2.new(0, -15, 0, -15)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://4996891970"
Glow.ImageColor3 = Color3.fromRGB(255, 0, 100)
Glow.ImageTransparency = 0.6
Glow.ZIndex = 0

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = Color3.fromRGB(255, 0, 85)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "TheDestroyer v6"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -100, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 15, 0, 0)

local Close = Instance.new("TextButton", TopBar)
Close.Text = "×"
Close.Size = UDim2.new(0, 45, 0, 45)
Close.Position = UDim2.new(1, -50, 0, 5)
Close.BackgroundTransparency = 1
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 36

local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -30)
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 85)
OpenBtn.Text = "D"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Font = Enum.Font.GothamBlack
OpenBtn.TextSize = 30
OpenBtn.Visible = false
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 30)

-- Scroll Frame
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -75)
Scroll.Position = UDim2.new(0, 10, 0, 65)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 6
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local function AddButton(name, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 55)
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 30)
    btn.Text = name .. " [OFF]"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = Scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    
    Scroll.CanvasSize = Scroll.CanvasSize + UDim2.new(0, 0, 0, 65)
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = name .. " ["..(active and "ON" or "OFF").."]"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(30, 30, 30)
        
        if name == "Fly Mobile/PC" then
            if active then loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/flymobile/main/fly.lua"))() else loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/flymobile/main/stop.lua"))() end
        elseif name == "Noclip" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/noclip/main/noclip.lua"))()
        elseif name == "Speed 300" then
            LocalPlayer.Character.Humanoid.WalkSpeed = active and 300 or 16
        elseif name == "Inf Jump" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/infj/main/inf.lua"))()
        elseif name == "Player ESP" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/esp/main/esp.lua"))()
        elseif name == "Click TP" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/clicktp/main/clicktp.lua"))()
        elseif name == "Object Troll" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/rajxzdev/objecttroll/main/troll.lua"))()
        end
    end)
end

-- SEMUA FITUR GILA
AddButton("Fly Mobile/PC", Color3.fromRGB(0, 255, 150))
AddButton("Noclip")
AddButton("Speed 300")
AddButton("Inf Jump")
AddButton("Player ESP")
AddButton("Click TP")
AddButton("Object Troll")
AddButton("Auto Farm")
AddButton("Kill Aura")
AddButton("God Mode")
AddButton("Fling All")
AddButton("Crash Server")

-- Close/Open
Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)
OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "TheDestroyer v6";
    Text = "Loaded successfully! by rajxzdev";
    Duration = 8;
})

print("TheDestroyer v6 FINAL GOD MODE - rajxzdev is now UNSTOPPABLE")
