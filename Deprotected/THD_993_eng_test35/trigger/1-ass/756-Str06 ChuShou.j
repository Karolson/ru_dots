function Trig_Str06_ChuShou takes nothing returns boolean
    local integer i = 1
    local location p1
    local location p2
    local unit u
    local unit v = GetTriggerUnit()
    local player p = GetOwningPlayer(v)
    if GetSpellAbilityId() == 'A01S' then
        set p1 = GetUnitLoc(v)
        loop
        exitwhen i > 9
            set p2 = PolarProjectionBJ(p1, 170, 40 * i)
            set u = CreateUnitAtLoc(p, 'n00H', p2, 40 * i + 180)
            call SetUnitAnimation(u, "birth")
            call UnitApplyTimedLife(u, 'BTLF', 9)
            call RemoveLocation(p2)
            set i = i + 1
        endloop
        call RemoveLocation(p1)
    endif
    set p1 = null
    set p2 = null
    set u = null
    set v = null
    set p = null
    return false
endfunction

function InitTrig_Str06_ChuShou takes nothing returns nothing
    set gg_trg_Str06_ChuShou = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Str06_ChuShou, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Str06_ChuShou, Condition(function Trig_Str06_ChuShou))
endfunction