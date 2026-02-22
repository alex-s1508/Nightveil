local addonName, ns = ...

ns.Defaults = {
    stealthEnabled = true,
    enableText = true,
    customText = ns.L.DefaultMessage,
    textColor = {r = 0.61, g = 0.30, b = 1},
    textAlpha = 1,
    textX = 0,
    textY = 150,
    textSize = 32,
    enableIcon = false,
    iconSize = 64,
    iconAlpha = 1,
    iconX = 0,
    iconY = 230,
    enableScreenColor = true,
    screenColor = {r = 0.61, g = 0.30, b = 1},
    screenAlpha = 0.1,
    screenStrata = "BACKGROUND",
    enableVignette = true,
    vignetteSize = 250,
    vignetteAlpha = 0.6,
    vignetteStrata = "BACKGROUND",
    enableHighlight = true,
    highlightType = 2,

    sdEnabled = false,
    sdEnableText = false,
    sdCustomText = ns.L.ShadowDanceMessage,
    sdTextColor = {r = 0.7, g = 0.5, b = 1},
    sdTextAlpha = 0.8,
    sdTextX = 0,
    sdTextY = 150,
    sdTextSize = 32,
    sdEnableIcon = false,
    sdIconSize = 64,
    sdIconAlpha = 0.8,
    sdIconX = 0,
    sdIconY = 230,
    sdEnableScreenColor = true,
    sdScreenColor = {r = 0.7, g = 0.5, b = 1},
    sdScreenAlpha = 0.06,
    sdScreenStrata = "BACKGROUND",
    sdEnableVignette = true,
    sdVignetteSize = 250,
    sdVignetteAlpha = 0.6,
    sdVignetteStrata = "BACKGROUND",
    sdEnableHighlight = true,
    sdHighlightType = 2,

    shroudCountdown = false,
    shroudChannel = "PARTY",
    shroudMessage = "",
    shroudInterval = false,
    shroudStartMsg = "",
    shroudEndMsg = "",
}

function ns.CopyDefaults(src, dst)
    for k, v in pairs(src) do
        if type(v) == "table" then
            dst[k] = dst[k] or {}
            ns.CopyDefaults(v, dst[k])
        elseif dst[k] == nil then
            dst[k] = v
        end
    end
end
