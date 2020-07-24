function Trig_Parsee02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0PM'
endfunction

function Trig_Parsee02_Drop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real a = LoadReal(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local group g
    local unit v
    local unit w
    local real damage
    local real duration
    local boolean flag = false
    if i > 0 then
        call SaveInteger(udg_ht, task, 4, i - 1)
        call SetUnitFlyHeight(u, i * 25, 0)
    else
        set damage = level * 30 + 20 + GetHeroInt(caster, true) * 1.0
        set duration = 1.0 + 0.2 * level
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 120, null)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Volcano\\VolcanoMissile.mdl", GetUnitX(u), GetUnitY(u)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\AcidBomb\\BottleMissile.mdl", GetUnitX(u), GetUnitY(u)))
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, GetOwningPlayer(u)) and IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(caster, v, damage, 5)
                set flag = true
                if udg_NewDebuffSys then
                    call UnitSlowTargetNew(caster, v, 40, duration, 2, 0)
                else
                    call UnitSlowTarget(caster, v, duration, 'A15S', 'Bslo')
                endif
            endif
        endloop
        if flag == false then
            call UnitManaingTarget(caster, caster, (60 + level * 20) * 0.25)
        endif
        call KillUnit(u)
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set g = null
    set v = null
    set w = null
endfunction

function Trig_Parsee02_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 9 - level)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BansheeMissile\\BansheeMissile.mdl", tx, ty))
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BansheeMissile\\BansheeMissile.mdl", tx, ty))
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BansheeMissile\\BansheeMissile.mdl", tx, ty))
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04A', tx, ty, bj_RADTODEG * a)
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, a)
    call SaveInteger(udg_ht, task, 4, 85)
    call TimerStart(t, 0.01, true, function Trig_Parsee02_Drop)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04A', tx, ty, bj_RADTODEG * a)
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, a)
    call SaveInteger(udg_ht, task, 4, 115)
    call TimerStart(t, 0.01, true, function Trig_Parsee02_Drop)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04A', tx, ty, bj_RADTODEG * a)
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, a)
    call SaveInteger(udg_ht, task, 4, 145)
    call TimerStart(t, 0.01, true, function Trig_Parsee02_Drop)
    set caster = null
    set t = null
    set u = null
endfunction

function InitTrig_Parsee02 takes nothing returns nothing
endfunction