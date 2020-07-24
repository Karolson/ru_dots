function Trig_Spirit_Conditions takes nothing returns boolean
    if not (IsUnitEnemy(GetKillingUnitBJ(), GetTriggerPlayer())) then
        return false
    endif
    return true
endfunction

function Trig_Spirit_Func001Func002C takes nothing returns boolean
    if not (IsUnitType(GetDyingUnit(), UNIT_TYPE_STRUCTURE)) then
        return false
    endif
    return true
endfunction

function Trig_Spirit_Func001C takes nothing returns boolean
    if not (IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO)) then
        return false
    endif
    return true
endfunction

function Trig_Spirit_Actions takes nothing returns nothing
    if Trig_Spirit_Func001C() then
        call THD_AddSpirit(GetOwningPlayer(GetKillingUnit()), udg_GameSetting_Spirit[2])
    else
        if Trig_Spirit_Func001Func002C() then
            call THD_AddSpirit(GetOwningPlayer(GetKillingUnit()), udg_GameSetting_Spirit[1])
        else
            call DoNothing()
        endif
    endif
endfunction

function InitTrig_Spirit takes nothing returns nothing
    set gg_trg_Spirit = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Spirit, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Spirit, Condition(function Trig_Spirit_Conditions))
    call TriggerAddAction(gg_trg_Spirit, function Trig_Spirit_Actions)
endfunction