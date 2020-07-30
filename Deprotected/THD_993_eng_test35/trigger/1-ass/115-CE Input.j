function Trig_CE_Input_Actions takes nothing returns nothing
    local unit h = GetEventDamageSource()
    local unit v = GetTriggerUnit()
    local real HP = GetUnitState(v, UNIT_STATE_LIFE)
    local real MAX = GetUnitState(v, UNIT_STATE_MAX_LIFE)
    local real damage = RMinBJ(GetEventDamage(), HP)
    local real input = 100.0 * damage / MAX
    if damage < HP then
        call CE_Input(h, v, input)
    else
        call CE_Set(h, v, input)
    endif
    set h = null
    set v = null
endfunction

function InitTrig_CE_Input takes nothing returns nothing
    set gg_trg_CE_Input = CreateTrigger()
    call TriggerAddAction(gg_trg_CE_Input, function Trig_CE_Input_Actions)
endfunction