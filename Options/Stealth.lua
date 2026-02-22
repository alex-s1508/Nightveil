local addonName, ns = ...

local function K(prefix, key)
    if prefix == "" then return key end
    return prefix .. key:sub(1,1):upper() .. key:sub(2)
end

local function AppearanceBlock(ui, prefix)
    local layers = {
        {text="BACKGROUND", value="BACKGROUND"},
        {text="LOW",        value="LOW"},
        {text="MEDIUM",     value="MEDIUM"},
        {text="HIGH",       value="HIGH"},
        {text="DIALOG",     value="DIALOG"},
        {text="FULLSCREEN", value="FULLSCREEN"},
    }
    local modes = {
        {text="Circle",                  value=1},
        {text="Outline",                 value=2},
        {text="Icon",                    value=3},
        {text="Circle + Outline",        value=4},
        {text="Circle + Icon",           value=5},
        {text="Outline + Icon",          value=6},
        {text="Circle + Outline + Icon", value=7},
    }

    ui:Header(ns.L.FloatingText)
    ui:Check(K(prefix, "enableText"), ns.L.Enable)
    local r1 = ui:GetY()
    local fallbackTXT = prefix == "" and ns.L.DefaultMessage or ns.L.ShadowDanceMessage
    ui:Edit(ns.L.CustomText, K(prefix, "customText"), 0, true, fallbackTXT)
    ui:Color(K(prefix, "textColor"), ns.L.Color, 220, false)
    ui:SetY(r1 - 60)
    local r2 = ui:GetY()
    ui:Slider(K(prefix, "textSize"),  ns.L.Size,    10,   100,  1,    0,  true)
    ui:Slider(K(prefix, "textAlpha"), ns.L.Opacity, 0,    1,    0.05, 220, false)
    ui:SetY(r2 - 60)
    local r3 = ui:GetY()
    ui:Slider(K(prefix, "textX"), ns.L.OffsetX, -500, 500, 1, 0,   true)
    ui:Slider(K(prefix, "textY"), ns.L.OffsetY, -500, 500, 1, 220, false)
    ui:SetY(r3 - 60)

    ui:Space(20)
    ui:Header(ns.L.IndicatorIcon)
    ui:Check(K(prefix, "enableIcon"), ns.L.Enable)
    local i1 = ui:GetY()
    ui:Slider(K(prefix, "iconSize"),  ns.L.Size,    16,   300,  1,    0,   true)
    ui:Slider(K(prefix, "iconAlpha"), ns.L.Opacity, 0,    1,    0.05, 220, true)
    ui:SetY(i1 - 50)
    local i2 = ui:GetY()
    ui:Slider(K(prefix, "iconX"), ns.L.OffsetX, -500, 500, 1, 0,   true)
    ui:Slider(K(prefix, "iconY"), ns.L.OffsetY, -500, 500, 1, 220, true)
    ui:SetY(i2 - 50)

    ui:Space(20)
    ui:Header(ns.L.ScreenColor)
    ui:Check(K(prefix, "enableScreenColor"), ns.L.Enable)
    ui:Color(K(prefix, "screenColor"),  ns.L.Color)
    ui:Slider(K(prefix, "screenAlpha"), ns.L.Opacity, 0, 0.8, 0.01)
    ui:Dropdown(ns.L.Layer, K(prefix, "screenStrata"), layers)

    ui:Space(20)
    ui:Header(ns.L.Vignette)
    ui:Check(K(prefix, "enableVignette"), ns.L.Enable)
    local v1 = ui:GetY()
    ui:Slider(K(prefix, "vignetteSize"),  ns.L.Thickness, 50,  600,  1,    0,   true)
    ui:Slider(K(prefix, "vignetteAlpha"), ns.L.Opacity,   0,   1,    0.05, 220, true)
    ui:SetY(v1 - 50)
    ui:Dropdown(ns.L.Layer, K(prefix, "vignetteStrata"), layers)

    ui:Space(20)
    ui:Header(ns.L.Highlight)
    ui:Check(K(prefix, "enableHighlight"), ns.L.Enable)
    ui:Dropdown(ns.L.Style, K(prefix, "highlightType"), modes)
end

ns.AppearanceBlock = AppearanceBlock

function ns.InitStealthPanel(category)
    local panel = CreateFrame("Frame", "VS_StealthPanel")
    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    ui:Header(ns.L.Settings)
    ui:Check("stealthEnabled", ns.L.EnableOnStealth)
    ui:Space(10)
    AppearanceBlock(ui, "")
    Settings.RegisterCanvasLayoutSubcategory(category, panel, ns.L.Stealth)
end
