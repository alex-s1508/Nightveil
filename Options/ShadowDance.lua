local addonName, ns = ...

function ns.InitShadowDancePanel(category)
    local panel = CreateFrame("Frame", "VS_ShadowDancePanel")
    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    ui:Header(ns.L.Settings)
    ui:Check("sdEnabled", ns.L.EnableOnShadowDance)
    ui:Space(10)
    ns.AppearanceBlock(ui, "sd")
    Settings.RegisterCanvasLayoutSubcategory(category, panel, ns.L.ShadowDance)
end
