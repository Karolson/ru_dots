function Trig_Eye03_TreeEye_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A02C'
endfunction

function Trig_Eye03_TreeEye_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local destructable target = GetSpellTargetDestructable()
    local real tx = GetDestructableX(target) - 64.0
    local real ty = GetDestructableY(target) - 64.0
    local unit u
    set u = CreateUnit(GetOwningPlayer(caster), 'n002', tx, ty, 225.0)
    call UnitApplyTimedLife(u, 'BTLF', 180.0)
    call TriggerSleepAction(1.0)
    set u = NewDummy(Player(PLAYER_NEUTRAL_AGGRESSIVE), tx, ty, 270.0)
    call UnitAddAbility(u, 'Adis')
    call IssuePointOrder(u, "dispel", tx, ty)
    call UnitRemoveAbility(u, 'Adis')
    call ReleaseDummy(u)
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Eye03_TreeEye takes nothing returns nothing
    set gg_trg_Eye03_TreeEye = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Eye03_TreeEye, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Eye03_TreeEye, Condition(function Trig_Eye03_TreeEye_Conditions))
    call TriggerAddAction(gg_trg_Eye03_TreeEye, function Trig_Eye03_TreeEye_Actions)
endfunction