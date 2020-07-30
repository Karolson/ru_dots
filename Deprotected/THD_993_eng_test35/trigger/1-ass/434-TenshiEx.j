function TenshiEX_CD_Condition takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetUnitTypeId(GetKillingUnit()) == 'H002'
endfunction

function TenshiEX_CD_Main takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task2 = GetHandleId(trg)
    local triggeraction tga = LoadTriggerActionHandle(udg_ht, task2, 0)
    local unit u = GetKillingUnit()
    call UnitRemoveAbility(u, 'A0W4')
    call UnitAddAbility(u, 'A0P8')
    call FlushChildHashtable(udg_ht, task2)
    call TriggerRemoveAction(trg, tga)
    call DestroyTrigger(trg)
    set trg = null
    set tga = null
    set u = null
endfunction

function TenshiEx_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    local unit v
    local real damage
    local player p
    local unit dammy = LoadUnitHandle(udg_ht, task, 1)
    local real duration = LoadReal(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    set duration = duration + 0.03125
    if duration < 0.7 then
        call SetUnitFlyHeight(u, 1777.8 * duration * (0.7 - duration), 0.0)
        call SetUnitFlyHeight(dammy, 1777.8 * duration * (0.7 - duration) - 200, 0.0)
        call SaveReal(udg_ht, task, 0, duration)
    else
        call SetUnitFlyHeight(u, GetUnitDefaultFlyHeight(u), 0.0)
        call SetUnitInvulnerable(u, false)
        call RemoveUnit(dammy)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", x, y))
        call PauseUnit(u, false)
        set damage = 50.0 + GetUnitAttack(u) * 0.5 + GetHeroStr(u, true) * 0.5
        call GroupEnumUnitsInRange(g, x, y, 300.0, null)
        set p = GetOwningPlayer(u)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, p) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(v, 'Avul') == 0 then
                call UnitMagicDamageTarget(u, v, damage, 5)
            endif
        endloop
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set dammy = null
    set t = null
    set u = null
    set v = null
    set g = null
    set p = null
endfunction

function TenshiEx_Condition takes nothing returns boolean
    local unit u = null
    local player p = null
    local integer id = GetSpellAbilityId()
    local real x
    local real y
    local timer t = null
    local integer task
    local trigger trg
    local triggeraction tga
    local unit dammy
    if id == 'A0P8' then
        call AbilityCoolDownResetion(u, GetSpellAbilityId(), 120)
        set u = GetTriggerUnit()
        set p = GetOwningPlayer(u)
        set x = GetUnitX(u)
        set y = GetUnitY(u)
        call EnableHeight(u)
        call SetUnitInvulnerable(u, true)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", x, y))
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveReal(udg_ht, task, 0, 0.0)
        call SaveUnitHandle(udg_ht, task, 0, u)
        call PauseUnit(u, true)
        set dammy = CreateUnit(GetOwningPlayer(u), 'e03C', x, y, 0.0)
        call SaveUnitHandle(udg_ht, task, 1, dammy)
        call TimerStart(t, 0.03125, true, function TenshiEx_Loop)
        set u = null
        set dammy = null
        set t = null
        set trg = null
        set tga = null
    endif
    return false
endfunction

function InitTrig_TenshiEx takes nothing returns nothing
endfunction