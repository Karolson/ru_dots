function Trig_ReisenN03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1GQ'
endfunction

function Trig_ReisenN03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 2)
    local real y = LoadReal(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 4)
    local integer i = LoadInteger(udg_ht, task, 5) - 1
    local real damage = ABCIAllInt(caster, 10 + 10 * level, 0.3)
    local integer j
    local real a
    local real r
    call SaveInteger(udg_ht, task, 5, i)
    call UnitMagicDamageArea(caster, x, y, 275, damage, 6)
    call UnitSlowTargetArea(caster, x, y, 275, 1, 'A1GT' + 4, 'B0A3')
    set j = 0
    loop
        set a = GetRandomInt(0, 360)
        set r = GetRandomInt(0, 275)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl", x + r * CosBJ(a), y + r * SinBJ(a)))
        set j = j + 1
    exitwhen j >= 16
    endloop
    if i <= 0 then
        call PauseTimer(t)
        call ReleaseTimer(t)
        call UnRegisterAreaShow(caster, 'A1GQ')
        call FlushChildHashtable(udg_ht, task)
    endif
    set caster = null
    set t = null
endfunction

function Trig_ReisenN03_CallBack takes nothing returns nothing
    local unit caster = udg_PS_Source
    local integer level = GetUnitAbilityLevel(caster, 'A1GQ')
    local real x = udg_PS_CurrentX
    local real y = udg_PS_CurrentY
    local real damage = ABCIAllInt(caster, 30 + 40 * level, 1.4)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer i
    local real a
    local real r
    call UnitMagicDamageArea(caster, x, y, 275, damage, 6)
    call UnitSlowTargetArea(caster, x, y, 275, 1, 'A1GT' + 4, 'B0A3')
    call DestroyEffect(AddSpecialEffect("bottlemissile.mdl", x, y))
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveReal(udg_ht, task, 2, x)
    call SaveReal(udg_ht, task, 3, y)
    call SaveInteger(udg_ht, task, 4, level)
    call SaveInteger(udg_ht, task, 5, 4)
    call TimerStart(t, 1.0, true, function Trig_ReisenN03_Main)
    call RegisterAreaShowXY(caster, 'A1GQ', x, y, 275, 12, 1, "Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl", 1)
    set i = 0
    loop
        set a = GetRandomInt(0, 360)
        set r = GetRandomInt(0, 275)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl", x + r * CosBJ(a), y + r * SinBJ(a)))
        set i = i + 1
    exitwhen i >= 16
    endloop
    set caster = null
    set t = null
endfunction

function Trig_ReisenN03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1GQ')
    call AbilityCoolDownResetion(caster, 'A1GQ', 16.5 - level * 1.5)
    call LaunchProjectileFromUnitToPoint("bottlemissile.mdl", 1.5, GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY(), 900, 50, "", "Trig_ReisenN03_CallBack", false, false, false)
    set caster = null
endfunction

function InitTrig_ReisenN03 takes nothing returns nothing
endfunction