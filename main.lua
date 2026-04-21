-- [[ PRABBBZ OMNIPOTENT - UNIVERSAL PUBLIC VERSION ]] --
-- Semua orang yang eksekusi otomatis jadi admin di menu ini

local Players = game:GetService("Players")
local LP = Players.LocalPlayer -- Mendeteksi siapa pun yang menjalankan skrip

-- 1. SISTEM PENYIMPANAN BAN (Global Server Memory)
shared.P_Bans = shared.P_Bans or {}

-- 2. LOGIKA EKSEKUSI (Server-Side)
local function executeAction(actionType, targetName, execPlayer)
    local function getT(n) return Players:FindFirstChild(n) end

    if actionType == "KICK" then
        local target = getT(targetName)
        if target then target:Kick("\n[ADMIN ACTION]\nKicked by: " .. execPlayer.Name) end
    
    elseif actionType == "BAN" then
        local target = getT(targetName)
        if target then
            shared.P_Bans[target.Name] = true
            target:Kick("\n[ADMIN ACTION]\nBanned by: " .. execPlayer.Name)
        end
        
    elseif actionType == "KALL" then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= execPlayer then p:Kick("Server Cleared.") end
        end
        
    elseif actionType == "BALL" then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= execPlayer then
                shared.P_Bans[p.Name] = true
                p:Kick("Server Blacklisted.")
            end
        end
    end
end

-- 3. AUTO-BAN REJOIN
if not _G.GlobalBanActive then
    _G.GlobalBanActive = true
    Players.PlayerAdded:Connect(function(p)
        if shared.P_Bans[p.Name] then
            p:Kick("You are banned from this server.")
        end
    end)
end

-- 4. UI GENERATOR (Universal Injector)
local function buildMenu(plr)
    -- Hapus menu lama jika ada
    if plr.PlayerGui:FindFirstChild("PrabbbzPublic") then
        plr.PlayerGui.PrabbbzPublic:Destroy()
    end

    local sg = Instance.new("ScreenGui", plr.PlayerGui)
    sg.Name = "PrabbbzPublic"
    sg.ResetOnSpawn = false

    local f = Instance.new("Frame", sg)
    f.Size = UDim2.new(0, 220, 0, 280)
    f.Position = UDim2.new(0.5, -110, 0.4, 0)
    f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    f.Active = true
    f.Draggable = true
    Instance.new("UICorner", f)

    local title = Instance.new("TextLabel", f)
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Text = "PRABBBZ OMNI [PUBLIC]"
    title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    Instance.new("UICorner", title)

    local input = Instance.new("TextBox", f)
    input.Size = UDim2.new(0.9, 0, 0, 35)
    input.Position = UDim2.new(0.05, 0, 0.18, 0)
    input.PlaceholderText = "Target Username..."
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    input.TextColor3 = Color3.new(1, 1, 1)

    local function createBtn(text, yPos, color, act)
        local btn = Instance.new("TextButton", f)
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = UDim2.new(0.05, 0, yPos, 0)
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", btn)

        btn.MouseButton1Click:Connect(function()
            executeAction(act, input.Text, plr)
        end)
    end

    createBtn("KICK PLAYER", 0.35, Color3.fromRGB(50, 50, 50), "KICK")
    createBtn("BAN PLAYER", 0.50, Color3.fromRGB(100, 0, 0), "BAN")
    createBtn("KICK ALL", 0.65, Color3.fromRGB(130, 0, 0), "KALL")
    createBtn("BAN ALL", 0.80, Color3.fromRGB(70, 0, 0), "BALL")
end

-- Langsung jalankan untuk siapa pun yang eksekusi
if LP then
    buildMenu(LP)
    print("Omnipotent Loaded for: " .. LP.Name)
end
