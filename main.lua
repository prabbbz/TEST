-- [[ PRABBBZ SERVERSIDE - ULTIMATE START ]] --
local adminName = "lonelyXreyy2" -- GANTI DENGAN USERNAME KAMU

local Players = game:GetService("Players")

-- 1. SISTEM PENYIMPANAN BAN (Server Memory)
shared.P_Bans = shared.P_Bans or {}

-- 2. LOGIKA UTAMA (Server Side Execution)
local function executeAction(actionType, targetName)
    if actionType == "KICK" then
        local target = Players:FindFirstChild(targetName)
        if target then 
            target:Kick("\n[PRABBBZ SS]\nKicked by Admin.") 
        end
    elseif actionType == "BAN" then
        local target = Players:FindFirstChild(targetName)
        if target then
            shared.P_Bans[target.Name] = true
            target:Kick("\n[PRABBBZ SS]\nBanned from this server.")
        end
    elseif actionType == "KALL" then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Name ~= adminName then p:Kick("Server Wiped.") end
        end
    elseif actionType == "BALL" then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Name ~= adminName then 
                shared.P_Bans[p.Name] = true
                p:Kick("Server Blacklisted.") 
            end
        end
    end
end

-- 3. AUTO-KICK UNTUK PLAYER YANG DI-BAN
if not _G.BanSystemActive then
    _G.BanSystemActive = true
    Players.PlayerAdded:Connect(function(player)
        if shared.P_Bans[player.Name] then
            player:Kick("You are banned from this server.")
        end
    end)
end

-- 4. UI GENERATOR (Injected from Server)
local function buildMenu(plr)
    -- Hapus menu lama agar tidak tumpuk
    local oldMenu = plr.PlayerGui:FindFirstChild("PrabbbzAdmin")
    if oldMenu then oldMenu:Destroy() end

    local sg = Instance.new("ScreenGui", plr.PlayerGui)
    sg.Name = "PrabbbzAdmin"
    sg.ResetOnSpawn = false

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 220, 0, 280)
    frame.Position = UDim2.new(0.5, -110, 0.4, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Text = "PRABBBZ ADMIN SS"
    title.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    Instance.new("UICorner", title)

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0.9, 0, 0, 35)
    input.Position = UDim2.new(0.05, 0, 0.18, 0)
    input.PlaceholderText = "Target Username..."
    input.Text = ""
    input.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    input.TextColor3 = Color3.new(1, 1, 1)

    local function createBtn(text, yPos, color, act)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = UDim2.new(0.05, 0, yPos, 0)
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.Gotham
        Instance.new("UICorner", btn)

        -- Koneksi klik langsung di Server Side Executor
        btn.MouseButton1Click:Connect(function()
            executeAction(act, input.Text)
        end)
    end

    createBtn("KICK PLAYER", 0.35, Color3.fromRGB(50, 50, 50), "KICK")
    createBtn("BAN PLAYER", 0.50, Color3.fromRGB(100, 0, 0), "BAN")
    createBtn("KICK ALL", 0.65, Color3.fromRGB(130, 0, 0), "KALL")
    createBtn("BAN ALL", 0.80, Color3.fromRGB(70, 0, 0), "BALL")
end

-- 5. EXECUTION (Mencari kamu di server)
local admin = Players:FindFirstChild(adminName)
if admin then
    buildMenu(admin)
    print("Successfully Loaded for: " .. adminName)
else
    -- Jika kamu belum masuk, tunggu sampai kamu masuk
    Players.PlayerAdded:Connect(function(p)
        if p.Name == adminName then
            buildMenu(p)
        end
    end)
    print("Waiting for " .. adminName .. " to join...")
end
