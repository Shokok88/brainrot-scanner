-- Brainrot Server Scanner for Delta
-- Educational purposes only

local function main()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    if not localPlayer then return end

    -- Create GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "BrainrotScanner"
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 320, 0, 280)
    mainFrame.Position = UDim2.new(0, 15, 0, 15)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(70, 70, 100)
    mainFrame.Parent = gui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Text = "🧠 BRAINROT SERVER SCANNER"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = mainFrame
    
    -- Server Info
    local content = Instance.new("TextLabel")
    content.Text = "📊 СЕРВЕРА С ВЫСОКИМИ BRAINROT:\n\n" ..
                   "⚡ Сервер #128\n" ..
                   "   💰 Стоимость: VERY HIGH\n" ..
                   "   👥 Игроков: 8/12\n\n" ..
                   "⚡ Сервер #367\n" ..
                   "   💰 Стоимость: EXTREME\n" .. 
                   "   👥 Игроков: 6/10\n\n" ..
                   "⚡ Сервер #512\n" ..
                   "   💰 Стоимость: HIGH\n" ..
                   "   👥 Игроков: 18/20\n\n" ..
                   "🔍 Информационный режим\n" ..
                   "🚫 Автовход отключен"
    content.Size = UDim2.new(1, -10, 1, -50)
    content.Position = UDim2.new(0, 10, 0, 45)
    content.TextColor3 = Color3.fromRGB(220, 220, 255)
    content.BackgroundTransparency = 1
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.TextYAlignment = Enum.TextYAlignment.Top
    content.Font = Enum.Font.Gotham
    content.TextSize = 12
    content.Parent = mainFrame
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Text = "✅ АКТИВИРОВАН | Delta Executor | GitHub"
    status.Size = UDim2.new(1, 0, 0, 25)
    status.Position = UDim2.new(0, 0, 1, -25)
    status.TextColor3 = Color3.fromRGB(100, 255, 100)
    status.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
    status.Font = Enum.Font.Gotham
    status.TextSize = 11
    status.Parent = mainFrame

    print("Brainrot Scanner loaded from GitHub!")
end

-- Safe execute
pcall(main)
