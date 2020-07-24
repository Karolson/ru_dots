function Trig_ByakurenDS_Conditions takes nothing returns boolean
    return GetWidgetLife(GetPlayerCharacter(GetTriggerPlayer())) > 0.405
endfunction

function Trig_ByakurenDS_Actions takes nothing returns nothing
    local player who = GetTriggerPlayer()
    local unit caster = GetPlayerCharacter(who)
    local integer level01 = GetUnitAbilityLevel(caster, 'A0O2')
    local real damage01 = GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.15 * (0.3 + 0.3 * level01)
    local real damage02 = R2I(GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.5)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Superman bonus HP: |r" + R2S(damage02))
    if level01 != 0 then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00F skill damage buff: |r" + R2S(damage01))
    endif
    set who = null
    set caster = null
endfunction

function InitTrig_ByakurenDS takes nothing returns nothing
endfunction