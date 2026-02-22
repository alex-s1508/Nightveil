local addonName, ns = ...

local SHADOW_DANCE_IDS = {185313, 185422}
local SHROUD_IDS = {115834, 114018}

local captured = {}
local hasCaptured = false
local shroudTicker = nil
local shroudActive = false
local lastShroudTime = 0

ns.IsInShadowDance = false

local function HasAura(ids)
    if C_UnitAuras then
        for _, id in ipairs(ids) do
            if C_UnitAuras.GetPlayerAuraBySpellID(id) then return true end
        end
    else
        local i = 1
        while true do
            local name, _, _, _, _, _, _, _, _, buffID = UnitBuff("player", i)
            if not name then break end
            for _, id in ipairs(ids) do
                if buffID == id then return true end
            end
            i = i + 1
        end
    end
    return false
end

local function GetAuraExpiration(ids)
    if not C_UnitAuras then return nil end
    for _, id in ipairs(ids) do
        local aura = C_UnitAuras.GetPlayerAuraBySpellID(id)
        if aura and aura.expirationTime then
            return aura.expirationTime
        end
    end
    return nil
end

local function BackupState()
    if not hasCaptured then return end
    VeilStateSavedState = {originalCVars = captured, isCaptured = true}
end

local function RecoverState()
    if VeilStateSavedState and VeilStateSavedState.isCaptured then
        captured = VeilStateSavedState.originalCVars
        hasCaptured = true
    end
end

local function ClearBackup()
    VeilStateSavedState = nil
end

function ns.CaptureOriginal()
    if hasCaptured then return end
    RecoverState()
    if hasCaptured then return end
    captured.findYourselfMode        = GetCVar("findYourselfMode")
    captured.findYourselfModeCircle  = GetCVar("findYourselfModeCircle")
    captured.findYourselfModeOutline = GetCVar("findYourselfModeOutline")
    captured.findYourselfModeIcon    = GetCVar("findYourselfModeIcon")
    captured.findYourselfAnywhere    = GetCVar("findYourselfAnywhere")
    captured.selfHighlight           = GetCVar("selfHighlight")
    hasCaptured = true
    BackupState()
end

function ns.RestoreOriginal()
    if not hasCaptured then return end
    SetCVar("findYourselfMode", 0)
    SetCVar("findYourselfModeCircle", 0)
    SetCVar("findYourselfModeOutline", 0)
    SetCVar("findYourselfModeIcon", 0)
    for cvar, val in pairs(captured) do
        if val then SetCVar(cvar, val) end
    end
    hasCaptured = false
    ClearBackup()
end

function ns.ApplyHighlight()
    local db = ns.db
    if not db then return end
    -- shadow dance takes priority if active
    local sd = ns.IsInShadowDance and db.sdEnabled
    local enableHL = sd and db.sdEnableHighlight
    if not sd then enableHL = db.enableHighlight end
    local hlType = sd and db.sdHighlightType or db.highlightType
    
    if not enableHL then
        SetCVar("findYourselfMode", 0)
        SetCVar("findYourselfModeCircle", 0)
        SetCVar("findYourselfModeOutline", 0)
        SetCVar("findYourselfModeIcon", 0)
        return
    end
    local s = hlType or 2
    SetCVar("findYourselfMode",        s)
    SetCVar("findYourselfModeCircle",  (s==1 or s==4 or s==5 or s==7) and 1 or 0)
    SetCVar("findYourselfModeOutline", (s==2 or s==4 or s==6 or s==7) and 1 or 0)
    SetCVar("findYourselfModeIcon",    (s==3 or s==5 or s==6 or s==7) and 1 or 0)
    SetCVar("findYourselfAnywhere", 1)
    SetCVar("selfHighlight", 1)
end

function ns.StopShroudCountdown(sendEnd)
    if sendEnd and shroudActive and ns.db and ns.db.shroudEndMsg and ns.db.shroudEndMsg:gsub("%s+", "") ~= "" then
        pcall(SendChatMessage, ns.db.shroudEndMsg, ns.db.shroudChannel or "PARTY")
    end
    if shroudTicker then shroudTicker:Cancel() end
    shroudTicker = nil
    shroudActive = false
end

function ns.StartShroudCountdown()
    ns.StopShroudCountdown(false)
    local db = ns.db
    if not db or not db.shroudCountdown then return end

    local channel      = db.shroudChannel or "PARTY"
    local useInterval  = db.shroudInterval
    local intervalSec  = db.shroudIntervalSeconds or 5
    local isFirstTick  = true

    local function Send(msg)
        if msg and msg:gsub("%s+", "") ~= "" then
            pcall(SendChatMessage, msg, channel)
        end
    end

    local function FormatMsg(timeLeft)
        local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%t"
        return template:gsub("%%t", tostring(timeLeft))
    end

    local duration = 14
    local expirationTime = GetTime() + duration

    shroudActive = true

    local function Tick()
        if not shroudActive then return end
        local remaining = expirationTime - GetTime()
        local timeLeft  = math.floor(remaining + 0.5)

        if timeLeft <= 0 then
            ns.StopShroudCountdown(true)
            return
        end

        local shouldSend = not useInterval
                        or timeLeft == 14
                        or timeLeft == 9
                        or timeLeft <= 5

        if shouldSend then
            if timeLeft == 14 and db.shroudStartMsg and db.shroudStartMsg:gsub("%s+", "") ~= "" then
                Send(db.shroudStartMsg)
            else
                Send(FormatMsg(timeLeft))
            end
        end
    end

    Tick()
    if not shroudActive then return end

    shroudTicker = C_Timer.NewTicker(1, Tick)
end

local function CheckShroud()
    local db = ns.db
    if not db or not db.shroudCountdown then
        if shroudActive then ns.StopShroudCountdown() end
        return
    end
    if HasAura(SHROUD_IDS) and not shroudActive then
        if GetTime() - lastShroudTime > 14 then
            lastShroudTime = GetTime()
            ns.StartShroudCountdown()
        end
    elseif not HasAura(SHROUD_IDS) and shroudActive then
        ns.StopShroudCountdown(true)
    end
end

function ns.UpdateState()
    ns.IsInShadowDance = HasAura(SHADOW_DANCE_IDS)
    local sd     = ns.IsInShadowDance and ns.db.sdEnabled
    local active = sd or (IsStealthed() and ns.db.stealthEnabled)
    if active then
        ns.CaptureOriginal()
    else
        ns.RestoreOriginal()
    end
    ns.RefreshVisuals()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("UPDATE_STEALTH")
eventFrame:RegisterEvent("UNIT_AURA")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        VeilStateDB = VeilStateDB or {}
        ns.CopyDefaults(ns.Defaults, VeilStateDB)
        ns.db = VeilStateDB
        
        RecoverState()
        local category = ns.InitMainPanel()
        ns.InitStealthPanel(category)
        ns.InitShadowDancePanel(category)
        ns.InitShroudPanel(category)
        ns.RefreshVisuals()
        if IsStealthed() then ns.UpdateState() end
    elseif event == "UNIT_AURA" and arg1 == "player" then
        local wasSD = ns.IsInShadowDance
        ns.IsInShadowDance = HasAura(SHADOW_DANCE_IDS)
        if ns.IsInShadowDance ~= wasSD then ns.UpdateState() end
        CheckShroud()
    else
        ns.UpdateState()
    end
end)
