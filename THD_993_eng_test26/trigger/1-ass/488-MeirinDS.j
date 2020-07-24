function Trig_MeirinDS_Conditions takes nothing returns boolean
    return GetWidgetLife(GetPlayerCharacter(GetTriggerPlayer())) > 0.405
endfunction

function Trig_MeirinDS_Actions takes nothing returns nothing
    local player who = GetTriggerPlayer()
    local unit caster = GetPlayerCharacter(who)
    local integer level01 = GetUnitAbilityLevel(caster, 'A0GC')
    local real damage01 = 10 * level01 + GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.04
    if level01 != 0 then
        call DisplayTextToPlayer(who, 0, 0, "|c00ffff00Aura 'Tiger Inner Strength' damage:|r" + R2S(damage01))
    endif
    set who = null
    set caster = null
endfunction

function InitTrig_MeirinDS takes nothing returns nothing
endfunction