function Trig_Satori04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0IZ'
endfunction

function Trig_Satori04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer c = LoadInteger(udg_ht, task, 2)
    local texttag e
    local real damage
    if i < 7 and GetWidgetLife(target) >= 0.405 then
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
        call SetUnitX(u, GetUnitX(target))
        call SetUnitY(u, GetUnitY(target))
        if GetUnitAbilityLevel(target, 'B04P') == 0 then
            call UnitRemoveAbility(target, 'B04O')
            call SetUnitAbilityLevel(u, c, 7 - i)
            set damage = ABCIAllInt(caster, 100 + level * 35, 2.6) / 7
            call UnitMagicDamageTarget(caster, target, damage, 2)
            call IssueTargetOrder(u, "shadowstrike", target)
            call SaveInteger(udg_ht, task, 1, i + 1)
            call TimerStart(t, 0.25 + 0.25 * level, false, function Trig_Satori04_Main)
        endif
    else
        call UnitRemoveAbility(target, 'B04O')
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set e = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Satori04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local unit u
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer c = 'A0J0' + level
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real dur  =  4.0 + I2R(level)
    if IsUnitType(target, UNIT_TYPE_HERO) == false then
        set dur  =  dur + 2.0
    endif
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 100 - 10 * level)
    call VE_Spellcast(caster)
    call CE_Input(caster, target, 200)
    set u = CreateUnit(GetOwningPlayer(caster), 'o000', x, y, 270.0)
    call UnitAddAbility(u, c)
    call UnitAddAbility(u, 'A0J5')
    call SetUnitAbilityLevel(u, 'A0J5', level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, c)
    call UnitDebuffTarget(caster, target, dur, 1, true, 'A00L', level, 'B04P', "sleep", 0, "")
    call CCSystem_textshow("Sleep", target, DebuffDuration(target, dur))
    call TimerStart(t, 0.03, true, function Trig_Satori04_Main)
    call DebugMsg("Satori04")
    set caster = null
    set target = null
    set u = null
    set t = null
endfunction

function InitTrig_Satori04 takes nothing returns nothing
endfunction