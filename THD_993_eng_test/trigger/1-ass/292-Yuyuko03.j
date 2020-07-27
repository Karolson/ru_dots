function Trig_Yuyuko03_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))) == 'U006'
endfunction

function Trig_Yuyuko03_Actions takes nothing returns nothing
    local unit u = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    local integer level = GetUnitAbilityLevel(u, 'A0MN')
    local real hp = GetUnitState(u, UNIT_STATE_LIFE)
    local real mp = GetUnitState(u, UNIT_STATE_MANA)
    call UnitHealingTarget(u, u, 5 + 5 * level)
    call SetUnitState(u, UNIT_STATE_MANA, mp + 5 + 5 * level)
    set u = null
endfunction

function Trig_Yuyuko03_ID takes nothing returns boolean
    return GetLearnedSkill() == 'A0MN'
endfunction

function Trig_Yuyuko03_Learn takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set gg_trg_Yuyuko03 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Yuyuko03, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Yuyuko03, Condition(function Trig_Yuyuko03_Conditions))
    call TriggerAddAction(gg_trg_Yuyuko03, function Trig_Yuyuko03_Actions)
endfunction

function InitTrig_Yuyuko03 takes nothing returns nothing
endfunction