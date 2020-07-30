function Trig_Reisen201_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A08Z'
endfunction

function Trig_Reisen201_Des_Condition takes nothing returns nothing
    set udg_SK_Reisen201I = udg_SK_Reisen201I + 1
endfunction

function Trig_Reisen201_Unit_Condition takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) > 0 then
        if GetFilterUnit() != udg_SK_Reisen201U1 and GetFilterUnit() != udg_SK_Reisen201U2 then
            set udg_SK_Reisen201I = udg_SK_Reisen201I + 1
        endif
    endif
    return false
endfunction

function Trig_Reisen201_Push takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local unit ud = LoadUnitHandle(udg_ht, task, 1)
    local group g
    local real f = LoadReal(udg_ht, task, 2)
    local real x = LoadReal(udg_ht, task, 3)
    local real y = LoadReal(udg_ht, task, 4)
    local real xt = PolarProjection(u, 9, f, true)
    local real yt = PolarProjection(u, 9, f, false)
    local integer level = LoadInteger(udg_ht, task, 5)
    local location p
    set udg_SK_Reisen201I = 0
    set udg_SK_Reisen201U1 = u
    set udg_SK_Reisen201U2 = ud
    if IsUnitInRangeXY(u, x, y, 750.0) then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, xt, yt, 45, Condition(function Trig_Reisen201_Unit_Condition))
        call DestroyGroup(g)
        set p = Location(xt, yt)
        call YDWEEnumDestructablesInCircleBJNull(100, p, function Trig_Reisen201_Des_Condition)
        call RemoveLocation(p)
        if udg_SK_Reisen201I <= 0 and IsTerrainPathable(xt, yt, PATHING_TYPE_WALKABILITY) == false then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\GlaiveMissile\\GlaiveMissileTarget.mdl", GetUnitX(u), GetUnitY(u)))
            call SetUnitX(u, xt)
            call SetUnitY(u, yt)
        else
            call PauseUnit(u, false)
            call SetUnitPathing(u, true)
            call SetUnitFlag(u, 4, false)
            call SetUnitFlag(u, 3, false)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        call PauseUnit(u, false)
        call SetUnitPathing(u, true)
        call SetUnitFlag(u, 4, false)
        call SetUnitFlag(u, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set udg_SK_Reisen201U1 = null
    set udg_SK_Reisen201U2 = null
    set p = null
    set t = null
    set ud = null
    set u = null
    set g = null
endfunction

function Trig_Reisen201_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A08Z')
    local timer t
    local integer task
    local real f
    call AbilityCoolDownResetion(caster, 'A08Z', 17 - 2 * level)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\StormBolt\\StormBoltMissile.mdl", GetUnitX(target), GetUnitY(target)))
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\GlaiveMissile\\GlaiveMissileTarget.mdl", GetUnitX(target), GetUnitY(target)))
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set t = null
            return
        endif
    endif
    if GetUnitTypeId(target) == 'n006' == false or IsUnitUUZ(target) then
        set t = CreateTimer()
        set task = GetHandleId(t)
        set f = AngleBetween(caster, target)
        if caster == target then
            set f = GetUnitFacing(caster)
        endif
        call SetUnitFlag(target, 3, true)
        call SaveUnitHandle(udg_ht, task, 0, target)
        call SaveUnitHandle(udg_ht, task, 1, caster)
        call SaveReal(udg_ht, task, 2, f)
        call SaveReal(udg_ht, task, 3, GetUnitX(caster))
        call SaveReal(udg_ht, task, 4, GetUnitY(caster))
        call SaveInteger(udg_ht, task, 5, level)
        call SetUnitPathing(target, true)
        call SetUnitFlag(target, 4, true)
        call TimerStart(t, 0.01, true, function Trig_Reisen201_Push)
    endif
    if IsUnitAlly(caster, GetOwningPlayer(target)) == false then
        if udg_NewDebuffSys then
            call UnitSlowTargetMspd(caster, target, 80, level * 0.5 + 1.0, 3, 0)
        else
            call UnitSlowTarget(caster, target, level * 0.5 + 1.0, 'A09T', 'B07F')
        endif
        if udg_GameMode / 100 != 3 then
            call UnitMagicDamageTarget(caster, target, level * 55 + 2.25 * GetHeroInt(caster, true), 1)
        else
            call UnitMagicDamageTarget(caster, target, (level * 55 + 2.25 * GetHeroInt(caster, true)) * 1.6, 1)
        endif
    endif
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Reisen201 takes nothing returns nothing
endfunction