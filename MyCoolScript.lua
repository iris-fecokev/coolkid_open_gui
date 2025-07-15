-- Улучшенный скрипт CoolGUI с полным функционалом
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Основное окно
local Window = Rayfield:CreateWindow({
    Name = "c00lgui Reborn",
    LoadingTitle = "Initializing c00lkidd scripts...",
    LoadingSubtitle = "v3.1 | FE Compatible",
    ConfigurationSaving = { Enabled = false },
    Theme = {
        Background = Color3.fromRGB(10, 10, 20),
        Text = Color3.fromRGB(220, 220, 255),
        Glow = Color3.fromRGB(100, 0, 255)
    }
})

-- Инициализация персонажа
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Авто-респавн персонажа
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
end)

-- Вкладка "Персонаж"
local PlayerTab = Window:CreateTab("Персонаж", "rbxassetid://1365169983")
PlayerTab:CreateSlider("Скорость", 16, 300, 16, {
    ValueName = "ед.",
    Callback = function(Value)
        if Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end
})

PlayerTab:CreateSlider("Сила прыжка", 50, 500, 50, {
    ValueName = "ед.",
    Callback = function(Value)
        if Humanoid then
            Humanoid.JumpPower = Value
        end
    end
})

-- Функция спама декалами
local function applyDecals()
    local DecalID = 1365169983
    local faces = {"Top", "Bottom", "Left", "Right", "Front", "Back"}
    
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            for _, face in ipairs(faces) do
                local decal = Instance.new("Decal")
                decal.Texture = "rbxassetid://"..DecalID
                decal.Face = face
                decal.Parent = part
            end
        end
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    for _, face in ipairs(faces) do
                        local decal = Instance.new("Decal")
                        decal.Texture = "rbxassetid://"..DecalID
                        decal.Face = face
                        decal.Parent = part
                    end
                end
            end
        end
    end
end

-- Вкладка "Визуал"
local VisualTab = Window:CreateTab("Визуал", "rbxassetid://138080479")
VisualTab:CreateButton("Спам декалами", function()
    applyDecals()
end)

-- Система полета
local Flying = false
local FlySpeed = 50
local TweenService = game:GetService("TweenService")

VisualTab:CreateToggle("Режим полета", {
    CurrentValue = false,
    Callback = function(Value)
        Flying = Value
        if Flying then
            local root = Character:FindFirstChild("HumanoidRootPart")
            if root then
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.P = 10000
                bodyGyro.D = 1000
                bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
                bodyGyro.CFrame = root.CFrame
                bodyGyro.Parent = root
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                bodyVelocity.Parent = root
                
                game:GetService("RunService").Heartbeat:Connect(function()
                    if not Flying then return end
                    
                    local cam = workspace.CurrentCamera
                    local direction = cam.CFrame.LookVector
                    
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        bodyVelocity.Velocity = direction * FlySpeed
                    elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                        bodyVelocity.Velocity = -direction * FlySpeed
                    else
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                    
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                        bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, FlySpeed/2, 0)
                    end
                end)
            end
        else
            if Character:FindFirstChild("HumanoidRootPart") then
                for _, obj in ipairs(Character.HumanoidRootPart:GetChildren()) do
                    if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                        obj:Destroy()
                    end
                end
            end
        end
    end
})

-- Система звуков
local SoundTab = Window:CreateTab("Звуки", "rbxassetid://8127297852")
local SoundID = 138080479

SoundTab:CreateInputField({
    Name = "ID звука",
    PlaceholderText = "Введите ID...",
    Callback = function(Text)
        SoundID = tonumber(Text) or 138080479
    end
})

SoundTab:CreateButton("Проиграть всем", function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://"..SoundID
                sound.Parent = head
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 10)
            end
        end
    end
end)

-- Система вращения
local Spinning = false
local TrollTab = Window:CreateTab("Троллинг")
TrollTab:CreateToggle("Режим спина", {
    CurrentValue = false,
    Callback = function(Value)
        Spinning = Value
        if Spinning then
            spinLoop = game:GetService("RunService").Heartbeat:Connect(function()
                if not Spinning then spinLoop:Disconnect() return end
                if Character and Character:FindFirstChild("HumanoidRootPart") then
                    Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
                end
            end)
        end
    end
})

-- Кнопка выхода
TrollTab:CreateButton("Закрыть GUI", function()
    Rayfield:Destroy()
end)

Rayfield:Notify({
    Title = "c00lgui Activated",
    Content = "Script loaded successfully!",
    Duration = 3,
    Image = "rbxassetid://1365169983"
})

Rayfield:LoadConfiguration()
