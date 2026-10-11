-- Script Gk Reach - Rayfield UI
-- Criador: Lara
-- Key: Gk01

-- ========== KEY SYSTEM ==========
local KEY_CORRETA = "Gk01"
local keyAceita = false

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "GkKeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.5
bg.Parent = keyGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 320, 0, 220)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

local kc = Instance.new("UICorner")
kc.CornerRadius = UDim.new(0, 12)
kc.Parent = keyFrame

local ks = Instance.new("UIStroke")
ks.Color = Color3.fromRGB(255, 255, 255)
ks.Thickness = 2
ks.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 45)
keyTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyTitle.Text = "🔐 Gk Reach - Key"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 16
keyTitle.Parent = keyFrame

local ktc = Instance.new("UICorner")
ktc.CornerRadius = UDim.new(0, 12)
ktc.Parent = keyTitle

local keyInfo = Instance.new("TextLabel")
keyInfo.Size = UDim2.new(1, 0, 0, 25)
keyInfo.Position = UDim2.new(0, 0, 0, 55)
keyInfo.BackgroundTransparency = 1
keyInfo.Text = "Digite a Key para acessar"
keyInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
keyInfo.Font = Enum.Font.Gotham
keyInfo.TextSize = 13
keyInfo.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.85, 0, 0, 40)
keyBox.Position = UDim2.new(0.075, 0, 0, 90)
keyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
keyBox.PlaceholderText = "Digite a Key..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.GothamBold
keyBox.TextSize = 14
keyBox.Parent = keyFrame

local kbc = Instance.new("UICorner")
kbc.CornerRadius = UDim.new(0, 8)
kbc.Parent = keyBox

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0.85, 0, 0, 40)
keyBtn.Position = UDim2.new(0.075, 0, 0, 145)
keyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
keyBtn.Text = "CONFIRMAR"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.Font = Enum.Font.GothamBlack
keyBtn.TextSize = 14
keyBtn.Parent = keyFrame

local kbc2 = Instance.new("UICorner")
kbc2.CornerRadius = UDim.new(0, 8)
kbc2.Parent = keyBtn

local keyErr = Instance.new("TextLabel")
keyErr.Size = UDim2.new(1, 0, 0, 20)
keyErr.Position = UDim2.new(0, 0, 0, 195)
keyErr.BackgroundTransparency = 1
keyErr.Text = ""
keyErr.TextColor3 = Color3.fromRGB(255, 50, 50)
keyErr.Font = Enum.Font.GothamBold
keyErr.TextSize = 12
keyErr.Parent = keyFrame

local function checarKey()
    if keyBox.Text == KEY_CORRETA then
        keyAceita = true
        keyBtn.Text = "✅ KEY CORRETA!"
        keyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.5)
        keyGui:Destroy()
        print("✅ Key correta!")
    else
        keyErr.Text = "❌ Key incorreta!"
        keyBox.Text = ""
    end
end

keyBtn.MouseButton1Click:Connect(checarKey)
keyBox.FocusLost:Connect(function(enter)
    if enter then checarKey() end
end)

repeat task.wait(0.1) until keyAceita

-- ========== RAYFIELD UI ==========
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Gk Reach",
    Icon = 0,
    LoadingTitle = "Gk Reach",
    LoadingSubtitle = "by Lara",
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.RightControl,
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "GkReach"
    },
    KeySystem = false
})

-- ========== SERVIÇOS ==========
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer

-- ========== CONFIG ==========
local CONFIG = {
    reach = 10,
    showReachSphere = true,
    autoSecondTouch = true,
    scanCooldown = 1.5,
    ballNames = {
        "TPS", "ESA", "MRS", "PRS", "MPS", "SSS", "AIFA", "RBZ",
        "RSF", "VEF", "SAML"
    }
}

local balls = {}
local lastRefresh = 0
local reachSphere
local ballSet = {}

for _, n in ipairs(CONFIG.ballNames) do
    ballSet[n] = true
end

-- ========== FUNÇÕES REACH ==========
local function refreshBalls(force)
    if not force and tick() - lastRefresh < CONFIG.scanCooldown then return end
    lastRefresh = tick()
    table.clear(balls)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and ballSet[v.Name] then
            balls[#balls + 1] = v
        end
    end
end

local function getValidParts(char)
    local parts = {}
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            parts[#parts + 1] = v
        end
    end
    return parts
end

local function updateReachSphere()
    if not CONFIG.showReachSphere then
        if reachSphere then reachSphere:Destroy() end
        reachSphere = nil
        return
    end
    if not reachSphere then
        reachSphere = Instance.new("Part")
        reachSphere.Name = "GkReachSphere"
        reachSphere.Shape = Enum.PartType.Ball
        reachSphere.Anchored = true
        reachSphere.CanCollide = false
        reachSphere.Transparency = 0.8
        reachSphere.Material = Enum.Material.ForceField
        reachSphere.Color = Color3.fromRGB(0, 0, 0)
        reachSphere.Parent = Workspace
        RunService.RenderStepped:Connect(function()
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                reachSphere.Position = hrp.Position
            end
        end)
    end
    reachSphere.Size = Vector3.new(CONFIG.reach * 2, CONFIG.reach * 2, CONFIG.reach * 2)
end

local function processTouch()
    local char = player.Character
    if not char then return end
    for _, part in ipairs(getValidParts(char)) do
        for _, ball in ipairs(balls) do
            if ball and ball.Parent then
                if (ball.Position - part.Position).Magnitude <= CONFIG.reach then
                    pcall(function()
                        firetouchinterest(ball, part, 0)
                        firetouchinterest(ball, part, 1)
                    end)
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if CONFIG.autoSecondTouch then
        processTouch()
    end
end)

task.spawn(function()
    while true do
        refreshBalls(false)
        task.wait(CONFIG.scanCooldown)
    end
end)

-- ========== ABA REACH ==========
local Tab = Window:CreateTab("Reach", 4483362458)

Tab:CreateSection("Configurações")

Tab:CreateToggle({
    Name = "Ativar Reach",
    CurrentValue = true,
    Flag = "ReachToggle",
    Callback = function(value)
        CONFIG.autoSecondTouch = value
        if value then
            updateReachSphere()
        end
    end
})

Tab:CreateToggle({
    Name = "Mostrar Esfera do Reach",
    CurrentValue = true,
    Flag = "SphereToggle",
    Callback = function(value)
        CONFIG.showReachSphere = value
        updateReachSphere()
    end
})

Tab:CreateSlider({
    Name = "Alcance do Reach",
    Range = {1, 10},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 10,
    Flag = "ReachSlider",
    Callback = function(value)
        CONFIG.reach = value
        updateReachSphere()
    end
})

Tab:CreateSection("Controles Rápidos")

Tab:CreateButton({
    Name = "➖ Diminuir Reach",
    Callback = function()
        CONFIG.reach = math.max(1, CONFIG.reach - 1)
        updateReachSphere()
        Rayfield:Notify({
            Title = "Gk Reach",
            Content = "Reach: " .. CONFIG.reach,
            Duration = 2,
            Image = 4483362458
        })
    end
})

Tab:CreateButton({
    Name = "➕ Aumentar Reach",
    Callback = function()
        CONFIG.reach = math.min(10, CONFIG.reach + 1)
        updateReachSphere()
        Rayfield:Notify({
            Title = "Gk Reach",
            Content = "Reach: " .. CONFIG.reach,
            Duration = 2,
            Image = 4483362458
        })
    end
})

-- ========== ABA SKYBOX ==========
local TabSky = Window:CreateTab("Skybox", 4483362458)
TabSky:CreateSection("Céus Disponíveis")

local function resetarCeu()
    pcall(function()
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        local atm = Lighting:FindFirstChildOfClass("Atmosphere")
        if atm then atm:Destroy() end
        local sky = Lighting:FindFirstChildOfClass("Sky")
        if sky then
            sky.SkyboxBk = ""
            sky.SkyboxDn = ""
            sky.SkyboxFt = ""
            sky.SkyboxLf = ""
            sky.SkyboxRt = ""
            sky.SkyboxUp = ""
        end
    end)
end

local function aplicarCeu(config)
    pcall(function()
        local atmAntigo = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmAntigo then atmAntigo:Destroy() end
        local skyAntigo = Lighting:FindFirstChildOfClass("Sky")
        if skyAntigo then skyAntigo:Destroy() end
        
        Lighting.ClockTime = config.ClockTime or 14
        Lighting.Brightness = config.Brightness or 2
        Lighting.Ambient = config.Ambient or Color3.fromRGB(70, 70, 70)
        Lighting.OutdoorAmbient = config.OutdoorAmbient or Color3.fromRGB(128, 128, 128)
        Lighting.FogEnd = config.FogEnd or 100000
        Lighting.FogStart = config.FogStart or 0
        Lighting.FogColor = config.FogColor or Color3.fromRGB(192, 192, 192)
        
        local atm = Instance.new("Atmosphere")
        atm.Density = config.Density or 0.3
        atm.Offset = config.Offset or 0
        atm.Color = config.AtmosphereColor or Color3.fromRGB(199, 199, 199)
        atm.Decay = config.Decay or Color3.fromRGB(106, 112, 125)
        atm.Glare = config.Glare or 0
        atm.Haze = config.Haze or 1.5
        atm.Parent = Lighting
        
        local sky = Instance.new("Sky")
        sky.Parent = Lighting
    end)
end

local ceus = {
    {Name = "☀️ Dia Limpo", ClockTime = 14, Brightness = 2, Ambient = Color3.fromRGB(70, 70, 70), OutdoorAmbient = Color3.fromRGB(128, 128, 128), FogEnd = 100000, FogColor = Color3.fromRGB(192, 192, 192), AtmosphereColor = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125), Density = 0.3, Haze = 1.5},
    {Name = "🌅 Pôr do Sol", ClockTime = 17.5, Brightness = 2, Ambient = Color3.fromRGB(100, 60, 30), OutdoorAmbient = Color3.fromRGB(200, 100, 50), FogEnd = 5000, FogColor = Color3.fromRGB(255, 120, 50), AtmosphereColor = Color3.fromRGB(255, 150, 80), Decay = Color3.fromRGB(255, 100, 50), Density = 0.4, Haze = 3},
    {Name = "🌇 Céu Vermelho", ClockTime = 18, Brightness = 1.5, Ambient = Color3.fromRGB(120, 30, 20), OutdoorAmbient = Color3.fromRGB(220, 60, 40), FogEnd = 3000, FogColor = Color3.fromRGB(200, 50, 30), AtmosphereColor = Color3.fromRGB(255, 80, 60), Decay = Color3.fromRGB(255, 50, 30), Density = 0.5, Haze = 4},
    {Name = "🌙 Noite Estrelada", ClockTime = 0, Brightness = 1, Ambient = Color3.fromRGB(20, 20, 40), OutdoorAmbient = Color3.fromRGB(40, 40, 80), FogEnd = 10000, FogColor = Color3.fromRGB(10, 10, 30), AtmosphereColor = Color3.fromRGB(30, 30, 60), Decay = Color3.fromRGB(20, 20, 50), Density = 0.3, Haze = 0},
    {Name = "💜 Céu Roxo", ClockTime = 20, Brightness = 1.5, Ambient = Color3.fromRGB(60, 30, 90), OutdoorAmbient = Color3.fromRGB(120, 60, 180), FogEnd = 5000, FogColor = Color3.fromRGB(90, 50, 150), AtmosphereColor = Color3.fromRGB(150, 80, 200), Decay = Color3.fromRGB(100, 50, 180), Density = 0.4, Haze = 2},
    {Name = "🌌 Galáxia", ClockTime = 0, Brightness = 0.8, Ambient = Color3.fromRGB(30, 10, 60), OutdoorAmbient = Color3.fromRGB(80, 40, 150), FogEnd = 8000, FogColor = Color3.fromRGB(40, 20, 80), AtmosphereColor = Color3.fromRGB(100, 50, 180), Decay = Color3.fromRGB(60, 30, 120), Density = 0.35, Haze = 1},
    {Name = "☁️ Nublado", ClockTime = 12, Brightness = 1.5, Ambient = Color3.fromRGB(80, 80, 80), OutdoorAmbient = Color3.fromRGB(150, 150, 150), FogEnd = 3000, FogColor = Color3.fromRGB(180, 180, 180), AtmosphereColor = Color3.fromRGB(200, 200, 200), Decay = Color3.fromRGB(120, 120, 120), Density = 0.6, Haze = 3},
    {Name = "🌫️ Nevoeiro", ClockTime = 8, Brightness = 1.2, Ambient = Color3.fromRGB(100, 100, 100), OutdoorAmbient = Color3.fromRGB(180, 180, 180), FogEnd = 500, FogColor = Color3.fromRGB(200, 200, 200), AtmosphereColor = Color3.fromRGB(220, 220, 220), Decay = Color3.fromRGB(150, 150, 150), Density = 0.7, Haze = 5},
    {Name = "🌊 Azul Oceano", ClockTime = 14, Brightness = 2, Ambient = Color3.fromRGB(30, 80, 120), OutdoorAmbient = Color3.fromRGB(80, 150, 200), FogEnd = 6000, FogColor = Color3.fromRGB(60, 130, 180), AtmosphereColor = Color3.fromRGB(100, 180, 220), Decay = Color3.fromRGB(40, 100, 150), Density = 0.35, Haze = 2},
    {Name = "💚 Aurora Verde", ClockTime = 2, Brightness = 1.2, Ambient = Color3.fromRGB(20, 60, 40), OutdoorAmbient = Color3.fromRGB(60, 180, 100), FogEnd = 6000, FogColor = Color3.fromRGB(40, 120, 80), AtmosphereColor = Color3.fromRGB(80, 200, 120), Decay = Color3.fromRGB(30, 100, 60), Density = 0.4, Haze = 1.5},
    {Name = "🔥 Céu de Lava", ClockTime = 18, Brightness = 1.8, Ambient = Color3.fromRGB(120, 40, 20), OutdoorAmbient = Color3.fromRGB(255, 80, 30), FogEnd = 2000, FogColor = Color3.fromRGB(255, 60, 20), AtmosphereColor = Color3.fromRGB(255, 100, 50), Decay = Color3.fromRGB(200, 60, 30), Density = 0.5, Haze = 6},
    {Name = "❄️ Céu de Gelo", ClockTime = 10, Brightness = 2.5, Ambient = Color3.fromRGB(180, 200, 220), OutdoorAmbient = Color3.fromRGB(220, 240, 255), FogEnd = 5000, FogColor = Color3.fromRGB(200, 220, 240), AtmosphereColor = Color3.fromRGB(220, 240, 255), Decay = Color3.fromRGB(180, 200, 220), Density = 0.4, Haze = 2},
}

for _, ceu in ipairs(ceus) do
    TabSky:CreateButton({
        Name = ceu.Name,
        Callback = function()
            aplicarCeu(ceu)
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "Céu: " .. ceu.Name,
                Duration = 2,
                Image = 4483362458
            })
        end
    })
end

TabSky:CreateSection("Controle")

TabSky:CreateButton({
    Name = "🔄 RESETAR CÉU",
    Callback = function()
        resetarCeu()
        Rayfield:Notify({
            Title = "Gk Reach",
            Content = "Céu restaurado!",
            Duration = 2,
            Image = 4483362458
        })
    end
})

TabSky:CreateSlider({
    Name = "Horário do Dia",
    Range = {0, 24},
    Increment = 0.5,
    Suffix = "h",
    CurrentValue = 14,
    Flag = "ClockTimeSlider",
    Callback = function(value)
        pcall(function()
            Lighting.ClockTime = value
        end)
    end
})

-- ========== ABA TRAIL PLAYER ==========
local TabTrail = Window:CreateTab("Trail Player", 4483362458)
TabTrail:CreateSection("Player Trail")

local TRAIL_CORES = {
    {Color3.fromRGB(255, 255, 255), "Branco"},
    {Color3.fromRGB(200, 200, 200), "Cinza Claro"},
    {Color3.fromRGB(130, 130, 130), "Cinza"},
    {Color3.fromRGB(30, 30, 30), "Preto"},
    {Color3.fromRGB(255, 50, 50), "Vermelho"},
    {Color3.fromRGB(160, 0, 0), "Vermelho Escuro"},
    {Color3.fromRGB(255, 105, 180), "Rosa"},
    {Color3.fromRGB(220, 20, 60), "Carmesim"},
    {Color3.fromRGB(255, 182, 193), "Rosa Bebê"},
    {Color3.fromRGB(255, 20, 147), "Rosa Choque"},
    {Color3.fromRGB(255, 140, 0), "Laranja Escuro"},
    {Color3.fromRGB(255, 165, 0), "Laranja"},
    {Color3.fromRGB(255, 215, 0), "Dourado"},
    {Color3.fromRGB(255, 255, 0), "Amarelo"},
    {Color3.fromRGB(173, 255, 47), "Verde Neon"},
    {Color3.fromRGB(50, 205, 50), "Verde Limão"},
    {Color3.fromRGB(0, 180, 0), "Verde"},
    {Color3.fromRGB(0, 100, 0), "Verde Escuro"},
    {Color3.fromRGB(0, 255, 127), "Verde Água"},
    {Color3.fromRGB(64, 224, 208), "Turquesa"},
    {Color3.fromRGB(0, 210, 210), "Ciano Claro"},
    {Color3.fromRGB(0, 180, 255), "Ciano"},
    {Color3.fromRGB(30, 100, 255), "Azul"},
    {Color3.fromRGB(0, 0, 180), "Azul Escuro"},
    {Color3.fromRGB(75, 0, 130), "Índigo"},
    {Color3.fromRGB(148, 0, 211), "Roxo"},
    {Color3.fromRGB(200, 0, 200), "Magenta"},
    {Color3.fromRGB(238, 130, 238), "Lavanda"},
    {Color3.fromRGB(139, 69, 19), "Marrom"},
    {Color3.fromRGB(192, 192, 192), "Prata"},
    {Color3.fromRGB(0, 255, 255), "Ciano Neon"},
    {Color3.fromRGB(255, 255, 255), "Branco Neon"},
    {Color3.fromRGB(57, 255, 20), "Verde Elétrico"},
    {Color3.fromRGB(255, 165, 0), "Âmbar"},
}

local playerTrailOn = false
local pTrailColor = Color3.fromRGB(255, 255, 255)
local pAtt0, pAtt1, pTrail = nil, nil, nil

local function buildPlayerTrail()
    local c = player.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if pAtt0 and pAtt0.Parent then pAtt0:Destroy() end
    if pAtt1 and pAtt1.Parent then pAtt1:Destroy() end
    pAtt0 = Instance.new("Attachment", hrp)
    pAtt0.Position = Vector3.new(0, 1, 0)
    pAtt1 = Instance.new("Attachment", hrp)
    pAtt1.Position = Vector3.new(0, -1, 0)
    pTrail = Instance.new("Trail", hrp)
    pTrail.Attachment0 = pAtt0
    pTrail.Attachment1 = pAtt1
    pTrail.Color = ColorSequence.new(pTrailColor)
    pTrail.Lifetime = 0.7
    pTrail.MinLength = 0
    pTrail.FaceCamera = true
    pTrail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
end

local function destroyPlayerTrail()
    if pAtt0 and pAtt0.Parent then pAtt0:Destroy() end
    if pAtt1 and pAtt1.Parent then pAtt1:Destroy() end
    pAtt0, pAtt1, pTrail = nil, nil, nil
end

TabTrail:CreateToggle({
    Name = "✨ Player Trail",
    CurrentValue = false,
    Flag = "PlayerTrailToggle",
    Callback = function(v)
        playerTrailOn = v
        if v then
            buildPlayerTrail()
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "✨ Player Trail ATIVADO!",
                Duration = 2,
                Image = 4483362458
            })
        else
            destroyPlayerTrail()
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "🔴 Player Trail desativado!",
                Duration = 2,
                Image = 4483362458
            })
        end
    end
})

TabTrail:CreateColorPicker({
    Name = "Cor do Trail",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "TrailColor",
    Callback = function(v)
        pTrailColor = v
        if pTrail then
            pTrail.Color = ColorSequence.new(v)
        end
    end
})

player.CharacterAdded:Connect(function()
    if playerTrailOn then
        task.wait(0.5)
        buildPlayerTrail()
    end
end)

-- Cores rápidas
TabTrail:CreateSection("Cores Rápidas")

for _, corData in ipairs(TRAIL_CORES) do
    TabTrail:CreateButton({
        Name = corData[2],
        Callback = function()
            pTrailColor = corData[1]
            if pTrail then
                pTrail.Color = ColorSequence.new(corData[1])
            end
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "Cor: " .. corData[2],
                Duration = 2,
                Image = 4483362458
            })
        end
    })
end

-- ========== INIT ==========
refreshBalls(true)
updateReachSphere()

Rayfield:Notify({
    Title = "Gk Reach",
    Content = "✅ Script carregado!",
    Duration = 3,
    Image = 4483362458
})

print("✅ Gk Reach carregado!")
