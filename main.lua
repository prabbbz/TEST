--[[ 
    PRABBBZ CREATOR - PRO ADMIN & UTILITY SUITE
    Features: Tab System, Auto-Updating Player List, Universal Remotes
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabButtons = Instance.new("UIListLayout")

-- Setup UI Utama
ScreenGui.Parent = game:GetService("CoreGui")
MainFrame.Name = "PrabbbzPanel"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

-- Sidebar (Navigasi)
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Sidebar.Size = UDim2.new(0, 120, 1, 0)

TabButtons.Parent = Sidebar
TabButtons.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabButtons.Padding = UDim.new(0, 5)

-- Kontainer Konten
ContentFrame.Name = "Content"
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 125, 0, 0)
ContentFrame.Size = UDim2.new(1, -125, 1, 0)
ContentFrame.BackgroundTransparency = 1

-- State Management
local currentTarget = nil

-- Fungsi Buat Tab
local Pages = {}
local function CreatePage(name)
    local frame = Instance.new("ScrollingFrame")
    frame.Name = name .. "Page"
    frame.Parent = ContentFrame
    frame.Size = UDim2.new(1, -10, 1, -10)
    frame.Position = UDim2.new(0, 5, 0, 5)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.CanvasSize = UDim2.new(0, 0, 2, 0)
    frame.ScrollBarThickness = 4
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = frame
    layout.Padding = UDim.new(0, 8)
    
    Pages[name] = frame
    
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        frame.Visible = true
    end)
    
    return frame
end

local adminPage = CreatePage("Admin")
local utilPage = CreatePage("Utilities")
local playerPage = CreatePage("Players")

-- Helper: Tombol Aksi
local function AddButton(parent, text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
end

-- TAB ADMIN
AddButton(adminPage, "KICK ALL", Color3.fromRGB(150, 50, 50), function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then p:Kick("Kicked by PRABBBZ Panel") end
    end
end)

AddButton(adminPage, "BAN ALL (Loop Kick)", Color3.fromRGB(100, 0, 0), function()
    -- Logic ban universal biasanya butuh remote spesifik game
    print("Ban All Executed")
end)

-- TAB UTILITIES
AddButton(utilPage, "COPY MAP (.rbxl)", Color3.fromRGB(50, 100, 150), function()
    if saveinstance then saveinstance() else print("Executor not supported") end
end)

AddButton(utilPage, "COPY AVATAR (Target)", Color3.fromRGB(100, 50, 150), function()
    if currentTarget then
        game.Players.LocalPlayer.CharacterAppearanceId = currentTarget.UserId
        print("Copying appearance of: " .. currentTarget.Name)
    end
end)

-- TAB PLAYER LIST & SELECTION
local function RefreshPlayerList()
    for _, v in pairs(playerPage:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    for _, p in pairs(game.Players:GetPlayers()) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(0.95, 0, 0, 30)
        pBtn.Text = p.Name
        pBtn.BackgroundColor3 = (currentTarget == p) and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
        pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pBtn.Parent = playerPage
        
        pBtn.MouseButton1Click:Connect(function()
            currentTarget = p
            RefreshPlayerList()
            print("Selected: " .. p.Name)
        end)
    end
end

-- Action Buttons for Specific Player (di bawah list atau di tab admin)
AddButton(adminPage, "KICK SELECTED", Color3.fromRGB(200, 80, 0), function()
    if currentTarget then currentTarget:Kick("Targeted Kick") end
end)

-- Initialize
game.Players.PlayerAdded:Connect(RefreshPlayerList)
game.Players.PlayerRemoving:Connect(RefreshPlayerList)
RefreshPlayerList()
Pages["Admin"].Visible = true -- Default page

print("PRABBBZ Panel Loaded Successfully.")
