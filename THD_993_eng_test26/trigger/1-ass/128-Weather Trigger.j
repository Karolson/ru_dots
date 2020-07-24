function Trig_Weather_TriggerConditions takes nothing returns boolean
    return udg_Weather_Type < 0
endfunction

function Trig_Weather_TriggerActions takes nothing returns nothing
    local unit u = GetSoldUnit()
    local player who = GetOwningPlayer(u)
    local integer ID = GetUnitTypeId(u)
    local integer i = 0
    local integer cost = 5
    call DebugMsg("Check Weather")
    if ID == 'n049' then
        set cost = 1
    elseif ID == 'n048' then
        set cost = 3
    elseif ID == 'n02F' then
        set cost = 5
    elseif ID == 'n02E' then
        set cost = 35
    elseif ID == 'n02C' then
        set cost = 5
    elseif ID == 'n02G' then
        set cost = 12
    elseif ID == 'n02D' then
        set cost = 12
    elseif ID == 'n044' then
        set cost = 12
    elseif ID == 'n02H' then
        set cost = 20
    elseif ID == 'n047' then
        set cost = 20
    elseif ID == 'n045' then
        set cost = 35
    elseif ID == 'n02B' then
        set cost = 35
    endif
    call KillUnit(u)
    call RemoveUnit(u)
    set u = null
    call DisableTrigger(GetTriggeringTrigger())
    loop
    exitwhen udg_Weather_TriggerItem[i] == ID or i > 13
        set i = i + 1
    endloop
    if i > 13 then
        set u = null
        set who = null
        return
    endif
    if THD_GetSpirit(who) < cost then
        call DisplayTextToPlayer(who, 0, 0, "Not enough faith, need " + I2S(cost) + " faith to change the weather.")
        call StartTimerBJ(udg_Weather_Timer[1], false, 0.01)
        call EnableTrigger(GetTriggeringTrigger())
    else
        call THD_AddSpirit(who, -cost)
        set udg_Weather_Type = i
        if i == 11 then
            set udg_Weather_Type = GetRandomInt(1, 10)
        endif
        call TriggerExecute(gg_trg_Weather_Effect_Create)
        call TriggerExecute(gg_trg_Weather_Effect_Spell)
        call StartTimerBJ(udg_Weather_Timer[1], false, 0.01)
        call EnableTrigger(GetTriggeringTrigger())
    endif
    set u = null
    set who = null
endfunction

function InitTrig_Weather_Trigger takes nothing returns nothing
    set gg_trg_Weather_Trigger = CreateTrigger()
    call TriggerAddCondition(gg_trg_Weather_Trigger, Condition(function Trig_Weather_TriggerConditions))
    call TriggerAddAction(gg_trg_Weather_Trigger, function Trig_Weather_TriggerActions)
endfunction