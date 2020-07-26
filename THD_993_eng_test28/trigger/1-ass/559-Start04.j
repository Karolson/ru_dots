function Start04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 2) - 1
    local group g
    local unit v
    local boolexpr iff
    call SaveInteger(udg_ht, task, 2, i)
    if i > 0 then
        call SetUnitFlyHeight(u, 800 - RAbsBJ(50 - i) * 800, 1)
    else
        call KillUnit(u)
        call SetUnitInvulnerable(caster, false)
        call PauseUnit(caster, false)
        call ShowUnit(caster, true)
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitAbsDamageTarget(caster, v, 0)
            endif
        endloop
        call DestroyGroup(g)
    endif
endfunction

function Trig_Start04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local unit u
    local integer level
    local integer task
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        if GetSpellAbilityId() == udg_START04_ABILITYID then
            set t = CreateTimer()
            set u = CreateUnit(GetOwningPlayer(caster), udg_START04_DAMMY, GetUnitX(caster), GetUnitY(caster), 0.0)
            set level = GetUnitAbilityLevel(u, udg_START04_ABILITYID)
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), udg_START04_COLDDOWN_BASIC + (level - 1) * udg_START04_COLDDOWN_INCOME)
            set task = GetHandleId(t)
            call EnableHeight(u)
            call SaveUnitHandle(udg_ht, task, 0, caster)
            call SaveUnitHandle(udg_ht, task, 1, u)
            call SaveInteger(udg_ht, task, 2, 100)
            call SaveInteger(udg_ht, task, 3, level)
            call TimerStart(t, 0.02, true, function Start04_Main)
            set t = null
            set u = null
        endif
    endif
    set caster = null
endfunction

function InitTrig_Start04 takes nothing returns nothing
    set gg_trg_Start04 = CreateTrigger()
    call TriggerAddAction(gg_trg_Start04, function Trig_Start04_Actions)
endfunction