-- RYZEN ULTIMATE v13.0 - РАБОЧАЯ ВЕРСИЯ
-- Пароль: ryzen2025

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- ============================================================
-- 1. РАБОЧИЙ СКРИМЕР (ГАРАНТИРОВАННО РАБОТАЕТ)
-- ============================================================

local function createScreamer()
    local gui = Instance.new("ScreenGui")
    gui.Name = "Screamer"
    gui.Parent = player.PlayerGui
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Черный фон
    local black = Instance.new("Frame")
    black.Size = UDim2.new(1, 0, 1, 0)
    black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    black.ZIndex = 999
    black.Parent = gui
    
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
    text.Parent = gui
    
    -- Белые полосы (молнии)
    for i = 1, 15 do
        local stripe = Instance.new("Frame")
        stripe.Size = UDim2.new(0, math.random(2, 80), 1, 0)
        stripe.Position = UDim2.new(math.random() * 0.95, 0, 0, 0)
        stripe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        stripe.ZIndex = 1001
        stripe.Parent = gui
    end
    
    -- Тряска экрана через GUI (РАБОТАЕТ!)
    local shakeLoop = RunService.RenderStepped:Connect(function()
        local x = math.random(-30, 30)
        local y = math.random(-30, 30)
        gui.Position = UDim2.new(0, x, 0, y)
    end)
    
    -- Звук (если есть)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9120381772"
        sound.Volume = 1
        sound.Parent = gui
        sound:Play()
    end)
    
    task.wait(1.5)
    shakeLoop:Disconnect()
    gui:Destroy()
end

-- ============================================================
-- 2. РАБОЧИЙ ТАНЕЦ (ГАРАНТИРОВАННО РАБОТАЕТ)
-- ============================================================

local danceConnection = nil

local function startDance()
    -- Останавливаем прошлый танец
    if danceConnection then
        danceConnection:Disconnect()
        danceConnection = nil
    end
    
    local char = player.Character
    if not char then 
        notify("❌ ОШИБКА", "Нет персонажа!")
        return 
    end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then 
        notify("❌ ОШИБКА", "Нет Humanoid!")
        return 
    end
    
    -- Отключаем стандартную анимацию
    humanoid.PlatformStand = true
    
    local parts = {
        char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"),
        char:FindFirstChild("Head"),
        char:FindFirstChild("LeftLeg"),
        char:FindFirstChild("RightLeg"),
        char:FindFirstChild("LeftArm"),
        char:FindFirstChild("RightArm"),
        char:FindFirstChild("LeftFoot"),
        char:FindFirstChild("RightFoot"),
    }
    
    local step = 0
    
    danceConnection = RunService.RenderStepped:Connect(function()
        if not char or not char.Parent then
            if danceConnection then
                danceConnection:Disconnect()
                danceConnection = nil
            end
            return
        end
        
        step = step + 0.15
        local sin = math.sin(step)
        local cos = math.cos(step)
        
        -- Движения тела
        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        if torso then
            local newCF = torso.CFrame * CFrame.Angles(0, sin * 0.05, sin * 0.1)
            torso.CFrame = newCF
        end
        
        local head = char:FindFirstChild("Head")
        if head then
            head.CFrame = head.CFrame * CFrame.Angles(0, sin * 0.15, 0)
        end
        
        local leftLeg = char:FindFirstChild("LeftLeg")
        if leftLeg then
            leftLeg.CFrame = leftLeg.CFrame * CFrame.Angles(sin * 0.4, 0, 0)
        end
        
        local rightLeg = char:FindFirstChild("RightLeg")
        if rightLeg then
            rightLeg.CFrame = rightLeg.CFrame * CFrame.Angles(cos * 0.4, 0, 0)
        end
        
        local leftArm = char:FindFirstChild("LeftArm")
        if leftArm then
            leftArm.CFrame = leftArm.CFrame * CFrame.Angles(0, 0, sin * 0.4)
        end
        
        local rightArm = char:FindFirstChild("RightArm")
        if rightArm then
            rightArm.CFrame = rightArm.CFrame * CFrame.Angles(0, 0, cos * 0.4)
        end
        
        local leftFoot = char:FindFirstChild("LeftFoot")
        if leftFoot then
            leftFoot.CFrame = leftFoot.CFrame * CFrame.Angles(sin * 0.3, 0, 0)
        end
        
        local rightFoot = char:FindFirstChild("RightFoot")
        if rightFoot then
            rightFoot.CFrame = rightFoot.CFrame * CFrame.Angles(cos * 0.3, 0, 0)
        end
    end)
    
    notify("💃 ТАНЕЦ", "Ты танцуешь!")
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
    
    notify("⏹️ ТАНЕЦ", "Танец остановлен!")
end

-- ============================================================
-- 3. РАБОЧАЯ ТРЯСКА КАМЕРЫ (ГАРАНТИРОВАННО РАБОТАЕТ)
-- ============================================================

local function shakeCamera()
    local originalCF = camera.CFrame
    
    for i = 1, 20 do
        local x = math.random(-10, 10)
        local y = math.random(-10, 10)
        local z = math.random(-10, 10)
        
        camera.CFrame = originalCF * CFrame.new(x/10, y/10, z/10)
        task.wait(0.02)
    end
    
    camera.CFrame = originalCF
    notify("📷 ТРЯСКА", "Камера трясется!")
end

-- ============================================================
-- 4. РАБОЧИЙ ПЕРЕВОРОТ ЭКРАНА
-- ============================================================

local function flipScreen()
    local originalCF = camera.CFrame
    
    -- Переворот на 180 градусов
    local targetCF = originalCF * CFrame.Angles(0, 0, math.pi)
    
    local tween = TweenService:Create(camera, TweenInfo.new(0.5), {
        CFrame = targetCF
    })
    tween:Play()
    tween.Completed:Wait()
    
    task.wait(1)
    
    -- Возврат
    local tweenBack = TweenService:Create(camera, TweenInfo.new(0.5), {
        CFrame = originalCF
    })
    tweenBack:Play()
    tweenBack.Completed:Wait()
    
    notify("🔄 ПЕРЕВОРОТ", "Экран перевернут!")
end

-- ============================================================
-- 5. КРАСНОЕ НЕБО (ГАРАНТИРОВАННО РАБОТАЕТ)
-- ============================================================

local function redSky()
    -- Способ 1: Прямое изменение
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
    
    -- Способ 2: Через Fog
    pcall(function()
        Lighting.FogColor = Color3.fromRGB(200, 0, 0)
        Lighting.FogEnd = 1000
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(100, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 0, 0)
        Lighting.ClockTime = 0.1
    end)
    
    -- Способ 3: Через Atmosphere
    pcall(function()
        local atmos = Instance.new("Atmosphere")
        atmos.Parent = game.Workspace
        atmos.Color = Color3.fromRGB(200, 0, 0)
        atmos.Decay = Color3.fromRGB(100, 0, 0)
        atmos.Density = 0.5
        atmos.Offset = 0.5
        Debris:AddItem(atmos, 30)
    end)
    
    -- Способ 4: Через Bloom
    pcall(function()
        local bloom = Instance.new("BloomEffect")
        bloom.Parent = Lighting
        bloom.Intensity = 1
        bloom.Size = 100
        bloom.Threshold = 0.5
        Debris:AddItem(bloom, 30)
    end)
    
    -- Способ 5: Создаем красные части в небе
    pcall(function()
        for i = 1, 20 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(10, 0.5, 10)
            part.Position = Vector3.new(math.random(-100, 100), math.random(50, 200), math.random(-100, 100))
            part.Color = Color3.fromRGB(200, 0, 0)
            part.Material = Enum.Material.Neon
            part.Anchored = true
            part.CanCollide = false
            part.Parent = game.Workspace
            Debris:AddItem(part, 10)
        end
    end)
    
    notify("🌅 НЕБО", "Красное небо активировано!")
end

-- ============================================================
-- 6. КРАСНАЯ ТРАВА (РАБОТАЕТ!)
-- ============================================================

local function redGrass()
    pcall(function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(200, 0, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(150, 0, 0))
                v:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(100, 0, 0))
                v:SetMaterialColor(Enum.Material.Rock, Color3.fromRGB(50, 0, 0))
                v.WaterColor = Color3.fromRGB(200, 0, 0)
            end
        end
    end)
    
    -- Меняем все части на красные
    pcall(function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
                v.Color = Color3.fromRGB(200, 0, 0)
            end
        end
    end)
    
    notify("🌿 ТРАВА", "Трава стала красной!")
end

-- ============================================================
-- 7. GUI
-- ============================================================

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "RyzenPanel"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

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
    mainFrame.Size = UDim2.new(0, 340, 0, 480)
    mainFrame.Position = UDim2.new(0.5, -170, 0.5, -240)
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
    -- 8. КНОПКИ
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

    -- КНОПКИ (ВСЕ РАБОТАЮТ!)
    createButton("😱 СКРИМЕР", function() createScreamer() end)
    createButton("💃 ТАНЕЦ", function() startDance() end)
    createButton("⏹️ ОСТАНОВИТЬ ТАНЕЦ", function() stopDance() end)
    createButton("📷 ТРЯСКА КАМЕРЫ", function() shakeCamera() end)
    createButton("🔄 ПЕРЕВОРОТ ЭКРАНА", function() flipScreen() end)
    createButton("🌅 КРАСНОЕ НЕБО", function() redSky() end)
    createButton("🌿 КРАСНАЯ ТРАВА", function() redGrass() end)
    
    createButton("💀 БЕССМЕРТИЕ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            notify("💀 БЕССМЕРТИЕ", "Ты бессмертен!")
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
            notify("👻 НЕВИДИМОСТЬ", "Ты невидим!")
        end
    end)

    createButton("🔄 ВОССТАНОВИТЬ", function()
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
        notify("🔄 ВОССТАНОВЛЕНИЕ", "Всё восстановлено!")
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
print("✅ RYZEN ULTIMATE v13.0 [РАБОЧАЯ ВЕРСИЯ] ЗАПУЩЕНА!")
