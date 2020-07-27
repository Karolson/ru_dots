function Trig_Str09_WeatherChange_Conditions_Old takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local string str1
    local string str2
    local player PLY = GetOwningPlayer(caster)
    if GetSpellAbilityId() == 'A1EF' then
        set str1 = "Nature Pulse"
        if udg_NewWeather_InWeather then
            call DisplayTextToPlayer(PLY, 0, 0, "The current weather is in progress and Nature Pulse cannot be used")
            set caster = null
            set PLY = null
            return false
        endif
        set str2 = udg_PN[GetPlayerId(PLY)]
        set udg_NewWeather_WID = RandomWeather()
        call BroadcastMessage(str2 + " uses " + str1 + ", changing the weather!")
        call BroadcastMessage("The weather changed to: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
        call TimerDialogSetTitle(udg_NewWeather_TD, "Notice: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
        call BroadcastMessage(udg_NewWeather_WeatherInfo[udg_NewWeather_WID])
    endif
    set caster = null
    set PLY = null
    return false
endfunction

function WeatherSword_6_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer cnt = LoadInteger(udg_ht, task, 2)
    if cnt == 0 then
        call PauseTimer(t)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", GetUnitX(u), GetUnitY(u)))
        call UnitDelDamageTarget(caster, u, GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.02)
        call SaveInteger(udg_ht, task, 2, cnt - 1)
    endif
    set u = null
    set t = null
    set caster = null
endfunction

function WeatherSword_6 takes unit caster, unit u returns nothing
    local timer t
    local integer task
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, 5)
    call TimerStart(t, 1.0, true, function WeatherSword_6_Main)
    set t = null
endfunction

function WeatherSword_7_CallBack takes nothing returns nothing
    call SetUnitExtraSlight(udg_PS_Target, 0)
endfunction

function WeatherSword_7 takes unit caster, unit u returns nothing
    call UnitSlowTargetEx(caster, u, 4, 'A1FA', 'B09X', "WeatherSword_7_CallBack", 0)
    call SetUnitExtraSlight(u, 300 - GetUnitSlight(u))
endfunction

function WeatherSword_8_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer cnt = LoadInteger(udg_ht, task, 2) - 1
    call SaveInteger(udg_ht, task, 2, cnt)
    if IsUnitType(u, UNIT_TYPE_DEAD) == false and cnt > 0 then
        call SetUnitXY(u, GetUnitX(v), GetUnitY(v))
    else
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set v = null
    set u = null
endfunction

function WeatherSword_8 takes unit caster, unit v returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    set u = CreateUnit(GetOwningPlayer(caster), 'n05R', GetUnitX(v), GetUnitY(v), 0)
    call SaveUnitHandle(udg_ht, task, 0, v)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, 40)
    call TimerStart(t, 0.1, true, function WeatherSword_8_Clear)
    set t = null
    set u = null
endfunction

function Trig_Str09_WeatherChange_Conditions takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local integer i
    local player PLY = GetOwningPlayer(caster)
    local unit u
    if GetSpellAbilityId() != 'A1EF' then
        set caster = null
        set PLY = null
        return false
    endif
    if udg_NewWeather_InWeather == false then
        call DisplayTextToPlayer(PLY, 0, 0, "The weather is really good today!")
        set caster = null
        set PLY = null
        set u = null
        return false
    endif
    if udg_NewWeather_WID == 3 then
        call UnitResetCooldown(caster)
    endif
    if udg_NewWeather_WID == 4 then
        set u = NewDummy(PLY, GetUnitX(caster), GetUnitY(caster), 0)
        call UnitAddAbility(u, 'A1F8')
        call IssueImmediateOrderById(u, 852285)
        call UnitRemoveAbility(u, 'A1F8')
        call ReleaseDummy(u)
        call DebugMsg("accelerate")
    endif
    if udg_NewWeather_WID == 9 then
        call UnitStunArea(caster, 2.0, GetUnitX(caster), GetUnitY(caster), 350, 0, 0)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl", caster, "overhead"))
    endif
    if udg_NewWeather_WID == 10 then
        call UnitAbsDamageArea(caster, GetUnitX(caster), GetUnitY(caster), 500, 200 + udg_GameTime / 60 * 4)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", caster, "overhead"))
    endif
    set i = 0
    loop
    exitwhen i >= 12
        set u = udg_PlayerHeroes[i]
        if IsUnitAlly(u, PLY) then
            if udg_NewWeather_WID == 1 then
                call UnitHealingTarget(caster, u, 200 + udg_GameTime / 60 * 4)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetUnitX(u), GetUnitY(u)))
            elseif udg_NewWeather_WID == 2 then
                call UnitManaingTarget(caster, u, 200 + udg_GameTime / 60 * 4)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetUnitX(u), GetUnitY(u)))
            endif
        else
            if udg_NewWeather_WID == 5 then
                call UnitSlowTarget(caster, u, 5, 'A1F9', 'B09W')
            elseif udg_NewWeather_WID == 6 then
                call WeatherSword_6(caster, u)
                call UnitSlowTarget(caster, u, 5, 'A1FB', 'B09Y')
            elseif udg_NewWeather_WID == 7 then
                call WeatherSword_7(caster, u)
            elseif udg_NewWeather_WID == 8 then
                call WeatherSword_8(caster, u)
                call UnitSlowTarget(caster, u, 5, 'A1FC', 'B09Z')
            elseif udg_NewWeather_WID == 11 then
                call UnitMagicDamageTarget(caster, u, 200 + udg_GameTime / 60 * 4, 5)
            elseif udg_NewWeather_WID == 12 then
                call UnitStunTarget(caster, u, 1.0, 0, 0)
            endif
        endif
        set i = i + 1
    endloop
    set caster = null
    set u = null
    set PLY = null
    return false
endfunction

function InitTrig_Str09_WeatherChange takes nothing returns nothing
    set gg_trg_Str09_WeatherChange = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Str09_WeatherChange, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Str09_WeatherChange, Condition(function Trig_Str09_WeatherChange_Conditions))
endfunction