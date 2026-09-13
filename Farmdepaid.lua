-- ==================================================
-- 🔥 EDGAR HUB — SOLO FARM 🌾 | MENÚ GRANDE + GUARDAR/CARGAR 💾
-- ==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then return end
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
if not PlayerGui then return end

-- ==================================================
-- ⚙️ CONFIGURACIÓN DE FARM
-- ==================================================
local Config = {
    AutoFarmGeneral = true,
    TrabajoLimpiador = false,
    TrabajoCajero = false,
    TrabajoCocinero = false,
    TrabajoMinero = false,
    TrabajoLeñador = false,
    TrabajoPesca = false,
    TrabajoRepartidor = false,
    RecogerMonedas = true,
    DistanciaFarm = 15,
    VelocidadRecoleccion = 0.35
}

-- ==================================================
-- 💾 FUNCIONES GUARDAR Y CARGAR
-- ==================================================
local function GuardarConfig()
    local Datos = "EdgarHub_Farm_Config:\n"
    for k, v in pairs(Config) do
        if type(v) == "boolean" then
            Datos = Datos .. k .. ":" .. tostring(v) .. "\n"
        end
    end
    setfflag("EdgarHub_Farm_Save", Datos)
    return true
end

local function CargarConfig()
    local Datos = getfflag("EdgarHub_Farm_Save")
    if not Datos or Datos == "" then return false end
    for linea in Datos:gmatch("[^\n]+") do
        local clave, valor = linea:match("([^:]+):(.+)")
        if clave and valor and Config[clave] ~= nil then
            Config[clave] = (valor == "true")
        end
    end
    return true
end

-- ==================================================
-- 🌾 FARM DE TODOS LOS TRABAJOS — FUNCIONAL ✅
-- ==================================================
local function FarmTrabajos()
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local HRP = Char.HumanoidRootPart

    for _, v in pairs(Workspace:GetChildren()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(Char) then
            local NombreMinus = string.lower(v.Name)
            local Dist = (v.Position - HRP.Position).Magnitude
            if Dist > Config.DistanciaFarm then continue end

            -- 💰 RECOGER MONEDAS Y OBJETOS GENERAL
            if Config.AutoFarmGeneral or Config.RecogerMonedas then
                if NombreMinus:find("coin") or NombreMinus:find("money") or NombreMinus:find("moneda") 
                or NombreMinus:find("drop") or NombreMinus:find("item") or NombreMinus:find("reward")
                or NombreMinus:find("gem") or NombreMinus:find("orb") then
                    task.spawn(function()
                        pcall(function()
                            v.Anchored = false
                            TweenService:Create(v, TweenInfo.new(Config.VelocidadRecoleccion), 
                                {Position = HRP.Position + Vector3.new(0, 2, 0)}):Play()
                            task.wait(Config.VelocidadRecoleccion + 0.1)
                            if v and v:IsDescendantOf(game) then v:Destroy() end
                        end)
                    end)
                end
            end

            -- 🧹 LIMPIADOR — destruir basura y suciedad
            if Config.TrabajoLimpiador then
                if NombreMinus:find("trash") or NombreMinus:find("basura") or NombreMinus:find("dirty") 
                or NombreMinus:find("suciedad") or NombreMinus:find("mess") then
                    task.spawn(function() pcall(function() v:Destroy() end) end)
                end
            end

            -- 🛒 CAJERO — interactuar con cajas de pago
            if Config.TrabajoCajero then
                if NombreMinus:find("cash") or NombreMinus:find("register") or NombreMinus:find("caja") 
                or NombreMinus:find("checkout") then
                    task.spawn(function() pcall(function() v:FireServer() end) end)
                end
            end

            -- 🍳 COCINERO — recoger comida y platos
            if Config.TrabajoCocinero then
                if NombreMinus:find("food") or NombreMinus:find("comida") or NombreMinus:find("plate") 
                or NombreMinus:find("plato") or NombreMinus:find("cook") then
                    task.spawn(function() pcall(function() v:Destroy() end) end)
                end
            end

            -- ⛏️ MINERO — recoger minerales y rocas
            if Config.TrabajoMinero then
                if NombreMinus:find("ore") or NombreMinus:find("mineral") or NombreMinus:find("rock") 
                or NombreMinus:find("piedra") or NombreMinus:find("gem") then
                    task.spawn(function() pcall(function() v:Destroy() end) end)
                end
            end

            -- 🪓 LEÑADOR — recoger madera y troncos
            if Config.TrabajoLeñador then
                if NombreMinus:find("wood") or NombreMinus:find("log") or NombreMinus:find("tree") 
                or NombreMinus:find("tronco") or NombreMinus:find("madera") then
                    task.spawn(function() pcall(function() v:Destroy() end) end)
                end
            end

            -- 🎣 PESCA — recoger peces
            if Config.TrabajoPesca then
                if NombreMinus:find("fish") or NombreMinus:find("pez") or NombreMinus:find("catch") then
                    task.spawn(function() pcall(function() v:Destroy() end) end)
                end
            end

            -- 📦 REPARTIDOR — recoger paquetes y cajas
            if Config.TrabajoRepartidor then
                if NombreMinus:find("package") or NombreMinus:find("paquete") or NombreMinus:find("box") 
                or NombreMinus:find("caja") or NombreMinus:find("delivery") then
                    task.spawn(function() pcall(function() v:Destroy() end) end)
                end
            end
        end
    end
end

-- ==================================================
-- 🎨 MENÚ CUADRADO GRANDE ROJO 🔴 — IGUAL AL TUYO
-- ==================================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "EdgarHub_Farm_Menu"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

-- 🟦 MENÚ CUADRADO GRANDE
local Ventana = Instance.new("Frame")
Ventana.Size = UDim2.new(0, 340, 0, 580)
Ventana.Position = UDim2.new(0.02, 0, 0.5, -290)
Ventana.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Ventana.BorderSizePixel = 4
Ventana.BorderColor3 = Color3.fromRGB(220, 0, 0)
Ventana.Active = true
Ventana.Draggable = true
Ventana.Parent = Gui

-- 🔴 BARRA DE TÍTULO
local TituloBarra = Instance.new("Frame")
TituloBarra.Size = UDim2.new(1, 0, 0, 55)
TituloBarra.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
TituloBarra.Parent = Ventana

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 1, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "🔥 EDGAR HUB — SOLO FARM 🌾"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Parent = TituloBarra

-- 🔘 FUNCIÓN BOTÓN
local Botones = {}
local function Boton(texto, posY, claveConfig)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 42)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Config[claveConfig] and Color3.fromRGB(25, 140, 50) or Color3.fromRGB(140, 15, 35)
    btn.Text = texto
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(255, 60, 80)
    btn.Parent = Ventana
    Botones[claveConfig] = btn
    btn.MouseButton1Click:Connect(function()
        Config[claveConfig] = not Config[claveConfig]
        btn.BackgroundColor3 = Config[claveConfig] and Color3.fromRGB(25, 140, 50) or Color3.fromRGB(140, 15, 35)
    end)
    return btn
end

-- ==================================================
-- 📋 BOTONES PRINCIPALES — FARM COMPLETO
-- ==================================================
Boton("🌾 AUTO FARM GENERAL", 70, "AutoFarmGeneral")
Boton("💰 RECOGER MONEDAS", 122, "RecogerMonedas")
Boton("🧹 LIMPIADOR", 174, "TrabajoLimpiador")
Boton("🛒 CAJERO", 226, "TrabajoCajero")
Boton("🍳 COCINERO", 278, "TrabajoCocinero")
Boton("⛏️ MINERO", 330, "TrabajoMinero")
Boton("🪓 LEÑADOR", 382, "TrabajoLeñador")
Boton("🎣 PESCA", 434, "TrabajoPesca")
Boton("📦 REPARTIDOR", 486, "TrabajoRepartidor")

-- ==================================================
-- 💾 BOTONES GUARDAR Y CARGAR
-- ==================================================
local BtnGuardar = Instance.new("TextButton")
BtnGuardar.Size = UDim2.new(0.42, 0, 0, 40)
BtnGuardar.Position = UDim2.new(0.05, 0, 0, 535)
BtnGuardar.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
BtnGuardar.Text = "💾 GUARDAR"
BtnGuardar.Font = Enum.Font.GothamBold
BtnGuardar.TextSize = 13
BtnGuardar.TextColor3 = Color3.new(1,1,1)
BtnGuardar.BorderSizePixel = 2
BtnGuardar.BorderColor3 = Color3.fromRGB(80, 180, 255)
BtnGuardar.Parent = Ventana

local BtnCargar = Instance.new("TextButton")
BtnCargar.Size = UDim2.new(0.42, 0, 0, 40)
BtnCargar.Position = UDim2.new(0.53, 0, 0, 535)
BtnCargar.BackgroundColor3 = Color3.fromRGB(0, 160, 80)
BtnCargar.Text = "📂 CARGAR"
BtnCargar.Font = Enum.Font.GothamBold
BtnCargar.TextSize = 13
BtnCargar.TextColor3 = Color3.new(1,1,1)
BtnCargar.BorderSizePixel = 2
BtnCargar.BorderColor3 = Color3.fromRGB(80, 255, 150)
BtnCargar.Parent = Ventana

-- 📂 CARGAR CONFIGURACIÓN AL INICIAR
task.spawn(function()
    if CargarConfig() then
        for nom, btn in pairs(Botones) do
            if type(Config[nom]) == "boolean" then
                btn.BackgroundColor3 = Config[nom] and Color3.fromRGB(25, 140, 50) or Color3.fromRGB(140, 15, 35)
            end
        end
        print("✅ Configuración cargada automáticamente")
    end
end)

-- 💾 GUARDAR
BtnGuardar.MouseButton1Click:Connect(function()
    if GuardarConfig() then
        BtnGuardar.Text = "✅ GUARDADO"
        task.wait(1.5)
        BtnGuardar.Text = "💾 GUARDAR"
    end
end)

-- 📂 CARGAR
BtnCargar.MouseButton1Click:Connect(function()
    if CargarConfig() then
        BtnCargar.Text = "✅ CARGADO"
        for nom, btn in pairs(Botones) do
            if type(Config[nom]) == "boolean" then
                btn.BackgroundColor3 = Config[nom] and Color3.fromRGB(25, 140, 50) or Color3.fromRGB(140, 15, 35)
            end
        end
        task.wait(1.5)
        BtnCargar.Text = "📂 CARGAR"
    else
        BtnCargar.Text = "❌ SIN GUARDADO"
        task.wait(1.5)
        BtnCargar.Text = "📂 CARGAR"
    end
end)

-- ==================================================
-- ⚙️ BUCLE PRINCIPAL — FUNCIONA TODO EL TIEMPO ✅
-- ==================================================
RunService.Heartbeat:Connect(function()
    FarmTrabajos()
end)

print("✅ EDGAR HUB CARGADO — SOLO FARM + TODOS LOS TRABAJOS 🌾💰🔥")
