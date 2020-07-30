function Trig_Twei03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0N4'
endfunction

function Trig_Twei03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call AddUnitAnimationProperties(caster, "alternate", false)
    set udg_SK_Twei03_Iff = udg_SK_Twei03_Iff - 1
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Twei03_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0N4')
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 15)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set t = null
        return
    endif
    call AddUnitAnimationProperties(caster, "alternate", true)
    set udg_SK_Twei03_Iff = udg_SK_Twei03_Iff + 1
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, level * 1.5, false, function Trig_Twei03_Clear)
    set t = null
    set caster = null
endfunction

function InitTrig_Twei03 takes nothing returns nothing
endfunction