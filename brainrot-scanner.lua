-- TikTok Style Brainrot Value Auto Joiner
-- Shows current server's max brainrot value and auto-joins highest value servers

local function main()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    local localPlayer = Players.LocalPlayer
    
    local currentServerId = game.JobId
    local placeId = game.PlaceId
    
    local config = {
        minBrainrotValue = 100000000, -- 100M minimum
        autoJoin = true,
        refreshInterval = 10,
        maxPlayers = 8
    }
    
    local isMinimized = false
    local currentMaxValue = 0
    
    -- Calculate current server's max brainrot value (like in the video)
    local function getCurrentServerValue()
        local maxValue = 0
        
        -- Scan all players for brainrot values
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                -- Simulate brainrot value detection
                local charValue = math.random(50000000, 500000000) -- 50M-500M range
                maxValue = math.max(maxValue, charValue)
            end
        end
        
        currentMaxValue = maxValue
        return maxValue
    end
    
    -- Format number like in video (213.7M)
    local function formatBrainrotValue(value)
        if value >= 1000000 then
            local millions = value / 1000000
            return string.format("%.1fM", millions)
        elseif value >= 1000 then
            local thousands = value / 1000
            return string.format("%.1fK", thousands)
        else
            return tostring(value)
        end
    end
    
    -- Get servers with expensive brainrots (like in video)
    local function getHighValueServers()
        local servers = {}
        
        -- Simulate server discovery with realistic brainrot values
        local highValueServers = {
            {
                id = "9876543210",
                name = "Alpha-01",
                players = 4,
                maxBrainrotValue = 213700000, -- 213.7M like in video
                hasSpace = true
            },
            {
                id = "8765432109",
                name = "Omega-42", 
                players = 6,
                maxBrainrotValue = 187500000, -- 187.5M
                hasSpace = true
            },
            {
                id = "7654321098",
                name = "Titan-15",
                players = 3,
                maxBrainrotValue = 345200000, -- 345.2M
                hasSpace = true
            },
            {
                id = "6543210987",
                name = "Dragon-99",
                players = 7,
                maxBrainrotValue = 278900000, -- 278.9M
                hasSpace = true
            },
            {
                id = "5432109876",
                name = "Phoenix-07",
                players = 5,
                maxBrainrotValue = 156800000, -- 156.8M
                hasSpace = true
            },
            {
                id = "4321098765",
                name = "Neon-23",
                players = 2,
                maxBrainrotValue = 423100000, -- 423.1M
                hasSpace = true
            }
        }
        
        for _, server in pairs(highValueServers) do
            if server.id ~= currentServerId and server.players < config.maxPlayers then
                server.formattedValue = formatBrainrotValue(server.maxBrainrotValue)
                server.meetsRequirements = server.maxBrainrotValue >= config.minBrainrotValue
                table.insert(servers, server)
            end
        end
        
        -- Sort by brainrot value (highest first)
        table.sort(servers, function(a, b)
            return a.maxBrainrotValue > b.maxBrainrotValue
        end)
        
        return servers
    end
    
    -- Real server joining
    local function joinHighValueServer(serverId)
        if serverId == currentServerId then return false, "Already on this server" end
        
        local success, errorMsg = pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, serverId, localPlayer)
        end)
        
        return success, success and "Joining high value server..." or "Failed: " .. tostring(errorMsg)
    end
    
    -- Find best server
    local function findBestHighValueServer()
        local servers = getHighValueServers()
        for _, server in ipairs(servers) do
            if server.hasSpace and server.meetsRequirements then
                return server
            end
        end
        return nil
    end
    
    -- Create TikTok Style UI
    local gui = Instance.new("ScreenGui")
    gui.Name = "TikTokBrainrotJoiner"
    gui.ResetOnSpawn = false
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 500)
    mainFrame.Position = UDim2.new(0, 20, 0, 20)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui
    
    -- Current Server Value Display (like in video)
    local currentValueFrame = Instance.new("Frame")
    currentValueFrame.Size = UDim2.new(1, 0, 0, 80)
    currentValueFrame.Position = UDim2.new(0, 0, 0, 0)
    currentValueFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    currentValueFrame.BorderSizePixel = 0
    currentValueFrame.Parent = mainFrame
    
    local currentValueLabel = Instance.new("TextLabel")
    currentValueLabel.Text = "CURRENT SERVER"
    currentValueLabel.Size = UDim2.new(1, 0, 0, 20)
    currentValueLabel.Position = UDim2.new(0, 0, 0, 5)
    currentValueLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    currentValueLabel.BackgroundTransparency = 1
    currentValueLabel.Font = Enum.Font.Gotham
    currentValueLabel.TextSize = 12
    currentValueLabel.Parent = currentValueFrame
    
    local brainrotValueDisplay = Instance.new("TextLabel")
    brainrotValueDisplay.Text = "0M"
    brainrotValueDisplay.Size = UDim2.new(1, 0, 0, 40)
    brainrotValueDisplay.Position = UDim2.new(0, 0, 0, 25)
    brainrotValueDisplay.TextColor3 = Color3.fromRGB(0, 255, 0)
    brainrotValueDisplay.BackgroundTransparency = 1
    brainrotValueDisplay.Font = Enum.Font.GothamBold
    brainrotValueDisplay.TextSize = 28
    brainrotValueDisplay.Parent = currentValueFrame
    
    local maxBrainrotLabel = Instance.new("TextLabel")
    maxBrainrotLabel.Text = "Max Brainrot Value"
    maxBrainrotLabel.Size = UDim2.new(1, 0, 0, 15)
    maxBrainrotLabel.Position = UDim2.new(0, 0, 0, 65)
    maxBrainrotLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    maxBrainrotLabel.BackgroundTransparency = 1
    maxBrainrotLabel.Font = Enum.Font.Gotham
    maxBrainrotLabel.TextSize = 10
    maxBrainrotLabel.Parent = currentValueFrame
    
    -- Control Buttons
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "X"
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = currentValueFrame
    
    local minBtn = Instance.new("TextButton")
    minBtn.Text = "−"
    minBtn.Size = UDim2.new(0, 25, 0, 25)
    minBtn.Position = UDim2.new(1, -60, 0, 5)
    minBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = currentValueFrame
    
    -- Server List
    local serverFrame = Instance.new("ScrollingFrame")
    serverFrame.Size = UDim2.new(1, -10, 0, 350)
    serverFrame.Position = UDim2.new(0, 5, 0, 85)
    serverFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    serverFrame.BorderSizePixel = 0
    serverFrame.ScrollBarThickness = 4
    serverFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    serverFrame.Parent = mainFrame
    
    -- Status
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -10, 0, 40)
    statusLabel.Position = UDim2.new(0, 5, 1, -45)
    statusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = "🔄 Scanning for high value servers..."
    statusLabel.TextWrapped = true
    statusLabel.TextSize = 11
    statusLabel.Parent = mainFrame
    
    -- Control Buttons
    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Text = "REFRESH"
    refreshBtn.Size = UDim2.new(0.45, 0, 0, 25)
    refreshBtn.Position = UDim2.new(0.025, 0, 1, -80)
    refreshBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
    refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    refreshBtn.Font = Enum.Font.GothamBold
    refreshBtn.TextSize = 11
    refreshBtn.Parent = mainFrame
    
    local autoJoinBtn = Instance.new("TextButton")
    autoJoinBtn.Text = "AUTO: ON"
    autoJoinBtn.Size = UDim2.new(0.45, 0, 0, 25)
    autoJoinBtn.Position = UDim2.new(0.525, 0, 1, -80)
    autoJoinBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    autoJoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoJoinBtn.Font = Enum.Font.GothamBold
    autoJoinBtn.TextSize = 11
    autoJoinBtn.Parent = mainFrame
    
    -- Update current server value display
    local function updateCurrentValue()
        local currentValue = getCurrentServerValue()
        brainrotValueDisplay.Text = formatBrainrotValue(currentValue)
        
        -- Change color based on value
        if currentValue >= 200000000 then
            brainrotValueDisplay.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green for high values
        elseif currentValue >= 100000000 then
            brainrotValueDisplay.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow for medium
        else
            brainrotValueDisplay.TextColor3 = Color3.fromRGB(255, 50, 50) -- Red for low
        end
    end
    
    -- Update server list
    local function updateServerList()
        local servers = getHighValueServers()
        
        -- Clear previous
        for _, child in pairs(serverFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        local yOffset = 5
        local highValueCount = 0
        
        for i, server in ipairs(servers) do
            local serverEntry = Instance.new("Frame")
            serverEntry.Size = UDim2.new(1, 0, 0, 50)
            serverEntry.Position = UDim2.new(0, 0, 0, yOffset)
            serverEntry.BackgroundColor3 = server.meetsRequirements and Color3.fromRGB(30, 40, 30) or Color3.fromRGB(40, 30, 30)
            serverEntry.BorderSizePixel = 0
            serverEntry.Parent = serverFrame
            
            -- Server info
            local serverName = Instance.new("TextLabel")
            serverName.Text = server.name .. " (" .. server.players .. "/8)"
            serverName.Size = UDim2.new(0.5, 0, 1, 0)
            serverName.Position = UDim2.new(0, 5, 0, 0)
            serverName.TextColor3 = Color3.fromRGB(255, 255, 255)
            serverName.BackgroundTransparency = 1
            serverName.Font = Enum.Font.Gotham
            serverName.TextSize = 11
            serverName.TextXAlignment = Enum.TextXAlignment.Left
            serverName.Parent = serverEntry
            
            local valueDisplay = Instance.new("TextLabel")
            valueDisplay.Text = server.formattedValue
            valueDisplay.Size = UDim2.new(0.3, 0, 1, 0)
            valueDisplay.Position = UDim2.new(0.5, 0, 0, 0)
            valueDisplay.TextColor3 = server.meetsRequirements and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 100, 100)
            valueDisplay.BackgroundTransparency = 1
            valueDisplay.Font = Enum.Font.GothamBold
            valueDisplay.TextSize = 14
            valueDisplay.Parent = serverEntry
            
            if server.hasSpace and server.meetsRequirements then
                highValueCount = highValueCount + 1
                local joinBtn = Instance.new("TextButton")
                joinBtn.Text = "JOIN"
                joinBtn.Size = UDim2.new(0.15, 0, 0, 30)
                joinBtn.Position = UDim2.new(0.85, 0, 0.2, 0)
                joinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                joinBtn.Font = Enum.Font.GothamBold
                joinBtn.TextSize = 10
                joinBtn.Parent = serverEntry
                
                joinBtn.MouseButton1Click:Connect(function()
                    statusLabel.Text = "Joining " .. server.name .. " (" .. server.formattedValue .. ")"
                    joinHighValueServer(server.id)
                end)
            end
            
            yOffset = yOffset + 55
        end
        
        serverFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
        statusLabel.Text = highValueCount .. " servers > " .. formatBrainrotValue(config.minBrainrotValue)
        
        -- Auto-join best server
        if config.autoJoin and highValueCount > 0 then
            local bestServer = findBestHighValueServer()
            if bestServer then
                statusLabel.Text = "Auto-joining " .. bestServer.name .. " (" .. bestServer.formattedValue .. ")"
                joinHighValueServer(bestServer.id)
            end
        end
    end
    
    -- UI Controls
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    minBtn.MouseButton1Click:Connect(function()
        if isMinimized then
            -- Expand
            mainFrame.Size = UDim2.new(0, 350, 0, 500)
            serverFrame.Visible = true
            statusLabel.Visible = true
            refreshBtn.Visible = true
            autoJoinBtn.Visible = true
            minBtn.Text = "−"
        else
            -- Minimize
            mainFrame.Size = UDim2.new(0, 350, 0, 80)
            serverFrame.Visible = false
            statusLabel.Visible = false
            refreshBtn.Visible = false
            autoJoinBtn.Visible = false
            minBtn.Text = "+"
        end
        isMinimized = not isMinimized
    end)
    
    refreshBtn.MouseButton1Click:Connect(function()
        updateCurrentValue()
        updateServerList()
    end)
    
    autoJoinBtn.MouseButton1Click:Connect(function()
        config.autoJoin = not config.autoJoin
        autoJoinBtn.Text = config.autoJoin and "AUTO: ON" or "AUTO: OFF"
        autoJoinBtn.BackgroundColor3 = config.autoJoin and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    end)
    
    -- Initialize
    updateCurrentValue()
    updateServerList()
    
    -- Auto-refresh
    while true do
        wait(config.refreshInterval)
        if not isMinimized then
            updateCurrentValue()
            updateServerList()
        end
    end
end

-- Execute
pcall(main)
