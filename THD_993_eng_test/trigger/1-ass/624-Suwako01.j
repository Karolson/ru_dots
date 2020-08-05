function Trig_Suwako01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0FI'
endfunction

function Trig_Suwako01_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit e1 = LoadUnitHandle(udg_ht, task, 0)
    local unit e2 = LoadUnitHandle(udg_ht, task, 1)
    local unit e3 = LoadUnitHandle(udg_ht, task, 2)
    call KillUnit(e1)
    call KillUnit(e2)
    call KillUnit(e3)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set e1 = null
    set e2 = null
    set e3 = null
endfunction

function Trig_Suwako01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real ox = LoadReal(udg_ht, task, 1)
    local real oy = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 4)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit u
    local unit v
    local unit w
    if i > 0 then
        set i = i - 1
        call SaveInteger(udg_ht, task, 3, i)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 300.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodPriest.mdl", v, "origin"))
                if i / 2 * 2 == i then
                    call UnitStunTarget(caster, v, 0.15, 0, 'B05K')
                else
                    call UnitStunTarget(caster, v, 0.15, 0, 0)
                endif
                if level == 1 then
                    call UnitPhysicalDamageTarget(caster, v, 10 + GetHeroInt(caster, true) * 1.4 / 11)
                    call Trig_Suwako03_ManaRe(caster, 10 + GetHeroInt(caster, true) * 1.4 / 11)
                elseif level == 2 then
                    call UnitPhysicalDamageTarget(caster, v, 10 + GetHeroInt(caster, true) * 1.4 / 14)
                    call Trig_Suwako03_ManaRe(caster, 10 + GetHeroInt(caster, true) * 1.4 / 14)
                elseif level == 3 then
                    call UnitPhysicalDamageTarget(caster, v, 10 + GetHeroInt(caster, true) * 1.4 / 17)
                    call Trig_Suwako03_ManaRe(caster, 10 + GetHeroInt(caster, true) * 1.4 / 17)
                elseif level == 4 then
                    call UnitPhysicalDamageTarget(caster, v, 10 + GetHeroInt(caster, true) * 1.4 / 20)
                    call Trig_Suwako03_ManaRe(caster, 10 + GetHeroInt(caster, true) * 1.4 / 20)
                endif
            endif
        endloop
        call DestroyGroup(g)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set g = null
    set iff = null
    set u = null
    set v = null
    set w = null
endfunction

function Trig_Suwako01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local timer t2 = CreateTimer()
    local integer task2 = GetHandleId(t2)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0FI')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local unit e1 = CreateUnit(GetOwningPlayer(caster), 'e01L', ox, oy, 0)
    local unit e2 = CreateUnit(GetOwningPlayer(caster), 'e01L', ox, oy, 0)
    local unit e3 = CreateUnit(GetOwningPlayer(caster), 'e01L', ox, oy, 0)
    local unit w
    call AbilityCoolDownResetion(caster, 'A0FI', 15 - level)
    call SetUnitPathing(e1, false)
    call SetUnitPathing(e2, false)
    call SetUnitPathing(e3, false)
    call SetUnitXY(e1, ox, oy)
    call SetUnitXY(e2, ox, oy)
    call SetUnitXY(e3, ox, oy)
    call SaveUnitHandle(udg_ht, task, 0, e1)
    call SaveUnitHandle(udg_ht, task, 1, e2)
    call SaveUnitHandle(udg_ht, task, 2, e3)
    call TimerStart(t, 0.8 + 0.3 * level, false, function Trig_Suwako01_Clear)
    call SaveUnitHandle(udg_ht, task2, 0, caster)
    call SaveReal(udg_ht, task2, 1, ox)
    call SaveReal(udg_ht, task2, 2, oy)
    call SaveInteger(udg_ht, task2, 3, 8 + 3 * level)
    call SaveInteger(udg_ht, task2, 4, level)
    call TimerStart(t2, 0.1, true, function Trig_Suwako01_Main)
    set t = null
    set t2 = null
    set caster = null
    set e1 = null
    set e2 = null
    set e3 = null
    set w = null
endfunction

function InitTrig_Suwako01 takes nothing returns nothing
endfunction