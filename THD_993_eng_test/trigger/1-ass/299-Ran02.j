function Trig_Ran02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A08M'
endfunction

function Trig_Ran02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local group g = LoadGroupHandle(udg_ht, task, 2)
    local unit v
    local boolexpr iff
    if i > 0 and IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        call SaveInteger(udg_ht, task, 1, i - 1)
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 375, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                if udg_NewDebuffSys then
                    call UnitSlowTargetMspd(caster, v, 80, 0.5, 2, 0)
                else
                    call UnitSlowTarget(caster, v, 0.5, 'A117', 'B03F')
                endif
            endif
        endloop
    else
        call UnitRemoveAbility(caster, 'A0ES')
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_Ran02_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A08M')
    local group g = CreateGroup()
    call AbilityCoolDownResetion(caster, 'A08M', 19 - level * 2)
    call UnitAddAbility(caster, 'A0ES')
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, 6 + 2 * 4)
    call SaveGroupHandle(udg_ht, task, 2, g)
    call TimerStart(t, 0.25, true, function Trig_Ran02_Main)
    set caster = null
    set t = null
    set g = null
endfunction

function InitTrig_Ran02 takes nothing returns nothing
endfunction