function Miko03 takes nothing returns integer
    return 'A186'
endfunction

function Miko03_Buff takes nothing returns integer
    return 'A686'
endfunction

function Miko03_Debuff takes nothing returns integer
    return 'A0UH'
endfunction

function Miko03_Armor takes nothing returns integer
    return 'A0UO'
endfunction

function Trig_Miko03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A186'
endfunction

function Trig_Miko03_Target takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    endif
    if GetUnitTypeId(GetFilterUnit()) == 'E02J' then
        return false
    endif
    return true
endfunction

function Trig_Miko03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_ht, task, 0)
    local unit v
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitRemoveAbilityBJ('A0UO', v)
    endloop
    call DestroyGroup(g)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set g = null
    set t = null
    set v = null
endfunction

function Trig_Miko03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local integer level = GetUnitAbilityLevel(caster, 'A186')
    local group g = CreateGroup()
    local group g2 = CreateGroup()
    local unit v
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local boolexpr iff = Filter(function Trig_Miko03_Target)
    call AbilityCoolDownResetion(caster, 'A186', 14)
    call GroupEnumUnitsInRange(g, x, y, 225.0, iff)
    call GroupAddUnitSimple(caster, g)
    call GroupAddGroup(g, g2)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitAddAbility(v, 'A0UO')
        call SetUnitAbilityLevel(v, 'A0UO', level)
        call UnitMakeAbilityPermanent(v, true, 'A0UO')
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Silence\\SilenceAreaBirth.mdl", GetUnitX(v), GetUnitY(v)))
        if udg_NewDebuffSys then
            call UnitDebuffTarget(caster, v, 4.0 * 1.0, 2, true, 'A04D', 1, 'B084', "drunkenhaze", 'A05P', "")
        else
            call UnitCurseTarget(caster, v, 4.0, 'A0UH', "drunkenhaze")
        endif
    endloop
    call DestroyGroup(g)
    call SaveGroupHandle(udg_ht, task, 0, g2)
    call TimerStart(t, 4.0, false, function Trig_Miko03_Clear)
    set caster = null
    set v = null
    set g = null
    set t = null
    set iff = null
    set g2 = null
endfunction

function InitTrig_Miko03 takes nothing returns nothing
endfunction