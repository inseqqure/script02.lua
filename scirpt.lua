- ============================================================
-- RYZEN ULTIMATE v13.0 - ЧАСТЬ 1: ЗАГРУЗКА
-- ============================================================

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RyzenGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(0, 350, 0, 200)
loadFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
loadFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
loadFrame.BorderSizePixel = 3
loadFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
loadFrame.ZIndex = 999
loadFrame.Parent = gui

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 15)
loadCorner.Parent = loadFrame

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(0.9, 0, 0.25, 0)
loadText.Position = UDim2.new(0.05, 0, 0.1, 0)
loadText.BackgroundTransparency = 1
loadText.Text = "⚡ ЗАГРУЗКА RYZEN..."
loadText.TextColor3 = Color3.fromRGB(255, 0, 0)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 22
loadText.ZIndex = 1000
loadText.Parent = loadFrame

local loadBar = Instance.new("Frame")
loadBar.Size = UDim2.new(0.8, 0, 0.08, 0)
loadBar.Position = UDim2.new(0.1, 0, 0.45, 0)
loadBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
loadBar.ZIndex = 1000
loadBar.Parent = loadFrame

local loadFill = Instance.new("Frame")
loadFill.Size = UDim2.new(0, 0, 1, 0)
loadFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
loadFill.ZIndex = 1001
loadFill.Parent = loadBar

local loadPercent = Instance.new("TextLabel")
loadPercent.Size = UDim2.new(1, 0, 0.2, 0)
loadPercent.Position = UDim2.new(0, 0, 0.65, 0)
loadPercent.BackgroundTransparency = 1
loadPercent.Text = "0%"
loadPercent.TextColor3 = Color3.fromRGB(200, 200, 200)
loadPercent.Font = Enum.Font.GothamBold
loadPercent.TextSize = 18
loadPercent.ZIndex = 1000
loadPercent.Parent = loadFrame

-- Анимация прогресс-бара
for i = 1, 20 do
    task.wait(0.05)
    local progress = i / 20
    loadFill.Size = UDim2.new(progress, 0, 1, 0)
    loadPercent.Text = math.floor(progress * 100) .. "%"
    if progress < 0.3 then
        loadText.Text = "🔐 ИНИЦИАЛИЗАЦИЯ..."
    elseif progress < 0.6 then
        loadText.Text = "📡 ПОДКЛЮЧЕНИЕ..."
    elseif progress < 0.8 then
        loadText.Text = "⚡ ЗАГРУЗКА МОДУЛЕЙ..."
    else
        loadText.Text = "🔥 АКТИВАЦИЯ..."
    end
end
loadText.Text = "✅ ГОТОВО!"
loadPercent.Text = "100%"
loadFill.Size = UDim2.new(1, 0, 1, 0)
task.wait(0.3)
loadFrame:Destroy()
local passFrame = Instance.new("Frame")
passFrame.Size = UDim2.new(0, 380, 0, 220)
passFrame.Position = UDim2.new(0.5, -190, 0.5, -110)
passFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
passFrame.BorderSizePixel = 3
passFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
passFrame.ZIndex = 5
passFrame.Parent = gui

local passCorner = Instance.new("UICorner")
passCorner.CornerRadius = UDim.new(0, 12)
passCorner.Parent = passFrame

local passTitle = Instance.new("TextLabel")
passTitle.Size = UDim2.new(1, 0, 0, 55)
passTitle.Position = UDim2.new(0, 0, 0, 10)
passTitle.BackgroundTransparency = 1
passTitle.Text = "🔐 ВВЕДИТЕ ПАРОЛЬ"
passTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
passTitle.Font = Enum.Font.GothamBold
passTitle.TextSize = 22
passTitle.ZIndex = 6
passTitle.Parent = passFrame

local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(0.8, 0, 0, 45)
passBox.Position = UDim2.new(0.1, 0, 0.38, 0)
passBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
passBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passBox.PlaceholderText = "Введите пароль..."
passBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
passBox.Text = ""
passBox.Font = Enum.Font.Gotham
passBox.TextSize = 18
passBox.ZIndex = 6
passBox.Parent = passFrame

local passBoxCorner = Instance.new("UICorner")
passBoxCorner.CornerRadius = UDim.new(0, 8)
passBoxCorner.Parent = passBox

local passBtn = Instance.new("TextButton")
passBtn.Size = UDim2.new(0.4, 0, 0, 45)
passBtn.Position = UDim2.new(0.3, 0, 0.72, 0)
passBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
passBtn.Text = "🔓 ВОЙТИ"
passBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
passBtn.Font = Enum.Font.GothamBold
passBtn.TextSize = 18
passBtn.ZIndex = 6
passBtn.Parent = passFrame

local passBtnCorner = Instance.new("UICorner")
passBtnCorner.CornerRadius = UDim.new(0, 8)
passBtnCorner.Parent = passBtn

-- ============================================================
-- БАЗОВЫЕ ФУНКЦИИ И СТАРЫЕ МОДЫ
-- ============================================================

local function notify(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "⚡ RYZEN",
            Text = text,
            Duration = 3
        })
    end)
end

local function makeEverythingRed()
    pcall(function()
        local sky = game.Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", game.Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        game.Lighting.FogColor = Color3.fromRGB(200, 0, 0)
        game.Lighting.Brightness = 2
        game.Lighting.Ambient = Color3.fromRGB(100, 0, 0)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(100, 0, 0)
    end)
    pcall(function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not game.Players:GetPlayerFromCharacter(v.Parent) then
                v.Color = Color3.fromRGB(200, 0, 0)
                if math.random(1, 3) == 1 then v.Material = Enum.Material.Neon end
            end
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(200, 0, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(150, 0, 0))
                v.WaterColor = Color3.fromRGB(200, 0, 0)
            end
        end
    end)
    notify("Мир успешно окрашен!")
end

local function showScreamer()
    local scr = Instance.new("Frame")
    scr.Size = UDim2.new(1, 0, 1, 0)
    scr.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    scr.ZIndex = 9999
    scr.Parent = gui
    
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = "😱 RYZEN ATTACK! 😱"
    txt.TextColor3 = Color3.fromRGB(255, 0, 0)
    txt.Font = Enum.Font.GothamBlack
    txt.TextScaled = true
    txt.ZIndex = 10000
    txt.Parent = scr
    
    local shakeLoop = game:GetService("RunService").RenderStepped:Connect(function()
        scr.Position = UDim2.new(0, math.random(-40, 40), 0, math.random(-40, 40))
    end)
    
    pcall(function()
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://9120381772"
        sound.Volume = 3
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 3)
    end)
    
    task.wait(2)
    shakeLoop:Disconnect()
    scr:Destroy()
end

local danceTracks = {}
local function startDance()
    for _, p in pairs(game.Players:GetPlayers()) do
        local char = p.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
                pcall(function()
                    local anim = Instance.new("Animation")
                    anim.AnimationId = "rbxassetid://148840371"
                    local track = animator:LoadAnimation(anim)
                    track:Play()
                    track.Looped = true
                    danceTracks[p] = track
                end)
            end
        end
    end
    notify("Все начали танцевать!")
end

-- ============================================================
-- НОВЫЕ ХАК-ФУНКЦИИ (FLY, NOCLIP, SPEED)
-- ============================================================

local speedEnabled = false
local noclipEnabled = false
local flyEnabled = false
local speedValue = 100

-- Функция Speed (Скорость)
local function toggleSpeed()
    speedEnabled = not speedEnabled
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        if speedEnabled then
            hum.WalkSpeed = speedValue
            notify("Скорость включена (100)")
        else
            hum.WalkSpeed = 16
            notify("Скорость сброшена")
        end
    end
end

-- Следим за скоростью при респавне
player.CharacterAdded:Connect(function(char)
    if speedEnabled then
        local hum = char:WaitForChild("Humanoid", 5)
        if hum then hum.WalkSpeed = speedValue end
    end
end)

-- Функция Noclip (Сквозь стены)
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        notify("Noclip включен!")
    else
        notify("Noclip выключен!")
    end
end

game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Функция Fly (Полет)
local function toggleFly()
    flyEnabled = not flyEnabled
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if not root or not hum then return end
    
    if flyEnabled then
        notify("Полет включен! (W/A/S/D)")
        local bv = Instance.new("BodyVelocity")
        bv.Name = "RyzenFlyBV"
        bv.MaxForce = Vector3.new(0, 0, 0)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = root
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "RyzenFlyBG"
        bg.MaxTorque = Vector3.new(0, 0, 0)
        bg.CFrame = root.CFrame
        bg.Parent = root
        
        hum.PlatformStand = true
        
        task.spawn(function()
            local camera = workspace.CurrentCamera
            while flyEnabled and root and bv.Parent do
                game:GetService("RunService").RenderStepped:Wait()
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.CFrame = camera.CFrame
                
                local dir = Vector3.new(0, 0, 0)
                local uis = game:GetService("UserInputService")
                if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + camera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - camera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + camera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - camera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
                
                bv.Velocity = dir.Unit * 50
                if dir == Vector3.new(0, 0, 0) then bv.Velocity = Vector3.new(0, 0, 0) end
            end
        end)
    else
        notify("Полет отключен")
        hum.PlatformStand = false
        if root:FindFirstChild("RyzenFlyBV") then root.RyzenFlyBV:Destroy() end
        if root:FindFirstChild("RyzenFlyBG") then root.RyzenFlyBG:Destroy() end
    end
end
local function createMainMenu()
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 320, 0, 360) -- Увеличил размер под новые кнопки
    mainFrame.Position = UDim2.new(0.5, -160, 0.5, -180)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    mainFrame.Parent = gui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "⚡ RYZEN ПАНЕЛЬ ХАКОВ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = mainFrame

    -- Функция для быстрого создания кнопок (шаблон)
    local function createBtn(text, pos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.86, 0, 0, 38)
        btn.Position = pos
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Parent = mainFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn
        
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    -- Кнопки из прошлой версии
    createBtn("🔴 Окрасить мир", UDim2.new(0.07, 0, 0.13, 0), makeEverythingRed)
    createBtn("😱 Включить Скример", UDim2.new(0.07, 0, 0.25, 0), showScreamer)
    createBtn("🕺 Устроить Танцы", UDim2.new(0.07, 0, 0.37, 0), startDance)
    
    -- Новые хак-кнопки
    createBtn("⚡ Скорость (Speed 100)", UDim2.new(0.07, 0, 0.52, 0), toggleSpeed)
    createBtn("🧱 Сквозь Стены (Noclip)", UDim2.new(0.07, 0, 0.64, 0), toggleNoclip)
    createBtn("🕊️ Полет (Fly)", UDim2.new(0.07, 0, 0.76, 0), toggleFly)

    -- Кнопка закрытия меню
    local closeBtn = createBtn("❌ Закрыть Меню", UDim2.new(0.07, 0, 0.88, 0), function()
        mainFrame:Destroy()
        gui:Destroy()
    end)
    closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end

-- Проверка пароля при нажатии кнопки "ВОЙТИ"
passBtn.MouseButton1Click:Connect(function()
    if passBox.Text == "ryzen2025" then
        passFrame:Destroy()
        notify("Доступ разрешен! Открытие меню...")
        createMainMenu()
    else
        passBox.Text = ""
        passBox.PlaceholderText = "❌ НЕВЕРНЫЙ ПАРОЛЬ!"
        task.wait(1.5)
        passBox.PlaceholderText = "Введите пароль..."
    end
end)
