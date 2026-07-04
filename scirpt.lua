-- ============================================================
-- RYZEN ULTIMATE v13.0 - ФОРСИРОВАННЫЙ ЗАПУСК
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
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 3
        })
    end)
end

-- ============================================================
-- 0. ФОРСИРОВАННОЕ СОЗДАНИЕ GUI (ДАЖЕ ЕСЛИ ОШИБКИ)
-- ============================================================

local function createGUI()
    print("🔧 СОЗДАНИЕ GUI...")
    
    -- Пробуем разные места для GUI
    local guiParent = nil
    
    -- 1. Пробуем PlayerGui
    pcall(function()
        if player and player:FindFirstChild("PlayerGui") then
            guiParent = player.PlayerGui
        end
    end)
    
    -- 2. Если не работает - пробуем CoreGui
    if not guiParent then
        pcall(function()
            guiParent = game:GetService("CoreGui")
        end)
    end
    
    -- 3. Если ничего не работает - создаём новый
    if not guiParent then
        pcall(function()
            guiParent = Instance.new("ScreenGui")
            guiParent.Name = "RyzenGui"
            guiParent.Parent = player
        end)
    end
    
    if not guiParent then
        warn("❌ НЕ УДАЛОСЬ СОЗДАТЬ GUI!")
        return
    end
    
    print("✅ GUI создан в: " .. guiParent.Name)

    -- ============================================================
    -- 1. ЗАГРУЗОЧНЫЙ ЭКРАН (ВСЕГДА ПОЯВЛЯЕТСЯ)
    -- ============================================================

    local loadingFrame = Instance.new("Frame")
    loadingFrame.Name = "LoadingFrame"
    loadingFrame.Size = UDim2.new(0, 350, 0, 200)
    loadingFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
    loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    loadingFrame.BorderSizePixel = 3
    loadingFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
    loadingFrame.ZIndex = 999
    loadingFrame.Parent = guiParent

    local loadCorner = Instance.new("UICorner")
    loadCorner.CornerRadius = UDim.new(0, 15)
    loadCorner.Parent = loadingFrame

    -- Логотип
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(1, 0, 0, 60)
    logo.Position = UDim2.new(0, 0, 0, 15)
    logo.BackgroundTransparency = 1
    logo.Text = "⚡ RYZEN ULTIMATE ⚡"
    logo.TextColor3 = Color3.fromRGB(200, 0, 0)
    logo.Font = Enum.Font.GothamBold
    logo.TextSize = 28
    logo.ZIndex = 1000
    logo.Parent = loadingFrame

    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(0.9, 0, 0.2, 0)
    loadingText.Position = UDim2.new(0.05, 0, 0.35, 0)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "🔐 ИНИЦИАЛИЗАЦИЯ..."
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.Font = Enum.Font.Gotham
    loadingText.TextSize = 16
    loadingText.ZIndex = 1001
    loadingText.Parent = loadingFrame

    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0.8, 0, 0.06, 0)
    progressBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    progressBar.ZIndex = 1001
    progressBar.Parent = loadingFrame

    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progressBar

    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    progressFill.ZIndex = 1002
    progressFill.Parent = progressBar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = progressFill

    local progressText = Instance.new("TextLabel")
    progressText.Size = UDim2.new(1, 0, 0.2, 0)
    progressText.Position = UDim2.new(0, 0, 0.75, 0)
    progressText.BackgroundTransparency = 1
    progressText.Text = "0%"
    progressText.TextColor3 = Color3.fromRGB(200, 200, 200)
    progressText.Font = Enum.Font.Gotham
    progressText.TextSize = 14
    progressText.ZIndex = 1001
    progressText.Parent = loadingFrame

    -- ============================================================
    -- 2. АНИМАЦИЯ ЗАГРУЗКИ (100% ВИДИМА)
    -- ============================================================

    local function animateLoading()
        local steps = 30
        for i = 1, steps do
            task.wait(0.05)
            local progress = i / steps
            progressFill.Size = UDim2.new(progress, 0, 1, 0)
            progressText.Text = math.floor(progress * 100) .. "%"
            
            if progress < 0.25 then
                loadingText.Text = "🔐 ИНИЦИАЛИЗАЦИЯ ЗАЩИТЫ..."
            elseif progress < 0.5 then
                loadingText.Text = "📡 ПОДКЛЮЧЕНИЕ К СЕРВЕРУ..."
            elseif progress < 0.75 then
                loadingText.Text = "⚡ ЗАГРУЗКА МОДУЛЕЙ..."
            else
                loadingText.Text = "🔥 АКТИВАЦИЯ RYZEN..."
            end
        end
        
        loadingText.Text = "✅ ГОТОВО!"
        progressText.Text = "100%"
        progressFill.Size = UDim2.new(1, 0, 1, 0)
        
        task.wait(0.5)
        
        -- Плавное исчезновение
        local tween = TweenService:Create(loadingFrame, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Wait()
        
        loadingFrame:Destroy()
        showPassword()
    end

    -- ============================================================
    -- 3. ОКНО ПАРОЛЯ
    -- ============================================================

    local function showPassword()
        local passwordFrame = Instance.new("Frame")
        passwordFrame.Size = UDim2.new(0, 340, 0, 220)
        passwordFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
        passwordFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
        passwordFrame.BorderSizePixel = 2
        passwordFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
        passwordFrame.ZIndex = 5
        passwordFrame.Parent = guiParent

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
        passTitle.TextSize = 20
        passTitle.ZIndex = 6
        passTitle.Parent = passwordFrame

        local passSub = Instance.new("TextLabel")
        passSub.Size = UDim2.new(1, 0, 0, 25)
        passSub.Position = UDim2.new(0, 0, 0, 60)
        passSub.BackgroundTransparency = 1
        passSub.Text = "Введите пароль для доступа"
        passSub.TextColor3 = Color3.fromRGB(150, 150, 150)
        passSub.Font = Enum.Font.Gotham
        passSub.TextSize = 14
        passSub.ZIndex = 6
        passSub.Parent = passwordFrame

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

        local textCorner = Instance.new("UICorner")
        textCorner.CornerRadius = UDim.new(0, 6)
        textCorner.Parent = textBox

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

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = submitBtn

        submitBtn.MouseButton1Click:Connect(function()
            if textBox.Text == "ryzen2025" then
                passwordFrame:Destroy()
                showMainMenu()
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

        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then submitBtn.MouseButton1Click:Fire() end
        end)
    end

    -- ============================================================
    -- 4. ГЛАВНОЕ МЕНЮ
    -- ============================================================

    local function showMainMenu()
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 360, 0, 500)
        mainFrame.Position = UDim2.new(0.5, -180, 0.5, -250)
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        mainFrame.BorderSizePixel = 2
        mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
        mainFrame.Active = true
        mainFrame.Draggable = true
        mainFrame.Parent = guiParent

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

        -- ВРЕМЕННЫЕ ФУНКЦИИ (заглушки)
        local function tempNotify(text)
            notify("✅", text)
        end

        -- КНОПКИ
        createButton("🔥 ВСЁ КРАСНОЕ", function()
            tempNotify("Всё красное!")
            -- здесь будет код из основного скрипта
        end)

        createButton("😱 СКРИМЕР", function()
            tempNotify("Скример!")
        end)

        createButton("💃 ТАНЕЦ", function()
            tempNotify("Танец!")
        end)

        createButton("📷 ТРЯСКА", function()
            tempNotify("Тряска!")
        end)

        createButton("🔄 ПЕРЕВОРОТ", function()
            tempNotify("Переворот!")
        end)

        createButton("👨 СКИН ГИТЛЕРА", function()
            tempNotify("Скин Гитлера!")
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

        -- Хоткей X
        UserInputService.InputBegan:Connect(function(input, gpe)
            if not gpe and input.KeyCode == Enum.KeyCode.X then
                mainFrame.Visible = not mainFrame.Visible
            end
        end)

        print("✅ МЕНЮ СОЗДАНО!")
    end

    -- ============================================================
    -- 5. ЗАПУСК
    -- ============================================================

    task.spawn(animateLoading)
end

-- ============================================================
-- 6. ФОРСИРОВАННЫЙ ЗАПУСК
-- ============================================================

print("🔥 ЗАПУСК RYZEN ULTIMATE...")

-- Защита от ошибок
pcall(function()
    -- Ждём появления игрока
    while not player or not player.Parent do
        task.wait(0.5)
    end
    
    -- Ждём PlayerGui
    while not player:FindFirstChild("PlayerGui") do
        task.wait(0.5)
    end
    
    print("✅ ИГРОК ЗАГРУЖЕН, СОЗДАЁМ GUI...")
    createGUI()
end)

-- Если что-то пошло не так - пробуем ещё раз через 2 секунды
task.wait(2)
if not game:GetService("CoreGui"):FindFirstChild("LoadingFrame") and not player.PlayerGui:FindFirstChild("LoadingFrame") then
    print("⚠️ ПОВТОРНАЯ ПОПЫТКА СОЗДАНИЯ GUI...")
    pcall(createGUI)
end

print("✅ RYZEN ULTIMATE - ФОРСИРОВАННЫЙ ЗАПУСК АКТИВИРОВАН!")
