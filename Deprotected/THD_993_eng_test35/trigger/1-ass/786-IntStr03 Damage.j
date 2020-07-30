function Trig_IntStr03_Damage_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A147') == 0 then
        return false
    endif
    return GetEventDamage() == 0.0
endfunction

function Trig_IntStr03_Damage_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
    local unit target = GetTriggerUnit()
    call UnitMagicDamageTarget(caster, target, 300 + 1.5 * GetHeroInt(caster, true), 7)
    set caster = null
    set target = null
endfunction

function InitTrig_IntStr03_Damage takes nothing returns nothing
    set gg_trg_IntStr03_Damage = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_IntStr03_Damage)
    call TriggerAddCondition(gg_trg_IntStr03_Damage, Condition(function Trig_IntStr03_Damage_Conditions))
    call TriggerAddAction(gg_trg_IntStr03_Damage, function Trig_IntStr03_Damage_Actions)
endfunction