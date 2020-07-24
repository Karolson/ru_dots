function Trig_Toramaru02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0R3' or GetSpellAbilityId() == 'A0SU'
endfunction

function Trig_Toramaru02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local boolean k = false
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if i > 0 then
        call SaveInteger(udg_ht, task, 3, i - 1)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 120.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(u, v, level * 50 + GetHeroInt(caster, true) * 1, 5)
                set k = true
            endif
        endloop
        call DestroyGroup(g)
        if k then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl", GetUnitX(u), GetUnitY(u)))
            call KillUnit(u)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl", GetUnitX(u), GetUnitY(u)))
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_Toramaru02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local integer level = GetUnitAbilityLevel(caster, 'A0R3')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real cd = GetAbilityCoolDownTime(caster, GetSpellAbilityId(), 7 - level)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 7 - level)
    if udg_SK_ToramaruDB_Count > 0 then
        set udg_SK_ToramaruDB_Count = udg_SK_ToramaruDB_Count - 1
        call Trig_ToramaruDB_Change()
        call UnitHealingTarget(caster, caster, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02)
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.02)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
    endif
    if GetUnitAbilityLevel(caster, 'A1GC') == 0 then
        set u = CreateUnit(GetOwningPlayer(caster), 'e01X', tx, ty, 0)
        call UnitBuffTarget(caster, caster, cd, 'A1GC', 0)
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 0)
    else
        set u = CreateUnit(GetOwningPlayer(caster), 'e01P', tx, ty, 0)
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 250)
    call TimerStart(t, 0.04, true, function Trig_Toramaru02_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Toramaru02 takes nothing returns nothing
endfunction