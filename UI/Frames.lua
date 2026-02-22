local addonName, ns = ...

local screenFrame = CreateFrame("Frame", "VS_ScreenFrame", UIParent)
screenFrame:SetAllPoints(UIParent)
screenFrame:Hide()

local screenOverlay = screenFrame:CreateTexture(nil, "BACKGROUND")
screenOverlay:SetAllPoints(UIParent)
screenOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")

local textFrame = CreateFrame("Frame", "VS_TextFrame", UIParent)
textFrame:SetAllPoints(UIParent)
textFrame:Hide()

local floatingText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
floatingText:SetShadowOffset(2, -2)
floatingText:SetShadowColor(0, 0, 0, 0.8)

local iconFrame = CreateFrame("Frame", "VS_IconFrame", UIParent)
iconFrame:SetAllPoints(UIParent)
iconFrame:Hide()

local indicatorIcon = iconFrame:CreateTexture(nil, "OVERLAY")

local vignetteFrame = CreateFrame("Frame", "VS_VignetteFrame", screenFrame)
vignetteFrame:SetAllPoints(UIParent)

local vignetteEdges = {}

local function BuildVignettes()
    if vignetteEdges.top then return end
    local function MakeEdge(anchor)
        local t = vignetteFrame:CreateTexture(nil, "BACKGROUND")
        t:SetTexture("Interface\\Buttons\\WHITE8X8")
        t:SetPoint(anchor)
        return t
    end
    vignetteEdges.top    = MakeEdge("TOPLEFT");    vignetteEdges.top:SetPoint("TOPRIGHT")
    vignetteEdges.bottom = MakeEdge("BOTTOMLEFT"); vignetteEdges.bottom:SetPoint("BOTTOMRIGHT")
    vignetteEdges.left   = MakeEdge("TOPLEFT");    vignetteEdges.left:SetPoint("BOTTOMLEFT")
    vignetteEdges.right  = MakeEdge("TOPRIGHT");   vignetteEdges.right:SetPoint("BOTTOMRIGHT")
end

function ns.RefreshVisuals()
    local db = ns.db
    if not db then return end

    local sd = ns.IsInShadowDance and db.sdEnabled
    local stealthed = IsStealthed()
    local active = sd or (stealthed and not sd and db.stealthEnabled)

    local function v(sdKey, sKey) 
        if sd then return db[sdKey] else return db[sKey] end 
    end

    local customText = v("sdCustomText", "customText") or ""
    local defaultMsg = sd and ns.L.ShadowDanceMessage or ns.L.DefaultMessage
    local displayText = customText:gsub("%s", "") ~= "" and customText or defaultMsg

    screenFrame:SetFrameStrata(v("sdScreenStrata", "screenStrata") or "BACKGROUND")
    vignetteFrame:SetFrameStrata(v("sdVignetteStrata", "vignetteStrata") or "BACKGROUND")

    if active and v("sdEnableScreenColor", "enableScreenColor") then
        local c = v("sdScreenColor", "screenColor")
        screenOverlay:SetVertexColor(c.r, c.g, c.b, v("sdScreenAlpha", "screenAlpha"))
        screenOverlay:Show()
    else
        screenOverlay:Hide()
    end

    if active and v("sdEnableText", "enableText") then
        floatingText:SetText(displayText)
        floatingText:SetFont(STANDARD_TEXT_FONT, v("sdTextSize", "textSize"), "OUTLINE")
        local c = v("sdTextColor", "textColor")
        floatingText:SetTextColor(c.r, c.g, c.b, v("sdTextAlpha", "textAlpha"))
        floatingText:ClearAllPoints()
        floatingText:SetPoint("CENTER", UIParent, "CENTER", v("sdTextX", "textX"), v("sdTextY", "textY"))
        floatingText:Show()
    else
        floatingText:Hide()
    end

    if active and v("sdEnableIcon", "enableIcon") then
        local sz = v("sdIconSize", "iconSize")
        indicatorIcon:SetSize(sz, sz)
        indicatorIcon:SetAlpha(v("sdIconAlpha", "iconAlpha"))
        indicatorIcon:ClearAllPoints()
        indicatorIcon:SetPoint("CENTER", UIParent, "CENTER", v("sdIconX", "iconX"), v("sdIconY", "iconY"))
        if sd then
            indicatorIcon:SetTexture("Interface\\Icons\\Ability_Rogue_ShadowDance")
        else
            indicatorIcon:SetTexture("Interface\\Icons\\Ability_Stealth")
        end
        indicatorIcon:Show()
    else
        indicatorIcon:Hide()
    end

    if active and v("sdEnableVignette", "enableVignette") then
        BuildVignettes()
        local solid = CreateColor(0, 0, 0, v("sdVignetteAlpha", "vignetteAlpha"))
        local clear = CreateColor(0, 0, 0, 0)
        local thick = v("sdVignetteSize", "vignetteSize")
        vignetteEdges.top:SetHeight(thick);         vignetteEdges.top:SetGradient("VERTICAL", clear, solid)
        vignetteEdges.bottom:SetHeight(thick);      vignetteEdges.bottom:SetGradient("VERTICAL", solid, clear)
        vignetteEdges.left:SetWidth(thick + 100);   vignetteEdges.left:SetGradient("HORIZONTAL", solid, clear)
        vignetteEdges.right:SetWidth(thick + 100);  vignetteEdges.right:SetGradient("HORIZONTAL", clear, solid)
        for _, edge in pairs(vignetteEdges) do edge:Show() end
    else
        for _, edge in pairs(vignetteEdges) do if edge then edge:Hide() end end
    end

    if active then ns.ApplyHighlight() end
    screenFrame:SetShown(active)
    textFrame:SetShown(active)
    iconFrame:SetShown(active)
end

function ns.CreateScrollPanel(panel)
    local scroll = CreateFrame("ScrollFrame", panel:GetName() .. "Scroll", panel, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 8, -8)
    scroll:SetPoint("BOTTOMRIGHT", -28, 8)
    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(600, 1600)
    scroll:SetScrollChild(content)
    return content
end

function ns.CreateUI(content)
    local ui = {}
    local y = -16
    local pad = 16

    function ui:Header(text)
        local h = content:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        h:SetPoint("TOPLEFT", pad, y)
        h:SetText(text)
        h:SetTextColor(0.6, 0.3, 1)
        local line = content:CreateTexture(nil, "ARTWORK")
        line:SetSize(580, 1)
        line:SetPoint("TOPLEFT", h, "BOTTOMLEFT", 0, -4)
        line:SetColorTexture(0.5, 0.5, 0.5, 0.3)
        y = y - 40
    end

    function ui:Title(text, subtext)
        local t = content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
        t:SetPoint("TOPLEFT", pad, y)
        t:SetText(text)
        y = y - 30
        if subtext then
            local s = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
            s:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, -4)
            s:SetText(subtext)
            y = y - 20
        end
        y = y - 10
    end

    function ui:Check(dbKey, label, xOff)
        local x = pad + (xOff or 0)
        local cb = CreateFrame("CheckButton", "VS_Check_" .. dbKey, content, "InterfaceOptionsCheckButtonTemplate")
        cb:SetPoint("TOPLEFT", x, y)
        _G[cb:GetName() .. "Text"]:SetText(label or ns.L.Enable)
        cb:SetChecked(ns.db[dbKey])
        cb:SetScript("OnClick", function(self)
            ns.db[dbKey] = self:GetChecked()
            ns.UpdateState()
        end)
        if not xOff then y = y - 32 end
        return cb
    end

    function ui:Slider(dbKey, label, min, max, step, xOff, hold)
        local x = pad + (xOff or 0)
        local sl = CreateFrame("Slider", "VS_Slider_" .. dbKey, content, "OptionsSliderTemplate")
        sl:SetPoint("TOPLEFT", x + 4, y - 10)
        sl:SetMinMaxValues(min, max)
        sl:SetValueStep(step)
        sl:SetValue(ns.db[dbKey] or min)
        sl:SetWidth(180)
        sl:SetObeyStepOnDrag(true)
        _G[sl:GetName() .. "Text"]:SetText(label)
        _G[sl:GetName() .. "Low"]:SetText(tostring(min))
        _G[sl:GetName() .. "High"]:SetText(tostring(max))
        local vt = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        vt:SetPoint("TOP", sl, "BOTTOM", 0, -2)
        vt:SetText(string.format("%.0f", ns.db[dbKey] or min))
        sl:SetScript("OnValueChanged", function(self, v2)
            local r = math.floor(v2 / step + 0.5) * step
            ns.db[dbKey] = r
            vt:SetText(string.format("%.0f", r))
            ns.UpdateState()
        end)
        if not hold then y = y - 50 end
    end

    function ui:Color(dbKey, label, xOff, hold)
        local x = pad + (xOff or 0)
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(24, 24)
        btn:SetPoint("TOPLEFT", x + 4, y)
        local swatch = btn:CreateTexture(nil, "OVERLAY")
        swatch:SetSize(18, 18)
        swatch:SetPoint("CENTER")
        swatch:SetTexture("Interface\\Buttons\\WHITE8X8")
        local function UpdateSwatch()
            local c = ns.db[dbKey] or {r=1, g=1, b=1}
            swatch:SetVertexColor(c.r, c.g, c.b)
        end
        UpdateSwatch()
        local lbl = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        lbl:SetPoint("LEFT", btn, "RIGHT", 8, 0)
        lbl:SetText(label or ns.L.Color)
        btn:SetScript("OnClick", function()
            local c = ns.db[dbKey] or {r=1, g=1, b=1}
            ColorPickerFrame:SetupColorPickerAndShow({
                r = c.r, g = c.g, b = c.b,
                swatchFunc = function()
                    local r, g, b = ColorPickerFrame:GetColorRGB()
                    ns.db[dbKey] = {r=r, g=g, b=b}
                    UpdateSwatch(); ns.UpdateState()
                end,
                cancelFunc = function()
                    ns.db[dbKey] = c; UpdateSwatch(); ns.UpdateState()
                end
            })
        end)
        if not hold then y = y - 32 end
    end

    function ui:Edit(label, dbKey, xOff, hold, fallback)
        local x = pad + (xOff or 0)
        local lbl = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        lbl:SetPoint("TOPLEFT", x, y)
        lbl:SetText(label)
        local eb = CreateFrame("EditBox", nil, content, "InputBoxTemplate")
        eb:SetSize(180, 32)
        eb:SetPoint("TOPLEFT", x + 4, y - 15)
        eb:SetAutoFocus(false)
        local val = ns.db[dbKey]
        if fallback and (not val or val:gsub("%s", "") == "") then 
            val = fallback 
        end
        eb:SetText(val or "")
        eb:SetScript("OnEnterPressed", function(self)
            ns.db[dbKey] = self:GetText(); ns.UpdateState(); self:ClearFocus()
        end)
        eb:SetScript("OnEditFocusLost", function(self)
            ns.db[dbKey] = self:GetText(); ns.UpdateState()
        end)
        if not hold then y = y - 60 end
    end

    function ui:Dropdown(label, dbKey, options, xOff, hold)
        local x = pad + (xOff or 0)
        local dd = CreateFrame("Frame", "VS_DD_" .. dbKey, content, "UIDropDownMenuTemplate")
        dd:SetPoint("TOPLEFT", x - 16, y - 15)
        local lbl = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        lbl:SetPoint("BOTTOMLEFT", dd, "TOPLEFT", 20, 0)
        lbl:SetText(label)
        UIDropDownMenu_SetWidth(dd, 150)
        local function OnSelect(self)
            ns.db[dbKey] = self.value
            UIDropDownMenu_SetText(dd, self:GetText())
            ns.UpdateState()
            CloseDropDownMenus()
        end
        UIDropDownMenu_Initialize(dd, function()
            local info = UIDropDownMenu_CreateInfo()
            for _, opt in ipairs(options or {}) do
                info.text = opt.text; info.value = opt.value; info.func = OnSelect
                info.checked = (ns.db[dbKey] == opt.value)
                UIDropDownMenu_AddButton(info)
            end
        end)
        for _, opt in ipairs(options or {}) do
            if opt.value == ns.db[dbKey] then UIDropDownMenu_SetText(dd, opt.text) end
        end
        if not hold then y = y - 60 end
    end

    function ui:Space(h) y = y - (h or 20) end
    function ui:GetY() return y end
    function ui:SetY(v2) y = v2 end

    return ui
end
