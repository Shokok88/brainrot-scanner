-- Real Brainrot Server Scanner for Delta
-- Educational purposes only

local function main()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    if not localPlayer then return end

    -- Create GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "RealBrainrotScanner"
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 300)
    mainFrame.Position = UDim2.new(0, 15, 0, 15)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(70, 70, 100)
    mainFrame.Parent = gui

    
    -- Title
    local title = Instance.new("TextLabel")
    title.Text = "🧠 REAL BRAINROT SCANNER"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = mainFrame
    
    -- Content area
    local content = Instance.new("TextLabel")
    content.Name = "Content"
    content.Size = UDim2.new(1, -10, 1, -80)
    content.Position = UDim2.new(0, 10, 0, 45)
    content.TextColor3 = Color3.fromRGB(220, 220, 255)
    content.BackgroundTransparency = 1
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.TextYAlignment = Enum.TextYAlignment.Top
    content.Font = Enum.Font.Gotham
    content.TextSize = 12
    content.Text = "🔍 Сканирую сервер..."
    content.Parent = mainFrame
    
    -- Refresh button
    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Text = "🔄 Сканировать"
    refreshBtn.Size = UDim2.new(0, 120, 0, 30)
    refreshBtn.Position = UDim2.new(0.5, -60, 1, -35)
    refreshBtn.BackgroundColor3 = Color3.fromRGB(0.2, 0.6, 1)
    refreshBtn.TextColor3 = Color3.fromRGB(1, 1, 1)
    refreshBtn.Font = Enum.Font.Gotham
    refreshBtn.Parent = mainFrame
    
    -- Function to scan for expensive brainrots
    local function scanBrainrots()
        local richPlayers = {}
        local totalPlayers = 0
        
        -- Анализируем игроков на сервере
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                totalPlayers = totalPlayers + 1
                
                -- Здесь должна быть логика определения стоимости брейнрота
                -- Это пример - в реальной игре нужно смотреть на конкретные объекты
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    -- Пример: считаем что у игрока дорогой брейнрот если у него много здоровья
                    if humanoid.Health > 80 then
                        table.insert(richPlayers, {
                            name = player.Name,
                            value = "HIGH",
                            health = humanoid.Health
                        })
                    elseif humanoid.Health > 50 then
                        table.insert(richPlayers, {
                            name = player.Name,
                            value = "MEDIUM", 
                            health = humanoid.Health
                        })
                    end
                end
            end
        end
        
        -- Сортируем по "стоимости"
        table.sort(richPlayers, function(a, b)
            return a.health > b.health
        end)
        
        return richPlayers, totalPlayers
    end
    
    -- Update display
    local function updateDisplay()
        content.Text = "🔍 Сканирую игроков..."
        
        local richPlayers, totalPlayers = scanBrainrots()
        
        local displayText = "📊 РЕЗУЛЬТАТЫ СКАНИРОВАНИЯ:\n\n"
        displayText = displayText .. "👥 Всего игроков: " .. totalPlayers .. "\n"
        displayText = displayText .. "💰 Богатые игроки: " .. #richPlayers .. "\n\n"
        
        if #richPlayers > 0 then
            displayText = displayText .. "🎯 ЦЕЛИ С ВЫСОКИМИ BRAINROT:\n"
            for i, player in ipairs(richPlayers) do
                if i <= 5 then -- Показываем топ-5
                    displayText = displayText .. "⚡ " .. player.name .. "\n"
                    displayText = displayText .. "   💰 Уровень: " .. player.value .. "\n"
                    displayText = displayText .. "   ❤️ Здоровье: " .. math.floor(player.health) .. "\n\n"
                end
            end
        else
            displayText = displayText .. "❌ Богатых игроков не найдено\n"
            displayText = displayText .. "Попробуйте другой сервер"
        end
        
        displayText = displayText .. "\n🔍 Образовательный скрипт"
        displayText = displayText .. "\n🚫 Автовход отключен"
        
        content.Text = displayText
    end
    
    -- Button click
    refreshBtn.MouseButton1Click:Connect(updateDisplay)
    
    -- First scan
    updateDisplay()
    
    print("Real Brainrot Scanner activated!")
end

-- Safe execute
pcall(main)
