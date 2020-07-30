function IsAIFinished takes unit h returns boolean
    local integer k = GetUnitTypeId(h)
    if k == 'H001' then
        return true
    elseif k == 'H02E' then
        return true
    elseif k == 'H02D' then
        return true
    elseif k == 'E01U' then
        return true
    elseif k == 'O009' then
        return true
    elseif k == 'E010' then
        return true
    elseif k == 'H01J' then
        return true
    elseif k == 'E01E' then
        return true
    elseif k == 'H01H' then
        return true
    elseif k == 'H01I' then
        return true
    elseif k == 'H01Y' then
        return true
    endif
    return false
endfunction

function Trig_AI_IsAIFinished_Actions takes nothing returns nothing
endfunction

function InitTrig_AI_IsAIFinished takes nothing returns nothing
    set gg_trg_AI_IsAIFinished = CreateTrigger()
    call TriggerAddAction(gg_trg_AI_IsAIFinished, function Trig_AI_IsAIFinished_Actions)
endfunction