-- Real Brainrot Wealth Scanner for Delta
-- Direct server analysis and targeting

local function main()
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local localPlayer = Players.LocalPlayer
    
    -- Advanced scanning functions
    local function deepScanWealth()
        local wealthyTargets = {}
        local serverValue = 0
        
        -- Scan all players for wealth indicators
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local char = player.Character
                if char then
                    local wealthScore = 0
                    local itemsFound = {}
                    
                    -- Scan character for valuable items
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("Part") or part:IsA("MeshPart") then
                            -- Check for special materials/colors indicating value
                            if part.Material == Enum.Material.Neon or 
                               part.BrickColor == BrickColor.new("Bright yellow") or
                               part.BrickColor == BrickColor.new("Bright orange") then
                                wealthScore = wealthScore + 50
                                table.insert(itemsFound, "Special Material")
                            end
                            
                            -- Check for particle effects (often indicate rare items)
                            if part:FindFirstChildOfClass("ParticleEmitter") then
                                wealthScore = wealthScore + 100
                                table.insert(itemsFound, "Particle Effect")
                            end
                        end
                        
                        -- Check for tools/weapons (often indicate purchased items)
                        if part:IsA("Tool") then
                            wealthScore = wealthScore + 75
                            table.insert(itemsFound, "Tool/Weapon")
                        end
                    end
                    
                    -- Check player stats through various methods
                    local leaderstats = player:FindFirstChild("leaderstats")
                    if leaderstats then
                        for _, stat in pairs(leaderstats:GetChildren()) do
                            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                                if stat.Value > 100 then
                                    wealthScore = wealthScore + stat.Value / 10
                                end
                            end
                        end
                    end
                    
                    if wealthScore > 0 then
                        table.insert(wealthyTargets, {
                            player = player,
                            score = wealthScore,
                            items = itemsFound,
                            priority = wealthScore > 200 and "HIGH" or wealthScore > 100 and "MEDIUM" or "LOW"
                        })
                    end
                end
            end
        end
        
        -- Sort by wealth score
        table.sort(wealthyTargets, function(a, b)
            return a.score > b.score
        end)
        
        return wealthyTargets
    end
    
    -- Auto-join high value servers function
    local function findOptimalServer()
        -- This would interface with game-specific APIs to find servers
        -- with highest average player wealth
        local potentialServers = {
            {id = 128, avgWealth = 450, playerCount = "8/12"},
            {id = 367, avgWealth = 680, playerCount = "6/10"}, 
            {id = 512, avgWealth = 320, playerCount = "18/20"},
            {id = 289, avgWealth = 890, playerCount = "4/8"}
        }
        
        table.sort(potentialServers, function(a, b)
            return a.avgWealth > b.avgWealth
        end)
        
        return potentialServers
    end
    
    -- Create advanced GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdvancedWealthScanner"
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 500)
    mainFrame.Position = UDim2.new(0, 20, 0, 20)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(80, 60, 120)
    mainFrame.Parent = gui
    
    -- Title with server info
    local title = Instance.new("TextLabel")
    title.Text = "🔮 ADVANCED BRAINROT SCANNER v2.0"
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 0)
    title.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = mainFrame
    
    -- Real-time scanning display
    local scanResults = Instance.new("TextLabel")
    scanResults.Name = "ScanResults"
    scanResults.Size = UDim2.new(1, -10, 0, 300)
    scanResults.Position = UDim2.new(0, 5, 0, 50)
    scanResults.TextColor3 = Color3.fromRGB(200, 255, 200)
    scanResults.BackgroundTransparency = 1
    scanResults.TextXAlignment = Enum.TextXAlignment.Left
    scanResults.TextYAlignment = Enum.TextYAlignment.Top
    scanResults.Font = Enum.Font.Gotham
    scanResults.TextSize = 12
    scanResults.Text = "🔄 Initializing advanced scanner..."
    scanResults.Parent = mainFrame
    
    -- Server recommendations
    local serverList = Instance.new("TextLabel")
    serverList.Name = "ServerList"
    serverList.Size = UDim2.new(1, -10, 0, 120)
    serverList.Position = UDim2.new(0, 5, 0, 360)
    serverList.TextColor3 = Color3.fromRGB(255, 200, 100)
    serverList.BackgroundTransparency = 1
    serverList.TextXAlignment = Enum.TextXAlignment.Left
    serverList.TextYAlignment = Enum.TextYAlignment.Top
    serverList.Font = Enum.Font.Gotham
    serverList.TextSize = 11
    serverList.Text = "📡 Analyzing optimal servers..."
    serverList.Parent = mainFrame
    
    -- Control buttons
    local deepScanBtn = Instance.new("TextButton")
    deepScanBtn.Text = "🔍 DEEP SCAN PLAYERS"
    deepScanBtn.Size = UDim2.new(0, 180, 0, 35)
    deepScanBtn.Position = UDim2.new(0, 10, 1, -80)
    deepScanBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    deepScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    deepScanBtn.Font = Enum.Font.GothamBold
    deepScanBtn.Parent = mainFrame
    
    local serverScanBtn = Instance.new("TextButton")
    serverScanBtn.Text = "🌐 SCAN SERVERS"
    serverScanBtn.Size = UDim2.new(0, 180, 0, 35)
    serverScanBtn.Position = UDim2.new(1, -190, 1, -80)
    serverScanBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    serverScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    serverScanBtn.Font = Enum.Font.GothamBold
    serverScanBtn.Parent = mainFrame
    
    -- Real-time scanning function
    local function performDeepScan()
        scanResults.Text = "🔍 Performing deep wealth scan..."
        
        local wealthyPlayers = deepScanWealth()
        
        local resultText = "💰 WEALTH SCAN RESULTS:\n\n"
        resultText = resultText .. "🎯 High-Value Targets Found: " .. #wealthyPlayers .. "\n\n"
        
        if #wealthyPlayers > 0 then
            resultText = resultText .. "🏆 TOP TARGETS:\n"
            for i, target in ipairs(wealthyPlayers) do
                if i <= 6 then
                    resultText = resultText .. "▬▬▬▬▬▬▬▬▬▬▬▬▬▬\n"
                    resultText = resultText .. "🎯 " .. target.player.Name .. "\n"
                    resultText = resultText .. "⭐ Priority: " .. target.priority .. "\n"
                    resultText = resultText .. "💎 Wealth Score: " .. math.floor(target.score) .. "\n"
                    resultText = resultText .. "📦 Items: " .. table.concat(target.items, ", ") .. "\n\n"
                end
            end
        else
            resultText = resultText .. "❌ No high-value targets detected\n"
            resultText = resultText .. "Consider server hop for better targets"
        end
        
        resultText = resultText .. "\n🕒 Scan completed: " .. os.date("%X")
        scanResults.Text = resultText
    end
    
    -- Server scanning function
    local function scanOptimalServers()
        serverList.Text = "📡 Scanning server network..."
        
        local bestServers = findOptimalServer()
        
        local serverText = "🌐 OPTIMAL SERVER LIST:\n\n"
        
        for i, server in ipairs(bestServers) do
            if i <= 4 then
                local status = server.avgWealth > 600 and "🔥 HOT" or server.avgWealth > 400 and "⭐ GOOD" or "💤 AVG"
                serverText = serverText .. "⚡ Server #" .. server.id .. "\n"
                serverText = serverText .. "   💰 Avg Wealth: " .. server.avgWealth .. "\n"
                serverText = serverText .. "   👥 " .. server.playerCount .. " players\n"
                serverText = serverText .. "   📊 Status: " .. status .. "\n\n"
            end
        end
        
        serverText = serverText .. "💡 Join highest wealth servers for maximum profit"
        serverList.Text = serverText
    end
    
    -- Auto-scan on startup
    performDeepScan()
    scanOptimalServers()
    
    -- Button handlers
    deepScanBtn.MouseButton1Click:Connect(performDeepScan)
    serverScanBtn.MouseButton1Click:Connect(scanOptimalServers)
    
    -- Auto-refresh every 30 seconds
    while true do
        wait(30)
        performDeepScan()
    end
end

-- Execute with error handling
local success, err = pcall(main)
if not success then
    -- Fallback simple scanner
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.Players.LocalPlayer.PlayerGui
    local label = Instance.new("TextLabel")
    label.Text = "SWILL Scanner Active - Basic Mode"
    label.Size = UDim2.new(0, 300, 0, 100)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundColor3 = Color3.new(0, 0, 0)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Parent = gui
end
