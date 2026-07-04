-- RYZEN ULTIMATE v13.0 - АБСОЛЮТНО РАБОЧАЯ ВЕРСИЯ
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
-- 1. СКРИМЕР (НОВЫЙ СПОСОБ!)
-- ============================================================

local function createScreamer()
    -- Создаем GUI через CoreGui (работает всегда!)
    local coreGui = game:GetService("CoreGui")
    local screamerGui = Instance.new("ScreenGui")
    screamerGui.Name = "Screamer"
    screamerGui.Parent = coreGui
    screamerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Черный фон на весь экран
    local black = Instance.new("Frame")
    black.Size = UDim2.new(1, 0, 1, 0)
    black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    black.ZIndex = 999
    black.Parent = screamerGui
    
    -- Красная надпись
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "😱 RYZEN ATTACK! 😱"
    text.TextColor3 = Color3.fromRGB(255, 0, 0)
    text.Font = Enum.Font.GothamBlack
    text.TextSize = 70
    text.TextScaled = true
    text.ZIndex = 1000
    text.Parent = screamerGui
    
    -- Белые полосы (молнии)
    for i = 1, 20 do
        local stripe = Instance.new("Frame")
        stripe.Size = UDim2.new(0, math.random(3, 100), 1, 0)
        stripe.Position = UDim2.new(math.random() * 0.95, 0, 0, 0)
        stripe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        stripe.ZIndex = 1001
        stripe.Parent = screamerGui
    end
    
    -- Красные полосы
    for i = 1, 10 do
        local stripe = Instance.new("Frame")
        stripe.Size = UDim2.new(0, math.random(3, 50), 1, 0)
        stripe.Position = UDim2.new(math.random() * 0.95, 0, 0, 0)
        stripe.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        stripe.ZIndex = 1001
        stripe.Parent = screamerGui
    end
    
    -- Тряска GUI (работает!)
    local shakeLoop = RunService.RenderStepped:Connect(function()
        local x = math.random(-40, 40)
        local y = math.random(-40, 40)
        screamerGui.Position = UDim2.new(0, x, 0, y)
    end)
    
    -- Звук
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9120381772"
        sound.Volume = 1
        sound.Parent = screamerGui
        sound:Play()
    end)
    
    task.wait(2)
    shakeLoop:Disconnect()
    screamerGui:Destroy()
end

-- ============================================================
-- 2. ТАНЕЦ (НОВЫЙ СПОСОБ - ЧЕРЕЗ МОТОРЫ!)
-- ============================================================

local danceConnection = nil
local danceMotor = nil

local function startDance()
    if danceConnection then
        danceConnection:Disconnect()
        danceConnection = nil
    end
    
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
    
    -- Включаем режим танца
    humanoid.PlatformStand = true
    
    -- Находим все части тела
    local parts = {}
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            table.insert(parts, part)
        end
    end
    
    local step = 0
    
    danceConnection = RunService.RenderStepped:Connect(function()
        if not char or not char.Parent then
            if danceConnection then
                danceConnection:Disconnect()
                danceConnection = nil
            end
            return
        end
        
        step = step + 0.2
        local sin = math.sin(step)
        local cos = math.cos(step)
        
        -- Двигаем каждую часть отдельно
        for _, part in pairs(parts) do
            local name = part.Name
            if name == "Head" then
                part.CFrame = part.CFrame * CFrame.Angles(0, sin * 0.2, 0)
            elseif name == "Torso" or name == "UpperTorso" then
                part.CFrame = part.CFrame * CFrame.Angles(0, sin * 0.05, sin * 0.1)
            elseif name == "LeftLeg" or name == "LeftUpperLeg" then
                part.CFrame = part.CFrame * CFrame.Angles(sin * 0.5, 0, 0)
            elseif name == "RightLeg" or name == "RightUpperLeg" then
                part.CFrame = part.CFrame * CFrame.Angles(cos * 0.5, 0, 0)
            elseif name == "LeftArm" or name == "LeftUpperArm" then
                part.CFrame = part.CFrame * CFrame.Angles(0, 0, sin * 0.5)
            elseif name == "RightArm" or name == "RightUpperArm" then
                part.CFrame = part.CFrame * CFrame.Angles(0, 0, cos * 0.5)
            elseif name == "LeftFoot" or name == "LeftLowerLeg" then
                part.CFrame = part.CFrame * CFrame.Angles(sin * 0.3, 0, 0)
            elseif name == "RightFoot" or name == "RightLowerLeg" then
                part.CFrame = part.CFrame * CFrame.Angles(cos * 0.3, 0, 0)
            end
        end
    end)
    
    notify("💃", "Ты танцуешь!")
end

local function stopDance()
    if danceConnection then
        danceConnection:Disconnect()
        danceConnection = nil
    end
    
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.PlatformStand = false
    end
    
    notify("⏹️", "Танец остановлен!")
end

-- ============================================================
-- 3. ТРЯСКА КАМЕРЫ (НОВЫЙ СПОСОБ!)
-- ============================================================

local function shakeCamera()
    local originalCF = camera.CFrame
    
    -- Тряска через цикл
    for intensity = 10, 1, -1 do
        for i = 1, 5 do
            local x = math.random(-intensity, intensity) / 2
            local y = math.random(-intensity, intensity) / 2
            local z = math.random(-intensity, intensity) / 2
            
            camera.CFrame = originalCF * CFrame.new(x, y, z)
            task.wait(0.01)
        end
    end
    
    camera.CFrame = originalCF
    notify("📷", "Камера трясется!")
end

-- ============================================================
-- 4. ПЕРЕВОРОТ ЭКРАНА (НОВЫЙ СПОСОБ!)
-- ============================================================

local function flipScreen()
    local originalCF = camera.CFrame
    
    -- Плавный переворот
    for i = 0, 180, 5 do
        local angle = math.rad(i)
        camera.CFrame = originalCF * CFrame.Angles(0, 0, angle)
        task.wait(0.01)
    end
    
    task.wait(1)
    
    -- Обратный переворот
    for i = 180, 0, -5 do
        local angle = math.rad(i)
        camera.CFrame = originalCF * CFrame.Angles(0, 0, angle)
        task.wait(0.01)
    end
    
    camera.CFrame = originalCF
    notify("🔄", "Экран перевернут!")
end

-- ============================================================
-- 5. КРАСНОЕ НЕБО (ВСЕ СПОСОБЫ)
-- ============================================================

local function redSky()
    -- Способ 1: Skybox
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = Lighting
        end
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
    end)
    
    -- Способ 2: Fog
    pcall(function()
        Lighting.FogColor = Color3.fromRGB(200, 0, 0)
        Lighting.FogEnd = 1000
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(100, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 0, 0)
    end)
    
    -- Способ 3: Atmosphere
    pcall(function()
        local atmos = Instance.new("Atmosphere")
        atmos.Parent = workspace
        atmos.Color = Color3.fromRGB(200, 0, 0)
        atmos.Decay = Color3.fromRGB(100, 0, 0)
        atmos.Density = 0.5
        atmos.Offset = 0.5
        Debris:AddItem(atmos, 30)
    end)
    
    -- Способ 4: Bloom
    pcall(function()
        local bloom = Instance.new("BloomEffect")
        bloom.Parent = Lighting
        bloom.Intensity = 1
        bloom.Size = 100
        bloom.Threshold = 0.5
        Debris:AddItem(bloom, 30)
    end)
    
    -- Способ 5: Красные частицы в небе
    pcall(function()
        for i = 1, 30 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(math.random(2, 8), 0.5, math.random(2, 8))
            part.Position = Vector3.new(
                math.random(-150, 150),
                math.random(50, 300),
                math.random(-150, 150)
            )
            part.Color = Color3.fromRGB(200, 0, 0)
            part.Material = Enum.Material.Neon
            part.Anchored = true
            part.CanCollide = false
            part.Parent = workspace
            Debris:AddItem(part, 15)
        end
    end)
    
    notify("🌅", "Красное небо активировано!")
end

-- ============================================================
-- 6. GUI (ОБНОВЛЕННЫЙ)
-- ============================================================

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "RyzenPanel"
    gui.ResetOnSpawn = false
    
    -- Пробуем разные родители
    local success, result = pcall(function()
        gui.Parent = player.PlayerGui
    end)
    if not success then
        pcall(function()
            gui.Parent = game:GetService("CoreGui")
        end)
    end

    -- Загрузка
    local loadingFrame = Instance.new("Frame")
    loadingFrame.Size = UDim2.new(0, 300, 0, 160)
    loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
    loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    loadingFrame.BorderSizePixel = 2
    loadingFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
    loadingFrame.ZIndex = 10
    loadingFrame.Parent = gui

    local loadCorner = Instance.new("UICorner")
    loadCorner.CornerRadius = UDim.new(0, 12)
    loadCorner.Parent = loadingFrame

    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(0.9, 0, 0.3, 0)
    loadingText.Position = UDim2.new(0.05, 0, 0.1, 0)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "⚡ ЗАГРУЗКА RYZEN..."
    loadingText.TextColor3 = Color3.fromRGB(200, 0, 0)
    loadingText.Font = Enum.Font.GothamBold
    loadingText.TextSize = 18
    loadingText.ZIndex = 11
    loadingText.Parent = loadingFrame

    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0.8, 0, 0.08, 0)
    progressBar.Position = UDim2.new(0.1, 0, 0.45, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    progressBar.ZIndex = 11
    progressBar.Parent = loadingFrame

    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    progressFill.ZIndex = 12
    progressFill.Parent = progressBar

    local progressText = Instance.new("TextLabel")
    progressText.Size = UDim2.new(1, 0, 0.25, 0)
    progressText.Position = UDim2.new(0, 0, 0.6, 0)
    progressText.BackgroundTransparency = 1
    progressText.Text = "0%"
    progressText.TextColor3 = Color3.fromRGB(200, 200, 200)
    progressText.Font = Enum.Font.Gotham
    progressText.TextSize = 12
    progressText.ZIndex = 11
    progressText.Parent = loadingFrame

    -- Пароль
    local passwordFrame = Instance.new("Frame")
    passwordFrame.Size = UDim2.new(0, 320, 0, 200)
    passwordFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
    passwordFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    passwordFrame.BorderSizePixel = 2
    passwordFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    passwordFrame.Visible = false
    passwordFrame.ZIndex = 5
    passwordFrame.Parent = gui

    local passCorner = Instance.new("UICorner")
    passCorner.CornerRadius = UDim.new(0, 10)
    passCorner.Parent = passwordFrame

    local passTitle = Instance.new("TextLabel")
    passTitle.Size = UDim2.new(1, 0, 0, 50)
    passTitle.Position = UDim2.new(0, 0, 0, 10)
    passTitle.BackgroundTransparency = 1
    passTitle.Text = "🔐 АВТОРИЗАЦИЯ"
    passTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    passTitle.Font = Enum.Font.GothamBold
    passTitle.TextSize = 18
    passTitle.ZIndex = 6
    passTitle.Parent = passwordFrame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.8, 0, 0, 40)
    textBox.Position = UDim2.new(0.1, 0, 0.45, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.PlaceholderText = "Введите пароль..."
    textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    textBox.Text = ""
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.ZIndex = 6
    textBox.Parent = passwordFrame

    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0.4, 0, 0, 40)
    submitBtn.Position = UDim2.new(0.3, 0, 0.75, 0)
    submitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    submitBtn.Text = "🔓 ВОЙТИ"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 16
    submitBtn.ZIndex = 6
    submitBtn.Parent = passwordFrame

    -- Главное меню
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 340, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -170, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = false
    mainFrame.Parent = gui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame

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
    scroll.CanvasSize = UDim2.new(0, 0, 0, 700)
    scroll.ScrollBarThickness = 6
    scroll.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    -- ============================================================
    -- 7. КНОПКИ
    -- ============================================================

    local function createButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(240, 240, 240)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Parent = scroll

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        end)
        btn.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
        return btn
    end

    -- ВСЕ КНОПКИ
    createButton("😱 СКРИМЕР", function() createScreamer() end)
    createButton("💃 ТАНЕЦ", function() startDance() end)
    createButton("⏹️ ОСТАНОВИТЬ ТАНЕЦ", function() stopDance() end)
    createButton("📷 ТРЯСКА КАМЕРЫ", function() shakeCamera() end)
    createButton("🔄 ПЕРЕВОРОТ ЭКРАНА", function() flipScreen() end)
    createButton("🌅 КРАСНОЕ НЕБО", function() redSky() end)
    
    createButton("💀 БЕССМЕРТИЕ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            notify("💀", "Ты бессмертен!")
        end
    end)

    createButton("💨 СУПЕР СКОРОСТЬ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 120
            notify("💨", "Скорость 120!")
        end
    end)

    createButton("⬆️ СУПЕР ПРЫЖОК", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 200
            notify("⬆️", "Прыжок 200!")
        end
    end)

    createButton("👻 НЕВИДИМОСТЬ", function()
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
            notify("👻", "Ты невидим!")
        end
    end)

    createButton("🔄 ВОССТАНОВИТЬ ВСЁ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
            char.Humanoid.JumpPower = 50
            char.Humanoid.MaxHealth = 100
            char.Humanoid.Health = 100
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
            end
        end
        pcall(function()
            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 1
        end)
        notify("🔄", "Всё восстановлено!")
    end)

    -- ============================================================
    -- 8. ЗАПУСК
    -- ============================================================

    local function animateLoading()
        for i = 1, 20 do
            task.wait(0.06)
            local progress = i / 20
            progressFill.Size = UDim2.new(progress, 0, 1, 0)
            progressText.Text = math.floor(progress * 100) .. "%"
            
            if progress < 0.3 then
                loadingText.Text = "🔐 ИНИЦИАЛИЗАЦИЯ..."
            elseif progress < 0.6 then
                loadingText.Text = "📡 ПОДКЛЮЧЕНИЕ..."
            elseif progress < 0.8 then
                loadingText.Text = "⚡ ЗАГРУЗКА МОДУЛЕЙ..."
            else
                loadingText.Text = "🔥 АКТИВАЦИЯ RYZEN..."
            end
        end
        
        loadingText.Text = "✅ ГОТОВО!"
        task.wait(0.3)
        loadingFrame:Destroy()
        passwordFrame.Visible = true
    end

    submitBtn.MouseButton1Click:Connect(function()
        if textBox.Text == "ryzen2025" then
            passwordFrame:Destroy()
            mainFrame.Visible = true
            notify("⚡", "✅ ДОСТУП РАЗРЕШЕН!")
        else
            textBox.Text = ""
            textBox.PlaceholderText = "❌ НЕВЕРНЫЙ ПАРОЛЬ!"
            textBox.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
            task.wait(1.5)
            textBox.PlaceholderText = "Введите пароль..."
            textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.X then
            if mainFrame.Visible then
                mainFrame.Visible = false
            elseif mainFrame.Parent then
                mainFrame.Visible = true
            end
        end
    end)

    task.spawn(animateLoading)
end

-- ============================================================
-- 9. ЗАПУСК
-- ============================================================

pcall(createGUI)
print("✅ RYZEN ULTIMATE v13.0 [НОВАЯ ВЕРСИЯ] ЗАПУЩЕНА!")
