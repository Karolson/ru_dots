function Trig_Kogasa02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0LS'
endfunction

function Trig_Kogasa02_Target takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    elseif IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    elseif GetUnitTypeId(GetFilterUnit()) == 'n01N' then
        return false
    endif
    return true
endfunction

function Trig_Kogasa02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local real damage = (0 - 90 + level * 120 + GetUnitAttack(caster) * 4.2) / 4
    local real damage2
    local filterfunc f
    local group g
    local unit v
    if i > 0 and GetUnitState(caster, UNIT_STATE_LIFE) >= 1 then
        call ClearAllNegativeBuff(caster, false)
        set i = i - 1
        if i / 5 * 5 == i then
            set g = CreateGroup()
            set f = Filter(function Trig_Kogasa02_Target)
            call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 250, f)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                set damage2 = damage
                if GetUnitTypeId(v) == udg_SU_ID_A[0] or GetUnitTypeId(v) == udg_SU_ID_B[0] then
                    call UnitPhysicalDamageTarget(caster, v, damage2 * 0.5 * 0.75)
                else
                    call UnitPhysicalDamageTarget(caster, v, damage2 * 0.5 * 1.1)
                endif
                call VE_Sword(v)
            endloop
            call DestroyFilter(f)
            call DestroyGroup(g)
        endif
        call SaveInteger(udg_ht, task, 2, i)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set f = null
    set g = null
    set v = null
endfunction

function Trig_Kogasa02_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0LS')
    local integer i = 40
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveInteger(udg_ht, task, 2, i)
    call TimerStart(t, 0.1, true, function Trig_Kogasa02_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Kogasa02 takes nothing returns nothing
endfunction