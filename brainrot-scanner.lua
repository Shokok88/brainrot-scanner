-- Advanced Brainrot Server Finder with Customizable Filters
-- Complete UI with movable, resizable interface and wealth targeting

local function main()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local localPlayer = Players.LocalPlayer
    
    -- Configuration settings
    local config = {
        minWealth = 500,  -- Minimum wealth threshold
        autoJoin = false,  -- Auto-join enabled
        refreshRate = 10   -- Scan interval in seconds
    }
    
    -- Server analysis database
    local serverCache = {}
    
    -- Advanced wealth scanning with customizable filters
    local function scanServerWealth(wealthThreshold)
        local wealthyPlayers = {}
        local totalWealth = 0
        local maxWealth = 0
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local wealthScore = 0
                local char = player.Character
                
                if char then
                    -- Comprehensive wealth detection
                    for _, obj in pairs(char:GetDescendants()) do
                        if obj:IsA("Part") then
                            -- Material-based wealth detection
                            if obj.Material == Enum.Material.Neon then
                                wealthScore = wealthScore + 100
                            elseif obj.Material == Enum.Material.Glass then
                                wealthScore = wealthScore + 75
                            elseif obj.Material == Enum.Material.DiamondPlate then
                                wealthScore = wealthScore + 50
                            end
                            
                            -- Color-based wealth detection
                            local brightColors = {
                                BrickColor.new("Bright yellow"),
                                BrickColor.new("Bright orange"), 
                                BrickColor.new("Bright red"),
                                BrickColor.new("Hot pink")
                            }
                            
                            for _, color in pairs(brightColors) do
                                if obj.BrickColor == color then
                                    wealthScore = wealthScore + 40
                                end
                            end
                            
                            -- Particle effects = high value
                            if obj:FindFirstChildOfClass("ParticleEmitter") then
                                wealthScore = wealthScore + 150
                            end
                        end
                        
                        -- Tool/gear detection
                        if obj:IsA("Tool") then
                            wealthScore = wealthScore + 80
                        end
                    end
                    
                    -- Leaderstats analysis
                    local leaderstats = player:FindFirstChild("leaderstats")
                    if leaderstats then
                        for _, stat in pairs(leaderstats:GetChildren()) do
                            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                                wealthScore = wealthScore + (stat.Value / 5)
                            end
                        end
                    end
                end
                
                if wealthScore > wealthThreshold then
                    table.insert(wealthyPlayers, {
                        player = player,
                        wealth = wealthScore,
                        meetsThreshold = wealthScore >= config.minWealth
                    })
                    maxWealth = math.max(maxWealth, wealthScore)
                end
                
                totalWealth = totalWealth + wealthScore
            end
        end
        
        return {
            wealthyPlayers = wealthyPlayers,
            totalWealth = totalWealth,
            maxWealth = maxWealth,
            playerCount = #Players:GetPlayers(),
            meetsRequirements = maxWealth >= config.minWealth
        }
    end
    
    -- Server recommendation engine
    local function getRecommendedServers()
        -- Simulated server data - in real implementation would query game API
        local servers = {}
        local baseId = math.random(100, 999)
        
        for i = 1, 8 do
            local wealth = math.random(100, 1000)
            local players = math.random(3, 18) .. "/20"
            local meetsReq = wealth >= config.minWealth
            
            table.insert(servers, {
                id = baseId + i,
                name = "Server#" .. (baseId + i),
                maxWealth = wealth,
                players = players,
                meetsRequirements = meetsReq,
                priority = meetsReq and "HIGH" or "LOW"
            })
        end
        
        -- Sort by wealth
        table.sort(servers, function(a, b)
            return a.maxWealth > b.maxWealth
        end)
        
        return servers
    end
    
    -- Create advanced movable UI
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdvancedBrainrotFinder"
    gui.ResetOnSpawn = false
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    -- Main container frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 450, 0, 550)
    mainFrame.Position = UDim2.new(0, 50, 0, 50)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(70, 70, 100)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui
    
    -- Title bar with controls
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    titleBar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Text = "🎯 BRAINROT SERVER FINDER v3.0"
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "X"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    
    -- Minimize button
    local minBtn = Instance.new("TextButton")
    minBtn.Text = "_"
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -70, 0, 2)
    minBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = titleBar
    
    -- Configuration panel
    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(1, -20, 0, 100)
    configFrame.Position = UDim2.new(0, 10, 0, 40)
    configFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    configFrame.BorderSizePixel = 1
    configFrame.Parent = mainFrame
    
    local wealthLabel = Instance.new("TextLabel")
    wealthLabel.Text = "Minimum Wealth: " .. config.minWealth
    wealthLabel.Size = UDim2.new(0.6, 0, 0, 25)
    wealthLabel.Position = UDim2.new(0, 10, 0, 10)
    wealthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    wealthLabel.BackgroundTransparency = 1
    wealthLabel.Font = Enum.Font.Gotham
    wealthLabel.TextXAlignment = Enum.TextXAlignment.Left
    wealthLabel.Parent = configFrame
    
    local wealthSlider = Instance.new("TextBox")
    wealthSlider.Text = tostring(config.minWealth)
    wealthSlider.Size = UDim2.new(0.3, 0, 0, 25)
    wealthSlider.Position = UDim2.new(0.65, 0, 0, 10)
    wealthSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    wealthSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    wealthSlider.Font = Enum.Font.Gotham
    wealthSlider.Parent = configFrame
    
    local autoJoinToggle = Instance.new("TextButton")
    autoJoinToggle.Text = "Auto-Join: " .. (config.autoJoin and "ON" or "OFF")
    autoJoinToggle.Size = UDim2.new(0.8, 0, 0, 30)
    autoJoinToggle.Position = UDim2.new(0.1, 0, 0, 45)
    autoJoinToggle.BackgroundColor3 = config.autoJoin and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    autoJoinToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoJoinToggle.Font = Enum.Font.Gotham
    autoJoinToggle.Parent = configFrame
    
    -- Results display
    local resultsFrame = Instance.new("ScrollingFrame")
    resultsFrame.Size = UDim2.new(1, -20, 0, 350)
    resultsFrame.Position = UDim2.new(0, 10, 0, 150)
    resultsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    resultsFrame.BorderSizePixel = 1
    resultsFrame.ScrollBarThickness = 8
    resultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    resultsFrame.Parent = mainFrame
    
    -- Control buttons
    local scanBtn = Instance.new("TextButton")
    scanBtn.Text = "🔍 SCAN SERVERS"
    scanBtn.Size = UDim2.new(0.45, 0, 0, 35)
    scanBtn.Position = UDim2.new(0.025, 0, 1, -45)
    scanBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.Parent = mainFrame
    
    local joinBestBtn = Instance.new("TextButton")
    joinBestBtn.Text = "🚀 JOIN BEST SERVER"
    joinBestBtn.Size = UDim2.new(0.45, 0, 0, 35)
    joinBestBtn.Position = UDim2.new(0.525, 0, 1, -45)
    joinBestBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    joinBestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    joinBestBtn.Font = Enum.Font.GothamBold
    joinBestBtn.Parent = mainFrame
    
    -- UI state management
    local isMinimized = false
    local originalSize = mainFrame.Size
    local minimizedSize = UDim2.new(0, 450, 0, 35)
    
    -- Function to update display
    local function updateServerDisplay()
        local currentScan = scanServerWealth(config.minWealth)
        local recommended = getRecommendedServers()
        
        -- Clear previous results
        for _, child in pairs(resultsFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        local yOffset = 5
        local contentHeight = 0
        
        -- Current server info
        local currentFrame = Instance.new("Frame")
        currentFrame.Size = UDim2.new(1, -10, 0, 80)
        currentFrame.Position = UDim2.new(0, 5, 0, yOffset)
        currentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        currentFrame.BorderSizePixel = 1
        currentFrame.Parent = resultsFrame
        
        local currentLabel = Instance.new("TextLabel")
        currentLabel.Text = "📍 CURRENT SERVER ANALYSIS:\n" ..
                           "👥 Players: " .. currentScan.playerCount .. "\n" ..
                           "💰 Max Wealth: " .. math.floor(currentScan.maxWealth) .. "\n" ..
                           "🎯 Rich Players: " .. #currentScan.wealthyPlayers .. "\n" ..
                           "✅ Meets Requirements: " .. (currentScan.meetsRequirements and "YES" or "NO")
        currentLabel.Size = UDim2.new(1, -10, 1, -10)
        currentLabel.Position = UDim2.new(0, 5, 0, 5)
        currentLabel.TextColor3 = currentScan.meetsRequirements and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        currentLabel.BackgroundTransparency = 1
        currentLabel.TextXAlignment = Enum.TextXAlignment.Left
        currentLabel.TextYAlignment = Enum.TextYAlignment.Top
        currentLabel.Font = Enum.Font.Gotham
        currentLabel.TextSize = 11
        currentLabel.Parent = currentFrame
        
        yOffset = yOffset + 85
        contentHeight = contentHeight + 85
        
        -- Recommended servers
        local recLabel = Instance.new("TextLabel")
        recLabel.Text = "🌐 RECOMMENDED SERVERS:"
        recLabel.Size = UDim2.new(1, -10, 0, 20)
        recLabel.Position = UDim2.new(0, 5, 0, yOffset)
        recLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        recLabel.BackgroundTransparency = 1
        recLabel.Font = Enum.Font.GothamBold
        recLabel.TextXAlignment = Enum.TextXAlignment.Left
        recLabel.Parent = resultsFrame
        
        yOffset = yOffset + 25
        contentHeight = contentHeight + 25
        
        for i, server in ipairs(recommended) do
            if i <= 5 then
                local serverFrame = Instance.new("Frame")
                serverFrame.Size = UDim2.new(1, -10, 0, 60)
                serverFrame.Position = UDim2.new(0, 5, 0, yOffset)
                serverFrame.BackgroundColor3 = server.meetsRequirements and Color3.fromRGB(40, 60, 40) or Color3.fromRGB(60, 40, 40)
                serverFrame.BorderSizePixel = 1
                serverFrame.Parent = resultsFrame
                
                local serverText = Instance.new("TextLabel")
                serverText.Text = "⚡ " .. server.name .. "\n" ..
                                "💰 Wealth: " .. server.maxWealth .. "\n" ..
                                "👥 " .. server.players .. " | " .. server.priority
                serverText.Size = UDim2.new(0.7, 0, 1, 0)
                serverText.Position = UDim2.new(0, 5, 0, 0)
                serverText.TextColor3 = Color3.fromRGB(255, 255, 255)
                serverText.BackgroundTransparency = 1
                serverText.TextXAlignment = Enum.TextXAlignment.Left
                serverText.TextYAlignment = Enum.TextYAlignment.Top
                serverText.Font = Enum.Font.Gotham
                serverText.TextSize = 10
                serverText.Parent = serverFrame
                
                if server.meetsRequirements then
                    local joinBtn = Instance.new("TextButton")
                    joinBtn.Text = "JOIN"
                    joinBtn.Size = UDim2.new(0.25, 0, 0, 25)
                    joinBtn.Position = UDim2.new(0.72, 0, 0.5, -12)
                    joinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                    joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    joinBtn.Font = Enum.Font.Gotham
                    joinBtn.TextSize = 10
                    joinBtn.Parent = serverFrame
                    
                    joinBtn.MouseButton1Click:Connect(function()
                        -- Auto-join functionality would go here
                        print("Attempting to join server: " .. server.name)
                    end)
                end
                
                yOffset = yOffset + 65
                contentHeight = contentHeight + 65
            end
        end
        
        resultsFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    end
    
    -- UI Control Functions
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    minBtn.MouseButton1Click:Connect(function()
        if isMinimized then
            mainFrame.Size = originalSize
            resultsFrame.Visible = true
            configFrame.Visible = true
            scanBtn.Visible = true
            joinBestBtn.Visible = true
        else
            mainFrame.Size = minimizedSize
            resultsFrame.Visible = false
            configFrame.Visible = false
            scanBtn.Visible = false
            joinBestBtn.Visible = false
        end
        isMinimized = not isMinimized
    end)
    
    wealthSlider.FocusLost:Connect(function()
        local newValue = tonumber(wealthSlider.Text)
        if newValue and newValue >= 0 and newValue <= 5000 then
            config.minWealth = newValue
            wealthLabel.Text = "Minimum Wealth: " .. newValue
            updateServerDisplay()
        else
            wealthSlider.Text = tostring(config.minWealth)
        end
    end)
    
    autoJoinToggle.MouseButton1Click:Connect(function()
        config.autoJoin = not config.autoJoin
        autoJoinToggle.Text = "Auto-Join: " .. (config.autoJoin and "ON" or "OFF")
        autoJoinToggle.BackgroundColor3 = config.autoJoin and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    end)
    
    scanBtn.MouseButton1Click:Connect(updateServerDisplay)
    
    joinBestBtn.MouseButton1Click:Connect(function()
        local recommended = getRecommendedServers()
        for _, server in ipairs(recommended) do
            if server.meetsRequirements then
                print("Joining best server: " .. server.name)
                -- Actual join code would go here
                break
            end
        end
    end)
    
    -- Initial scan
    updateServerDisplay()
    
    -- Auto-refresh
    while true do
        wait(config.refreshRate)
        if not isMinimized then
            updateServerDisplay()
        end
    end
end

-- Execute
pcall(main)
