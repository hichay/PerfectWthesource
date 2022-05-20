
local PlayerVars = PlayerVars or {}

local DefaultVars = {
    ["dead"] = false,
    ["handcuffed"] = false,
    ["recentcuff"] = 0,
    ["trunk"] = false,
    ["call"] = false,
}


function setVar(var, data)
    PlayerVars[var] = data
end

function getVar(var)
    return PlayerVars[var]
end

function setChar(var, data)
    if not PlayerVars["char"] then return end

    PlayerVars["char"][var] = data
end

function getChar(var)
    if PlayerVars["char"] then
        if var then
            return PlayerVars["char"][var]
        end

        return PlayerVars["char"]
    else
        return
    end
end

function resetVars()
    for k, v in pairs(DefaultVars) do
        PlayerVars[k] = v
    end
end


exports("setVar", setVar)
exports("getVar", getVar)
exports("setChar", setChar)
exports("getChar", getChar)
exports("resetVars", resetVars)

RegisterNetEvent("pw-base:setVar")
AddEventHandler("pw-base:setVar", setVar)

RegisterNetEvent("pw-base:setChar")
AddEventHandler("pw-base:setChar", setChar)

RegisterNetEvent("pw-base:resetVars")
AddEventHandler("pw-base:resetVars", resetVars)


Citizen.CreateThread(function()
    resetVars()
end)