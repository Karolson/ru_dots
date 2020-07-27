function Trig_Steam_Bun_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A01K' then
        return true
    elseif GetSpellAbilityId() == 'A0FG' then
        return true
    endif
    return false
endfunction

function Trig_Steam_Bun_Actions takes nothing returns nothing
    local unit u = GetOrderTargetUnit()
    call UnitRemoveAbility(u, 'B00N')
    call UnitRemoveAbility(u, 'B03S')
    set u = null
endfunction

function InitTrig_Steam_Bun_And_Frog takes nothing returns nothing
    set gg_trg_Steam_Bun_And_Frog = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Steam_Bun_And_Frog, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Steam_Bun_And_Frog, Condition(function Trig_Steam_Bun_Conditions))
    call TriggerAddAction(gg_trg_Steam_Bun_And_Frog, function Trig_Steam_Bun_Actions)
endfunction