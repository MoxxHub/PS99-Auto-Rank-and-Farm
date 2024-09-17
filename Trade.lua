-- Local variables for trading events
local TradeService = game:GetService("ReplicatedStorage").TradeService -- Assuming trade service is under ReplicatedStorage
local player = game.Players.LocalPlayer

-- Function to accept incoming trades automatically
local function onTradeRequestReceived(tradeData)
    local tradeSender = tradeData.Sender
    local tradeReceiver = tradeData.Receiver

    -- Check if the trade is for the local player
    if tradeReceiver == player.Name then
        -- Automatically accept the trade request
        TradeService:FireServer("AcceptTrade", tradeSender)
        print("Trade accepted from: " .. tradeSender)
    end
end

-- Function to confirm trade automatically once trade is accepted
local function onTradeUpdate(tradeData)
    local tradeStatus = tradeData.Status

    -- If trade is accepted by both parties, confirm it
    if tradeStatus == "AcceptedByBoth" then
        TradeService:FireServer("ConfirmTrade")
        print("Trade confirmed!")
    end
end

-- Listening for trade request events and updates
TradeService.TradeRequest.OnClientEvent:Connect(onTradeRequestReceived)
TradeService.TradeUpdate.OnClientEvent:Connect(onTradeUpdate)
