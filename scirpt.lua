-- ============================================================
-- RYZEN ULTIMATE v13.0 - ПРОСТАЯ РАБОЧАЯ ВЕРСИЯ
-- Пароль: ryzen2025
-- ============================================================

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

-- ============================================================
-- 1. ЗАГРУЗОЧНЫЙ ЭКРАН (ОГРОМНЫЙ, ЧТОБЫ ТОЧНО УВИДЕТЬ)
-- ============================================================

local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(1, 0, 1, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadFrame.ZIndex = 999
loadFrame.Parent = gui

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(1, 0, 0.3, 0)
loadText.Position = UDim2.new(0, 0, 0.35, 0)
loadText.BackgroundTransparency = 1
loadText.Text = "⚡ ЗАГРУЗКА RYZEN..."
loadText.TextColor3 = Color3.fromRGB(255, 0, 0)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 50
loadText.ZIndex = 1000
loadText.Parent = loadFrame

local loadBar = Instance.new("Frame")
loadBar.Size = UDim2.new(0.6, 0, 0.05, 0)
loadBar.Position = UDim2.new(0.2, 0, 0.5, 0)
loadBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadBar.ZIndex = 1000
loadBar.Parent = loadFrame

local loadFill = Instance.new("Frame")
loadFill.Size = UDim2.new(0, 0, 1, 0)
loadFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
loadFill.ZIndex = 1001
loadFill.Parent = loadBar

local loadPercent = Instance.new("TextLabel")
loadPercent.Size = UDim2.new(1, 0, 0.1, 0)
loadPercent.Position = UDim2.new(0, 0, 0.58, 0)
loadPercent.BackgroundTransparency = 1
loadPercent.Text = "0%"
loadPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
loadPercent.Font = Enum.Font.GothamBold
loadPercent.TextSize = 30
loadPercent.ZIndex = 1000
loadPercent.Parent = loadFrame

-- ============================================================
-- 2. АНИМАЦИЯ ЗАГРУЗКИ
-- ============================================================

for i = 1, 20 do
    task.wait(0.1)
    local progress = i / 20
    loadFill.Size = UDim2.new(progress, 0, 1, 0)
    loadPercent.Text = math.floor(progress * 100) .. "%"
    
    if progress < 0.3 then
        loadText.Text = "🔐 ЗАЩИТА..."
    elseif progress < 0.6 then
        loadText.Text = "📡 ПОДКЛЮЧЕНИЕ..."
    elseif progress < 0.8 then
        loadText.Text = "⚡ МОДУЛИ..."
    else
        loadText.Text = "🔥 АКТИВАЦИЯ..."
    end
end

loadText.Text = "✅ ГОТОВО!"
loadPercent.Text = "100%"
loadFill.Size = UDim2.new(1, 0, 1, 0)
task.wait(0.5)

loadFrame:Destroy()

-- ============================================================
-- 3. ОКНО ПАРОЛЯ
-- ============================================================

local passFrame = Instance.new("Frame")
passFrame.Size = UDim2.new(0, 400, 0, 250)
passFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
passFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
passFrame.BorderSizePixel = 3
passFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
passFrame.Parent = gui

local passTitle = Instance.new("TextLabel")
passTitle.Size = UDim2.new(1, 0, 0, 60)
passTitle.Position = UDim2.new(0, 0, 0, 10)
passTitle.BackgroundTransparency = 1
passTitle.Text = "🔐 ВВЕДИТЕ ПАРОЛЬ"
passTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
passTitle.Font = Enum.Font.GothamBold
passTitle.TextSize = 24
passTitle.Parent = passFrame

local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(0.8, 0, 0, 50)
passBox.Position = UDim2.new(0.1, 0, 0.35, 0)
passBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
passBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passBox.PlaceholderText = "Введите пароль..."
passBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
passBox.Text = ""
passBox.Font = Enum.Font.Gotham
passBox.TextSize = 20
passBox.Parent = passFrame

local passBtn = Instance.new("TextButton")
passBtn.Size = UDim2.new(0.4, 0, 0, 50)
passBtn.Position = UDim2.new(0.3, 0, 0.7, 0)
passBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
passBtn.Text = "🔓 ВОЙТИ"
passBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
passBtn.Font = Enum.Font.GothamBold
passBtn.TextSize = 20
passBtn.Parent = passFrame

local function showMainMenu()
    passFrame:Destroy()
    
    -- ============================================================
    -- 4. ГЛАВНОЕ МЕНЮ
    -- ============================================================
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 400, 0, 500)
    main.Position = UDim2.new(0.5, -200, 0.5, -250)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    main.BorderSizePixel = 3
    main.BorderColor3 = Color3.fromRGB(200, 0, 0)
    main.Active = true
    main.Draggable = true
    main.Parent = gui
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    title.Text = "⚡ RYZEN PANEL ⚡"
    title.TextColor3 = Color3.fromRGB(200, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = main
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -60)
    scroll.Position = UDim2.new(0, 5, 0, 55)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
    scroll.ScrollBarThickness = 6
    scroll.Parent = main
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll
    
    local function addButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 45)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Parent = scroll
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        end)
        btn.MouseButton1Click:Connect(callback)
    end
    
    -- КНОПКИ
    addButton("🔥 ВСЁ КРАСНОЕ", function()
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("BasePart") then
                pcall(function() v.Color = Color3.fromRGB(200, 0, 0) end)
            end
        end
        local sky = game.Lighting:FindFirstChild("Sky") or Instance.new("Sky", game.Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        game.Lighting.FogColor = Color3.fromRGB(200, 0, 0)
    end)
    
    addButton("😱 СКРИМЕР", function()
        local scr = Instance.new("Frame")
        scr.Size = UDim2.new(1, 0, 1, 0)
        scr.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        scr.ZIndex = 999
        scr.Parent = gui
        
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.Text = "😱 RYZEN ATTACK! 😱"
        txt.TextColor3 = Color3.fromRGB(255, 0, 0)
        txt.Font = Enum.Font.GothamBlack
        txt.TextSize = 80
        txt.TextScaled = true
        txt.ZIndex = 1000
        txt.Parent = scr
        
        task.wait(2)
        scr:Destroy()
    end)
    
    addButton("💃 ТАНЕЦ", function()
        for _, p in pairs(game.Players:GetPlayers()) do
            local char = p.Character
            if char and char:FindFirstChild("Humanoid") then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://148840371"
                local track = char.Humanoid:LoadAnimation(anim)
                track:Play()
                track.Looped = true
            end
        end
    end)
    
    addButton("📷 ТРЯСКА", function()
        local cam = game.Workspace.CurrentCamera
        local orig = cam.CFrame
        for i = 1, 30 do
            cam.CFrame = orig * CFrame.new(
                math.random(-20, 20)/10,
                math.random(-20, 20)/10,
                math.random(-20, 20)/10
            )
            task.wait(0.02)
        end
        cam.CFrame = orig
    end)
    
    addButton("🔄 ПЕРЕВОРОТ", function()
        local cam = game.Workspace.CurrentCamera
        local orig = cam.CFrame
        for i = 0, 180, 10 do
            cam.CFrame = orig * CFrame.Angles(0, 0, math.rad(i))
            task.wait(0.02)
        end
        task.wait(0.5)
        for i = 180, 0, -10 do
            cam.CFrame = orig * CFrame.Angles(0, 0, math.rad(i))
            task.wait(0.02)
        end
        cam.CFrame = orig
    end)
    
    addButton("👢 КИК ВСЕХ", function()
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                pcall(function() p:Kick("KICKED BY RYZEN!") end)
            end
        end
    end)
    
    addButton("💀 БЕССМЕРТИЕ", function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
        end
    end)
    
    addButton("💨 СКОРОСТЬ 120", function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 120
        end
    end)
    
    addButton("⬆️ ПРЫЖОК 200", function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 200
        end
    end)
    
    addButton("👻 НЕВИДИМОСТЬ", function()
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Transparency = 1
                end
            end
        end
    end)
    
    addButton("🔄 ВОССТАНОВИТЬ", function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
            char.Humanoid.JumpPower = 50
            char.Humanoid.MaxHealth = 100
            char.Humanoid.Health = 100
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Transparency = 0
                end
            end
        end
        game.Lighting.FogColor = Color3.fromRGB(255, 255, 255)
    end)
    
    -- ХОТКЕЙ X
    game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.X then
            main.Visible = not main.Visible
        end
    end)
end

-- ============================================================
-- 5. ЛОГИКА ПАРОЛЯ
-- ============================================================

passBtn.MouseButton1Click:Connect(function()
    if passBox.Text == "ryzen2025" then
        showMainMenu()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅",
            Text = "ДОСТУП РАЗРЕШЕН!",
            Duration = 3
        })
    else
        passBox.Text = ""
        passBox.PlaceholderText = "❌ НЕВЕРНЫЙ ПАРОЛЬ!"
        passBox.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
        task.wait(1.5)
        passBox.PlaceholderText = "Введите пароль..."
        passBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

passBox.FocusLost:Connect(function(enter)
    if enter then passBtn.MouseButton1Click:Fire() end
end)

print("✅ RYZEN ULTIMATE ЗАПУЩЕН!")
