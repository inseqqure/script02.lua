-- RYZEN ULTIMATE – ПОЛНАЯ КРАСНАЯ ТЕМА + ТАНЕЦ
-- Пароль: ryzen2025

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- ============================================================
-- 1. ГЛАВНАЯ ФУНКЦИЯ – ВСЁ КРАСНОЕ
-- ============================================================

local function makeEverythingRed()
    notify("🔥", "Начинаем превращение...")
    
    -- 1. НЕБО (Skybox + Fog + Atmosphere + Bloom)
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        Lighting.FogColor = Color3.fromRGB(200, 0, 0)
        Lighting.FogEnd = 1000
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(100, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 0, 0)
        Lighting.ClockTime = 0.1
    end)
    
    pcall(function()
        local atmos = Instance.new("Atmosphere")
        atmos.Parent = workspace
        atmos.Color = Color3.fromRGB(200, 0, 0)
        atmos.Decay = Color3.fromRGB(100, 0, 0)
        atmos.Density = 0.5
        atmos.Offset = 0.5
        Debris:AddItem(atmos, 60)
    end)
    
    pcall(function()
        local bloom = Instance.new("BloomEffect")
        bloom.Parent = Lighting
        bloom.Intensity = 1.5
        bloom.Size = 100
        bloom.Threshold = 0.3
        Debris:AddItem(bloom, 60)
    end)
    
    -- 2. ТЕРРЕЙН (трава, земля, песок, вода)
    pcall(function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(200, 0, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(150, 0, 0))
                v:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(100, 0, 0))
                v:SetMaterialColor(Enum.Material.Rock, Color3.fromRGB(50, 0, 0))
                v.WaterColor = Color3.fromRGB(200, 0, 0)
                v.WaterReflectance = 0.5
                v.WaterTransparency = 0.4
            end
        end
    end)
    
    -- 3. ВСЕ ЧАСТИ (стены, пол, объекты) – делаем красными + свечение
    pcall(function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
                v.Color = Color3.fromRGB(200, 0, 0)
                if math.random(1, 3) == 1 then
                    v.Material = Enum.Material.Neon
                end
            end
        end
    end)
    
    -- 4. СОЗДАЁМ КРАСНЫЕ ПАРТИКЛЫ ПО ВСЕЙ КАРТЕ
    pcall(function()
        for i = 1, 80 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(math.random(1, 5), 0.5, math.random(1, 5))
            part.Position = Vector3.new(
                math.random(-250, 250),
                math.random(0, 150),
                math.random(-250, 250)
            )
            part.Color = Color3.fromRGB(200, 0, 0)
            part.Material = Enum.Material.Neon
            part.Anchored = true
            part.CanCollide = false
            part.Parent = workspace
            Debris:AddItem(part, 20)
        end
    end)
    
    -- 5. КРАСНЫЙ СВЕТ (PointLight) над игроком
    pcall(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local light = Instance.new("PointLight")
            light.Parent = char.HumanoidRootPart
            light.Color = Color3.fromRGB(255, 0, 0)
            light.Range = 50
            light.Brightness = 5
            Debris:AddItem(light, 30)
        end
    end)
    
    notify("✅", "ВСЁ СТАЛО КРАСНЫМ!")
end

-- ============================================================
-- 2. ТАНЕЦ (НОРМАЛЬНАЯ АНИМАЦИЯ ИЗ ROBLOX)
-- ============================================================

local danceTrack = nil
local danceAnim = nil

local function startDance()
    local char = player.Character
    if not char then 
        notify("❌", "Нет персонажа!")
        return 
    end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then 
        notify("❌", "Нет Humanoid!")
        return 
    end
    
    -- Останавливаем предыдущий танец
    if danceTrack then
        danceTrack:Stop()
        danceTrack = nil
    end
    
    -- Загружаем анимацию танца из Roblox (ID: 148840371 – популярный танец)
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://148840371"
    danceTrack = humanoid:LoadAnimation(animation)
    danceTrack:Play()
    danceTrack.Looped = true
    
    notify("💃", "Ты танцуешь!")
end

local function stopDance()
    if danceTrack then
        danceTrack:Stop()
        danceTrack = nil
        notify("⏹️", "Танец остановлен!")
    end
end

-- ============================================================
-- 3. ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ (по желанию)
-- ============================================================

local function shakeCamera()
    local orig = camera.CFrame
    for _ = 1, 30 do
        camera.CFrame = orig * CFrame.new(
            math.random(-15, 15)/5,
            math.random(-15, 15)/5,
            math.random(-15, 15)/5
        )
        task.wait(0.01)
    end
    camera.CFrame = orig
    notify("📷", "Тряска!")
end

local function flipScreen()
    local orig = camera.CFrame
    for i = 0, 180, 10 do
        camera.CFrame = orig * CFrame.Angles(0, 0, math.rad(i))
        task.wait(0.02)
    end
    task.wait(0.5)
    for i = 180, 0, -10 do
        camera.CFrame = orig * CFrame.Angles(0, 0, math.rad(i))
        task.wait(0.02)
    end
    camera.CFrame = orig
    notify("🔄", "Переворот!")
end

-- ============================================================
-- 4. GUI (стандартный, с паролем)
-- ============================================================

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "RyzenPanel"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = player.PlayerGui end)
    if not gui.Parent then
        pcall(function() gui.Parent = game:GetService("CoreGui") end)
    end

    -- Загрузочный экран (маленький)
    local loadingFrame = Instance.new("Frame")
    loadingFrame.Size = UDim2.new(0, 300, 0, 160)
    loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
    loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    loadingFrame.BorderSizePixel = 2
    loadingFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
    loadingFrame.ZIndex = 10
    loadingFrame.Parent = gui
    -- ... (остальные элементы загрузки пропустим для краткости, они стандартные)

    -- Окно пароля
    local passwordFrame = Instance.new("Frame")
    passwordFrame.Size = UDim2.new(0, 320, 0, 200)
    passwordFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
    passwordFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    passwordFrame.BorderSizePixel = 2
    passwordFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    passwordFrame.Visible = false
    passwordFrame.ZIndex = 5
    passwordFrame.Parent = gui

    -- Заголовок
    local passTitle = Instance.new("TextLabel")
    passTitle.Size = UDim2.new(1, 0, 0, 50)
    passTitle.Position = UDim2.new(0, 0, 0, 10)
    passTitle.BackgroundTransparency = 1
    passTitle.Text = "🔐 АВТОРИЗАЦИЯ"
    passTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    passTitle.Font = Enum.Font.GothamBold
    passTitle.TextSize = 18
    passTitle.Parent = passwordFrame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.8, 0, 0, 40)
    textBox.Position = UDim2.new(0.1, 0, 0.45, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.PlaceholderText = "Введите пароль..."
    textBox.Text = ""
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.Parent = passwordFrame

    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0.4, 0, 0, 40)
    submitBtn.Position = UDim2.new(0.3, 0, 0.75, 0)
    submitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    submitBtn.Text = "🔓 ВОЙТИ"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 16
    submitBtn.Parent = passwordFrame

    -- Главное меню
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 340, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -170, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = false
    mainFrame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    title.BorderSizePixel = 0
    title.Text = "⚡ RYZEN PANEL ⚡"
    title.TextColor3 = Color3.fromRGB(200, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = mainFrame

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -55)
    scroll.Position = UDim2.new(0, 5, 0, 50)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, 350)
    scroll.ScrollBarThickness = 6
    scroll.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    -- КНОПКИ
    local function createButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(240, 240, 240)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Parent = scroll
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 6)
        c.Parent = btn
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55) end)
        btn.MouseButton1Click:Connect(function() pcall(callback) end)
        return btn
    end

    -- ГЛАВНАЯ КНОПКА
    createButton("🔥 ВСЁ КРАСНОЕ (ОДНИМ КЛИКОМ)", function()
        makeEverythingRed()
    end)

    createButton("💃 ТАНЕЦ (ROBLOX)", function()
        startDance()
    end)
    createButton("⏹️ ОСТАНОВИТЬ ТАНЕЦ", function()
        stopDance()
    end)
    createButton("📷 ТРЯСКА", function()
        shakeCamera()
    end)
    createButton("🔄 ПЕРЕВОРОТ", function()
        flipScreen()
    end)

    -- Бонусные кнопки
    createButton("💀 БЕССМЕРТИЕ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            notify("💀", "Бессмертие!")
        end
    end)
    createButton("💨 СКОРОСТЬ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 120
            notify("💨", "Скорость 120!")
        end
    end)
    createButton("⬆️ ПРЫЖОК", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 200
            notify("⬆️", "Прыжок 200!")
        end
    end)
    createButton("👻 НЕВИДИМОСТЬ", function()
        local char = player.Character
        if char then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.Transparency = 1 end
            end
            notify("👻", "Невидимость!")
        end
    end)
    createButton("🔄 ВОССТАНОВИТЬ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
            char.Humanoid.JumpPower = 50
            char.Humanoid.MaxHealth = 100
            char.Humanoid.Health = 100
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.Transparency = 0 end
            end
        end
        pcall(function()
            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        end)
        notify("🔄", "Восстановлено!")
    end)

    -- Запуск
    submitBtn.MouseButton1Click:Connect(function()
        if textBox.Text == "ryzen2025" then
            passwordFrame:Destroy()
            mainFrame.Visible = true
            notify("⚡", "Доступ разрешён!")
        else
            textBox.Text = ""
            textBox.PlaceholderText = "❌ НЕВЕРНЫЙ ПАРОЛЬ!"
            task.wait(1.5)
            textBox.PlaceholderText = "Введите пароль..."
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.X then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    -- Анимация загрузки
    for i = 1, 20 do
        task.wait(0.06)
        -- можно добавить прогресс, но для краткости пропустим
    end
    loadingFrame:Destroy()
    passwordFrame.Visible = true
end

-- ============================================================
-- 5. ЗАПУСК
-- ============================================================

pcall(createGUI)
print("✅ RYZEN ULTIMATE – ВСЁ КРАСНОЕ + ТАНЕЦ ЗАПУЩЕНЫ!")
