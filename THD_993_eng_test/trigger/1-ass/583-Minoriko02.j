function Trig_Minoriko02_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSummonedUnit()) == 'o00S'
endfunction

function Trig_Minoriko02_Target takes nothing returns boolean
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    elseif GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MAGIC_IMMUNE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_GIANT) then
        return false
    endif
    return true
endfunction

function Trig_Minoriko02_Heal takes unit caster, unit h, integer level, real rate returns boolean
    local real b = rate * (level * 30.0) / 5.0
    local boolean fullmp = GetUnitState(h, UNIT_STATE_MANA) + 1.0 >= GetUnitState(h, UNIT_STATE_MAX_MANA)
    local boolean fullhp = GetUnitState(h, UNIT_STATE_LIFE) + 1.0 >= GetUnitState(h, UNIT_STATE_MAX_LIFE)
    if fullmp and fullhp then
        return false
    endif
    if not fullmp then
        call UnitManaingTarget(caster, h, b)
    endif
    if not fullhp then
        call UnitHealingTarget(caster, h, b)
    endif
    return true
endfunction

function Trig_Minoriko02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local player w = GetOwningPlayer(u)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local group g
    local filterfunc f
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer j
    local integer k
    if i < 20 and GetWidgetLife(u) > 0.405 then
        call SaveInteger(udg_ht, task, 1, i + 1)
        set g = CreateGroup()
        set f = Filter(function Trig_Minoriko02_Target)
        call GroupEnumUnitsInRange(g, ox, oy, 500.0, f)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitAlly(v, w) then
                set k = GetHandleId(v)
                if HaveSavedInteger(udg_ht, task, k) then
                    set j = LoadInteger(udg_ht, task, k)
                else
                    set j = 0
                endif
                if j < 5 then
                    if Trig_Minoriko02_Heal(caster, v, level, 1.0) then
                        set j = j + 1
                    endif
                    call SaveInteger(udg_ht, task, k, j)
                endif
            endif
        endloop
        call DestroyFilter(f)
        call DestroyGroup(g)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set f = null
    set w = null
endfunction

function Trig_Minoriko02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u = GetSummonedUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0JI')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A0JI', 18)
    call SetUnitAbilityLevel(u, 'A0L6', level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 0.5, true, function Trig_Minoriko02_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Minoriko02 takes nothing returns nothing
endfunction