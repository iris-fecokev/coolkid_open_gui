-- Загрузка библиотеки Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Создание основного окна в стиле CoolGUI
local Window = Rayfield:CreateWindow({
    Name = "c00lgui Reborn",
    LoadingTitle = "Loading c00lkidd scripts...",
    LoadingSubtitle = "v2.2 | FE Bypass Enabled",
    ConfigurationSaving = { Enabled = false },
    Theme = {
        Background = Color3.fromRGB(10, 10, 20),
        Text = Color3.fromRGB(220, 220, 255),
        Glow = Color3.fromRGB(100, 0, 255) -- Неоновое сияние
    }
})

-- Вкладка "Основные"
local MainTab = Window:CreateTab("Основные", "rbxassetid://1365169983")
local MainSection = MainTab:CreateSection("Персонаж")

MainTab:CreateSlider("Скорость", 16, 300, 50, {
    ValueName = "ед.",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

MainTab:CreateSlider("Прыжок", 50, 500, 50, {
    ValueName = "ед.",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

-- Вкладка "Визуал"
local VisualTab = Window:CreateTab("Визуал", "rbxassetid://138080479")
local DecalSection = VisualTab:CreateSection("Спам декалами")

VisualTab:CreateButton("Наклеить декали", function()
    local DecalID = 1365169983
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local decal = Instance.new("Decal")
            decal.Texture = "rbxassetid://"..DecalID
            decal.Face = "Top"
            decal.Parent = part
        end
    end
end)

-- Вкладка "Троллинг"
local TrollTab = Window:CreateTab("Троллинг")
local SoundSection = TrollTab:CreateSection("Звуки")

TrollTab:CreateInputField({
    Name = "ID звука",
    PlaceholderText = "Введите ID...",
    Callback = function(Text)
        _G.SoundID = tonumber(Text) or 138080479
    end
})

TrollTab:CreateButton("Spooky Skeletons", function()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Character then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://138080479"
            sound.Parent = player.Character:FindFirstChild("Head")
            sound:Play()
        end
    end
end)

-- Вкладка "FE Bypass"
local FEBypassTab = Window:CreateTab("FE Bypass", "rbxassetid://8127297852")
FEBypassTab:CreateParagraph({
    Title = "⚠️ Внимание",
    Content = "FE-скрипты могут не работать на некоторых играх."
})

FEBypassTab:CreateButton("FE Destroy GUI", {
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/FEbypassScript"))()
    end
})

-- Анимации и стилизация
Rayfield:Notify({
    Title = "c00lgui Activated",
    Content = "Welcome back, c00lkidd!",
    Duration = 5,
    Image = "rbxassetid://138080479",
    Actions = {
        Ignore = { Name = "OK" }
    }
})

Rayfield:LoadConfiguration()
