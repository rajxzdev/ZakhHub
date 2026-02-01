-- SCRIPT CEK TERAKHIR (TANPA GUI, TANPA PART)
-- Jika ini tidak membuatmu lari cepat, berarti Delta tidak jalan.

print("Mencoba mengubah WalkSpeed...")

local p = game:GetService("Players").LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- 1. Ubah kecepatan lari (Pasti terasa kalau work)
hum.WalkSpeed = 200 

-- 2. Ubah tinggi lompatan
hum.JumpPower = 300
hum.UseJumpPower = true

-- 3. Notifikasi resmi sistem Roblox (Bukan GUI buatan saya)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZHAK CHECK",
    Text = "Jika lari kamu cepat, Delta WORK!",
    Duration = 10
})

print("WalkSpeed diubah ke 200. Jika tidak lari cepat, Delta kamu ERROR.")
