function Trig_TensiDS_Conditions takes nothing returns boolean
    return GetWidgetLife(GetPlayerCharacter(GetTriggerPlayer())) >= 0.405
endfunction

function Trig_TensiDS_Actions takes nothing returns nothing
    local player who = GetTriggerPlayer()
    local unit caster = GetPlayerCharacter(who)
    local integer level01 = GetUnitAbilityLevel(caster, 'A071')
    local real period
    if GetUnitAbilityLevel(caster, 'B001') != 0 then
        set period = 2 + 4800.0 / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    else
        set period = 2 + 7200.0 / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    endif
    if level01 != 0 then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Heaven Sign 'Sword of Divine Justice': |r" + R2S(period))
    endif
    set who = null
    set caster = null
endfunction

function InitTrig_TensiDS takes nothing returns nothing
endfunction