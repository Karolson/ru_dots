function Trig_Iku02_Target takes unit target returns boolean
    if GetWidgetLife(target) < 0.405 then
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return true
endfunction

function Trig_Iku02_Repel_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamMissile\\SteamMissile.mdl", ox, oy))
        set px = ox + 30.0 * Cos(a * 0.017454)
        set py = oy + 30.0 * Sin(a * 0.017454)
        if IsTerrainPathable(px, py, PATHING_TYPE_WALKABILITY) or IsUnitCCImmune(target) then
            call SaveInteger(udg_ht, task, 1, 0)
        else
            call SetUnitXY(target, px, py)
            call SaveInteger(udg_ht, task, 1, i - 1)
        endif
    else
        call SetUnitPathing(target, true)
        call SetUnitFlag(target, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Iku02_Repel takes unit caster, unit target returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real a = AngleBetweenUnits(caster, target)
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n001', GetUnitX(caster), GetUnitY(caster), a)
    local real k = 20 + GetUnitAbilityLevel(caster, 'A04S') * 20 + 0.5 * GetHeroInt(caster, true)
    call UnitAddAbility(u, 'A0A3')
    call SetUnitAbilityLevel(u, 'A0A3', GetUnitAbilityLevel(caster, 'A04S'))
    call IssueTargetOrder(u, "chainlightning", target)
    if GetUnitAbilityLevel(caster, 'B01T') > 0 then
        set k = k + 12.5 * GetUnitAbilityLevel(caster, 'A04O')
    endif
    call UnitMagicDamageTarget(caster, target, k, 6)
    call SetUnitFlag(target, 3, true)
    call SaveInteger(udg_ht, task, 1, 10)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveReal(udg_ht, task, 0, a)
    call TimerStart(t, 0.02, true, function Trig_Iku02_Repel_Main)
    set t = null
    set u = null
endfunction

function Trig_Iku02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit v
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if i > 0 and GetWidgetLife(caster) >= 0.405 then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 250.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if Trig_Iku02_Target(v) and IsUnitInRange(v, caster, 200.0) and GetUnitAbilityLevel(GetTriggerUnit(), 'B04B') == 0 and GetUnitAbilityLevel(GetTriggerUnit(), 'BOvc') == 0 then
                call Trig_Iku02_Repel(caster, v)
            endif
        endloop
        call DestroyGroup(g)
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 1))
        call UnitRemoveAbility(caster, 'A04T')
        call UnitRemoveAbility(caster, 'A09Z')
        call SetUnitMoveSpeed(caster, GetUnitDefaultMoveSpeed(caster))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_Iku02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A04S'
endfunction

function Trig_Iku02_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A04S')
    local effect e = AddSpecialEffectTarget("GlowingRunes2.mdl", caster, "origin")
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 15)
    call UnitAddAbility(caster, 'A09Z')
    call SetUnitAbilityLevel(caster, 'A09Z', level)
    call UnitAddAbility(caster, 'A04T')
    call SetUnitAbilityLevel(caster, 'A04T', level)
    call SetUnitMoveSpeed(caster, 220.0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveEffectHandle(udg_ht, task, 1, e)
    call SaveInteger(udg_ht, task, 1, 8)
    call SaveInteger(udg_ht, task, 2, level)
    call TimerStart(t, 0.5, true, function Trig_Iku02_Main)
    set t = null
    set caster = null
    set e = null
endfunction

function InitTrig_Iku02 takes nothing returns nothing
endfunction