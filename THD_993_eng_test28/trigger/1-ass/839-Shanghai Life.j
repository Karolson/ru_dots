function Trig_Shanghai_Life_Target01 takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == 'n006'
endfunction

function Trig_Shanghai_Life_Target02 takes nothing returns boolean
    if IsUnitIllusion(GetFilterUnit()) then
        return false
    endif
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Shanghai_Life_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_ht, task, 1)
    local boolexpr f1 = LoadBooleanExprHandle(udg_ht, task, 2)
    local group h = LoadGroupHandle(udg_ht, task, 3)
    local boolexpr f2 = LoadBooleanExprHandle(udg_ht, task, 4)
    local unit v
    local unit w
    local boolean k = false
    local real px
    local real py
    call GroupEnumUnitsInRange(g, 0, 0, 99999.0, f1)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call ClearAllNegativeBuff(v, false)
        if GetUnitAbilityLevel(v, 'A17U') == 0 then
            call IssueImmediateOrder(v, "holdposition")
            call UnitAddAbility(v, 'A17U')
        endif
        set px = GetUnitX(v)
        set py = GetUnitY(v)
        call GroupEnumUnitsInRange(h, px, py, 650, f2)
        set w = FirstOfGroup(h)
        if w == null then
            set k = false
        else
            set k = true
        endif
        if k == false then
            call SetUnitState(v, UNIT_STATE_LIFE, GetWidgetLife(v) + 100.0)
        endif
    endloop
    set t = null
    set g = null
    set h = null
    set v = null
    set w = null
    set f1 = null
    set f2 = null
endfunction

function Trig_Shanghai_Life_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    local group h = CreateGroup()
    local boolexpr f1 = Filter(function Trig_Shanghai_Life_Target01)
    local boolexpr f2 = Filter(function Trig_Shanghai_Life_Target02)
    call SaveGroupHandle(udg_ht, task, 1, g)
    call SaveBooleanExprHandle(udg_ht, task, 2, f1)
    call SaveGroupHandle(udg_ht, task, 3, h)
    call SaveBooleanExprHandle(udg_ht, task, 4, f2)
    call TimerStart(t, 0.33, true, function Trig_Shanghai_Life_Main)
    set t = null
    set g = null
    set h = null
    set f1 = null
    set f2 = null
endfunction

function InitTrig_Shanghai_Life takes nothing returns nothing
    set gg_trg_Shanghai_Life = CreateTrigger()
    call TriggerAddAction(gg_trg_Shanghai_Life, function Trig_Shanghai_Life_Actions)
endfunction