local addonName, ns = ...

function ns.InitShroudPanel(category)
    local panel = CreateFrame("Frame", "VS_ShroudPanel")
    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    local channels = {
        {text = "Say",      value = "SAY"},
        {text = "Party",    value = "PARTY"},
        {text = "Raid",     value = "RAID"},
        {text = "Instance", value = "INSTANCE_CHAT"},
        {text = "Yell",     value = "YELL"},
    }

    ui:Header(ns.L.Settings)
    ui:Check("shroudCountdown", ns.L.Countdown)
    ui:Dropdown(ns.L.ChatChannel, "shroudChannel", channels)
    ui:Check("shroudInterval", ns.L.ShroudInterval)
    local intervalHint = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    intervalHint:SetPoint("TOPLEFT", 45, ui:GetY() + 4)
    intervalHint:SetText(ns.L.ShroudIntervalDesc)
    intervalHint:SetTextColor(0.7, 0.7, 0.7)

    ui:Space(20)
    ui:Header(ns.L.Messages)
    ui:Edit(ns.L.ShroudMessage, "shroudMessage", 0, false, "%t")
    local hint = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    hint:SetPoint("TOPLEFT", 20, ui:GetY() + 10)
    hint:SetText("|cffaaaaaa" .. (ns.L.TimeRemainingHint or "%t = time remaining") .. "|r")
    
    ui:Space(16)
    ui:Edit(ns.L.ShroudOnStart, "shroudStartMsg")
    ui:Edit(ns.L.ShroudOnEnd, "shroudEndMsg")

    Settings.RegisterCanvasLayoutSubcategory(category, panel, ns.L.ShroudOfConcealment)
end
