function Trig_MerlinEx_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))) == 'E01W'
endfunction

function Trig_MerlinEx_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    local unit target = GetTriggerUnit()
    if udg_GameTime >= 45 * 60 then
        call UnitAddMaxLife(caster, 2)
        set udg_SK_MerlinEx_Kills = udg_SK_MerlinEx_Kills + 2
    else
        call UnitAddMaxLife(caster, 4)
        set udg_SK_MerlinEx_Kills = udg_SK_MerlinEx_Kills + 4
    endif
    if udg_GameMode / 100 == 3 or udg_NewMid then
        if udg_GameTime >= 45 * 60 then
            call UnitAddMaxLife(caster, 2)
            set udg_SK_MerlinEx_Kills = udg_SK_MerlinEx_Kills + 2
        else
            call UnitAddMaxLife(caster, 4)
            set udg_SK_MerlinEx_Kills = udg_SK_MerlinEx_Kills + 4
        endif
    endif
    call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnit()), 0, 0, "|c00ffff00Prism Concerto - Trumpet|r bonus health: " + I2S(udg_SK_MerlinEx_Kills))
    set caster = null
    set target = null
endfunction

function InitTrig_MerlinEx takes nothing returns nothing
endfunction