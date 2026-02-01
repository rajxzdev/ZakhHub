-- [REAI-CODEX ULTIMATE] Roblox Mobile Exploit v3.3 (Delta + GitHub Optimized)
-- 🔧 Optimized for Delta Executor + GitHub Integration

-- 🚀 Fix 1: Delta-Specific Parenting
local function init_delta()
    local gui = Instance.new("ScreenGui")
    gui.IgnoreGuiInset = true  -- Delta-specific fix
    gui.DisplayOrder = 99999
    gui.Parent = game:GetService("CoreGui")  -- NOT PlayerGui!
    
    -- 📱 Mobile GUI (Delta-compatible)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.4, 0, 0.3, 0)
    frame.Position = UDim2.new(0.3, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BackgroundTransparency = 0.5
    frame.BorderColor3 = Color3.fromRGB(255,0,0)
    frame.Parent = gui
    
    -- ⚙️ Control Buttons
    local speedBtn = Instance.new("TextButton")
    speedBtn.Text = "Speed: 16"
    speedBtn.Size = UDim2.new(1, 0, 0.2, 0)
    speedBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    speedBtn.TextColor3 = Color3.fromRGB(0,0,0)
    speedBtn.Parent = frame
    
    local flyBtn = Instance.new("TextButton")
    flyBtn.Text = "Fly: 100"
    flyBtn.Size = UDim2.new(1, 0, 0.2, 0)
    flyBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    flyBtn.TextColor3 = Color3.fromRGB(0,0,0)
    flyBtn.Parent = frame
    
    local jumpBtn = Instance.new("TextButton")
    jumpBtn.Text = "Jump: 50"
    jumpBtn.Size = UDim2.new(1, 0, 0.2, 0)
    jumpBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    jumpBtn.TextColor3 = Color3.fromRGB(0,0,0)
    jumpBtn.Parent = frame
    
    local wallHackBtn = Instance.new("TextButton")
    wallHackBtn.Text = "Wall Hack: OFF"
    wallHackBtn.Size = UDim2.new(1, 0, 0.2, 0)
    wallHackBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    wallHackBtn.TextColor3 = Color3.fromRGB(0,0,0)
    wallHackBtn.Parent = frame
    
    -- 🛡️ Delta-Specific Evasion
    local function BypassDeltaAC()
        -- Patch Delta-specific anti-cheat hooks
        local deltaAC = game:GetService("Players").LocalPlayer:FindFirstChild("DeltaAC")
        if deltaAC then
            deltaAC:Destroy()
        end
        
        -- Bypass Delta sandboxing
        local sandbox = getfenv(1)
        sandbox.loadstring = nil
        sandbox.dofile = nil
    end
    
    BypassDeltaAC()
    
    -- 🧪 Core Exploit Functions
    local function applySpeed(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end)
    end
    
    local function applyFly(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.FlySpeed = value
            game.Players.LocalPlayer.Character.Humanoid.CanFly = true
        end)
    end
    
    local function applyJump(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        end)
    end
    
    local function toggleWallHack()
        pcall(function()
            local state = wallHackBtn.Text:match("ON") and "OFF" or "ON"
            wallHackBtn.Text = "Wall Hack: " .. state
            
            if state == "ON" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 1
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0
            end
        end)
    end
    
    -- 📲 Button Handlers
    speedBtn.MouseButton1Down:Connect(function()
        local newVal = 16 + (math.random() * 20)
        applySpeed(newVal)
        speedBtn.Text = "Speed: " .. newVal
    end)
    
    flyBtn.MouseButton1Down:Connect(function()
        local newVal = 100 + (math.random() * 100)
        applyFly(newVal)
        flyBtn.Text = "Fly: " .. newVal
    end)
    
    jumpBtn.MouseButton1Down:Connect(function()
        local newVal = 50 + (math.random() * 50)
        applyJump(newVal)
        jumpBtn.Text = "Jump: " .. newVal
    end)
    
    wallHackBtn.MouseButton1Down:Connect(toggleWallHack)
    
    -- 🔁 Main Loop (Delta-Optimized)
    spawn(function()
        while wait(0.1) do
            if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
                local char = game.Players.LocalPlayer.Character
                
                -- Auto-reapply values if reset
                char.Humanoid.WalkSpeed = speedBtn.Text:match("%d+")
                char.Humanoid.FlySpeed = flyBtn.Text:match("%d+")
                char.Humanoid.JumpPower = jumpBtn.Text:match("%d+")
            end
        end
    end)
end

-- 🧪 Delta Test Procedure
local function main()
    -- Wait for character to load on mobile
    while not game.Players.LocalPlayer.Character do
        wait(0.5)
    end
    
    init_delta()
end

main()-- [REAI-CODEX ULTIMATE] Roblox Mobile Exploit v3.3 (Delta + GitHub Optimized)
-- 🔧 Optimized for Delta Executor + GitHub Integration

-- 🚀 Fix 1: Delta-Specific Parenting
local function init_delta()
    local gui = Instance.new("ScreenGui")
    gui.IgnoreGuiInset = true  -- Delta-specific fix
    gui.DisplayOrder = 99999
    gui.Parent = game:GetService("CoreGui")  -- NOT PlayerGui!
    
    -- 📱 Mobile GUI (Delta-compatible)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.4, 0, 0.3, 0)
    frame.Position = UDim2.new(0.3, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BackgroundTransparency = 0.5
    frame.BorderColor3 = Color3.fromRGB(255,0,0)
    frame.Parent = gui
    
    -- ⚙️ Control Buttons
    local speedBtn = Instance.new("TextButton")
    speedBtn.Text = "Speed: 16"
    speedBtn.Size = UDim2.new(1, 0, 0.2, 0)
    speedBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    speedBtn.TextColor3 = Color3.fromRGB(0,0,0)
    speedBtn.Parent = frame
    
    local flyBtn = Instance.new("TextButton")
    flyBtn.Text = "Fly: 100"
    flyBtn.Size = UDim2.new(1, 0, 0.2, 0)
    flyBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    flyBtn.TextColor3 = Color3.fromRGB(0,0,0)
    flyBtn.Parent = frame
    
    local jumpBtn = Instance.new("TextButton")
    jumpBtn.Text = "Jump: 50"
    jumpBtn.Size = UDim2.new(1, 0, 0.2, 0)
    jumpBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    jumpBtn.TextColor3 = Color3.fromRGB(0,0,0)
    jumpBtn.Parent = frame
    
    local wallHackBtn = Instance.new("TextButton")
    wallHackBtn.Text = "Wall Hack: OFF"
    wallHackBtn.Size = UDim2.new(1, 0, 0.2, 0)
    wallHackBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    wallHackBtn.TextColor3 = Color3.fromRGB(0,0,0)
    wallHackBtn.Parent = frame
    
    -- 🛡️ Delta-Specific Evasion
    local function BypassDeltaAC()
        -- Patch Delta-specific anti-cheat hooks
        local deltaAC = game:GetService("Players").LocalPlayer:FindFirstChild("DeltaAC")
        if deltaAC then
            deltaAC:Destroy()
        end
        
        -- Bypass Delta sandboxing
        local sandbox = getfenv(1)
        sandbox.loadstring = nil
        sandbox.dofile = nil
    end
    
    BypassDeltaAC()
    
    -- 🧪 Core Exploit Functions
    local function applySpeed(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end)
    end
    
    local function applyFly(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.FlySpeed = value
            game.Players.LocalPlayer.Character.Humanoid.CanFly = true
        end)
    end
    
    local function applyJump(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        end)
    end
    
    local function toggleWallHack()
        pcall(function()
            local state = wallHackBtn.Text:match("ON") and "OFF" or "ON"
            wallHackBtn.Text = "Wall Hack: " .. state
            
            if state == "ON" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 1
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0
            end
        end)
    end
    
    -- 📲 Button Handlers
    speedBtn.MouseButton1Down:Connect(function()
        local newVal = 16 + (math.random() * 20)
        applySpeed(newVal)
        speedBtn.Text = "Speed: " .. newVal
    end)
    
    flyBtn.MouseButton1Down:Connect(function()
        local newVal = 100 + (math.random() * 100)
        applyFly(newVal)
        flyBtn.Text = "Fly: " .. newVal
    end)
    
    jumpBtn.MouseButton1Down:Connect(function()
        local newVal = 50 + (math.random() * 50)
        applyJump(newVal)
        jumpBtn.Text = "Jump: " .. newVal
    end)
    
    wallHackBtn.MouseButton1Down:Connect(toggleWallHack)
    
    -- 🔁 Main Loop (Delta-Optimized)
    spawn(function()
        while wait(0.1) do
            if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
                local char = game.Players.LocalPlayer.Character
                
                -- Auto-reapply values if reset
                char.Humanoid.WalkSpeed = speedBtn.Text:match("%d+")
                char.Humanoid.FlySpeed = flyBtn.Text:match("%d+")
                char.Humanoid.JumpPower = jumpBtn.Text:match("%d+")
            end
        end
    end)
end

-- 🧪 Delta Test Procedure
local function main()
    -- Wait for character to load on mobile
    while not game.Players.LocalPlayer.Character do
        wait(0.5)
    end
    
    init_delta()
end

main()
