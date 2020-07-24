function Income_Exp takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local player PLY = LoadPlayerHandle(udg_ht, task, 1)
    local integer i = 0
    loop
    exitwhen i >= 12
        if IsUnitAlly(udg_PlayerHeroes[i], PLY) then
            call AddHeroXP(udg_PlayerHeroes[i], 1, true)
        endif
        set i = i + 1
    endloop
    set t = null
    set PLY = null
endfunction

function Income_Exp_Start takes unit u returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SavePlayerHandle(udg_ht, task, 1, GetOwningPlayer(u))
    call TimerStart(t, 6.0, true, function Income_Exp)
    set t = null
endfunction

function Trig_Spirit_Income_Conditions takes nothing returns boolean
    local integer cost = 15
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local unit tower = GetTriggerUnit()
    local player PLY = GetOwningPlayer(u)
    local string str01
    if GetUnitTypeId(u) == 'n05K' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "____!__15______")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set tower = null
            set PLY = null
            set str01 = ""
            return false
        endif
        set str01 = "__"
        if IsUnitAlly(caster, udg_PlayerA[0]) then
            set udg_GameSetting_Spirit[3] = udg_GameSetting_Spirit[3] + 1
        else
            set udg_GameSetting_Spirit[4] = udg_GameSetting_Spirit[4] + 1
        endif
    elseif GetUnitTypeId(u) == 'n05J' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "____!__15______")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set tower = null
            set PLY = null
            set str01 = ""
            return false
        endif
        set str01 = "__"
        call Income_Exp_Start(caster)
    elseif GetUnitTypeId(u) == 'n05I' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "____!__15______")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set tower = null
            set PLY = null
            set str01 = ""
            return false
        endif
        set str01 = "__"
        if IsUnitAlly(caster, udg_PlayerA[0]) then
            set udg_GameSetting_Gold_A = udg_GameSetting_Gold_A + 1
        else
            set udg_GameSetting_Gold_B = udg_GameSetting_Gold_B + 1
        endif
    else
        set caster = null
        set u = null
        set tower = null
        set PLY = null
        return false
    endif
    call RemoveUnit(u)
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + "___|cff8000ff____ - " + str01 + "|r!", PLY)
    set caster = null
    set u = null
    set tower = null
    set PLY = null
    set str01 = ""
    return false
endfunction

function Trig_Spirit_Income_Actions takes nothing returns nothing
endfunction

function InitTrig_Spirit_Income takes nothing returns nothing
    set gg_trg_Spirit_Income = CreateTrigger()
    call TriggerAddCondition(gg_trg_Spirit_Income, Condition(function Trig_Spirit_Income_Conditions))
endfunction