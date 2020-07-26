function Trig_KanakoEX03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0FC'
endfunction

function GroupKill takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Kanako03_Thunder takes unit caster, real px, real py returns nothing
    local real h = GetPositionZ(px, py)
    local lightning e = AddLightningEx("FORK", true, px, py, h + 800.0, px, py, h)
    call TimedLightning(e, 0.5)
    call UnitStunArea(caster, 0.3, px, py, 220, 0, 0)
    call UnitMagicDamageArea(caster, px, py, 220, 160 + GetHeroInt(caster, true) * 0.8, 5)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", px, py))
    set e = null
endfunction

function Trig_KanakoEX03_Slow takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit caster = LoadUnitHandle(udg_ht, task, 2)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, 300, iff)
    if GetWidgetLife(u) < 0.405 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call DestroyGroup(g)
        set t = null
        set u = null
        set caster = null
        set v = null
        set g = null
        set iff = null
        return
    endif
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A172') == 0 then
            if udg_NewDebuffSys then
                call UnitSlowTargetMspd(caster, v, 60, 1.0, 3, 0)
            else
                call UnitSlowTarget(caster, v, 1, 'A172', 'Basl')
            endif
        endif
    endloop
    call DestroyGroup(g)
    set t = null
    set u = null
    set caster = null
    set v = null
    set g = null
    set iff = null
endfunction

function KanakoEX03_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer n = LoadInteger(udg_sht, task, 0)
    local real ox = LoadReal(udg_sht, task, 1)
    local real oy = LoadReal(udg_sht, task, 2)
    local group g
    local real d
    local real a
    local real tx
    local real ty
    if n > 0 and GetUnitCurrentOrder(caster) == OrderId("blizzard") then
        set a = GetRandomReal(0.0, 6.28344)
        set d = GetRandomReal(0.0, 250.0)
        set tx = ox + d * Cos(a)
        set ty = oy + d * Sin(a)
        call Trig_Kanako03_Thunder(caster, tx, ty)
        set n = n - 1
        call SaveInteger(udg_sht, task, 0, n)
    else
        set g = LoadGroupHandle(udg_sht, task, 3)
        call ForGroup(g, function GroupKill)
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
    endif
    set g = null
    set t = null
    set caster = null
endfunction

function Trig_KanakoEX03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real px
    local real py
    local real s
    local integer level = GetUnitAbilityLevel(caster, 'A0FC')
    local integer i
    local integer n
    local group g = CreateGroup()
    local timer t
    local integer task
    local timer t2
    local integer task2
    local real a
    local real d
    call AbilityCoolDownResetion(caster, 'A0FC', 20)
    set u = CreateUnit(GetOwningPlayer(caster), 'n033', tx, ty, 0.0)
    call GroupAddUnit(g, u)
    set n = level / 2 + 2
    set s = 360.0 / n
    set i = 0
    loop
    exitwhen i >= n
        set px = tx + 100.0 * Cos(i * s * 0.017454)
        set py = ty + 100.0 * Sin(i * s * 0.017454)
        set u = CreateUnit(GetOwningPlayer(caster), 'n036', px, py, i * s)
        call GroupAddUnit(g, u)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 1, u)
        call SaveUnitHandle(udg_ht, task, 2, caster)
        call TimerStart(t, 1.0, true, function Trig_KanakoEX03_Slow)
        set i = i + 1
    endloop
    set n = level * 2
    set s = 2.0 / level
    set t2 = CreateTimer()
    set task2 = GetHandleId(t2)
    set a = GetRandomReal(0.0, 6.28344)
    set d = GetRandomReal(0.0, 250.0)
    set px = tx + d * Cos(a)
    set py = ty + d * Sin(a)
    call Trig_Kanako03_Thunder(caster, px, py)
    call SaveUnitHandle(udg_sht, task2, 0, caster)
    call SaveInteger(udg_sht, task2, 0, n - 1)
    call SaveReal(udg_sht, task2, 1, tx)
    call SaveReal(udg_sht, task2, 2, ty)
    call SaveGroupHandle(udg_sht, task2, 3, g)
    call TimerStart(t2, s, true, function KanakoEX03_Loop)
    set caster = null
    set t = null
    set t2 = null
    set u = null
    set g = null
endfunction

function InitTrig_KanakoEX03 takes nothing returns nothing
endfunction