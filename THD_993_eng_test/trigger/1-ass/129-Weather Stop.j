function Trig_Weather_Stop_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSoldUnit()) == 'n046'
endfunction

function Trig_Weather_Stop_Actions takes nothing returns nothing
    local integer cost = 15
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local player PLY = GetOwningPlayer(u)
    call KillUnit(u)
    call RemoveUnit(u)
    if THD_GetSpirit(PLY) < cost then
        call DisplayTextToPlayer(PLY, 0, 0, "Not enough faith, need 15 faith to disperse the weather.")
        call AddUnitToStock(caster, 'n046', 1, 1)
        set caster = null
        set u = null
        set PLY = null
        return
    endif
    if udg_Weather_Type == -1 then
        call DisplayTextToPlayer(PLY, 0, 0, "Currently, there is no weather...")
        call AddUnitToStock(caster, 'n046', 1, 1)
        set caster = null
        set u = null
        set PLY = null
        return
    endif
    if udg_Weather_Type == 10 then
        call DisplayTextToPlayer(PLY, 0, 0, "Such a good weather...")
        call AddUnitToStock(caster, 'n046', 1, 1)
        set caster = null
        set u = null
        set PLY = null
        return
    endif
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call TriggerExecute(gg_trg_Weather_Effect_Remove)
    set caster = null
    set u = null
    set PLY = null
endfunction

function InitTrig_Weather_Stop takes nothing returns nothing
    set gg_trg_Weather_Stop = CreateTrigger()
    call TriggerAddCondition(gg_trg_Weather_Stop, Condition(function Trig_Weather_Stop_Conditions))
    call TriggerAddAction(gg_trg_Weather_Stop, function Trig_Weather_Stop_Actions)
endfunction