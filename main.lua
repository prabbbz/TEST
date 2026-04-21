--[[ 
    PRABBBZ CREATOR - Admin Utility Interface
    Catatan: Fungsi Kick/Ban hanya bekerja jika game memiliki 
    RemoteEvent yang terekspos tanpa pengecekan sisi server.
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local Title = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

-- Setup UI Dasar
ScreenGui.Parent = game:GetService("CoreGui") -- Biar ga hilang pas reset
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ADMIN PANEL - PRABBBZ"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Position = UDim2.new(0, 0, 0, 45)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)

UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi Helper untuk mencari Remote
local function FireServerAction(action, target)
    -- Mencoba mencari RemoteEvent yang mungkin bisa dieksploitasi
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("admin") or v.Name:lower():find("kick")) then
            v:FireServer(action, target)
        end
    end
end

-- Template Tombol
local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(callback)
end

-- FITUR: KICK & BAN
CreateButton("Kick All Players", function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            FireServerAction("kick", p)
        end
    end
end)

CreateButton("Ban All (Shadow)", function()
    -- Simulasi Ban dengan loop kick
    FireServerAction("ban", "all")
end)

-- FITUR: COPY MAP (Local Save)
CreateButton("Copy Map (SaveInstance)", function()
    -- Catatan: Executor level tinggi biasanya punya fungsi 'saveinstance()'
    if saveinstance then
        saveinstance()
        print("Map saved to workspace folder!")
    else
        print("Executor kamu tidak support saveinstance.")
    end
end)

-- FITUR: COPY AVATAR (Non-Visual / Real)
CreateButton("Copy Targeted Avatar", function()
    local targetName = "PlayerNameDisini" -- Bisa dikembangkan dengan TextBox
    local target = game.Players:FindFirstChild(targetName)
    if target and target.Character then
        local lplr = game.Players.LocalPlayer
        lplr.CharacterAppearanceId = target.UserId
        -- Refresh character untuk apply (hanya bekerja di beberapa game)
    end
end)

print("Panel Loaded.")
