function AKYU03 takes nothing returns integer
    return 'A0P0'
endfunction

function AKYU03_EFFECT takes nothing returns string
    return "Abilities\\Spells\\Other\\Parasite\\ParasiteMissile.mdl"
endfunction

function Akyu03_Duration takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local real elapsed = LoadReal(udg_sht, task, 0)
    local effect e
    if elapsed <= 5.0 then
        set elapsed = elapsed + 0.01
        call SaveReal(udg_sht, task, 0, elapsed)
        call ClearAllNegativeBuff(caster, false)
    else
        call UnitRemoveAbility(caster, 'A0PF')
        set e = LoadEffectHandle(udg_sht, task, 1)
        call DestroyEffect(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
        call UnitStunTarget(caster, caster, 1.0, 0, 0)
    endif
    set t = null
    set e = null
    set caster = null
endfunction

function Akyu03_Conditions takes nothing returns boolean
    local timer t
    local unit u
    local effect e
    local integer task
    if GetSpellAbilityId() == 'A0P0' then
        set t = CreateTimer()
        set task = GetHandleId(t)
        set u = GetTriggerUnit()
        set e = AddSpecialEffectTarget("Abilities\\Spells\\Other\\Parasite\\ParasiteMissile.mdl", u, "hand left")
        if udg_GameMode / 100 != 3 and udg_NewMid == false then
            call AbilityCoolDownResetion(u, 'A0P0', 36 - 6 * GetUnitAbilityLevel(u, 'A0P0'))
        else
            call AbilityCoolDownResetion(u, 'A0P0', (36 - 6 * GetUnitAbilityLevel(u, 'A0P0')) * 0.65)
        endif
        call UnitAddAbility(u, 'A0PF')
        call SetUnitAbilityLevel(u, 'A0PF', GetUnitAbilityLevel(u, 'A0P0'))
        call UnitMakeAbilityPermanent(u, true, 'A0PF')
        call SaveUnitHandle(udg_sht, task, 0, u)
        call SaveReal(udg_sht, task, 0, 0.01)
        call SaveEffectHandle(udg_sht, task, 1, e)
        call TimerStart(t, 0.01, true, function Akyu03_Duration)
    endif
    set u = null
    set e = null
    set t = null
    return false
endfunction

function InitTrig_Akyu03 takes nothing returns nothing
endfunction