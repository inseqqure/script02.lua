-- RYZEN ULTIMATE v13.0 - ХАКЕРСКАЯ ТЕМА
-- Пароль: ryzen2025

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer

-- ============================================================
-- 1. ФУНКЦИИ ДЛЯ ИЗМЕНЕНИЯ ТЕКСТУР
-- ============================================================

local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- СОЗДАНИЕ КРАСНО-ЧЕРНЫХ ТЕКСТУР
local function createRedBlackTexture()
    -- Создаем текстуру в памяти
    local textureId = "rbxassetid://15050311563" -- Красное небо
    
    -- Меняем все части на карте
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            pcall(function()
                -- Меняем цвет на красный/черный
                local colors = {
                    Color3.fromRGB(255, 0, 0),    -- Красный
                    Color3.fromRGB(200, 0, 0),    -- Темно-красный
                    Color3.fromRGB(150, 0, 0),    -- Еще темнее
                    Color3.fromRGB(0, 0, 0),      -- Черный
                    Color3.fromRGB(50, 0, 0),     -- Очень темный красный
                }
                v.Color = colors[math.random(1, #colors)]
                
                -- Делаем материал матовым или стеклянным
                local materials = {
                    Enum.Material.SmoothPlastic,
                    Enum.Material.Glass,
                    Enum.Material.Neon,
                }
                v.Material = materials[math.random(1, #materials)]
                
                -- Добавляем свечение некоторым частям
                if math.random(1, 3) == 1 then
                    v.Material = Enum.Material.Neon
                end
            end)
        end
    end
end

-- ИЗМЕНЕНИЕ НЕБА (ХАКЕРСКИЙ СТИЛЬ)
local function changeSkyToHacker()
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
        
        -- Хакерское небо (красное с черным)
        sky.SkyboxBk = "rbxassetid://15050311563"  -- Красное
        sky.SkyboxDn = "rbxassetid://15050311563"  -- Красное
        sky.SkyboxLf = "rbxassetid://15050311563"  -- Красное
        sky.SkyboxRt = "rbxassetid://15050311563"  -- Красное
        sky.SkyboxUp = "rbxassetid://15050311563"  -- Красное
        
        -- Настройки освещения
        Lighting.FogColor = Color3.fromRGB(200, 0, 0)
        Lighting.FogEnd = 1000
        Lighting.Brightness = 1.5
        Lighting.Ambient = Color3.fromRGB(50, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 0, 0)
        
        -- Создаем хакерские эффекты
        local effects = Instance.new("Folder")
        effects.Name = "HackerEffects"
        effects.Parent = game.Workspace
        
        -- Создаем красные партиклы по всей карте
        for i = 1, 100 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.5, 0.5, 0.5)
            part.Position = Vector3.new(
                math.random(-200, 200),
                math.random(0, 100),
                math.random(-200, 200)
            )
            part.BrickColor = BrickColor.new("Bright red")
            part.Material = Enum.Material.Neon
            part.Anchored = true
            part.CanCollide = false
            part.Parent = effects
            Debris:AddItem(part, 5)
        end
        
        -- Создаем красные лучи
        for i = 1, 20 do
            local beam = Instance.new("Part")
            beam.Size = Vector3.new(0.2, math.random(10, 50), 0.2)
            beam.Position = Vector3.new(
                math.random(-150, 150),
                math.random(10, 50),
                math.random(-150, 150)
            )
            beam.BrickColor = BrickColor.new("Bright red")
            beam.Material = Enum.Material.Neon
            beam.Anchored = true
            beam.CanCollide = false
            beam.Parent = effects
            Debris:AddItem(beam, 10)
        end
    end)
    
    notify("🌅 НЕБО", "Хакерское небо активировано!")
end

-- ПОЛНАЯ ТРАНСФОРМАЦИЯ КАРТЫ
local function transformMap()
    notify("🔥 ТРАНСФОРМАЦИЯ", "Начинаем изменение карты...")
    
    -- Меняем все текстуры
    createRedBlackTexture()
    
    -- Меняем небо
    changeSkyToHacker()
    
    -- Добавляем атмосферу
    pcall(function()
        -- Меняем цвет воды (если есть)
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                v.WaterColor = Color3.fromRGB(200, 0, 0)
                v.WaterReflectance = 0.5
                v.WaterTransparency = 0.5
            end
        end
        
        -- Меняем цвет земли в Terrain
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                for x = -50, 50, 10 do
                    for z = -50, 50, 10 do
                        pcall(function()
                            v:FillBlock(CFrame.new(x, -5, z), Vector3.new(10, 1, 10), Enum.Material.Air)
                        end)
                    end
                end
            end
        end
    end)
    
    notify("✅ ТРАНСФОРМАЦИЯ", "Карта полностью изменена!")
end

-- ВОССТАНОВЛЕНИЕ КАРТЫ
local function restoreMap()
    pcall(function()
        -- Удаляем эффекты
        local effects = game.Workspace:FindFirstChild("HackerEffects")
        if effects then effects:Destroy() end
        
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
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        
        -- Восстанавливаем цвета частей
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
-- 2. СОЗДАНИЕ GUI
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
    scroll.CanvasSize = UDim2.new(0, 0, 0, 500)
    scroll.ScrollBarThickness = 6
    scroll.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    -- ============================================================
    -- 3. СОЗДАНИЕ КНОПОК
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

    -- ============================================================
    -- 4. КНОПКИ
    -- ============================================================

    createButton("🔥 ПОЛНАЯ ТРАНСФОРМАЦИЯ КАРТЫ", function()
        transformMap()
    end)

    createButton("🌅 ТОЛЬКО ХАКЕРСКОЕ НЕБО", function()
        changeSkyToHacker()
    end)

    createButton("🎨 ТОЛЬКО КРАСНО-ЧЕРНЫЕ ТЕКСТУРЫ", function()
        createRedBlackTexture()
        notify("🎨 ТЕКСТУРЫ", "Все текстуры изменены на красно-черные!")
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

    createButton("🔫 ПОЛУЧИТЬ ОРУЖИЕ", function()
        local tool = Instance.new("Tool")
        tool.Name = "Ryzen_Weapon"
        tool.RequiresHandle = true
        tool.Parent = player.Backpack
        
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(1, 0.5, 2)
        handle.BrickColor = BrickColor.new("Really black")
        handle.Parent = tool
        notify("🔫 ОРУЖИЕ", "Оружие выдано!")
    end)

    createButton("👑 ВИЗУАЛЬНАЯ АДМИНКА", function()
        for _, plr in pairs(Players:GetPlayers()) do
            plr.DisplayName = "[ADMIN] " .. plr.DisplayName
        end
        notify("👑 АДМИНКА", "Визуальная админка выдана!")
    end)

    createButton("🔄 СБРОСИТЬ НАСТРОЙКИ", function()
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
            notify("🔄 СБРОС", "Все настройки сброшены!")
        end
    end)

    -- ============================================================
    -- 5. ЛОГИКА ЗАПУСКА
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
-- 6. ЗАПУСК
-- ============================================================

pcall(createGUI)
print("✅ RYZEN ULTIMATE v13.0 [ХАКЕРСКАЯ ТЕМА] ЗАПУЩЕНА!")
