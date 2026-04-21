--[[ 
    MASTER SS PANEL - PRABBBZ CREATOR
    Desain: Cyberpunk Dark Aesthetic
]]

local Lplr = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- 1. MENCARI JEMBATAN (BACKDOOR)
local MasterRemote = nil
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") and (v.Name == "InternalData_Update" or v.Name:lower():find("backdoor")) then
        MasterRemote = v
        break
    end
end

if not MasterRemote then 
    print("No Backdoor Detected. Fitur SS terbatas.") 
end

-- 2. UI CONSTRUCTION (MEWAH)
local UI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- Tambah Glow/Shadow Effect
local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

-- Header dengan Gradasi
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local HeaderCorner = Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel", Header)
Title.Text = "PRABBBZ MASTER SS | v1.0"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(0, 255, 150) -- Neon Green
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- Sidebar Navigasi
local Sidebar = Instance.new("ScrollingFrame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, -45)
Sidebar.Position = UDim2.new(0, 5, 0, 45)
Sidebar.BackgroundTransparency = 1
Sidebar.ScrollBarThickness = 2

local List = Instance.new("UIListLayout", Sidebar)
List.Padding = UDim.new(0, 5)

-- Content Area
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -155, 1, -50)
Content.Position = UDim2.new(0, 150, 0, 45)
Content.BackgroundTransparency = 1

-- FUNGSI RUN SCRIPT SS
local function ExecuteSS(code)
    if MasterRemote then
        MasterRemote:FireServer(code)
    else
        -- Fallback: Coba loadstring standar (biasanya gagal di FE kecuali ada backdoor lain)
        loadstring(code)()
    end
end

-- TAB: SCRIPT LIBRARY (Ratusan Script)
local Library = Instance.new("ScrollingFrame", Content)
Library.Size = UDim2.new(1, 0, 1, 0)
Library.BackgroundTransparency = 1
Library.Visible = true
Library.ScrollBarThickness = 4
local LibList = Instance.new("UIListLayout", Library)

local function AddToLib(name, code)
    local btn = Instance.new("TextButton", Library)
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.Text = "  " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    local c = Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        ExecuteSS(code)
    end)
end

-- CONTOH ISI LIBRARY (Bisa kamu tambah sampai ratusan)
AddToLib("Kill All Players", "for _, p in pairs(game.Players:GetPlayers()) do if p.Character then p.Character:BreakJoints() end end")
AddToLib("Destroy Map", "game.Workspace:ClearAllChildren()")
AddToLib("Btools for Everyone", "for _, p in pairs(game.Players:GetPlayers()) do Instance.new('HopperBin', p.Backpack).BinType = 4 end")
AddToLib("Server Message", "local m = Instance.new('Message', game.Workspace); m.Text = 'Hacked by PRABBBZ'; wait(5); m:Destroy()")
AddToLib("Give All Admin", "require(451231231).Admi(game.Players.LocalPlayer.Name) -- Contoh Module")

-- FITUR: CUSTOM EXECUTION
local CustomExec = Instance.new("TextBox", Content)
CustomExec.Size = UDim2.new(1, 0, 0, 100)
CustomExec.Visible = false
CustomExec.MultiLine = true
CustomExec.Text = "-- Paste SS Code Here"
-- ... (Logika tab switching)

print("Mega SS Panel Loaded. Backdoor Status: " .. (MasterRemote and "CONNECTED" or "NOT FOUND"))
