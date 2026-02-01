-- ULTIMATE UNIVERSAL HUB v6.66 - FULL SCRIPT (NO HTTPGET)
-- Fly | Noclip | Speed | ESP | Teleport Player | OBJECT FLY TROLL

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local GuiScale = IsMobile and 1.5 or 1

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "DestroyerHub"

Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.02, 0, 0.25, 0)
Main.Size = UDim2.new(0, 300 * GuiScale, 0, 520 * GuiScale)
Main.Active = true
Main.Draggable = true
Main.BackgroundTransparency = 0.05

Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBlack
Title.Text = "DESTROYER HUB v6.66"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 22 * GuiScale

local function Btn(name, text, color, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = Main
    btn.BackgroundColor3 = color
    btn.Position = UDim2.new(0.05, 0, 0, posY * 60)
    btn.Size = UDim2.new(0.9, 0, 0, 50 * GuiScale)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 18 * GuiScale
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Variables
local Flying = false
local Noclipping = false
local SelectedPlayer = nil

-- Fly Button
Btn("Fly", "Fly [OFF]", Color3.fromRGB(0, 170, 255), 1, function(self)
    Flying = not Flying
    self.Text = "Fly ["..(Flying and "ON" or "OFF").."]"
    self.BackgroundColor3 = Flying and Color3.fromRGB(0,255,0) or Color3.fromRGB(0,170,255)
    
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local bv = Instance.new("BodyVelocity", hrp)
    local bg = Instance.new("BodyGyro", hrp)
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    bg.P = 9e9
    
    spawn(function()
        while Flying and hrp.Parent do
            local dir = Vector3.new(
                (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0),
                (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
            )
            bv.Velocity = (Camera.CFrame.LookVector * dir.Z + Camera.CFrame.RightVector * dir.X + Vector3.new(0, dir.Y, 0)) * 200
            bg.CFrame = Camera.CFrame
            task.wait()
        end
        bv:Destroy(); bg:Destroy()
    end)
end)

-- Noclip
Btn("Noclip", "Noclip [OFF]", Color3.fromRGB(255, 170, 0), 2, function(self)
    Noclipping = not Noclipping
    self.Text = "Noclip ["..(Noclipping and "ON" or "OFF").."]"
    RunService.Stepped:Connect(function()
        if Noclipping and LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- Speed
Btn("Speed", "Speed Hack", Color3.fromRGB(170, 0, 255), 3, function(self)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = hum.WalkSpeed == 16 and 250 or 16
        self.Text = "Speed ["..(hum.WalkSpeed == 250 and "ON" or "OFF").."]"
    end
end)

-- Player List + Teleport
local PlayerList = Instance.new("ScrollingFrame", Main)
PlayerList.Size = UDim2.new(0.9, 0, 0, 140 * GuiScale)
PlayerList.Position = UDim2.new(0.05, 0, 0, 260)
PlayerList.BackgroundTransparency = 0.8
PlayerList.ScrollBarThickness = 6

local function RefreshPlayers()
    for _, v in pairs(PlayerList:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    local y = 0
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local btn = Instance.new("TextButton", PlayerList)
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, y)
            btn.Text = plr.DisplayName.." (@"+plr.Name..")"
            btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.MouseButton1Click:Connect(function()
                SelectedPlayer = plr
                game.StarterGui:SetCore("SendNotification",{Title="Target Locked",Text=plr.DisplayName.." siap dihancurkan!",Duration=3})
            end)
            y = y + 35
        end
    end
end
RefreshPlayers()
Players.PlayerAdded:Connect(RefreshPlayers)
Players.PlayerRemoving:Connect(RefreshPlayers)

-- Teleport to Selected Player
Btn("Teleport", "Teleport ke Target", Color3.fromRGB(255, 100, 100), 7, function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame
    else
        game.StarterGui:SetCore("SendNotification",{Title="Error",Text="Pilih target dulu bro!",Duration=3})
    end
end)

-- OBJECT FLY TROLL (FITUR PALING JAHAT)
Btn("ObjectTroll", "Object Fly ke Target", Color3.fromRGB(150, 0, 0), 8, function(self)
    if not SelectedPlayer then return end
    local target = SelectedPlayer.Character.HumanoidRootPart
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored and obj ~= target and obj.Parent ~= LocalPlayer.Character then
            obj.CanCollide = false
            spawn(function()
                while task.wait(0.05) and target.Parent do
                    obj.Velocity = (target.Position - obj.Position).unit * 300 + Vector3.new(0, 100, 0)
                end
            end)
        end
    end
    self.Text = "Object Troll ON (klik lagi = mati)"
    task.wait(8)
    self.Text = "Object Fly ke Target"
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "DESTROYER HUB v6.66";
    Text = "Loaded. Pilih target lalu hajar!";
    Duration = 6;
})

print("DESTROYER HUB v6.66 ACTIVE - NO MERCY MODE")
