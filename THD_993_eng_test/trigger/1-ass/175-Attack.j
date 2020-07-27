function Trig_Attack_Conditions takes nothing returns boolean
    return GetIssuedOrderId() == OrderId("attack") and IsUnitAlly(GetOrderTargetUnit(), GetTriggerPlayer())
endfunction

function Trig_Attack_Actions takes nothing returns nothing
    local unit target = GetOrderTargetUnit()
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local unit attacker = GetTriggerUnit()
    if IsUnitType(target, UNIT_TYPE_HERO) then
        if GetUnitLifePercent(target) >= 0.0 then
            call PauseUnit(attacker, true)
            call IssueImmediateOrder(attacker, "stop")
            call PauseUnit(attacker, false)
            call IssuePointOrder(attacker, "smart", x, y)
        endif
    elseif IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        if GetUnitLifePercent(target) >= 10.0 then
            call PauseUnit(attacker, true)
            call IssueImmediateOrder(attacker, "stop")
            call PauseUnit(attacker, false)
            call IssuePointOrder(attacker, "smart", x, y)
        endif
    elseif GetUnitLifePercent(target) >= 50.0 then
        call PauseUnit(attacker, true)
        call IssueImmediateOrder(attacker, "stop")
        call PauseUnit(attacker, false)
        call IssuePointOrder(attacker, "smart", x, y)
    endif
    set target = null
    set attacker = null
endfunction

function InitTrig_Attack takes nothing returns nothing
    set gg_trg_Attack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Attack, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(gg_trg_Attack, Condition(function Trig_Attack_Conditions))
    call TriggerAddAction(gg_trg_Attack, function Trig_Attack_Actions)
endfunction