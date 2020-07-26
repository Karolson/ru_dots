function Advanced_Strategy_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    if IsUnitType(u, UNIT_TYPE_DEAD) == false then
        call SetUnitXY(u, GetUnitX(v), GetUnitY(v))
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set v = null
    set u = null
endfunction

function Advanced_Strategy_Main takes unit caster, unit v returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    set u = CreateUnit(GetOwningPlayer(caster), 'n05R', GetUnitX(v), GetUnitY(v), 0)
    call SaveUnitHandle(udg_ht, task, 0, v)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call TimerStart(t, 0.1, true, function Advanced_Strategy_Clear)
    set t = null
    set u = null
endfunction

function Trig_Advanced_Strategy_Conditions takes nothing returns boolean
    local integer cost = 70
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local unit tower = GetTriggerUnit()
    local player PLY = GetOwningPlayer(u)
    local string str01
    local integer i
    local unit v
    if GetUnitTypeId(u) == 'n05P' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! Need " + I2S(cost) + " faith to launch")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set v = null
            return false
        endif
        set str01 = "Sixty years trial!"
        set i = 0
        loop
        exitwhen i >= 12
            if IsUnitAlly(udg_PlayerHeroes[i], PLY) then
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl", udg_PlayerHeroes[i], "origin"))
                call UnitAbsDamageArea(udg_PlayerHeroes[i], GetUnitX(udg_PlayerHeroes[i]), GetUnitY(udg_PlayerHeroes[i]), 600, 120 + udg_GameTime / 15)
            endif
            set i = i + 1
        endloop
    elseif GetUnitTypeId(u) == 'n05O' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! Need " + I2S(cost) + " faith to launch")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set v = null
            return false
        endif
        set str01 = "Sight (Reporting technique)"
        set i = 0
        loop
        exitwhen i >= 12
            if IsUnitAlly(udg_PlayerHeroes[i], PLY) == false then
                call Advanced_Strategy_Main(caster, udg_PlayerHeroes[i])
            endif
            set i = i + 1
        endloop
    elseif GetUnitTypeId(u) == 'n05Q' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! Need " + I2S(cost) + " faith to launch")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set v = null
            return false
        endif
        set str01 = "Rune 'God's Footsteps'"
        set i = 0
        loop
        exitwhen i >= 12
            if IsUnitAlly(udg_PlayerHeroes[i], PLY) then
                call UnitBuffTarget(udg_PlayerHeroes[i], udg_PlayerHeroes[i], 8.0, 'A1E1', 0)
            endif
            set i = i + 1
        endloop
    else
        set caster = null
        set u = null
        set tower = null
        set PLY = null
        return false
    endif
    call RemoveUnit(u)
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call BroadcastMessage(udg_PN[GetPlayerId(PLY)] + " has used |cff8000ff" + str01 + "|r!")
    set caster = null
    set u = null
    set tower = null
    set PLY = null
    return false
endfunction

function InitTrig_Advanced_Strategy takes nothing returns nothing
    set gg_trg_Advanced_Strategy = CreateTrigger()
    call TriggerAddCondition(gg_trg_Advanced_Strategy, Condition(function Trig_Advanced_Strategy_Conditions))
endfunction