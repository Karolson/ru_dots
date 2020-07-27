function Trig_LyricaEx_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))) == 'E020'
endfunction

function Trig_LyricaEx_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    if udg_SK_LyricaEx_Buff > 0.4 then
        if udg_GameTime >= 45 * 60 then
            set udg_SK_LyricaEx_Buff = udg_SK_LyricaEx_Buff * (1 - 0.0015)
        else
            set udg_SK_LyricaEx_Buff = udg_SK_LyricaEx_Buff * (1 - 0.003)
        endif
    else
        set udg_SK_LyricaEx_Buff = 0.4
    endif
    if udg_GameMode / 100 == 3 or udg_NewMid then
        if udg_SK_LyricaEx_Buff > 0.4 then
            if udg_GameTime >= 45 * 60 then
                set udg_SK_LyricaEx_Buff = udg_SK_LyricaEx_Buff * (1 - 0.0015)
            else
                set udg_SK_LyricaEx_Buff = udg_SK_LyricaEx_Buff * (1 - 0.003)
            endif
        else
            set udg_SK_LyricaEx_Buff = 0.4
        endif
    endif
    call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnit()), 0, 0, "|c00ffff00Prism Concerto - Keyboard|r cooldown reduction: " + R2S((1 - udg_SK_LyricaEx_Buff) * 100) + "%")
    set caster = null
endfunction

function InitTrig_LyricaEx takes nothing returns nothing
endfunction