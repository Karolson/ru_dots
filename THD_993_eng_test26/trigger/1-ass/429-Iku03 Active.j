function Trig_Iku03_Active_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A00Y') == 0 then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitIllusionBJ(GetEventDamageSource()) then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Iku03_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local integer level = GetUnitAbilityLevel(target, 'A012')
    call EnableHeight(u)
    call SetUnitXY(u, GetUnitX(target), GetUnitY(target))
    call SetUnitFlyHeight(u, GetUnitFlyHeight(target), 0)
    if level == 0 then
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
    else
        call SetUnitScale(u, level * 1.5, level * 1.5, level * 1.5)
    endif
    set t = null
    set u = null
    set target = null
endfunction

function Trig_Iku03_Effect takes unit caster, unit target returns nothing
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local unit u = CreateUnit(GetOwningPlayer(caster), 'o00X', x, y, 0)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_sht, task, 0, u)
    call SaveUnitHandle(udg_sht, task, 1, target)
    call TimerStart(t, 0.05, true, function Trig_Iku03_Effect_Main)
    set u = null
    set t = null
endfunction

function Trig_Iku03_Active_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local unit u
    local integer rate = 0
    local integer level = GetUnitAbilityLevel(caster, 'A00Y')
    if GetUnitAbilityLevel(target, 'B027') > 0 then
        set rate = 100
    else
        if udg_GameMode / 100 != 3 and udg_NewMid == false then
            if GetUnitAbilityLevel(target, 'A012') == 0 then
                call UnitBuffTarget(caster, target, 14.0, 'A012', 0)
            elseif GetUnitAbilityLevel(target, 'A012') <= 2 then
                call UnitBuffTarget(caster, target, 14.0, 'A012', 0)
                call SetUnitAbilityLevel(target, 'A012', GetUnitAbilityLevel(target, 'A012') + 1)
            elseif GetUnitAbilityLevel(target, 'A012') == 3 then
                set rate = 100
                call UnitBuffTarget(caster, target, 14.0, 'A012', 0)
                call SetUnitAbilityLevel(target, 'A012', 1)
            endif
        else
            if GetUnitAbilityLevel(target, 'A012') == 0 then
                call UnitBuffTarget(caster, target, 14.0, 'A012', 0)
            elseif GetUnitAbilityLevel(target, 'A012') <= 1 then
                call UnitBuffTarget(caster, target, 14.0, 'A012', 0)
                call SetUnitAbilityLevel(target, 'A012', GetUnitAbilityLevel(target, 'A012') + 1)
            elseif GetUnitAbilityLevel(target, 'A012') == 2 then
                set rate = 100
                call UnitBuffTarget(caster, target, 14.0, 'A012', 0)
                call SetUnitAbilityLevel(target, 'A012', 1)
            endif
        endif
    endif
    if rate == 100 then
        set u = CreateUnit(GetOwningPlayer(caster), 'n00E', GetUnitX(caster), GetUnitY(caster), 0)
        call UnitAddAbility(u, 'A04R')
        call IssueTargetOrder(u, "chainlightning", target)
    endif
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Iku03_Active takes nothing returns nothing
endfunction