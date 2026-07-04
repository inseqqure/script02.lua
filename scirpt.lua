-- RYZEN ULTIMATE v13.0 - ПОЛНАЯ ВЕРСИЯ
-- Пароль: ryzen2025

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

-- ============================================================
-- 1. ФУНКЦИИ
-- ============================================================

local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- ПЕРЕЛИВАЮЩИЕСЯ ЦВЕТА
local colorCycle = 0
local function getCyclicColor()
    colorCycle = colorCycle + 0.02
    local r = math.sin(colorCycle) * 0.5 + 0.5
    local g = math.sin(colorCycle + 2) * 0.1
    local b = math.sin(colorCycle + 4) * 0.1
    return Color3.new(r, g, b)
end

-- ИЗМЕНЕНИЕ ТРАВЫ (ЧЕРЕЗ TERRAIN)
local function changeGrassToRed()
    pcall(function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                -- Меняем цвет травы на красный
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(200, 0, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(150, 0, 0))
                v:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(100, 0, 0))
                v:SetMaterialColor(Enum.Material.Rock, Color3.fromRGB(50, 0, 0))
                v.WaterColor = Color3.fromRGB(200, 0, 0)
            end
        end
        
        -- Меняем цвет всех частей на переливающийся
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
                pcall(function()
                    v.Color = getCyclicColor()
                    if math.random(1, 3) == 1 then
                        v.Material = Enum.Material.Neon
                    end
                end)
            end
        end
    end)
end

-- АНИМАЦИЯ ПЕРЕЛИВАЮЩИХСЯ ЦВЕТОВ
local colorLoop
local function startColorCycle()
    if colorLoop then return end
    
    colorLoop = RunService.RenderStepped:Connect(function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
                pcall(function()
                    v.Color = getCyclicColor()
                end)
            end
        end
        
        -- Меняем цвет тумана
        Lighting.FogColor = getCyclicColor()
    end)
    
    notify("🎨 ЦВЕТА", "Переливающиеся цвета активированы!")
end

-- ОСТАНОВКА ПЕРЕЛИВАНИЯ
local function stopColorCycle()
    if colorLoop then
        colorLoop:Disconnect()
        colorLoop = nil
        notify("🔄 ЦВЕТА", "Переливание остановлено!")
    end
end

-- ============================================================
-- 2. СКРИМЕРЫ
-- ============================================================

local function createScreamer()
    -- Создаем черный экран
    local screamer = Instance.new("Frame")
    screamer.Size = UDim2.new(1, 0, 1, 0)
    screamer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    screamer.ZIndex = 999
    screamer.Parent = player.PlayerGui
    
    -- Красная надпись
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "😱 RYZEN ATTACK! 😱"
    text.TextColor3 = Color3.fromRGB(255, 0, 0)
    text.Font = Enum.Font.GothamBlack
    text.TextSize = 60
    text.ZIndex = 1000
    text.Parent = screamer
    
    -- Красные молнии
    for i = 1, 10 do
        local lightning = Instance.new("Frame")
        lightning.Size = UDim2.new(0, math.random(5, 100), 1, 0)
        lightning.Position = UDim2.new(math.random() * 0.9, 0, 0, 0)
        lightning.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        lightning.ZIndex = 1001
        lightning.Parent = screamer
    end
    
    -- Тряска экрана
    local originalPos = camera.CFrame
    for i = 1, 10 do
        camera.CFrame = originalPos * CFrame.new(
            math.random(-5, 5),
            math.random(-5, 5),
            math.random(-5, 5)
        )
        task.wait(0.05)
    end
    camera.CFrame = originalPos
    
    -- Звук скримера (если есть)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9120381772" -- Звук скримера
        sound.Volume = 1
        sound.Parent = game.Workspace
        sound:Play()
        Debris:AddItem(sound, 3)
    end)
    
    task.wait(0.5)
    screamer:Destroy()
end

-- ============================================================
-- 3. ТАНЦЫ
-- ============================================================

local function danceAnimation()
    local char = player.Character
    if not char then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- Анимация танца через изменение позиции частей тела
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    local head = char:FindFirstChild("Head")
    local leftLeg = char:FindFirstChild("LeftLeg")
    local rightLeg = char:FindFirstChild("RightLeg")
    local leftArm = char:FindFirstChild("LeftArm")
    local rightArm = char:FindFirstChild("RightArm")
    
    if not torso then return end
    
    local danceLoop = true
    local step = 0
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if not danceLoop or not char.Parent then
            return
        end
        
        step = step + 0.1
        local sin = math.sin(step)
        local cos = math.cos(step)
        
        -- Движения тела
        if torso then
            torso.CFrame = torso.CFrame * CFrame.Angles(0, 0, sin * 0.1)
        end
        
        if head then
            head.CFrame = head.CFrame * CFrame.Angles(0, sin * 0.2, 0)
        end
        
        if leftLeg then
            leftLeg.CFrame = leftLeg.CFrame * CFrame.Angles(sin * 0.3, 0, 0)
        end
        
        if rightLeg then
            rightLeg.CFrame = rightLeg.CFrame * CFrame.Angles(cos * 0.3, 0, 0)
        end
        
        if leftArm then
            leftArm.CFrame = leftArm.CFrame * CFrame.Angles(0, 0, sin * 0.3)
        end
        
        if rightArm then
            rightArm.CFrame = rightArm.CFrame * CFrame.Angles(0, 0, cos * 0.3)
        end
    end)
    
    notify("💃 ТАНЕЦ", "Вы танцуете!")
end

-- ============================================================
-- 4. ПЕРЕВОРОТ ЭКРАНА
-- ============================================================

local function flipScreen()
    local flipGui = Instance.new("ScreenGui")
    flipGui.Name = "FlipScreen"
    flipGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 999
    frame.Parent = flipGui
    
    local flipText = Instance.new("TextLabel")
    flipText.Size = UDim2.new(1, 0, 1, 0)
    flipText.BackgroundTransparency = 1
    flipText.Text = "🔄 ЭКРАН ПЕРЕВЕРНУТ!"
    flipText.TextColor3 = Color3.fromRGB(255, 0, 0)
    flipText.Font = Enum.Font.GothamBold
    flipText.TextSize = 40
    flipText.ZIndex = 1000
    flipText.Parent = frame
    
    -- Эффект переворота через поворот камеры
    local originalCF = camera.CFrame
    local targetCF = originalCF * CFrame.Angles(0, 0, math.pi) -- Переворот на 180 градусов
    
    local tween = TweenService:Create(camera, TweenInfo.new(0.5), {
        CFrame = targetCF
    })
    tween:Play()
    
    task.wait(2)
    
    -- Возвращаем обратно
    local tweenBack = TweenService:Create(camera, TweenInfo.new(0.5), {
        CFrame = originalCF
    })
    tweenBack:Play()
    
    task.wait(0.5)
    flipGui:Destroy()
end

-- ============================================================
-- 5. ТРАНСФОРМАЦИЯ КАРТЫ
-- ============================================================

local function transformMap()
    notify("🔥 ТРАНСФОРМАЦИЯ", "Начинаем изменение карты...")
    
    -- Меняем траву
    changeGrassToRed()
    
    -- Запускаем переливание цветов
    startColorCycle()
    
    -- Меняем небо
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        Lighting.FogColor = Color3.fromRGB(200, 0, 0)
        Lighting.Brightness = 1.5
    end)
    
    -- Меняем пол (землю)
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():match("floor") or v.Name:lower():match("ground") then
            pcall(function()
                v.Color = Color3.fromRGB(100, 0, 0)
                v.Material = Enum.Material.Neon
            end)
        end
    end
    
    notify("✅ ТРАНСФОРМАЦИЯ", "Карта полностью изменена!")
end

-- ============================================================
-- 6. ВОССТАНОВЛЕНИЕ
-- ============================================================

local function restoreMap()
    stopColorCycle()
    
    pcall(function()
        -- Восстанавливаем небо
        local sky = Lighting:FindFirstChild("Sky")
        if sky then
            sky.SkyboxBk = "rbxassetid://0"
            sky.SkyboxDn = "rbxassetid://0"
            sky.SkyboxLf = "rbxassetid://0"
            sky.SkyboxRt = "rbxassetid://0"
            sky.SkyboxUp = "rbxassetid://0"
        end
        
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 1
        
        -- Восстанавливаем траву
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(0, 255, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(255, 255, 0))
                v:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(139, 69, 19))
                v.WaterColor = Color3.fromRGB(0, 0, 255)
            end
        end
        
        -- Восстанавливаем части
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                pcall(function()
                    v.Color = Color3.fromRGB(255, 255, 255)
                    v.Material = Enum.Material.SmoothPlastic
                end)
            end
        end
    end)
    
    notify("🔄 ВОССТАНОВЛЕНИЕ", "Карта восстановлена!")
end

-- ============================================================
-- 7. GUI
-- ============================================================

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "RyzenPanel"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    -- Загрузочный экран
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

    -- Главная панель
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 340, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -170, 0.5, -260)
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
    scroll.CanvasSize = UDim2.new(0, 0, 0, 650)
    scroll.ScrollBarThickness = 6
    scroll.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    -- ============================================================
    -- 8. КНОПКИ
    -- ============================================================

    local function createButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(240, 240, 240)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
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

    createButton("🔥 ПОЛНАЯ ТРАНСФОРМАЦИЯ", function()
        transformMap()
    end)

    createButton("🌿 КРАСНАЯ ТРАВА И ПОЛ", function()
        changeGrassToRed()
        notify("🌿 ТРАВА", "Трава и пол стали красными!")
    end)

    createButton("🎨 ПЕРЕЛИВАЮЩИЕСЯ ЦВЕТА (ВКЛ)", function()
        startColorCycle()
    end)

    createButton("🔄 ОСТАНОВИТЬ ПЕРЕЛИВАНИЕ", function()
        stopColorCycle()
    end)

    createButton("😱 СКРИМЕР", function()
        createScreamer()
    end)

    createButton("💃 ТАНЕЦ", function()
        danceAnimation()
    end)

    createButton("🔄 ПЕРЕВОРОТ ЭКРАНА", function()
        flipScreen()
    end)

    createButton("🌅 ХАКЕРСКОЕ НЕБО", function()
        pcall(function()
            local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
            sky.SkyboxBk = "rbxassetid://15050311563"
            sky.SkyboxDn = "rbxassetid://15050311563"
            sky.SkyboxLf = "rbxassetid://15050311563"
            sky.SkyboxRt = "rbxassetid://15050311563"
            sky.SkyboxUp = "rbxassetid://15050311563"
            Lighting.FogColor = Color3.fromRGB(200, 0, 0)
            Lighting.Brightness = 1.5
            notify("🌅 НЕБО", "Хакерское небо активировано!")
        end)
    end)

    createButton("🔄 ВОССТАНОВИТЬ КАРТУ", function()
        restoreMap()
    end)

    createButton("💀 БЕССМЕРТИЕ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            notify("💀 БЕССМЕРТИЕ", "Вы бессмертны!")
        end
    end)

    createButton("💨 СУПЕР СКОРОСТЬ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 120
            notify("💨 СКОРОСТЬ", "Скорость 120!")
        end
    end)

    createButton("⬆️ СУПЕР ПРЫЖОК", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 200
            notify("⬆️ ПРЫЖОК", "Прыжок 200!")
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
            notify("👻 НЕВИДИМОСТЬ", "Вы невидимы!")
        end
    end)

    -- ============================================================
    -- 9. ЗАПУСК
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
            notify("⚡ RYZEN CORE", "✅ ДОСТУП РАЗРЕШЕН!")
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
-- 10. ЗАПУСК
-- ============================================================

pcall(createGUI)
print("✅ RYZEN ULTIMATE v13.0 [ПОЛНАЯ ВЕРСИЯ] ЗАПУЩЕНА!")
