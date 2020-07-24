function Trig_Lyrica02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0TS'
endfunction

function Trig_Lyrica02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    call SetUnitVertexColor(target, 255, 255, 255, 255)
    if udg_SK_Lyrica02_Unit[udg_SK_Lyrica02_Count] == target then
        set udg_SK_Lyrica02_Unit[udg_SK_Lyrica02_Count] = null
        set udg_SK_Lyrica02_Attack[udg_SK_Lyrica02_Count] = false
        set udg_SK_Lyrica02_Defend[udg_SK_Lyrica02_Count] = false
        call DestroyEffect(udg_SK_Lyrica02_Effect[udg_SK_Lyrica02_Count])
        set udg_SK_Lyrica02_Effect[udg_SK_Lyrica02_Count] = null
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set target = null
endfunction

function Trig_Lyrica02_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 8 * udg_SK_LyricaEx_Buff)
    call PlaySoundOnUnitBJ(gg_snd_PianoChorus02a, 100, caster)
    set udg_SK_Lyrica02_Count = udg_SK_Lyrica02_Count + 1
    if udg_SK_Lyrica02_Count >= 6 then
        set udg_SK_Lyrica02_Count = udg_SK_Lyrica02_Count - 6
    endif
    if udg_SK_Lyrica02_Effect[udg_SK_Lyrica02_Count] == null then
        set udg_SK_Lyrica02_Unit[udg_SK_Lyrica02_Count] = target
        set udg_SK_Lyrica02_Attack[udg_SK_Lyrica02_Count] = true
        set udg_SK_Lyrica02_Defend[udg_SK_Lyrica02_Count] = true
        set udg_SK_Lyrica02_Effect[udg_SK_Lyrica02_Count] = AddSpecialEffectTarget("Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl", target, "chest")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, target)
        call SaveInteger(udg_ht, task, 1, udg_SK_Lyrica02_Count)
        call TimerStart(t, 6.0, false, function Trig_Lyrica02_Main)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function InitTrig_Lyrica02 takes nothing returns nothing
endfunction