function Trig_LunasaEx_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))) == 'E01N'
endfunction

function Trig_LunasaEx_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    local unit target = GetAttackedUnitBJ()
    local integer id = GetConvertedPlayerId(GetOwningPlayer(caster))
    if udg_GameTime >= 45 * 60 then
        set udg_SK_Lunasa02_Buff[id] = udg_SK_Lunasa02_Buff[id] + 0.125
    else
        set udg_SK_Lunasa02_Buff[id] = udg_SK_Lunasa02_Buff[id] + 0.25
    endif
    if udg_GameMode / 100 == 3 or udg_NewMid then
        if udg_GameTime >= 45 * 60 then
            set udg_SK_Lunasa02_Buff[id] = udg_SK_Lunasa02_Buff[id] + 0.125
        else
            set udg_SK_Lunasa02_Buff[id] = udg_SK_Lunasa02_Buff[id] + 0.25
        endif
    endif
    call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnit()), 0, 0, "|c00ffff00Prism Concerto - Violin|r bonus damage: " + R2S(udg_SK_Lunasa02_Buff[id]) + "|c00ffff00%|r")
    set caster = null
    set target = null
endfunction

function InitTrig_LunasaEx takes nothing returns nothing
endfunction