-- [[ PRABBBZ UNIVERSAL ADMIN WRAPPER ]] --
-- Support: Madium, Xeno, Velocity, Solara, etc.

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. UI Library (Simple & Clean)
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "Prabbbz_Admin_Hub"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 350, 0, 400)
Main.Position = UDim2.new(0.5, -175, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "PRABBBZ OMNI ADMIN HUB"
Header.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Header.TextColor3 = Color3.new(1, 1, 1)
Header.Font = Enum.Font.GothamBold
Instance.new("UICorner", Header)

-- 2. Fungsi Load Admin Terkenal (Wrapper)
local function LoadAdmin(name)
    if name == "InfiniteYield" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    elseif name == "Adonis" then
        -- Versi Client-Side Simulated Adonis
        loadstring(game:HttpGet("https://raw.githubusercontent.com/pilled/adonis/main/client.lua"))()
    elseif name == "HDAdmin" then
        -- HD Admin biasanya butuh server, ini versi wrapper untuk command visual
        print("Loading HD Admin Wrapper...")
        -- (Biasanya pakai CMDX atau sejenisnya)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Binary-Eater/HD-Admin-Client/main/source.lua"))()
    elseif name == "Reviz" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mustacheduck/Reviz-Admin-V2/master/revizadminv2.lua"))()
    end
end

-- 3. Tombol-Tombol Menu
local function CreateButton(txt, y, adminType)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.Text = "LOAD " .. txt
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        LoadAdmin(adminType)
    end)
end

CreateButton("INFINITE YIELD (Best FE)", 60, "InfiniteYield")
CreateButton("ADONIS (Client Version)", 120, "Adonis")
CreateButton("REVIZ ADMIN (Troll)", 180, "Reviz")
CreateButton("HD ADMIN WRAPPER", 240, "HDAdmin")

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0.9, 0, 0, 30)
Close.Position = UDim2.new(0.05, 0, 0, 350)
Close.Text = "CLOSE"
Close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.MouseButton1Click:Connect(function() sg:Destroy() end)
