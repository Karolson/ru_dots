function Trig_MediEx_Target takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'B029') >= 1 then
        return true
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'B01N') >= 1 then
        return true
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'B076') >= 1 then
        return true
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'A0A0') >= 1 then
        return true
    endif
    return false
endfunction

function Trig_MediEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local group g = LoadGroupHandle(udg_ht, task, 1)
    local unit v
    local real ox
    local real oy
    local real damage
    if caster == null then
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set g = null
        set v = null
    endif
    set ox = GetUnitX(caster)
    set oy = GetUnitY(caster)
    call GroupEnumUnitsInRange(g, ox, oy, 99999, Filter(function Trig_MediEx_Target))
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        set damage = 0
        if GetUnitAbilityLevel(v, 'B029') >= 1 then
            set damage = damage + GetUnitState(v, UNIT_STATE_MAX_LIFE) * 0.008
        endif
        if GetUnitAbilityLevel(v, 'B01N') >= 1 then
            set damage = damage + GetUnitState(v, UNIT_STATE_MAX_LIFE) * 0.008
        endif
        if GetUnitAbilityLevel(v, 'B076') >= 1 then
            set damage = damage + GetUnitState(v, UNIT_STATE_MAX_LIFE) * 0.008
        endif
        if GetUnitAbilityLevel(v, 'A0A0') >= 1 then
            set damage = damage + GetUnitState(v, UNIT_STATE_MAX_LIFE) * 0.008
        endif
        call UnitMagicDamageTarget(caster, v, damage, 2)
    endloop
    set t = null
    set caster = null
    set g = null
endfunction

function InitTrig_MediEx takes nothing returns nothing
endfunction