function FLANDRE03 takes nothing returns integer
    return 'A0FV'
endfunction

function FLANDRE03_SELF_BUFF takes nothing returns integer
    return 'A19K'
endfunction

function FLANDRE03_BUFF_SKILL takes nothing returns integer
    return 'A0JV'
endfunction

function Flandre03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    local group g
    local unit tmpunit
    local integer id = GetUnitTypeId(caster)
    call DebugMsg("Clear Flandre03 Buff")
    call UnitRemoveAbility(caster, 'A19K')
    set g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set tmpunit = FirstOfGroup(g)
    exitwhen tmpunit == null
        call GroupRemoveUnit(g, tmpunit)
        if GetUnitTypeId(tmpunit) == id then
            call UnitRemoveAbility(tmpunit, 'A08J')
        endif
    endloop
    call DestroyGroup(g)
    call RemoveSavedHandle(udg_sht, StringHash("Flandre03Timer"), GetHandleId(caster))
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    set t = null
    set caster = null
    set g = null
    set tmpunit = null
endfunction

function Flandre03_Conditions takes nothing returns boolean
    local unit caster
    local unit target
    local group g
    local unit tmpunit
    local integer id
    local timer t
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        if GetSpellAbilityId() == 'A0FV' then
            set caster = GetTriggerUnit()
            set id = GetUnitTypeId(caster)
            call ClearAllNegativeBuff(caster, false)
            call AbilityCoolDownResetion(caster, 'A0FV', 8)
            call UnitAddAbility(caster, 'A19K')
            call SetUnitAbilityLevel(caster, 'A19K', GetUnitAbilityLevel(caster, 'A0FV'))
            set g = CreateGroup()
            call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
            loop
                set tmpunit = FirstOfGroup(g)
            exitwhen tmpunit == null
                call GroupRemoveUnit(g, tmpunit)
                if GetUnitTypeId(tmpunit) == id then
                    call UnitAddAbility(tmpunit, 'A08J')
                endif
            endloop
            call DestroyGroup(g)
            if HaveSavedHandle(udg_sht, StringHash("Flandre03Timer"), GetHandleId(caster)) then
                set t = LoadTimerHandle(udg_sht, StringHash("Flandre03Timer"), GetHandleId(caster))
            else
                set t = CreateTimer()
                call SaveTimerHandle(udg_sht, StringHash("Flandre03Timer"), GetHandleId(caster), t)
            endif
            call SaveUnitHandle(udg_sht, GetHandleId(t), 0, caster)
            call TimerStart(t, 10.0, false, function Flandre03_Clear)
        endif
        set caster = null
        set target = null
        set g = null
        set tmpunit = null
        set t = null
        return false
    else
        set caster = GetEventDamageSource()
        set target = GetTriggerUnit()
        if GetUnitAbilityLevel(caster, 'A0FV') > 0 and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and IsUnitEnemy(target, GetOwningPlayer(caster)) and GetEventDamage() > 0 and not IsDamageNotUnitAttack(caster) then
            if udg_GameMode / 100 != 3 and udg_NewMid == false then
                call UnitPhysicalDamageTarget(caster, target, 8 + 8 * GetUnitAbilityLevel(caster, 'A0FV'))
            else
                call UnitPhysicalDamageTarget(caster, target, (8 + 8 * GetUnitAbilityLevel(caster, 'A0FV')) * 2)
            endif
            call DebugMsg(GetUnitName(caster) + " additional damage of " + I2S(8 + 8 * GetUnitAbilityLevel(caster, 'A0FV')) + " to " + GetUnitName(target))
        endif
        set caster = null
        set target = null
        set g = null
        set tmpunit = null
        set t = null
        return false
    endif
    set caster = null
    set target = null
    set g = null
    set tmpunit = null
    set t = null
    return false
endfunction

function InitTrig_Flandre03 takes nothing returns nothing
endfunction