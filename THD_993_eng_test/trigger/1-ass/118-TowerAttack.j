function Trig_TowerAttack_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A05E') == 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    endif
    return GetRandomInt(0, 100) < 20
endfunction

function Trig_TowerAttack_Actions takes nothing returns nothing
    call UnitAbsDamageTarget(GetEventDamageSource(), GetTriggerUnit(), GetUnitState(GetTriggerUnit(), UNIT_STATE_MAX_LIFE) * 0.1)
endfunction

function InitTrig_TowerAttack takes nothing returns nothing
    set gg_trg_TowerAttack = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_TowerAttack)
    call TriggerAddCondition(gg_trg_TowerAttack, Condition(function Trig_TowerAttack_Conditions))
    call TriggerAddAction(gg_trg_TowerAttack, function Trig_TowerAttack_Actions)
endfunction