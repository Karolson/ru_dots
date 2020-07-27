function Trig_Tensi04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0AJ'
endfunction

function Trig_Tensi04_Main_Stage_4 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call SetUnitTimeScale(caster, 1.0)
    call DisplayCineFilter(false)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call EnableTrigger(gg_trg_Tensi04)
    set t = null
    set caster = null
endfunction

function Trig_Tensi04_Main_Stage_3_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    local player p = GetOwningPlayer(caster)
    local unit u
    local integer i = 0
    loop
    exitwhen i > 11
        if udg_PlayerHeroes[i] != null and GetWidgetLife(udg_PlayerHeroes[i]) > 0.405 then
            if IsUnitEnemy(udg_PlayerHeroes[i], p) then
                set u = CreateUnit(p, 'n01W', GetUnitX(udg_PlayerHeroes[i]) - 5.0, GetUnitY(udg_PlayerHeroes[i]), 0.0)
                call UnitAddAbility(u, 'A0AK')
                call SetUnitAbilityLevel(u, 'A0AK', level)
                call IssueTargetOrder(u, "fingerofdeath", udg_PlayerHeroes[i])
                if GetUnitAbilityLevel(caster, 'B006') != 0 then
                    call UnitAbsDamageTarget(caster, udg_PlayerHeroes[i], (125 + level * 125) * 1.25)
                else
                    call UnitAbsDamageTarget(caster, udg_PlayerHeroes[i], 125 + level * 125)
                endif
            else
                if GetUnitAbilityLevel(caster, 'B067') != 0 then
                    call UnitGainLife(udg_PlayerHeroes[i], (65 + level * 135) * 0.5)
                endif
            endif
        endif
        set i = i + 1
    endloop
    call PauseTimer(t)
    call TimerStart(t, 1.0, false, function Trig_Tensi04_Main_Stage_4)
    set t = null
    set caster = null
    set p = null
    set u = null
endfunction

function Trig_Tensi04_Main_Stage_2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\White_mask.blp")
    call SetCineFilterBlendMode(BLEND_MODE_BLEND)
    call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
    call SetCineFilterStartUV(0, 0, 1, 1)
    call SetCineFilterEndUV(0, 0, 1, 1)
    call SetCineFilterEndColor(255, 32, 0, 0)
    if GetWidgetLife(caster) > 0.405 then
        call SetCineFilterStartColor(255, 32, 0, 240)
        call SetCineFilterDuration(1.5)
        call PauseTimer(t)
        call TimerStart(t, 0.3, false, function Trig_Tensi04_Main_Stage_3_Damage)
    else
        call SetCineFilterStartColor(255, 32, 0, 220)
        call SetCineFilterDuration(0.3)
        call DisplayCineFilter(true)
        call PauseTimer(t)
        call TimerStart(t, 0.3, false, function Trig_Tensi04_Main_Stage_4)
    endif
    call DisplayCineFilter(true)
    set caster = null
    set t = null
endfunction

function Trig_Tensi04_Main_Stage_1 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    if GetWidgetLife(caster) > 0.405 then
        call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\White_mask.blp")
        call SetCineFilterBlendMode(BLEND_MODE_BLEND)
        call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
        call SetCineFilterStartUV(0, 0, 1, 1)
        call SetCineFilterEndUV(0, 0, 1, 1)
        call SetCineFilterStartColor(255, 32, 0, 0)
        call SetCineFilterEndColor(255, 32, 0, 240)
        call SetCineFilterDuration(0.2)
        call DisplayCineFilter(true)
        call PauseTimer(t)
        call TimerStart(t, 0.4, false, function Trig_Tensi04_Main_Stage_2)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call SetUnitTimeScale(caster, 1.0)
        call EnableTrigger(gg_trg_Tensi04)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Tensi04_FOW takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call ReleaseTimer(t)
    set t = null
endfunction

function Trig_Tensi04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local unit k
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call VE_Spellcast(caster)
        call AbilityCoolDownResetion(caster, 'A0AJ', 135)
        set t = CreateTimer()
        call TimerStart(t, 4.0, false, function Trig_Tensi04_FOW)
    elseif GetTriggerEventId() == EVENT_UNIT_SPELL_FINISH then
        call DisableTrigger(gg_trg_Tensi04)
        set t = CreateTimer()
        set task = GetHandleId(t)
        set k = CreateUnit(GetOwningPlayer(caster), 'n001', GetUnitX(caster) - 5.0, GetUnitY(caster), 0.0)
        call UnitAddAbility(k, 'A0MK')
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, GetUnitAbilityLevel(caster, 'A0AJ'))
        call SaveInteger(udg_ht, task, 1, 0)
        call SetUnitTimeScale(caster, 0.0)
        call TimerStart(t, 0.3, false, function Trig_Tensi04_Main_Stage_1)
        call CastSpell(caster, "Scarlet Weather Rhapsody of All Humankind!!!")
    endif
    set caster = null
    set t = null
    set k = null
endfunction

function InitTrig_Tensi04 takes nothing returns nothing
endfunction