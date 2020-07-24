function Trig_Nue04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0M4'
endfunction

function Trig_Nue04_Ufo takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real a = LoadReal(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local unit k = LoadUnitHandle(udg_ht, task, 5)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local group g
    local unit v
    local effect e
    local real nmdamage
    if i > 0 then
        call SaveInteger(udg_ht, task, 4, i - 1)
        set px = ox + 5 * Cos(a)
        set py = oy + 5 * Sin(a)
        call SetUnitXY(u, px, py)
        call SetUnitXY(k, px, py)
        call SetUnitFlyHeight(u, GetUnitFlyHeight(u) - 40, 0)
        call SetUnitFlyHeight(k, GetUnitFlyHeight(u) - 40, 0)
    else
        set nmdamage = NueDamageCounting(caster) * 4.0
        call SetUnitXY(caster, ox, oy)
        call ShowUnitXumn(caster, true)
        call SelectUnitForPlayerSingle(caster, GetOwningPlayer(caster))
        set g = CreateGroup()
        set e = AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", ox, oy)
        call DestroyEffect(e)
        call UnitStunArea(caster, 1.5 + 0.5 * level, ox, oy, 250 + 50 * level, 0, 0)
        call GroupEnumUnitsInRange(g, ox, oy, 250 + level * 50, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, GetOwningPlayer(u)) and GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(caster, v, level * 80 - 20 + GetHeroInt(caster, true) * 1.3 + nmdamage, 5)
            endif
        endloop
        call UnRegisterAreaShow(caster, 'A0M4')
        call DestroyGroup(g)
        call KillUnit(u)
        call KillUnit(k)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set e = null
    set t = null
    set caster = null
    set u = null
    set g = null
    set v = null
    set k = null
endfunction

function Trig_Nue04_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0M4')
    local unit u
    local unit k
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    call AbilityCoolDownResetion(caster, 'A0M4', 135 - 15 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set t = null
        set u = null
        return
    endif
    call RegisterAreaShowXY(caster, 'A0M4', tx, ty, 250 + 50 * level, 5, 0, "Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", 0.02)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call ShowUnit(caster, false)
    set u = CreateUnit(GetOwningPlayer(caster), 'e017', tx - 375 * Cos(a), ty - 375 * Sin(a), bj_RADTODEG * a)
    set k = CreateUnit(GetOwningPlayer(caster), 'e019', tx - 375 * Cos(a), ty - 375 * Sin(a), bj_RADTODEG * a)
    call SetUnitPathing(u, false)
    call SetUnitPathing(k, false)
    call SetUnitVertexColor(u, GetRandomInt(1, 255), GetRandomInt(1, 255), GetRandomInt(1, 255), 255)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, a)
    call SaveInteger(udg_ht, task, 4, 75)
    call SaveUnitHandle(udg_ht, task, 5, k)
    call TimerStart(t, 0.02, true, function Trig_Nue04_Ufo)
    set caster = null
    set t = null
    set u = null
    set k = null
endfunction

function InitTrig_Nue04 takes nothing returns nothing
endfunction