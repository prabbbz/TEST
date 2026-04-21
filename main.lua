-- [[ PRABBBZ OMNI HUB V8 - FIXED & CLEAN ]] --
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. UI SETUP (CoreGui agar tidak terdeteksi script map)
local sg = Instance.new("ScreenGui")
sg.Name = "OmniHubV8"
sg.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 280, 0, 320)
Main.Position = UDim2.new(0.5, -140, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "PRABBBZ OMNI V8"
Header.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Header.TextColor3 = Color3.new(1, 1, 1)
Header.Font = Enum.Font.GothamBold
Instance.new("UICorner", Header)

-- 2. FUNGSI LOADER (Link Terverifikasi Aktif 2026)
local function SafeLoad(id)
    local success, err = pcall(function()
        if id == "IY" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        elseif id == "CMDX" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"))()
        elseif id == "NAMELESS" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
        elseif id == "FATES" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
        end
    end)
    
    if not success then
        warn("Gagal load script: " .. tostring(err))
    end
end

-- 3. TOMBOL GENERATOR
local function AddBtn(txt, y, id)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        SafeLoad(id)
    end)
end

AddBtn("INFINITE YIELD", 60, "IY")
AddBtn("CMD-X (Full Features)", 115, "CMDX")
AddBtn("NAMELESS ADMIN", 170, "NAMELESS")
AddBtn("FATES ADMIN", 225, "FATES")

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(1, 0, 0, 25)
Close.Position = UDim2.new(0, 0, 0.92, 0)
Close.Text = "CLOSE MENU"
Close.BackgroundTransparency = 1
Close.TextColor3 = Color3.fromRGB(150, 150, 150)
Close.MouseButton1Click:Connect(function() sg:Destroy() end)

print("Omni Hub V8 Loaded Successfully!")
