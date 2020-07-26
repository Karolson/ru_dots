function Trig_Sakuya04_Reset_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A04H' then
        return true
    elseif GetSpellAbilityId() == 'A099' then
        return true
    elseif GetSpellAbilityId() == 'A09A' then
        return true
    elseif GetSpellAbilityId() == 'A0QT' then
        return true
    elseif GetSpellAbilityId() == 'A1IA' then
        return true
    endif
    return false
endfunction

function Trig_Sakuya04_Reset_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer d = LoadInteger(udg_ht, task, 0)
    if IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        call Trig_Sakuya04_Reset(caster, d)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Sakuya04_Reset_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer d = GetSpellAbilityId()
    local timer t
    local integer task
    local integer k = GetPlayerId(GetOwningPlayer(caster)) + 1
    set udg_SK_Sakuya04_Time[k] = udg_SK_Sakuya04_Time[k] - 1
    if udg_SK_Sakuya04_Time[k] <= 0 then
        set caster = null
        set t = null
    endif
    if GetSpellAbilityId() == 'A04H' then
        set udg_SK_Sakuya04_Mana01[k] = udg_SK_Sakuya04_Mana01[k] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 5.0, "|c00ffff00Used Illusion Sign 'Killing Doll' |r" + I2S(udg_SK_Sakuya04_Mana01[k]) + "|c00ffff00 times|r")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, d)
        call TimerStart(t, 0.05, true, function Trig_Sakuya04_Reset_Main)
    elseif GetSpellAbilityId() == 'A099' then
        set udg_SK_Sakuya04_Mana02[k] = udg_SK_Sakuya04_Mana02[k] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 5.0, "|c00ffff00Used Illusion |r" + I2S(udg_SK_Sakuya04_Mana02[k]) + "|c00ffff00 times|r")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, d)
        call TimerStart(t, 0.05, true, function Trig_Sakuya04_Reset_Main)
    elseif GetSpellAbilityId() == 'A1IA' then
        set udg_SK_Sakuya04_Mana02[k] = udg_SK_Sakuya04_Mana02[k] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 5.0, "|c00ffff00Used Time Sign 'Mysterious Jack' |r" + I2S(udg_SK_Sakuya04_Mana02[k]) + "|c00ffff00 times|r")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, d)
        call TimerStart(t, 0.05, true, function Trig_Sakuya04_Reset_Main)
    elseif GetSpellAbilityId() == 'A09A' then
        set udg_SK_Sakuya04_Mana03[k] = udg_SK_Sakuya04_Mana03[k] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 5.0, "|c00ffff00Used Time Sign 'Misdirection' |r" + I2S(udg_SK_Sakuya04_Mana03[k]) + "|c00ffff00 times|r")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, d)
        call TimerStart(t, 0.05, true, function Trig_Sakuya04_Reset_Main)
    elseif GetSpellAbilityId() == 'A0QT' then
        set udg_SK_Sakuya04_Mana04[k] = udg_SK_Sakuya04_Mana04[k] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 5.0, "|c00ffff00Used Stopwatch |r" + I2S(udg_SK_Sakuya04_Mana04[k]) + "|c00ffff00 times|r")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, d)
        call TimerStart(t, 0.01, true, function Trig_Sakuya04_Reset_Main)
    endif
    set caster = null
    set t = null
endfunction

function InitTrig_Sakuya04_Reset takes nothing returns nothing
endfunction