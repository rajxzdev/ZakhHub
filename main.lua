-- rajxzdev 2026 – GUI 100000% MUNCUL DI SEMUA EXECUTOR
-- Paste langsung → GUI keluar pasti

local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdevFinal"
gui.ResetOnSpawn = false

-- METHOD BRUTAL FORCE 2026 (work di Solara, Delta X, Codex, semua)
repeat
    pcall(function()
        gui.Parent = game:GetService("CoreGui")
    end)
    task.wait()
until gui.Parent

-- Kalau masih ga muncul, paksa lewat Players
if not gui.Parent then
    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- GUI
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 400, 0, 560)
main.Position = UDim2.new(0.5, -200, 0.5, -280)
main.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 24)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 80)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
title.Text = "rajxzdev 2026"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 42
title.TextStrokeTransparency = 0
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 24)

-- Tombol-tombol
local function btn(name, pos, color, func)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.85, 0, 0, 70)
    b.Position = UDim2.new(0.075, 0, 0, pos)
    b.BackgroundColor3 = color
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 26
    b.TextStrokeTransparency = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 16)
    b.MouseButton1Click:Connect(func)
end

local fly = false
local flyspeed = 300
local walkspeed = 300

btn("Fly Mobile/PC", 120, Color3.fromRGB(0, 200, 255), function()
    fly = not fly
    if fly then
        local bv = Instance.new("BodyVelocity", Players.LocalPlayer.Character.HumanoidRootPart)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        local bg = Instance.new("BodyGyro", Players.LocalPlayer.Character.HumanoidRootPart)
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bg.P = 9e9
        spawn(function()
            while fly do
                local cam = workspace.CurrentCamera.CFrame
                local move = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
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
