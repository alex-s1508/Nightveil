local addonName, ns = ...

SLASH_VEILSTATE1 = "/veil"
SLASH_VEILSTATE2 = "/vs"

SlashCmdList["VEILSTATE"] = function()
    if ns.MainCategory then
        Settings.OpenToCategory(ns.MainCategory:GetID())
    end
end
