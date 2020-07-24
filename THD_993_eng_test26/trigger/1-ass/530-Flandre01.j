function Trig_Flandre01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A06J'
endfunction

function Flandre01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    local group g
    local unit tmpunit
    local integer id = GetUnitTypeId(caster)
    local boolean addEffect = false
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    call UnitRemoveAbility(caster, 'A1F2')
    if GetUnitAbilityLevel(caster, 'A19K') > 0 then
        set addEffect = true
    endif
    set g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set tmpunit = FirstOfGroup(g)
    exitwhen tmpunit == null
        call GroupRemoveUnit(g, tmpunit)
        if GetUnitTypeId(tmpunit) == id then
            call SelectUnitAddForPlayer(tmpunit, GetOwningPlayer(caster))
            if addEffect then
                call UnitAddAbility(tmpunit, 'A08J')
            endif
        endif
    endloop
    call DestroyGroup(g)
    set t = null
    set caster = null
    set g = null
    set tmpunit = null
endfunction

function Trig_Flandre01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    call ClearAllNegativeBuff(caster, false)
    call AbilityCoolDownResetion(caster, 'A06J', 25)
    if GetUnitAbilityLevel(caster, 'A08J') > 0 then
        call UnitRemoveAbility(caster, 'A08J')
    endif
    call UnitAddAbility(caster, 'A1F2')
    set t = CreateTimer()
    call SaveUnitHandle(udg_sht, GetHandleId(t), 0, caster)
    call TimerStart(t, 0.7, false, function Flandre01_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_Flandre01 takes nothing returns nothing
endfunction