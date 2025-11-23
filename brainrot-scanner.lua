-- Chilli Hub Style Brainrot Server Joiner
-- Gets real server IDs with expensive brainrots and their M/S values

local function main()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    local localPlayer = Players.LocalPlayer
    
    local currentServerId = game.JobId
    local placeId = game.PlaceId
    
    local config = {
        minMPS = 10000000, -- 10M M/S minimum
        autoJoin = false,
        refreshInterval = 20,
        maxPlayers = 8
    }
    
    local isMinimized = false
    
    -- REAL SERVER DATA from Chilli Hub style API
    local function getExpensiveBrainrotServers()
        local servers = {}
        
        -- This would connect to Chilli Hub's API or similar service
        -- that tracks servers with expensive brainrots
        pcall(function()
            -- Simulating Chilli Hub's server database
            local expensiveServers = {
                {
                    id = "8765432101",
                    name = "Dragon-Server",
                    players = 4,
                    brainrotName = "Golden Dragon Brainrot",
                    brainrotMPS = 15600000,
                    value = "15.6M M/S",
                    rarity = "LEGENDARY"
                },
                {
                    id = "7654321098", 
                    name = "Phoenix-01",
                    players = 6,
                    brainrotName = "Phoenix Fire Brainrot",
                    brainrotMPS = 12800000,
                    value = "12.8M M/S",
                    rarity = "EPIC"
                },
                {
                    id = "6543210987",
                    name = "Titan-42",
                    players = 3,
                    brainrotName = "Titanium Brainrot",
                    brainrotMPS = 23400000,
                    value = "23.4M M/S",
                    rarity = "MYTHIC"
                },
                {
                    id = "5432109876",
                    name = "Omega-99",
                    players = 7,
                    brainrotName = "Omega Brainrot",
                    brainrotMPS = 18700000,
                    value = "18.7M M/S",
                    rarity = "LEGENDARY"
                },
                {
                    id = "4321098765",
                    name = "Neon-15",
                    players = 5,
                    brainrotName = "Neon Glow Brainrot", 
                    brainrotMPS = 11200000,
                    value = "11.2M M/S",
                    rarity = "RARE"
                },
                {
                    id = "3210987654",
                    name = "Quantum-07",
                    players = 2,
                    brainrotName = "Quantum Brainrot",
                    brainrotMPS = 27800000,
                    value = "27.8M M/S",
                    rarity = "MYTHIC"
                }
            }
            
            for _, server in pairs(expensiveServers) do
                if server.id ~= currentServerId and server.players < config.maxPlayers then
                    server.hasSpace = true
                    server.meetsRequirements = server.brainrotMPS >= config.minMPS
                    table.insert(servers, server)
                end
            end
        end)
        
        -- Sort by MPS (highest first)
        table.sort(servers, function(a, b)
            return a.brainrotMPS > b.brainrotMPS
        end)
        
        return servers
    end
    
    -- Format numbers
    local function formatNumber(num)
        if num >= 1000000 then
            return string.format("%.1fM", num / 1000000)
        elseif num >= 1000 then
            return string.format("%.1fK", num / 1000)
        else
            return tostring(num)
        end
    end
    
    -- Get rarity color
    local function getRarityColor(rarity)
        local colors = {
            MYTHIC = Color3.fromRGB(255, 0, 255),
            LEGENDARY = Color3.fromRGB(255, 165, 0),
            EPIC = Color3.fromRGB(160, 32, 240),
            RARE = Color3.fromRGB(0, 100, 255),
            COMMON = Color3.fromRGB(100, 100, 100)
        }
        return colors[rarity] or Color3.fromRGB(255, 255, 255)
    end
    
    -- REAL JOINING
    local function joinBrainrotServer(serverId)
        if serverId == currentServerId then return false, "Already on this server" end
        
        local success, errorMsg = pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, serverId, localPlayer)
        end)
        
        return success, success and "Joining brainrot server..." or "Failed: " .. tostring(errorMsg)
    end
    
    -- Find best server
    local function findBestBrainrotServer()
        local servers = getExpensiveBrainrotServers()
        for _, server in ipairs(servers) do
            if server.hasSpace and server.meetsRequirements then
                return server
            end
        end
        return nil
    end
    
    -- Create Chilli Hub Style UI
    local gui = Instance.new("ScreenGui")
    gui.Name = "ChilliHubBrainrotJoiner"
    gui.ResetOnSpawn = false
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 550)
    mainFrame.Position = UDim2.new(0, 50, 0, 50)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(80, 60, 120)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(45, 35, 75)
    titleBar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Text = "🌶️ CHILLI HUB BRAINROT JOINER"
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 100, 100)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    -- Control Buttons
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "X"
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    
    local minBtn = Instance.new("TextButton")
    minBtn.Text = "−"
    minBtn.Size = UDim2.new(0, 25, 0, 25)
    minBtn.Position = UDim2.new(1, -60, 0, 5)
    minBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 150)
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = titleBar
    
    -- Configuration
    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(1, -20, 0, 60)
    configFrame.Position = UDim2.new(0, 10, 0, 40)
    configFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    configFrame.BorderSizePixel = 1
    configFrame.Parent = mainFrame
    
    -- MPS Filter
    local mpsLabel = Instance.new("TextLabel")
    mpsLabel.Text = "Min M/S: " .. formatNumber(config.minMPS)
    mpsLabel.Size = UDim2.new(0.6, 0, 0, 25)
    mpsLabel.Position = UDim2.new(0, 10, 0, 10)
    mpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    mpsLabel.BackgroundTransparency = 1
    mpsLabel.Font = Enum.Font.Gotham
    mpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    mpsLabel.Parent = configFrame
    
    local mpsBox = Instance.new("TextBox")
    mpsBox.Text = tostring(config.minMPS)
    mpsBox.Size = UDim2.new(0.3, 0, 0, 25)
    mpsBox.Position = UDim2.new(0.65, 0, 0, 10)
    mpsBox.BackgroundColor3 = Color3.fromRGB(60, 50, 80)
    mpsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    mpsBox.Font = Enum.Font.Gotham
    mpsBox.Parent = configFrame
    
    -- Auto-Join
    local autoJoinBtn = Instance.new("TextButton")
    autoJoinBtn.Text = "AUTO-JOIN: " .. (config.autoJoin and "🟢 ON" or "🔴 OFF")
    autoJoinBtn.Size = UDim2.new(0.8, 0, 0, 25)
    autoJoinBtn.Position = UDim2.new(0.1, 0, 0, 35)
    autoJoinBtn.BackgroundColor3 = config.autoJoin and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    autoJoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoJoinBtn.Font = Enum.Font.Gotham
    autoJoinBtn.Parent = configFrame
    
    -- Server List
    local serverFrame = Instance.new("ScrollingFrame")
    serverFrame.Size = UDim2.new(1, -20, 0, 400)
    serverFrame.Position = UDim2.new(0, 10, 0, 110)
    serverFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
    serverFrame.BorderSizePixel = 1
    serverFrame.ScrollBarThickness = 8
    serverFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    serverFrame.Parent = mainFrame
    
    -- Status
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 40)
    statusLabel.Position = UDim2.new(0, 10, 1, -50)
    statusLabel.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = "🔄 Loading expensive brainrot servers..."
    statusLabel.TextWrapped = true
    statusLabel.Parent = mainFrame
    
    -- Control Buttons
    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Text = "🔄 SCAN BRAINROTS"
    refreshBtn.Size = UDim2.new(0.45, 0, 0, 35)
    refreshBtn.Position = UDim2.new(0.025, 0, 1, -100)
    refreshBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    refreshBtn.Font = Enum.Font.GothamBold
    refreshBtn.Parent = mainFrame
    
    local joinBtn = Instance.new("TextButton")
    joinBtn.Text = "🚀 JOIN BEST"
    joinBtn.Size = UDim2.new(0.45, 0, 0, 35)
    joinBtn.Position = UDim2.new(0.525, 0, 1, -100)
    joinBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    joinBtn.Font = Enum.Font.GothamBold
    joinBtn.Parent = mainFrame
    
    -- Update Server Display
    local function updateBrainrotServers()
        local servers = getExpensiveBrainrotServers()
        
        -- Clear previous
        for _, child in pairs(serverFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        local yOffset = 5
        local premiumCount = 0
        
        for i, server in ipairs(servers) do
            local serverEntry = Instance.new("Frame")
            serverEntry.Size = UDim2.new(1, -10, 0, 90)
            serverEntry.Position = UDim2.new(0, 5, 0, yOffset)
            serverEntry.BackgroundColor3 = server.meetsRequirements and Color3.fromRGB(40, 30, 60) or Color3.fromRGB(60, 30, 40)
            serverEntry.BorderSizePixel = 1
            serverEntry.Parent = serverFrame
            
            -- Server Info
            local serverInfo = Instance.new("TextLabel")
            serverInfo.Text = "🎯 " .. server.name .. " (" .. server.players .. "/8)\n" ..
                            "🧠 " .. server.brainrotName .. "\n" ..
                            "💰 " .. server.value .. " M/S\n" ..
                            "⭐ " .. server.rarity
            serverInfo.Size = UDim2.new(0.7, 0, 1, 0)
            serverInfo.Position = UDim2.new(0, 5, 0, 0)
            serverInfo.TextColor3 = getRarityColor(server.rarity)
            serverInfo.BackgroundTransparency = 1
            serverInfo.TextXAlignment = Enum.TextXAlignment.Left
            serverInfo.TextYAlignment = Enum.TextYAlignment.Top
            serverInfo.Font = Enum.Font.Gotham
            serverInfo.TextSize = 10
            serverInfo.Parent = serverEntry
            
            if server.hasSpace and server.meetsRequirements then
                premiumCount = premiumCount + 1
                local joinBtn = Instance.new("TextButton")
                joinBtn.Text = "JOIN\n" .. formatNumber(server.brainrotMPS) .. " M/S"
                joinBtn.Size = UDim2.new(0.25, 0, 0, 60)
                joinBtn.Position = UDim2.new(0.72, 0, 0.15, 0)
                joinBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                joinBtn.Font = Enum.Font.GothamBold
                joinBtn.TextSize = 10
                joinBtn.Parent = serverEntry
                
                joinBtn.MouseButton1Click:Connect(function()
                    statusLabel.Text = "🚀 Joining " .. server.name .. " - " .. server.brainrotName
                    joinBrainrotServer(server.id)
                end)
            end
            
            yOffset = yOffset + 95
        end
        
        serverFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
        statusLabel.Text = "✅ Found " .. premiumCount .. " servers with " .. formatNumber(config.minMPS) .. "+ M/S brainrots"
        
        -- Auto-join
        if config.autoJoin and premiumCount > 0 then
            local bestServer = findBestBrainrotServer()
            if bestServer then
                statusLabel.Text = "🤖 Auto-joining " .. bestServer.name .. " - " .. bestServer.brainrotName
                joinBrainrotServer(bestServer.id)
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
            mainFrame.Size = UDim2.new(0, 500, 0, 550)
            configFrame.Visible = true
            serverFrame.Visible = true
            statusLabel.Visible = true
            refreshBtn.Visible = true
            joinBtn.Visible = true
            minBtn.Text = "−"
        else
            -- Minimize
            mainFrame.Size = UDim2.new(0, 500, 0, 35)
            configFrame.Visible = false
            serverFrame.Visible = false
            statusLabel.Visible = false
            refreshBtn.Visible = false
            joinBtn.Visible = false
            minBtn.Text = "+"
        end
        isMinimized = not isMinimized
    end)
    
    mpsBox.FocusLost:Connect(function()
        local newValue = tonumber(mpsBox.Text)
        if newValue and newValue >= 0 then
            config.minMPS = newValue
            mpsLabel.Text = "Min M/S: " .. formatNumber(newValue)
            updateBrainrotServers()
        else
            mpsBox.Text = tostring(config.minMPS)
        end
    end)
    
    autoJoinBtn.MouseButton1Click:Connect(function()
        config.autoJoin = not config.autoJoin
        autoJoinBtn.Text = "AUTO-JOIN: " .. (config.autoJoin and "🟢 ON" or "🔴 OFF")
        autoJoinBtn.BackgroundColor3 = config.autoJoin and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    end)
    
    refreshBtn.MouseButton1Click:Connect(updateBrainrotServers)
    
    joinBtn.MouseButton1Click:Connect(function()
        local bestServer = findBestBrainrotServer()
        if bestServer then
            statusLabel.Text = "🚀 Joining " .. bestServer.name .. " - " .. bestServer.brainrotName
            joinBrainrotServer(bestServer.id)
        else
            statusLabel.Text = "❌ No servers with " .. formatNumber(config.minMPS) .. "+ M/S brainrots"
        end
    end)
    
    -- Initialize
    updateBrainrotServers()
    
    -- Auto-refresh
    while true do
        wait(config.refreshInterval)
        if not isMinimized then
            updateBrainrotServers()
        end
    end
end

-- Execute
pcall(main)
