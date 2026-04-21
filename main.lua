--[[ 
    PRABBBZ MASTER SS v6.0
    Design: Ultra-Clean Obsidian Gradient
]]

local SECRET = "PRABBBZ_KEY_88"
local FoundRemote = nil

-- SCANNER LOGIC
local function Scan()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and v:GetAttribute("PrbzID") == "SUPREME_SS" then
            FoundRemote = v
            return true
        end
    end
    return false
end

-- UI CONSTRUCTION
local UI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 650, 0, 420)
Main.Position = UDim2.new(0.5, -325, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.Active = true
Main.Draggable = true
Main.Visible = false

local MainCorner = Instance.new("UICorner", Main); MainCorner.CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Color3.fromRGB(0, 170, 255); MainStroke.Thickness = 2

-- TOGGLE ICON (PRBZ KOTAK)
local Icon = Instance.new("TextButton", UI)
Icon.Size = UDim2.new(0, 45, 0, 45)
Icon.Position = UDim2.new(0, 20, 0.5, -22)
Icon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Icon.Text = "PRBZ"
Icon.TextColor3 = Color3.fromRGB(0, 170, 255)
Icon.Font = Enum.Font.GothamBold
Icon.Active = true
Icon.Draggable = true
Instance.new("UICorner", Icon)
Instance.new("UIStroke", Icon).Color = Color3.fromRGB(0, 170, 255)

Icon.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, -40)
Sidebar.Position = UDim2.new(0, 10, 0, 30)
Sidebar.BackgroundTransparency = 1
local SList = Instance.new("UIListLayout", Sidebar); SList.Padding = UDim.new(0, 5)

-- CONTENT FRAME
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -170, 1, -60)
Content.Position = UDim2.new(0, 160, 0, 40)
Content.BackgroundTransparency = 1

-- SISTEM TAB
local Tabs = {}
local function NewTab(name)
    local f = Instance.new("ScrollingFrame", Content)
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
    f.ScrollBarThickness = 2
    f.CanvasSize = UDim2.new(0, 0, 0, 0)
    local l = Instance.new("UIListLayout", f); l.Padding = UDim.new(0, 8); l.HorizontalAlignment = 1
    
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, 0, 0, 35)
    b.Text = name; b.BackgroundColor3 = Color3.fromRGB(30, 30, 35); b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        f.Visible = true
    end)
    
    l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        f.CanvasSize = UDim2.new(0, 0, 0, l.AbsoluteContentSize.Y + 10)
    end)
    
    Tabs[name] = f
    return f
end

local GenTab = NewTab("General")
local LibTab = NewTab("Script Library")
local FunTab = NewTab("Fun")

-- SCRIPT LOADER (Mewah)
local function Add(tab, name, code)
    local frame = Instance.new("Frame", tab)
    frame.Size = UDim2.new(0.95, 0, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", frame)
    
    local txt = Instance.new("TextLabel", frame)
    txt.Text = "  " .. name; txt.Size = UDim2.new(0.7, 0, 1, 0); txt.BackgroundTransparency = 1; txt.TextColor3 = Color3.new(1,1,1); txt.TextXAlignment = 0
    
    local exec = Instance.new("TextButton", frame)
    exec.Text = "EXECUTE"; exec.Size = UDim2.new(0.25, 0, 0.7, 0); exec.Position = UDim2.new(0.72, 0, 0.15, 0)
    exec.BackgroundColor3 = Color3.fromRGB(0, 120, 255); exec.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", exec)
    
    exec.MouseButton1Click:Connect(function()
        if FoundRemote then FoundRemote:FireServer(SECRET, code) end
    end)
end

-- DATA: PULUHAN SCRIPT YANG WORK
-- General
Add(GenTab, "BTools", "Instance.new('HopperBin', game.Players.LocalPlayer.Backpack).BinType = 4")
Add(GenTab, "Unlock All Parts", "for _,v in pairs(workspace:GetDescendants()) do if v:IsA('BasePart') then v.Locked = false end end")
Add(GenTab, "Clear Workspace", "workspace:ClearAllChildren()")

-- Library (Contoh script populer dari GitHub/Pastebin)
Add(LibTab, "Infinite Yield SS", "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()")
Add(LibTab, "Dex Explorer SS", "loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()")
Add(LibTab, "Server Crasher", "while true do end")
Add(LibTab, "Kick Others", "for _,p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer then p:Kick('PRBZ SS') end end")

-- Isi puluhan lagi otomatis untuk testing scroll
for i = 1, 30 do
    Add(LibTab, "GitHub Script #" .. i, "print('Running " .. i .. "')")
end

-- Fun
Add(FunTab, "Rainbow Map", "while wait() do game.Lighting.Ambient = Color3.fromHSV(tick()%5/5, 1, 1) end")
Add(FunTab, "Big Head All", "for _,p in pairs(game.Players:GetPlayers()) do p.Character.Head.Size = Vector3.new(10,10,10) end")

-- STARTUP
GenTab.Visible = true
task.spawn(function()
    while not Scan() do task.wait(1) end
    print("Connected!")
end)
