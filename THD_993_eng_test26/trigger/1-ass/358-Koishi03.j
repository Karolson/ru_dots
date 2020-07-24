function KOISHI03 takes nothing returns integer
    return 'A0I0'
endfunction

function KOISHI03_HIDDEN_SPELLBOOK takes nothing returns integer
    return 'A0I3'
endfunction

function KOISHI03_BRAWLER takes nothing returns integer
    return 'A0DQ'
endfunction

function KOISHI03_TRUE_STRIKE takes nothing returns integer
    return 'A0IP'
endfunction

function Koishi03_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local integer level
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        if GetLearnedSkill() == 'A0I0' then
            set level = GetLearnedSkillLevel()
            if level == 1 then
                call UnitAddAbility(u, 'A0I3')
                call UnitMakeAbilityPermanent(u, true, 'A0I3')
                call UnitMakeAbilityPermanent(u, true, 'A0DQ')
                call UnitMakeAbilityPermanent(u, true, 'A0IP')
                call SetUnitAbilityLevel(u, 'A0DQ', 2)
                call SetUnitAbilityLevel(u, 'A0IP', 1)
                call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'A0I3', false)
            else
                if not LoadBoolean(udg_sht, StringHash("Koishi03Switched"), GetHandleId(u)) then
                    call SetUnitAbilityLevel(u, 'A0DQ', level + 1)
                endif
            endif
        endif
        set u = null
        return false
    elseif GetSpellAbilityId() == 'A0I0' then
        call SetUnitAbilityLevel(u, 'A0DQ', 1)
        call SetUnitAbilityLevel(u, 'A0IP', 2)
        call KoishiToggleSkillEffect(u, 3, true)
        call SaveBoolean(udg_sht, StringHash("Koishi03Switched"), GetHandleId(u), true)
        set u = null
        return true
    endif
    set u = null
    return false
endfunction

function Koishi03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    call SetUnitAbilityLevel(caster, 'A0IP', 1)
    call SetUnitAbilityLevel(caster, 'A0DQ', GetUnitAbilityLevel(caster, 'A0I0') + 1)
    call SaveBoolean(udg_sht, StringHash("Koishi03Switched"), GetHandleId(caster), false)
    call KoishiToggleSkillEffect(caster, 3, false)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
endfunction

function Koishi03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A0I0', 15)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call TimerStart(t, 8.0, false, function Koishi03_Clear)
    set caster = null
    set t = null
endfunction

function InitTrig_Koishi03 takes nothing returns nothing
endfunction