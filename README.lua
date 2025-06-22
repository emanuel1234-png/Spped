# Spped
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local espBoxes = {}

-- Função para criar ESP para um jogador
local function createESP(player)
    if player == localPlayer then return end

    player.CharacterAdded:Connect(function(character)
        RunService.RenderStepped:Connect(function()
            local head = character:FindFirstChild("Head")
            if head then
                if not espBoxes[player] then
                    local box = Drawing.new("Square")
                    box.Color = Color3.fromRGB(255, 140, 0) -- Laranja
                    box.Thickness = 2
                    box.Transparency = 1
                    box.Filled = false
                    espBoxes[player] = box
                end

                local box = espBoxes[player]
                local pos, onScreen = local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)

                if onScreen then
                    box.Size = Vector2.new(60, 60)
                    box.Position = Vector2.new(pos.X - 30, pos.Y - 60)
                    box.Visible = true
                else
                    box.Visible = false
                end
            end
        end)
    end)
end

-- Aplica para todos os jogadores existentes
for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end

-- Aplica para novos jogadores
Players.PlayerAdded:Connect(createESP)
