-- [[ PRABBBZ OMNI ADMIN HUB V7 ]] --
-- Fixed for: Madium, Xeno, Velocity, Solara

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. UI SETUP
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "Prabbbz_OmniHub"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "PRABBBZ OMNI HUB"
Header.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Header.TextColor3 = Color3.new(1, 1, 1)
Header.Font = Enum.Font.GothamBold
Instance.new("UICorner", Header)

-- 2. LIST SCRIPT YANG SUDAH TERBUKTI WORK DI CLIENT
local function LoadScript(name)
    if name == "IY" then
        -- Infinite Yield (Best FE Admin)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    elseif name == "CMD" then
        -- CMD-X (Saingan IY, fitur lebih banyak)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"))()
    elseif name == "REVIZ" then
        -- Reviz Admin (Troll Admin)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mustacheduck/Reviz-Admin-V2/master/revizadminv2.lua"))()
    elseif name == "FATES" then
        -- Fates Admin (UI-nya keren banget)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
    elseif name == "NAM" then
        -- Nameless Admin (Sangat OP buat bypass)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
    end
end

-- 3. TOMBOL GENERATOR
local function AddButton(txt, y, type)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        print("Loading " .. txt .. "...")
        LoadScript(type)
    end)
end

AddButton("INFINITE YIELD", 60, "IY")
AddButton("CMD-X ADMIN", 110, "CMD")
AddButton("FATES ADMIN", 160, "FATES")
AddButton("NAMELESS ADMIN", 210, "NAM")
AddButton("REVIZ ADMIN", 260, "REVIZ")

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(1, 0, 0, 20)
Close.Position = UDim2.new(0, 0, 1, 0)
Close.Text = "CLOSE"
Close.BackgroundTransparency = 1
Close.TextColor3 = Color3.new(0.6, 0.6, 0.6)
Close.MouseButton1Click:Connect(function() sg:Destroy() end)
