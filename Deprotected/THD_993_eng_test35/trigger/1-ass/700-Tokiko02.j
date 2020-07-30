function Trig_Tokiko02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0ZL'
endfunction

function Trig_Tokiko02_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    if i <= 6 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", x + i * 57 * CosBJ(a), y + i * 57 * SinBJ(a)))
    endif
    if i >= 4 and i <= 6 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", x + 171 * CosBJ(a + 24 * (i - 5)), y + 171 * SinBJ(a + 24 * (i - 5))))
    endif
    if i >= 7 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", x + 342 * CosBJ(a - 14.4 * (i - 5)), y + 342 * SinBJ(a - 14.4 * (i - 5))))
    endif
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= 11 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Tokiko02_Fire takes real x, real y, real a returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call TimerStart(t, 0.03, true, function Trig_Tokiko02_Fire_Main)
    set t = null
endfunction

function Trig_Tokiko02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0ZL')
    local integer i
    local group g
    local unit v
    call AbilityCoolDownResetion(caster, 'A0ZL', 3)
    call UnitAbsDamageTarget(caster, caster, level * 20 + 20)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, ox, oy, 350, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and v != caster and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            if IsUnitAlly(v, GetOwningPlayer(caster)) == false and IsUnitType(v, UNIT_TYPE_HERO) then
                if GetUnitAbilityLevel(v, 'A19Q') >= 1 then
                    call UnitMagicDamageTarget(caster, v, (level * 25 + 30 + 1.15 * GetHeroInt(caster, true)) * 2.2, 5)
                    call UnitBuffTarget(caster, v, 8, 'A19Q', 0)
                elseif GetUnitAbilityLevel(v, 'A19P') >= 1 then
                    call UnitMagicDamageTarget(caster, v, (level * 25 + 30 + 1.15 * GetHeroInt(caster, true)) * 1.9, 5)
                    call UnitRemoveAbility(v, 'A19P')
                    call UnitBuffTarget(caster, v, 8, 'A19Q', 0)
                elseif GetUnitAbilityLevel(v, 'A19O') >= 1 then
                    call UnitMagicDamageTarget(caster, v, (level * 25 + 30 + 1.15 * GetHeroInt(caster, true)) * 1.6, 5)
                    call UnitRemoveAbility(v, 'A19O')
                    call UnitBuffTarget(caster, v, 8, 'A19P', 0)
                elseif GetUnitAbilityLevel(v, 'A19N') >= 1 then
                    call UnitMagicDamageTarget(caster, v, (level * 25 + 30 + 1.15 * GetHeroInt(caster, true)) * 1.3, 5)
                    call UnitRemoveAbility(v, 'A19N')
                    call UnitBuffTarget(caster, v, 8, 'A19O', 0)
                else
                    call UnitMagicDamageTarget(caster, v, level * 25 + 30 + 1.15 * GetHeroInt(caster, true), 5)
                    call UnitBuffTarget(caster, v, 8, 'A19N', 0)
                endif
            elseif IsUnitAlly(v, GetOwningPlayer(caster)) == false then
                call UnitMagicDamageTarget(caster, v, level * 25 + 30 + 1.15 * GetHeroInt(caster, true), 5)
            endif
        endif
    endloop
    call DestroyGroup(g)
    set i = 0
    loop
        call Trig_Tokiko02_Fire(ox, oy, i * 72)
        set i = i + 1
    exitwhen i == 5
    endloop
    set caster = null
    set g = null
    set v = null
endfunction

function InitTrig_Tokiko02 takes nothing returns nothing
endfunction