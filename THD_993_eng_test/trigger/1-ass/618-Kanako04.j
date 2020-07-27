function Trig_Kanako04_Thunder_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer ctask = GetHandleId(caster)
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local boolean k = LoadBoolean(udg_sht, GetHandleId(caster), 0)
    local integer level = GetUnitAbilityLevel(caster, 'A0F7')
    if GetWidgetLife(caster) > 0.405 and k and GetUnitTypeId(caster) == 'U00M' then
        call UnitAddAbility(caster, 'A0FB')
        call SetUnitAbilityLevel(caster, 'A0FB', level)
        set u = LoadUnitHandle(udg_sht, ctask, 0)
        if u != null then
            call SetUnitX(u, ox)
            call SetUnitY(u, oy)
        endif
        set u = LoadUnitHandle(udg_sht, ctask, 1)
        if u != null then
            call SetUnitX(u, ox)
            call SetUnitY(u, oy)
        endif
        set u = LoadUnitHandle(udg_sht, ctask, 2)
        if u != null then
            call SetUnitX(u, ox)
            call SetUnitY(u, oy)
        endif
        if GetUnitAbilityLevel(caster, 'A0FE') == 0 then
            call UnitAddAbility(caster, 'A0FE')
        endif
        set level = GetUnitAbilityLevel(caster, 'A0F1')
        call SetUnitAbilityLevel(caster, 'A0FE', level)
        if GetUnitAbilityLevel(caster, 'A0F8') == 0 then
            call UnitAddAbility(caster, 'A0F8')
        endif
        set level = GetUnitAbilityLevel(caster, 'A0F4')
        call SetUnitAbilityLevel(caster, 'A0F8', level)
        if GetUnitAbilityLevel(caster, 'A0FC') == 0 then
            call UnitAddAbility(caster, 'A0FC')
        endif
        set level = GetUnitAbilityLevel(caster, 'A0F6')
        call SetUnitAbilityLevel(caster, 'A0FC', level)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Kanako04_Thunder takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0F7')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call DebugMsg("MOF START")
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 0.75, true, function Trig_Kanako04_Thunder_Main)
    set caster = null
    set t = null
endfunction

function Trig_Kanako04_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A0F7' then
        return false
    elseif GetUnitTypeId(GetTriggerUnit()) == 'U00M' then
        return true
    elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call SaveBoolean(udg_sht, GetHandleId(GetTriggerUnit()), 0, true)
        call Trig_Kanako04_Thunder()
    endif
    return false
endfunction

function Trig_Kanako04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A0F7')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer ctask = GetHandleId(caster)
    if GetTriggerEventId() == EVENT_UNIT_SPELL_FINISH then
        call DebugMsg("MOF ON")
        call VE_Spellcast(caster)
        call SaveBoolean(udg_sht, ctask, 0, true)
        set u = CreateUnit(GetOwningPlayer(caster), 'n032', ox, oy, GetUnitFacing(caster))
        call SetUnitFlyHeight(u, -50, 1000.0)
        call SaveUnitHandle(udg_sht, ctask, 0, u)
        set u = CreateUnit(GetOwningPlayer(caster), 'n032', ox, oy, GetUnitFacing(caster))
        call SetUnitFlyHeight(u, -50, 1000.0)
        call SaveUnitHandle(udg_sht, ctask, 1, u)
        set u = CreateUnit(GetOwningPlayer(caster), 'n032', ox, oy, GetUnitFacing(caster))
        call SetUnitFlyHeight(u, -50, 1000.0)
        call SaveUnitHandle(udg_sht, ctask, 2, u)
        call AddSpecialEffectTarget("Light.mdl", u, "chest")
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ReviveHuman\\ReviveHuman.mdl", u, "origin"))
        set level = GetUnitAbilityLevel(caster, 'A0F1')
        if level > 0 then
            call UnitAddAbility(caster, 'A0FE')
            call SetUnitAbilityLevel(caster, 'A0FE', level)
        endif
        set level = GetUnitAbilityLevel(caster, 'A0F4')
        if level > 0 then
            call UnitAddAbility(caster, 'A0F8')
            call SetUnitAbilityLevel(caster, 'A0F8', level)
        endif
        set level = GetUnitAbilityLevel(caster, 'A0F6')
        if level > 0 then
            call UnitAddAbility(caster, 'A0FC')
            call SetUnitAbilityLevel(caster, 'A0FC', level)
        endif
        set level = GetUnitAbilityLevel(caster, 'A0F7')
        call UnitAddAbility(caster, 'A0FB')
        call SetUnitAbilityLevel(caster, 'A0FB', level)
    else
        set u = LoadUnitHandle(udg_sht, ctask, 0)
        if u != null then
            call RemoveUnit(u)
        endif
        set u = LoadUnitHandle(udg_sht, ctask, 1)
        if u != null then
            call RemoveUnit(u)
        endif
        set u = LoadUnitHandle(udg_sht, ctask, 2)
        if u != null then
            call RemoveUnit(u)
        endif
        call DebugMsg("MOF OFF")
    endif
    set caster = null
    set u = null
endfunction

function InitTrig_Kanako04 takes nothing returns nothing
endfunction