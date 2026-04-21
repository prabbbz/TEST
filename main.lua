-- [[ PRABBBZ OMNIPOTENT V5 - CLIENT EXECUTOR EDITION ]] --
-- Gunakan di Solara/Wave/dll. 
-- Skrip ini otomatis mencari celah agar tidak muncul error "Non-local player"

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. SCANNER ENGINE (Mencari Remote yang bisa di-abuse)
local function FindVulnerableRemote()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local name = v.Name:lower()
            -- Daftar nama remote yang biasanya punya akses Kick/Admin
            if name:find("kick") or name:find("ban") or name:find("admin") or name:find("control") or name:find("mod") then
                return v
            end
        end
    end
    return nil
end

-- 2. ACTION HANDLER
local function DoAction(action, targetName)
    local target = Players:FindFirstChild(targetName)
    local remote = FindVulnerableRemote()

    if not remote then
        print("❌ GAGAL: Tidak ditemukan RemoteEvent yang bocor di map ini.")
        return
    end

    if action == "KICK" and target then
        -- Mencoba berbagai format argumen yang biasanya dipakai developer
        remote:FireServer(target, "Kicked by PRABBBZ")
        remote:FireServer(target.Name, "Kicked by PRABBBZ")
        remote:FireServer("Kick", target)
    elseif action == "KALL" then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP then
                remote:FireServer(p, "Server Wiped")
            end
        end
    end
end

-- 3. UI GENERATOR (Pasti Muncul karena ini Client-Side)
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "Prabbbz_V5"

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 220, 0, 260)
f.Position = UDim2.new(0.5, -110, 0.4, 0)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
f.Active = true
f.Draggable = true
Instance.new("UICorner", f)

local t = Instance.new("TextBox", f)
t.Size = UDim2.new(0.9, 0, 0, 35)
t.Position = UDim2.new(0.05, 0, 0.2, 0)
t.PlaceholderText = "Username Target..."
t.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
t.TextColor3 = Color3.new(1, 1, 1)

local function btn(txt, y, act)
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, y, 0)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        DoAction(act, t.Text)
    end)
end

btn("BYPASS KICK", 0.4, "KICK")
btn("BYPASS KICK ALL", 0.6, "KALL")

print("V5 Loaded. Scanning for Remotes...")
