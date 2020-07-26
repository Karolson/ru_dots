function Trig_Orange04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0TO'
endfunction

function Trig_Orange04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer ctask = LoadInteger(udg_sht, task, 1)
    local integer total = LoadInteger(udg_sht, ctask, 1)
    call DebugMsg("Chen04 End")
    call DisableTrigger(gg_trg_Orange04_Attack)
    if IsUnitPaused(caster) then
        call PauseUnit(caster, false)
        call UnitReduceAttackDamage(caster, total)
        call PauseUnit(caster, true)
    else
        call UnitReduceAttackDamage(caster, total)
    endif
    call KillUnit(udg_SK_Chen04)
    set udg_SK_Chen04 = null
    call Trig_Orange03_Effecting(caster)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    call FlushChildHashtable(udg_sht, ctask)
    set t = null
    set caster = null
endfunction

function Trig_Orange04_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer ctask = GetHandleId(caster)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 18)
    call VE_Spellcast(caster)
    call EnableTrigger(gg_trg_Orange04_Attack)
    if HaveSavedHandle(udg_sht, ctask, 0) then
        set t = LoadTimerHandle(udg_sht, ctask, 0)
        set task = GetHandleId(t)
        call DebugMsg("Chen04 Restart")
    else
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveTimerHandle(udg_sht, ctask, 0, t)
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call SaveInteger(udg_sht, task, 1, ctask)
        call DebugMsg("Chen04 Start")
    endif
    if not HaveSavedInteger(udg_sht, ctask, 1) then
        call SaveInteger(udg_sht, ctask, 1, 0)
    endif
    call TimerStart(t, 6.0, false, function Trig_Orange04_Clear)
    call DebugMsg("Attack Bonus: " + I2S(LoadInteger(udg_sht, ctask, 1)))
    set t = null
    set caster = null
endfunction

function InitTrig_Orange04 takes nothing returns nothing
endfunction