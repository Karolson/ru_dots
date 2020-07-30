function Trig_Lyrica03_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0TT'
endfunction

function Trig_Lyrica03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local player w = GetOwningPlayer(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0TT')
    local group g
    local unit v
    set g = CreateGroupOfAllHeroes()
    if IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitAlly(v, w) == false and GetUnitTypeId(v) != 'H02H' and IsUnitInRange(caster, v, 900.0) and IsUnitType(v, UNIT_TYPE_DEAD) == false then
                if GetUnitAbilityLevel(v, 'A0N0') == 1 then
                    if GetUnitAbilityLevel(v, 'A0UU') == 0 then
                        call UnitAddAbility(v, 'A0UU')
                        call UnitMakeAbilityPermanent(v, true, 'A0UU')
                        call SetUnitAbilityLevel(v, 'A0UU', level)
                    endif
                else
                    if GetUnitAbilityLevel(v, 'A0TZ') == 0 then
                        call UnitAddAbility(v, 'A0TZ')
                        call UnitMakeAbilityPermanent(v, true, 'A0TZ')
                        call SetUnitAbilityLevel(v, 'A0TZ', level)
                    endif
                endif
            else
                if GetUnitAbilityLevel(v, 'A0TZ') > 0 then
                    call UnitRemoveAbility(v, 'A0TZ')
                endif
                if GetUnitAbilityLevel(v, 'A0UU') > 0 then
                    call UnitRemoveAbility(v, 'A0UU')
                endif
            endif
        endloop
    else
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetUnitAbilityLevel(v, 'A0TZ') > 0 then
                call UnitRemoveAbility(v, 'A0TZ')
            elseif GetUnitAbilityLevel(v, 'A0UU') > 0 then
                call UnitRemoveAbility(v, 'A0UU')
            endif
        endloop
    endif
    call DestroyGroup(g)
    set t = null
    set caster = null
    set w = null
    set g = null
    set v = null
endfunction

function Trig_Lyrica03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, 'A0TT')
    if level == 1 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call TimerStart(t, 0.5, true, function Trig_Lyrica03_Main)
    endif
    set caster = null
    set t = null
endfunction

function InitTrig_Lyrica03 takes nothing returns nothing
endfunction