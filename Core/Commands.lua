local addonName, ns = ...

SLASH_VEILSTATE1 = "/veil"

SlashCmdList["VEILSTATE"] = function()
    if ns.MainCategory then
        Settings.OpenToCategory(ns.MainCategory:GetID())
    end
end
