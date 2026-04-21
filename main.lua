-- [[ PRABBBZ OMNIPOTENT V4 - SOURCE ]] --
-- [[ PRABBBZ OMNIPOTENT V4 - FIXED ]] --
local adminName = "lonelyXreyy2"
local player = game:GetService("Players").LocalPlayer

-- Pengecekan User (Case Insensitive agar lebih aman)
if player.Name:lower() ~= adminName:lower() then 
    warn("Unauthorized User: " .. player.Name) 
    return 
end

-- Lanjut ke skrip UI dan fitur...
print("Welcome, " .. player.Name .. "! Omnipotent V4 Loaded.")
if game.Players.LocalPlayer.Name ~= _G.AdminName then 
    warn("Unauthorized User Detected.") 
    return 
end

local Library = {} -- Simpel UI Library gaya profesional
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

-- BYPASS ENGINE: Mencari lubang keamanan (Remote Scanners)
local function GetVulnerableRemote()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            -- Mencari nama-nama remote yang rentan di-abuse
            local n = v.Name:lower()
            if n:find("kick") or n:find("ban") or n:find("admin") or n:find("control") then
                return v
            end
        end
    end
    return nil
end

-- UI CREATION
local sg = Instance.new("ScreenGui", game.CoreGui or game.Players.LocalPlayer.PlayerGui)
sg.Name = "Omni_V4"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local Corner = Instance.new("UICorner", Main)

local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "PRABBBZ OMNIPOTENT V4"
Header.BackgroundColor3 = _G.ThemeColor or Color3.fromRGB(150, 0, 0)
Header.TextColor3 = Color3.new(1, 1, 1)
Header.Font = Enum.Font.GothamBold
Instance.new("UICorner", Header)

local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0.9, 0, 0, 35)
Input.Position = UDim2.new(0.05, 0, 0.15, 0)
Input.PlaceholderText = "Target Username..."
Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Input.TextColor3 = Color3.new(1, 1, 1)

local Log = Instance.new("TextLabel", Main)
Log.Size = UDim2.new(0.9, 0, 0, 20)
Log.Position = UDim2.new(0.05, 0, 0.9, 0)
Log.Text = "Status: Ready"
Log.BackgroundTransparency = 1
Log.TextColor3 = Color3.new(0.6, 0.6, 0.6)
Log.TextSize = 10

-- FUNCTIONALITY
local function Execute(act)
    local target = Players:FindFirstChild(Input.Text)
    local remote = GetVulnerableRemote()

    if not remote then
        Log.Text = "Status: No Vulnerable Remote Found!"
        return
    end

    if act == "KICK" and target then
        remote:FireServer(target, "Kicked by Omnipotent V4")
        Log.Text = "Status: Attempting Kick on " .. target.Name
    elseif act == "KALL" then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer then
                remote:FireServer(p, "Server Wiped")
            end
        end
        Log.Text = "Status: Attempting Mass Kick"
    end
end

-- BUTTONS
local function AddBtn(txt, y, act)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, y, 0)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() Execute(act) end)
end

AddBtn("FE KICK PLAYER", 0.3, "KICK")
AddBtn("FE KICK ALL", 0.45, "KALL")
AddBtn("SHUTDOWN (EXPERIMENTAL)", 0.6, "KALL")

print("Omnipotent V4 Loaded for " .. _G.AdminName)
