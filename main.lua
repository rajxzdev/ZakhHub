-- rajxzdev 2026 – KHUSUS DELTA X ONLY (100% WORK)
-- Paste di Delta X → GUI langsung muncul

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- CARA KHUSUS DELTA X (pake PlayerGui dulu baru pindah ke CoreGui)
local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdevDeltaX"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")  -- Kunci utama buat Delta X

task.wait(0.5)

-- Pindah ke CoreGui biar ga keganggu
gui.Parent = game:GetService("CoreGui")

-- GUI CANTIK
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 380, 0, 540)
main.Position = UDim2.new(0.5, -190, 0.5, -270)
main.BackgroundColor3 = Color3.fromRGB(8, 0, 15)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 22)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 80)
title.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
title.Text = "rajxzdev DELTA X"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 38
title.TextStrokeTransparency = 0
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 22)

local function btn(name, pos, color, func)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.85, 0, 0, 70)
    b.Position = UDim2.new(0.075, 0, 0, pos)
    b.BackgroundColor3 = color
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 28
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 16)
    b.MouseButton1Click:Connect(func)
end

local fly = false
local flyspeed = 300

btn("Fly Mobile/PC", 120, Color3.fromRGB(0, 200, 255), function()
    fly = not fly
    local hrp = LocalPlayer.Character.HumanoidRootPart
    if fly then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        local bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bg.P = 9e9
        spawn(function()
            while fly do
                local dir = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
                bv.Velocity = dir * flyspeed
                bg.CFrame = Camera.CFrame
                task.wait()
            end
            bv:Destroy(); bg:Destroy()
        end)
    end
end)

btn("Speed 500", 210, Color3.fromRGB(255, 100, 0), function()
    LocalPlayer.Character.Humanoid.WalkSpeed = 500
end)

btn("Infinite Jump", 300, Color3.fromRGB(0, 255, 150), function()
    UserInputService.JumpRequest:Connect(function()
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end)
end)

btn("Wallhack", 390, Color3.fromRGB(255, 0, 150), function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, p in pairs(plr.Character:GetChildren()) do
                if p:IsA("BasePart") then
                    p.Transparency = p.Transparency == 0.7 and 0 or 0.7
                end
            end
        end
    end
end)

print("rajxzdev 2026 – KHUSUS DELTA X – GUI 100% MUNCUL")
game.StarterGui:SetCore("SendNotification", {Title = "DELTA X MODE"; Text = "rajxzdev 2026 loaded perfectly"; Duration = 6})                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
                bv.Velocity = move * flyspeed
                bg.CFrame = cam
                task.wait()
            end
            bv:Destroy()
            bg:Destroy()
        end)
    end
end)

btn("Infinite Jump", 210, Color3.fromRGB(0, 255, 150), function()
    UserInputService.JumpRequest:Connect(function()
        Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end)
end)

btn("Speed Adjust: "..walkspeed, 300, Color3.fromRGB(255, 100, 0), function(self)
    walkspeed = walkspeed + 100
    if walkspeed > 1000 then walkspeed = 100 end
    self.Text = "Speed Adjust: "..walkspeed
    Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
end)

btn("Wallhack X-Ray", 390, Color3.fromRGB(255, 0, 150), function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = part.Transparency == 0.7 and 0 or 0.7
                end
            end
        end
    end
end)

print("rajxzdev 2026 – GUI 100000% MUNCUL – Mobile/PC – Clean & Ganteng")
game.StarterGui:SetCore("SendNotification", {Title = "rajxzdev 2026"; Text = "GUI Loaded – kamu sekarang dewa"; Duration = 5})
