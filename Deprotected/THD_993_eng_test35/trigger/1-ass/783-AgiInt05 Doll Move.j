function Trig_Doll_Move_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSummoningUnit()) == 'n00G'
endfunction

function Trig_Doll_Move_Actions takes nothing returns nothing
    local real x = GetUnitX(udg_ObjectsDoll)
    local real y = GetUnitY(udg_ObjectsDoll)
    local real facing = GetUnitFacing(udg_ObjectsDoll)
    local unit u = GetSummonedUnit()
    call SetUnitPosition(u, x, y)
    call SetUnitFacing(u, facing)
    set udg_ObjectsDoll = null
    set u = null
endfunction

function InitTrig_AgiInt05_Doll_Move takes nothing returns nothing
    set gg_trg_AgiInt05_Doll_Move = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AgiInt05_Doll_Move, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_AgiInt05_Doll_Move, Condition(function Trig_Doll_Move_Conditions))
    call TriggerAddAction(gg_trg_AgiInt05_Doll_Move, function Trig_Doll_Move_Actions)
endfunction