function Trig_Minoriko03_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0JJ'
endfunction

function Trig_Minoriko03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local player w = GetOwningPlayer(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0JJ')
    local unit v
    local integer i = 0
    if GetWidgetLife(caster) >= 0.405 then
        loop
        exitwhen i > 11
            set v = udg_PlayerHeroes[i]
            if v != null and IsUnitAlly(v, w) and IsUnitInRange(caster, v, 600.0) and GetWidgetLife(v) > 0.405 then
                if GetUnitAbilityLevel(v, 'A0JN') == 0 then
                    call UnitAddAbility(v, 'A0JN')
                    call UnitAddMaxLife(v, 75)
                    call UnitMakeAbilityPermanent(v, true, 'A0JN')
                endif
                if v == caster then
                    call UnitAddMaxLife(v, 75 * (level * 2 - GetUnitAbilityLevel(v, 'A0JN')))
                    call SetUnitAbilityLevel(v, 'A0JN', level * 2)
                else
                    call UnitAddMaxLife(v, 75 * (level - GetUnitAbilityLevel(v, 'A0JN')))
                    call SetUnitAbilityLevel(v, 'A0JN', level)
                endif
            elseif GetUnitAbilityLevel(v, 'A0JN') > 0 then
                call UnitAddMaxLife(v, -75 * GetUnitAbilityLevel(v, 'A0JN'))
                call UnitRemoveAbility(v, 'A0JN')
            endif
            set i = i + 1
        endloop
    else
        loop
        exitwhen i > 11
            set v = udg_PlayerHeroes[i]
            if GetUnitAbilityLevel(v, 'A0JN') > 0 then
                call UnitAddMaxLife(v, -75 * GetUnitAbilityLevel(v, 'A0JN'))
                call UnitRemoveAbility(v, 'A0JN')
            endif
            set i = i + 1
        endloop
    endif
    set t = null
    set caster = null
    set w = null
    set v = null
endfunction

function Trig_Minoriko03_Actions takes nothing returns nothing
    local unit h = GetTriggerUnit()
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(h, 'A0JJ')
    if level == 1 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, h)
        call TimerStart(t, 0.5, true, function Trig_Minoriko03_Main)
    endif
    set h = null
    set t = null
endfunction

function InitTrig_Minoriko03 takes nothing returns nothing
endfunction