function Trig_AbilitySqOff_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetTriggerPlayer())
    local integer task = GetHandleId(caster)
    call SaveInteger(udg_Hashtable_CastSq, task, 0, 0)
    set caster = null
endfunction

function InitTrig_AbilitySqOff takes nothing returns nothing
    set gg_trg_AbilitySqOff = CreateTrigger()
    call TriggerAddAction(gg_trg_AbilitySqOff, function Trig_AbilitySqOff_Actions)
endfunction