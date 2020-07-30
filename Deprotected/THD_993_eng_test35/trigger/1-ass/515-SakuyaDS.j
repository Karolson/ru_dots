function Trig_SakuyaDS_Conditions takes nothing returns boolean
    return GetWidgetLife(GetPlayerCharacter(GetTriggerPlayer())) > 0.405
endfunction

function Trig_SakuyaDS_Actions takes nothing returns nothing
    local player who = GetTriggerPlayer()
    local unit caster = GetPlayerCharacter(who)
    local integer level01 = GetUnitAbilityLevel(caster, 'A04H')
    local integer level02 = GetUnitAbilityLevel(caster, 'A099')
    local integer level03 = GetUnitAbilityLevel(caster, 'A09A')
    local real damage01 = (25.0 * level01 - 15.0 + GetUnitAttack(caster) * 0.5) * (1 + GetHeroInt(caster, true) * 0.002)
    local real damage03 = (20.0 + 30.0 * level02 + GetUnitAttack(caster) * 0.8) * (1 + GetHeroInt(caster, true) * 0.002)
    local real damage04 = (40.0 * level03 - 35.0 + GetUnitAttack(caster) * 0.8) * (1 + GetHeroInt(caster, true) * 0.002)
    if level01 != 0 then
        call DisplayTextToPlayer(who, 0, 0, "|c00ffff00Illusion Sign 'Killing Doll': |r" + R2S(damage01))
    endif
    if level02 != 0 then
        call DisplayTextToPlayer(who, 0, 0, "|c00ffff00Time Sign 'Mysterious Jack': |r" + R2S(damage03))
    endif
    if level03 != 0 then
        call DisplayTextToPlayer(who, 0, 0, "|c00ffff00Time Sign 'Misdirection': |r" + R2S(damage04))
    endif
    set who = null
    set caster = null
endfunction

function InitTrig_SakuyaDS takes nothing returns nothing
endfunction