local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local aimEnabled = false

local function isEnemy(target)
    return target.Team ~= player.Team
end

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size, mainFrame.Position, mainFrame.BackgroundColor3 = UDim2.new(0, 250, 0, 150), UDim2.new(0.1, 0, 0.1, 0), Color3.fromRGB(50, 50, 50)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size, titleLabel.Text, titleLabel.TextColor3, titleLabel.BackgroundColor3 = UDim2.new(1, 0, 0, 30), "Menu Hack", Color3.fromRGB(255, 255, 255), Color3.fromRGB(30, 30, 30)

local button = Instance.new("TextButton", mainFrame)
button.Size, button.Position, button.Text, button.BackgroundColor3, button.TextColor3 = UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.5, -25), "Bật Aim", Color3.fromRGB(70, 70, 70), Color3.fromRGB(255, 255, 255)

local function getClosestEnemy()
    local closestEnemy, closestDistance = nil, math.huge
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and isEnemy(player) then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local distance = (character.HumanoidRootPart.Position - humanoidRootPart.Position).magnitude
                if distance < closestDistance then
                    closestDistance, closestEnemy = distance, character
                end
            end
        end
    end
    return closestEnemy
end

local function toggleAim()
    aimEnabled = not aimEnabled
    button.Text, button.BackgroundColor3 = aimEnabled and "Tắt Aim" or "Bật Aim", aimEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(70, 70, 70)
    while aimEnabled do
        local target = getClosestEnemy()
        if target then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.HumanoidRootPart.Position)
        end
        wait(0.1)
    end
end

button.MouseButton1Click:Connect(toggleAim)
