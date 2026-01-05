-- [[ KA HUB - MODO DE SEGURANÇA MÁXIMA ]]
-- Sem menus, sem bibliotecas externas. Roda direto.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- 1. CRIAÇÃO DA MIRA (Um ponto vermelho fixo no meio da tela)
local sg = Instance.new("ScreenGui", LP.PlayerGui)
sg.Name = "MiraSimples"
local dot = Instance.new("Frame", sg)
dot.Size = UDim2.new(0, 8, 0, 8)
dot.Position = UDim2.new(0.5, -4, 0.5, -4)
dot.BackgroundColor3 = Color3.new(1, 0, 0)
dot.BorderSizePixel = 0

-- 2. AUTO CLICKER ULTRA RÁPIDO (Ativo por padrão)
RunService.Heartbeat:Connect(function()
    -- Clica onde a mira vermelha estiver
    local x = dot.AbsolutePosition.X + 4
    local y = dot.AbsolutePosition.Y + 4
    VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
    VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end)

-- 3. ESP (Ver através das paredes - Ativo por padrão)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            if not p.Character:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight", p.Character)
                h.FillColor = Color3.new(1, 0, 0) -- Vermelho
                h.OutlineColor = Color3.new(1, 1, 1) -- Branco
            end
        end
    end
end)

-- 4. AIMBOT SUAVE (Mira automaticamente ao chegar perto)
RunService.RenderStepped:Connect(function()
    local target = nil
    local shortestDist = 200 -- Raio do Aimbot

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    target = p
                end
            end
        end
    end

    if target then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
    end
end)

print("KA HUB: TUDO ATIVADO AUTOMATICAMENTE!")
