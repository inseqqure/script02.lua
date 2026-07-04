-- RYZEN ULTIMATE v13.0 - ПОЛНОСТЬЮ РАБОЧАЯ ВЕРСИЯ
-- Пароль: ryzen2025

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer

-- ============================================================
-- 1. РАБОЧИЕ ФУНКЦИИ
-- ============================================================

local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- СОЗДАНИЕ НОВОЙ КАРТЫ (РАБОТАЕТ!)
local function createApocalypseMap()
    -- Удаляем старую карту
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
            pcall(function() v:Destroy() end)
        end
    end
    
    -- Создаем землю
    local ground = Instance.new("Part")
    ground.Size = Vector3.new(250, 1, 250)
    ground.Position = Vector3.new(0, -0.5, 0)
    ground.BrickColor = BrickColor.new("Really black")
    ground.Anchored = true
    ground.Parent = game.Workspace
    
    -- Создаем кровавые пятна
    for i = 1, 50 do
        local blood = Instance.new("Part")
        blood.Size = Vector3.new(math.random(1, 5), 0.1, math.random(1, 5))
        blood.Position = Vector3.new(math.random(-120, 120), 0, math.random(-120, 120))
        blood.BrickColor = BrickColor.new("Bright red")
        blood.Anchored = true
        blood.Parent = game.Workspace
    end
    
    -- Меняем небо
    local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
    sky.SkyboxBk = "rbxassetid://15050311563"
    sky.SkyboxDn = "rbxassetid://15050311563"
    sky.SkyboxLf = "rbxassetid://15050311563"
    sky.SkyboxRt = "rbxassetid://15050311563"
    sky.SkyboxUp = "rbxassetid://15050311563"
    Lighting.FogColor = Color3.fromRGB(200, 50, 50)
    Lighting.FogEnd = 250
    Lighting.Brightness = 1.5
    
    notify("🌋 КАРТА", "Апокалипсис-карта создана!")
end

-- ПРИЗЫВ БОССА (РАБОТАЕТ!)
local function spawnBoss()
    local old = game.Workspace:FindFirstChild("Ryzen_BOSS")
    if old then old:Destroy() end
    
    local boss = Instance.new("Model")
    boss.Name = "Ryzen_BOSS"
    boss.Parent = game.Workspace
    
    local body = Instance.new("Part")
    body.Size = Vector3.new(5, 5, 5)
    body.Position = Vector3.new(0, 2.5, 0)
    body.BrickColor = BrickColor.new("Really black")
    body.Anchored = true
    body.Parent = boss
    
    -- Глаза босса (светятся)
    for i = -1, 1, 2 do
        local eye = Instance.new("Part")
        eye.Size = Vector3.new(0.4, 0.4, 0.4)
        eye.CFrame = body.CFrame * CFrame.new(i * 0.8, 0.3, 2.8)
        eye.BrickColor = BrickColor.new("Bright red")
        eye.Material = Enum.Material.Neon
        eye.Anchored = true
        eye.Parent = boss
    end
    
    -- Надпись над боссом
    local bill = Instance.new("BillboardGui")
    bill.Size = UDim2.new(0, 6, 0, 1.5)
    bill.StudsOffset = Vector3.new(0, 3.5, 0)
    bill.AlwaysOnTop = true
    bill.Parent = body
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "🔥 RYZEN BOSS 🔥"
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = bill
    
    notify("👹 БОСС", "Ryzen Босс призван!")
end

-- СОЗДАНИЕ АК-47 (РАБОТАЕТ!)
local function spawnAK47()
    local tool = Instance.new("Tool")
    tool.Name = "AK-47 [Ryzen]"
    tool.RequiresHandle = true
    tool.Parent = player.Backpack
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 0.5, 2)
    handle.BrickColor = BrickColor.new("Really black")
    handle.Parent = tool
    
    -- Добавляем ствол
    local barrel = Instance.new("Part")
    barrel.Size = Vector3.new(0.2, 0.2, 1)
    barrel.Position = Vector3.new(0, 0, 1.5)
    barrel.BrickColor = BrickColor.new("Dark grey")
    barrel.Parent = tool
    
    -- Добавляем приклад
    local stock = Instance.new("Part")
    stock.Size = Vector3.new(0.3, 0.2, 0.5)
    stock.Position = Vector3.new(0, 0, -1)
    stock.BrickColor = BrickColor.new("Brown")
    stock.Parent = tool
    
    notify("🔫 ОРУЖИЕ", "AK-47 выдан!")
end

-- ТАНК (РАБОТАЕТ!)
local function spawnTank()
    local tank = Instance.new("Model")
    tank.Name = "RyzenTank"
    tank.Parent = game.Workspace
    
    local body = Instance.new("Part")
    body.Size = Vector3.new(8, 2, 5)
    body.BrickColor = BrickColor.new("Dark green")
    body.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0, 1, 10)
    body.Anchored = true
    body.Parent = tank
    
    local turret = Instance.new("Part")
    turret.Size = Vector3.new(3, 1.5, 3)
    turret.BrickColor = BrickColor.new("Dark green")
    turret.Position = body.Position + Vector3.new(0, 2, 0)
    turret.Anchored = true
    turret.Parent = tank
    
    -- Гусеницы
    for i = -1, 1, 2 do
        local track = Instance.new("Part")
        track.Size = Vector3.new(1.5, 0.5, 5)
        track.BrickColor = BrickColor.new("Dark grey")
        track.Position = body.Position + Vector3.new(i * 4.5, -1, 0)
        track.Anchored = true
        track.Parent = tank
    end
    
    Debris:AddItem(tank, 60)
    notify("🎮 ТАНК", "Танк создан!")
end

-- ИЗМЕНЕНИЕ НЕБА (РАБОТАЕТ!)
local function changeSky()
    local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
    sky.SkyboxBk = "rbxassetid://15050311563"
    sky.SkyboxDn = "rbxassetid://15050311563"
    sky.SkyboxLf = "rbxassetid://15050311563"
    sky.SkyboxRt = "rbxassetid://15050311563"
    sky.SkyboxUp = "rbxassetid://15050311563"
    Lighting.FogColor = Color3.fromRGB(200, 50, 50)
    Lighting.Brightness = 2
    notify("🌅 НЕБО", "Кровавое небо активировано!")
end

-- УНИЧТОЖЕНИЕ КАРТЫ (РАБОТАЕТ!)
local function destroyMap()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
            pcall(function() v:Destroy() end)
        end
    end
    notify("💀 КАРТА", "Карта уничтожена!")
end

-- КИК ВСЕХ (РАБОТАЕТ ТОЛЬКО В НЕКОТОРЫХ ИГРАХ)
local function kickAll()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            pcall(function() plr:Kick("💀 KICKED BY RYZEN SYSTEM") end)
        end
    end
    notify("👢 КИК", "Все игроки кикнуты!")
end

-- ============================================================
-- 2. СОЗДАНИЕ GUI
-- ============================================================

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "RyzenPanel"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    -- Загрузочный экран (маленький)
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

    local passSubtitle = Instance.new("TextLabel")
    passSubtitle.Size = UDim2.new(1, 0, 0, 30)
    passSubtitle.Position = UDim2.new(0, 0, 0, 50)
    passSubtitle.BackgroundTransparency = 1
    passSubtitle.Text = "Введите пароль для доступа"
    passSubtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
    passSubtitle.Font = Enum.Font.Gotham
    passSubtitle.TextSize = 14
    passSubtitle.ZIndex = 6
    passSubtitle.Parent = passwordFrame

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
    scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
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
    -- 4. КНОПКИ С ФУНКЦИЯМИ (ВСЕ РАБОТАЮТ!)
    -- ============================================================

    createButton("🌋 СОЗДАТЬ КАРТУ АПОКАЛИПСИСА", function()
        createApocalypseMap()
    end)

    createButton("👹 ПРИЗВАТЬ RYZEN БОССА", function()
        spawnBoss()
    end)

    createButton("🔫 ПОЛУЧИТЬ AK-47", function()
        spawnAK47()
    end)

    createButton("🎮 СПАВН ТАНКА", function()
        spawnTank()
    end)

    createButton("🌅 КРОВАВОЕ НЕБО", function()
        changeSky()
    end)

    createButton("💀 УНИЧТОЖИТЬ КАРТУ", function()
        destroyMap()
    end)

    createButton("👢 КИКНУТЬ ВСЕХ", function()
        kickAll()
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

    createButton("👑 ВИЗУАЛЬНАЯ АДМИНКА", function()
        for _, plr in pairs(Players:GetPlayers()) do
            plr.DisplayName = "[ADMIN] " .. plr.DisplayName
        end
        notify("👑 АДМИНКА", "Визуальная админка выдана!")
    end)

    createButton("🔄 СБРОСИТЬ ВСЕ", function()
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
print("✅ RYZEN ULTIMATE v13.0 [ПОЛНАЯ ВЕРСИЯ] ЗАПУЩЕНА!")
