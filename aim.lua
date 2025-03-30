local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local aimEnabled = false

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.1, 0, 0.1, 0)
button.Text = "Bật Aim"
button.Parent = screenGui

local function getClosestEnemy()
    local closestEnemy = nil
    local closestDistance = math.huge

    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") then
            local distance = (enemy.HumanoidRootPart.Position - humanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestEnemy = enemy
            end
        end
    end

    return closestEnemy
end

local function toggleAim()
    aimEnabled = not aimEnabled
    button.Text = aimEnabled and "Tắt Aim" or "Bật Aim"

    while aimEnabled do
        local target = getClosestEnemy()
        if target then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.HumanoidRootPart.Position)
        end
        wait(0.1)
    end
end

button.MouseButton1Click:Connect(toggleAim)
