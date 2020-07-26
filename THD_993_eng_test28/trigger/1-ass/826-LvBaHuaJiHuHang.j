function Trig_LvBaHuaJiHuHang_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0AP'
endfunction

function Trig_LvBaHuaJiHuHang_Iff takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) < 0.405 or IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or not IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    endif
    return true
endfunction

function Trig_LvBaHuaJiHuHang_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_ht, GetHandleId(t), 0)
    local unit v
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call RemoveSavedReal(udg_Hashtable_Slow, GetHandleId(v), 'A1DL' * -10)
    endloop
    call RemoveSavedHandle(udg_ht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    call DestroyGroup(g)
    set t = null
    set g = null
    set v = null
endfunction

function Trig_LvBaHuaJiHuHang_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local unit v = null
    local unit u = NewDummy(GetOwningPlayer(caster), x, y, 0.0)
    local boolexpr iff = Filter(function Trig_LvBaHuaJiHuHang_Iff)
    local group g = CreateGroup()
    local group gg = CreateGroup()
    local timer t = CreateTimer()
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 500, iff)
    call GroupAddGroup(g, gg)
    call SaveGroupHandle(udg_ht, GetHandleId(t), 0, g)
    call TimerStart(t, 10, false, function Trig_LvBaHuaJiHuHang_Clear)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitBuffTarget(caster, v, 10.0, 'A1DL', 'Bam2')
        call SaveReal(udg_Hashtable_Slow, GetHandleId(v), 'A1DL' * -10, 600 + udg_GameTime / 60 * 4)
        call SaveUnitHandle(udg_Hashtable_Slow, GetHandleId(v), 'A1DL' * -10, caster)
    endloop
    call UnitRemoveAbility(u, 'A0AO')
    call DestroyGroup(g)
    call ReleaseDummy(u)
    set caster = null
    set g = null
    set u = null
    set gg = null
    set t = null
endfunction

function InitTrig_LvBaHuaJiHuHang takes nothing returns nothing
    set gg_trg_LvBaHuaJiHuHang = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LvBaHuaJiHuHang, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_LvBaHuaJiHuHang, Condition(function Trig_LvBaHuaJiHuHang_Conditions))
    call TriggerAddAction(gg_trg_LvBaHuaJiHuHang, function Trig_LvBaHuaJiHuHang_Actions)
endfunction