function Trig_Power_Create_Conditions takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_TAUREN) then
        return false
    endif
    if IsUnitSpawn(GetTriggerUnit()) == false then
        return false
    endif
    return GetRandomReal(0, 100) <= 5.0
endfunction

function Trig_Power_Create_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call CreateItem('I03H', GetUnitX(u), GetUnitY(u))
    set u = null
endfunction

function InitTrig_Power_Create takes nothing returns nothing
    set gg_trg_Power_Create = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Power_Create, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Power_Create, Condition(function Trig_Power_Create_Conditions))
    call TriggerAddAction(gg_trg_Power_Create, function Trig_Power_Create_Actions)
endfunction