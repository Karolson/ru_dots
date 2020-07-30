function Trig_Yuugi02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A08B'
endfunction

function Yuugi02_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g2 = LoadGroupHandle(udg_ht, task, 0)
    local unit v
    loop
        set v = FirstOfGroup(g2)
    exitwhen v == null
        call GroupRemoveUnit(g2, v)
        set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] / 0.75
    endloop
    call DestroyGroup(g2)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
endfunction

function Trig_Yuugi02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local location loc1 = GetUnitLoc(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A08B')
    local location loc2
    local integer i
    local effect e
    local group g = CreateGroup()
    local group g2 = CreateGroup()
    local unit v
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local real damage = ABCIAllAtk(caster, 50 + level * 30, 1.0)
    local player p = GetOwningPlayer(caster)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local boolexpr iff
    call AbilityCoolDownResetion(caster, 'A08B', 11.5 - 1.5 * level)
    set i = 1
    call GroupEnumUnitsInRange(g, x, y, 320 + level * 30, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, p) and GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, 'Aloc') == 0 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
            call UnitPhysicalDamageTarget(caster, v, damage)
            if udg_NewDebuffSys then
                call UnitSlowTargetAspd(caster, v, 25, 4.0, 2, 0)
                call UnitSlowTargetMspd(caster, v, 50, 4.0, 2, 0)
            else
                call UnitSlowTarget(caster, v, 4.0, 'A118', 'B06H')
            endif
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] * 0.75
                call GroupAddUnit(g2, v)
            endif
        endif
    endloop
    call SaveGroupHandle(udg_ht, task, 0, g2)
    call TimerStart(t, 4, false, function Yuugi02_Clear)
    loop
    exitwhen i > 10
        set loc2 = PolarProjectionBJ(loc1, level * 30.0 + 180.0, 60.0 * i)
        set e = AddSpecialEffectLoc("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", loc2)
        call DestroyEffect(e)
        call RemoveLocation(loc2)
        set i = i + 1
    endloop
    call RemoveLocation(loc1)
    call DestroyGroup(g)
    set g = null
    set g2 = null
    set iff = null
    set v = null
    set caster = null
    set loc1 = null
    set loc2 = null
    set e = null
endfunction

function InitTrig_Yuugi02 takes nothing returns nothing
endfunction