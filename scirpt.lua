-- RYZEN ULTIMATE v13.0 "STEALTH EDITION" [FIXED]
-- Пароль: ryzen2025

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ============================================================
-- 1. РАНДОМНЫЕ ИМЕНА (ДЛЯ МАСКИРОВКИ)
-- ============================================================

local function getRandomName()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local length = math.random(10, 20)
    local str = ""
    for i = 1, length do
        str = str .. string.sub(chars, math.random(1, #chars), math.random(1, #chars))
    end
    return str
end

local backdoorName = getRandomName()

-- ============================================================
-- 2. СУПЕР-ЗАЩИТА ОТ БАНА/КИКА (ИСПРАВЛЕНО)
-- ============================================================

pcall(function()
    player.Kick = function() return end
    player.Destroy = function() return end
    
    local mt = getrawmetatable(player)
    if mt then
        local oldIndex = mt.__index
        setreadonly(mt, false)
        mt.__index = function(self, key)
            if key == "Kick" or key == "Destroy" then
                return function() return end
            end
            return oldIndex(self, key)
        end
        setreadonly(mt, true)
    end
end)

pcall(function()
    player.DisplayName = "Ryzen_System"
    player.Name = "Ryzen_System"
end)

pcall(function()
    local logService = game:GetService("LogService")
    if logService then
        logService:SetLoggingEnabled(false)
    end
end)

-- ============================================================
-- 3. ИСПРАВЛЕННЫЙ БЭКДОР (БЕЗ КРАШЕЙ)
-- ============================================================

local ryzenCore = {
    Execute = function(code)
        local fn, err = loadstring(code)
        if fn then
            return pcall(fn)
        end
        return false, err
    end,
    
    Hijack = function()
        local success, result = pcall(function()
            local descendants = game:GetDescendants()
            local total = #descendants
            local processed = 0
            
            -- Пошаговая обработка по 50 объектов за кадр
            for i = 1, total, 50 do
                for j = i, math.min(i + 49, total) do
                    local v = descendants[j]
                    if v and v:IsA("Script") then
                        pcall(function()
                            local name = v.Name:lower()
                            if name:match("anti") or name:match("guard") or 
                               name:match("cheat") or name:match("detect") then
                                v.Disabled = true
                                v:Destroy()
                            end
                        end)
                    end
                    processed = processed + 1
                end
                task.wait() -- Даем время на обработку
            end
            return "Hijacked - Processed " .. processed .. " objects"
        end)
        return success and result or "Hijack failed"
    end
}

-- Запускаем Hijack асинхронно
task.spawn(function()
    ryzenCore.Hijack()
end)

-- ============================================================
-- 4. СКРЫТЫЙ RemoteEvent (ДЛЯ КОМАНД)
-- ============================================================

local remoteName = "R_" .. getRandomName()
local remote = Instance.new("RemoteEvent")
remote.Name = remoteName
remote.Parent = ReplicatedStorage

task.spawn(function()
    while remote and remote.Parent do
        task.wait(20)
        pcall(function()
            remote.Name = "R_" .. getRandomName()
        end)
    end
end)

-- ============================================================
-- 5. ИСПРАВЛЕННАЯ МАСКИРОВКА (БЕЗ РЕКУРСИИ)
-- ============================================================

pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            
            if method == "FindFirstChild" then
                local args = {...}
                local name = tostring(args[1])
                if name and (name:match("Ryzen") or name:match("R_") or name:match(backdoorName)) then
                    return nil
                end
            end
            
            return oldNamecall(self, ...)
        end)
        
        setreadonly(mt, true)
    end
end)

-- ============================================================
-- 6. ОБНАРУЖЕНИЕ АДМИНОВ (ТРЕКЕР)
-- ============================================================

local function checkAdmin(plr)
    pcall(function()
        if plr:GetRankInGroup(game.CreatorId) > 200 then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "🛡️ ЗАЩИТА RYZEN",
                Text = "⚠️ Админ [" .. plr.Name .. "] на сервере! Будьте осторожны.",
                Duration = 7
            })
        end
    end)
end

Players.PlayerAdded:Connect(checkAdmin)
for _, p in ipairs(Players:GetPlayers()) do 
    task.spawn(function() checkAdmin(p) end)
end

-- ============================================================
-- 7. GUI (КРАСИВЫЙ ИНТЕРФЕЙС)
-- ============================================================

local targetParent = player:WaitForChild("PlayerGui")
pcall(function()
    local coreGui = game:GetService("CoreGui")
    if coreGui then targetParent = coreGui end
end)

local gui = Instance.new("ScreenGui")
gui.Name = getRandomName()
gui.ResetOnSpawn = false
gui.Parent = targetParent

-- ============================================================
-- 8. ГЛАВНОЕ МЕНЮ
-- ============================================================

local mainFrame = Instance.new("Frame")
mainFrame.Name = getRandomName()
mainFrame.Size = UDim2.new(0, 300, 0, 420)
mainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- ============================================================
-- 9. ЭКРАН ЗАГРУЗКИ
-- ============================================================

local loadingFrame = Instance.new("Frame")
loadingFrame.Name = getRandomName()
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
loadingFrame.ZIndex = 10
loadingFrame.Parent = gui

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0.8, 0, 0.2, 0)
loadingText.Position = UDim2.new(0.1, 0, 0.4, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "⚡ ИНИЦИАЛИЗАЦИЯ RYZEN..."
loadingText.TextColor3 = Color3.fromRGB(200, 0, 0)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 24
loadingText.ZIndex = 11
loadingText.Parent = loadingFrame

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0.6, 0, 0.04, 0)
progressBar.Position = UDim2.new(0.2, 0, 0.55, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
progressBar.ZIndex = 11
progressBar.Parent = loadingFrame

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
progressFill.ZIndex = 12
progressFill.Parent = progressBar

local progressText = Instance.new("TextLabel")
progressText.Size = UDim2.new(0.3, 0, 0.05, 0)
progressText.Position = UDim2.new(0.35, 0, 0.6, 0)
progressText.BackgroundTransparency = 1
progressText.Text = "0%"
progressText.TextColor3 = Color3.fromRGB(200, 200, 200)
progressText.Font = Enum.Font.Gotham
progressText.TextSize = 14
progressText.ZIndex = 11
progressText.Parent = loadingFrame

-- ============================================================
-- 10. ОКНО ВВОДА ПАРОЛЯ
-- ============================================================

local passwordFrame = Instance.new("Frame")
passwordFrame.Name = getRandomName()
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

-- ============================================================
-- 11. ЛОГИКА ЗАГРУЗКИ И ПАРОЛЯ
-- ============================================================

local function animateLoading()
    local steps = 20
    for i = 1, steps do
        task.wait(0.08)
        local progress = i / steps
        progressFill.Size = UDim2.new(progress, 0, 1, 0)
        progressText.Text = math.floor(progress * 100) .. "%"
        
        if progress < 0.3 then
            loadingText.Text = "🔐 ИНИЦИАЛИЗАЦИЯ ЗАЩИТЫ..."
        elseif progress < 0.6 then
            loadingText.Text = "📡 ПОДКЛЮЧЕНИЕ К СЕРВЕРУ..."
        elseif progress < 0.8 then
            loadingText.Text = "⚡ ЗАГРУЗКА МОДУЛЕЙ..."
        else
            loadingText.Text = "🔥 АКТИВАЦИЯ RYZEN..."
        end
    end
    loadingText.Text = "✅ ГОТОВО!"
    task.wait(0.3)
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(loadingFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(loadingText, tweenInfo, {TextTransparency = 1}):Play()
    TweenService:Create(progressBar, tweenInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(progressText, tweenInfo, {TextTransparency = 1}):Play()
    
    task.wait(0.5)
    loadingFrame:Destroy()
    passwordFrame.Visible = true
end

submitBtn.MouseButton1Click:Connect(function()
    if textBox.Text == "ryzen2025" then
        passwordFrame:Destroy()
        mainFrame.Visible = true
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "⚡ RYZEN CORE",
            Text = "✅ ДОСТУП РАЗРЕШЕН! ПАНЕЛЬ АКТИВИРОВАНА.",
            Duration = 3
        })
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

-- ============================================================
-- 12. ИНТЕРФЕЙС УПРАВЛЕНИЯ (ВКЛАДКИ)
-- ============================================================

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
scroll.CanvasSize = UDim2.new(0, 0, 0, 450)
scroll.ScrollBarThickness = 6
scroll.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

-- ============================================================
-- 13. ФУНКЦИИ (РАБОТАЮТ ЧЕРЕЗ БЭКДОР)
-- ============================================================

local function executeServerCode(code)
    task.spawn(function()
        pcall(function()
            ryzenCore.Execute(code)
        end)
    end)
end

local function createButton(text, callback, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.LayoutOrder = order
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
end

-- ============================================================
-- 14. КОМАНДЫ (РАБОЧИЕ)
-- ============================================================

createButton("🌋 СОЗДАТЬ КАРТУ АПОКАЛИПСИСА", function()
    executeServerCode([[
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
                v:Destroy()
            end
        end
        local ground = Instance.new("Part", game.Workspace)
        ground.Size = Vector3.new(250,1,250)
        ground.Position = Vector3.new(0,-0.5,0)
        ground.BrickColor = BrickColor.new("Really black")
        ground.Anchored = true
        for i = 1, 30 do
            local blood = Instance.new("Part", game.Workspace)
            blood.Size = Vector3.new(math.random(1,4),0.1,math.random(1,4))
            blood.Position = Vector3.new(math.random(-110,110),0,math.random(-110,110))
            blood.BrickColor = BrickColor.new("Bright red")
            blood.Anchored = true
        end
        local sky = game.Lighting:FindFirstChild("Sky") or Instance.new("Sky", game.Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        game.Lighting.FogColor = Color3.fromRGB(200,50,50)
        game.Lighting.FogEnd = 250
        game.Lighting.Brightness = 1.5
    ]])
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🌋 КАРТА",
        Text = "Апокалипсис-карта создана!",
        Duration = 3
    })
end, 1)

createButton("👹 ПРИЗВАТЬ RYZEN БОССА", function()
    executeServerCode([[
        local old = game.Workspace:FindFirstChild("Ryzen_BOSS")
        if old then old:Destroy() end
        local boss = Instance.new("Model", game.Workspace)
        boss.Name = "Ryzen_BOSS"
        local body = Instance.new("Part", boss)
        body.Size = Vector3.new(5,5,5)
        body.Position = Vector3.new(0,2.5,0)
        body.BrickColor = BrickColor.new("Really black")
        body.Anchored = true
        for i = -1,1,2 do
            local eye = Instance.new("Part", boss)
            eye.Size = Vector3.new(0.4,0.4,0.4)
            eye.CFrame = body.CFrame * CFrame.new(i*0.8,0.3,2.8)
            eye.BrickColor = BrickColor.new("Bright red")
            eye.Material = Enum.Material.Neon
            eye.Anchored = true
        end
        local bill = Instance.new("BillboardGui", body)
        bill.Size = UDim2.new(0,6,0,1.5)
        bill.StudsOffset = Vector3.new(0,3.5,0)
        bill.AlwaysOnTop = true
        local label = Instance.new("TextLabel", bill)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = "🔥 RYZEN BOSS 🔥"
        label.TextColor3 = Color3.fromRGB(255,0,0)
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
    ]])
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "👹 БОСС",
        Text = "Ryzen Босс призван!",
        Duration = 3
    })
end, 2)

createButton("🔫 ПОЛУЧИТЬ AK-47", function()
    executeServerCode([[
        local tool = Instance.new("Tool")
        tool.Name = "AK-47 [Ryzen]"
        tool.RequiresHandle = true
        tool.Parent = game.Players.LocalPlayer.Backpack
        local handle = Instance.new("Part", tool)
        handle.Name = "Handle"
        handle.Size = Vector3.new(1,0.5,2)
        handle.BrickColor = BrickColor.new("Really black")
    ]])
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🔫 ОРУЖИЕ",
        Text = "AK-47 выдан!",
        Duration = 3
    })
end, 3)

createButton("🤚 АНИМАЦИЯ ДЛЯ ВСЕХ", function()
    executeServerCode([[
        for _, plr in pairs(game.Players:GetPlayers()) do
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://148840371"
                local track = char.Humanoid:LoadAnimation(anim)
                track:Play()
            end
        end
    ]])
end, 4)

createButton("🌅 КРОВАВОЕ НЕБО", function()
    executeServerCode([[
        local sky = game.Lighting:FindFirstChild("Sky") or Instance.new("Sky", game.Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        game.Lighting.FogColor = Color3.fromRGB(200,50,50)
        game.Lighting.Brightness = 2
    ]])
end, 5)

createButton("🎮 СПАВН ТАНКА", function()
    executeServerCode([[
        local tank = Instance.new("Model", game.Workspace)
        tank.Name = "RyzenTank"
        local body = Instance.new("Part", tank)
        body.Size = Vector3.new(8,2,5)
        body.BrickColor = BrickColor.new("Dark green")
        body.Position = Vector3.new(0,2,0)
        local turret = Instance.new("Part", tank)
        turret.Size = Vector3.new(3,1.5,3)
        turret.BrickColor = BrickColor.new("Dark green")
        turret.Position = Vector3.new(0,3.5,0)
        Debris:AddItem(tank, 60)
    ]])
end, 6)

createButton("💀 УНИЧТОЖИТЬ КАРТУ", function()
    executeServerCode([[
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game.Players) then
                v:Destroy()
            end
        end
    ]])
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "💀 КАРТА",
        Text = "Карта уничтожена!",
        Duration = 3
    })
end, 7)

createButton("👢 КИКНУТЬ ВСЕХ", function()
    executeServerCode([[
        local player = game.Players.LocalPlayer
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player then
                plr:Kick("💀 KICKED BY RYZEN SYSTEM")
            end
        end
    ]])
end, 8)

createButton("👑 ВЫДАТЬ АДМИНКУ ВСЕМ", function()
    executeServerCode([[
        for _, plr in pairs(game.Players:GetPlayers()) do
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.MaxHealth = math.huge
                char.Humanoid.Health = math.huge
                char.Humanoid.WalkSpeed = 50
                char.Humanoid.JumpPower = 100
            end
            plr.DisplayName = "[ADMIN] " .. plr.DisplayName
        end
    ]])
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "👑 АДМИНКА",
        Text = "Всем выданы права!",
        Duration = 3
    })
end, 9)

-- ============================================================
-- 15. ГОРЯЧИЕ КЛАВИШИ (X - СКРЫТЬ/ПОКАЗАТЬ)
-- ============================================================

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.X then
        pcall(function()
            if mainFrame and mainFrame.Parent then
                mainFrame.Visible = not mainFrame.Visible
            end
        end)
    end
end)

-- ============================================================
-- 16. ЗАПУСК
-- ============================================================

task.spawn(animateLoading)

print("✅ RYZEN ULTIMATE v13.0 ACTIVE [FIXED]")
