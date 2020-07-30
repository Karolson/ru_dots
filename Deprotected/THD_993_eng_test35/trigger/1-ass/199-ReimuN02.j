function Trig_ReimuN02_Target takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitDead(GetFilterUnit()) then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    return true
endfunction

function Trig_ReimuN02_Clear takes nothing returns nothing
    call UnitRemoveAbility(GetEnumUnit(), 'B04K')
endfunction

function Trig_ReimuN02_Trace takes nothing returns nothing
    local integer task = GetHandleId(GetExpiredTimer())
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v = GetEnumUnit()
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real r = LoadReal(udg_ht, task, 0)
    if IsUnitInRangeXY(v, ox, oy, r) == false then
        call UnitRemoveAbility(v, 'B04K')
    endif
    set u = null
    set v = null
endfunction

function Trig_ReimuN02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real r = LoadReal(udg_ht, task, 0)
    local group m = LoadGroupHandle(udg_ht, task, 3)
    local group g
    local boolexpr f
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer n = LoadInteger(udg_ht, task, 2)
    local integer j
    local integer k
    if i <= 12 then
        call SaveInteger(udg_ht, task, 1, i + 1)
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
        call ForGroup(m, function Trig_ReimuN02_Trace)
        call GroupClear(m)
        set g = CreateGroup()
        set f = Filter(function Trig_ReimuN02_Target)
        call GroupEnumUnitsInRange(g, ox, oy, r, f)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            call GroupAddUnit(m, v)
            if IsUnitAlly(v, GetOwningPlayer(caster)) then
                if GetUnitAbilityLevel(v, 'A1G6') != 0 then
                    call UnitBuffTarget(v, v, 1, 'A1CG', 0)
                endif
            else
                set k = GetHandleId(v)
                if HaveSavedInteger(udg_ht, task, k) then
                    set j = LoadInteger(udg_ht, task, k)
                else
                    set j = 0
                endif
                if j < n then
                    call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 10 + level, 0.5), 5)
                    call UnitStunTarget(caster, v, 0.1, 0, 0)
                    if IsUnitType(v, UNIT_TYPE_HERO) then
                        call KillUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e014', GetUnitX(v), GetUnitY(v), 22.5))
                        call KillUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e014', GetUnitX(v), GetUnitY(v), 22.5))
                        call KillUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e014', GetUnitX(v), GetUnitY(v), 22.5))
                    endif
                    set j = j + 1
                endif
                call SaveInteger(udg_ht, task, k, j)
            endif
        endloop
        call DestroyBoolExpr(f)
        call DestroyGroup(g)
    else
        call KillUnit(LoadUnitHandle(udg_ht, task, 2))
        call RemoveUnit(u)
        call ForGroup(m, function Trig_ReimuN02_Clear)
        call DestroyGroup(m)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set m = null
    set g = null
    set f = null
endfunction

function Trig_ReimuN02_Field_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local real a = LoadReal(udg_ht, task, 0)
    local real b = LoadReal(udg_ht, task, 1)
    local real k = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i < 50 then
        set a = a + k * (b - a)
        call SaveReal(udg_ht, task, 0, a)
        call SaveInteger(udg_ht, task, 1, i + 1)
        call SetUnitScale(u, a, a, a)
    else
        call SetUnitScale(u, b, b, b)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
endfunction

function Trig_ReimuN02_Field takes unit u, real begin, real end, real k returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitScale(u, begin, begin, begin)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveInteger(udg_ht, task, 1, 1)
    call SaveReal(udg_ht, task, 0, begin)
    call SaveReal(udg_ht, task, 1, end)
    call SaveReal(udg_ht, task, 2, k)
    call TimerStart(t, 0.02, true, function Trig_ReimuN02_Field_Main)
    set t = null
endfunction

function Trig_ReimuN02_Functioned takes unit caster, integer level, real r returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    local unit v
    local unit w
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real s = r / 380
    local group m = CreateGroup()
    local group g
    local boolexpr f
    set w = CreateUnit(GetOwningPlayer(caster), 'n00W', ox, oy, 180)
    call SetUnitVertexColor(w, 255, 255, 255, 220)
    call Trig_ReimuN02_Field(w, 0.3, s, 0.08)
    call UnitBuffTarget(caster, caster, 1, 'A1CG', 0)
    set u = NewDummy(GetOwningPlayer(caster), ox, oy, 0)
    call UnitAddAbility(u, 'A0CC')
    set g = CreateGroup()
    set f = Filter(function Trig_ReimuN02_Target)
    call GroupEnumUnitsInRange(g, ox, oy, r, f)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(caster)) then
            call GroupAddUnit(m, v)
        endif
    endloop
    call DestroyBoolExpr(f)
    call DestroyGroup(g)
    call UnitRemoveAbility(u, 'A0CC')
    call ReleaseDummy(u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, 4)
    call SaveReal(udg_ht, task, 0, r)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, w)
    call SaveUnitHandle(udg_ht, task, 2, w)
    call SaveGroupHandle(udg_ht, task, 3, m)
    call TimerStart(t, 0.4, true, function Trig_ReimuN02_Main)
    set t = null
    set u = null
    set v = null
    set w = null
    set m = null
    set g = null
    set f = null
endfunction

function Trig_ReimuN02_Conditions takes nothing returns boolean
    local unit caster
    local integer abid = GetSpellAbilityId()
    local integer level
    local real r
    if abid != 'A1G6' then
        return false
    endif
    set caster = GetTriggerUnit()
    set level = GetUnitAbilityLevel(caster, abid)
    set r = 400
    call AbilityCoolDownResetion(caster, abid, 16)
    call Trig_ReimuN02_Functioned(caster, level, r)
    call VE_Spellcast(caster)
    set caster = null
    return false
endfunction

function Trig_ReimuN02_Actions takes nothing returns nothing
endfunction

function InitTrig_ReimuN02 takes nothing returns nothing
    set gg_trg_ReimuN02 = CreateTrigger()
    call DisableTrigger(gg_trg_ReimuN02)
    call TriggerAddCondition(gg_trg_ReimuN02, Condition(function Trig_ReimuN02_Conditions))
    call TriggerAddAction(gg_trg_ReimuN02, function Trig_ReimuN02_Actions)
endfunction