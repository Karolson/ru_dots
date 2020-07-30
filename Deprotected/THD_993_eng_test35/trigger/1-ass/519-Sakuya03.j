function Trig_Sakuya03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A09A'
endfunction

function Trig_Sakuya03_Speedup_Timeout takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call UnitRemoveAbility(caster, 'A09D')
    call FlushChildHashtable(udg_ht, task)
    call FlushChildHashtable(udg_ht, GetHandleId(caster))
    call ReleaseTimer(t)
    set t = null
    set caster = null
endfunction

function Trig_Sakuya03_Speedup takes unit caster returns nothing
    local timer t
    local integer level = GetUnitAbilityLevel(caster, 'A09D')
    if level == 0 then
        set t = CreateTimer()
        call UnitAddAbility(caster, 'A09D')
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
        call SaveTimerHandle(udg_sht, GetHandleId(caster), 0, t)
    else
        set t = LoadTimerHandle(udg_sht, GetHandleId(caster), 0)
        call SetUnitAbilityLevel(caster, 'A09D', IMinBJ(4, level + 1))
    endif
    call TimerStart(t, 6.0, false, function Trig_Sakuya03_Speedup_Timeout)
    set t = null
endfunction

function Trig_Sakuya03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real dx = GetSpellTargetX() - ox
    local real dy = GetSpellTargetY() - oy
    local real px
    local real py
    local real a = Atan2(dy, dx)
    local real d = SquareRoot(dx * dx + dy * dy)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer i
    local unit v
    local group g
    local boolexpr iff
    local real damage
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 20 - 3 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set u = null
        set v = null
        set g = null
        set iff = null
        return
    endif
    call Trig_Sakuya03_Speedup(caster)
    set d = RMaxBJ(150.0, d)
    set d = RMinBJ(300.0 + level * 100.0, d)
    set px = ox + d * Cos(a)
    set py = oy + d * Sin(a)
    call Trig_BlinkPlaceRealer(px, py, d, a)
    set px = udg_SK_BlinkPlace_x
    set py = udg_SK_BlinkPlace_y
    call SetUnitXY(caster, px, py)
    set u = CreateUnit(GetOwningPlayer(caster), 'n01R', ox, oy, GetUnitFacing(caster))
    call UnitFade(u, true, true, 0.1)
    set damage = ABCIAllInt(caster, 0 - 30 + level * 40, 1.0)
    if udg_SK_Sakuya04_Mana03[k] != 0 then
        call SetUnitState(caster, UNIT_STATE_MANA, RMaxBJ(GetUnitState(caster, UNIT_STATE_MANA) - 110 * 0.75, 0))
    endif
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, px, py, 300, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            call UnitPhysicalDamageTarget(caster, v, damage)
        endif
    endloop
    call DestroyGroup(g)
    set u = NewDummy(GetOwningPlayer(caster), px, py, 0.0)
    call UnitAddAbility(u, 'A09F')
    set i = 1
    loop
    exitwhen i > 8
        call SetUnitX(u, px + 250.0 * Cos(i * 45 * 0.017454))
        call SetUnitY(u, py + 250.0 * Sin(i * 45 * 0.017454))
        call IssuePointOrder(u, "clusterrockets", px, py)
        set i = i + 1
    endloop
    call UnitRemoveAbility(u, 'A09F')
    call ReleaseDummy(u)
    set caster = null
    set u = null
    set g = null
    set iff = null
    set v = null
endfunction

function InitTrig_Sakuya03 takes nothing returns nothing
endfunction