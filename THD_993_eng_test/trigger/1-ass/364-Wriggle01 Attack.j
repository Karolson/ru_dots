function Wriggle_01_Attack_Conditions takes nothing returns boolean
    local unit u
    local unit v
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_ATTACKED then
        if GetUnitAbilityLevel(GetAttacker(), 'A0VU') > 0 then
            set v = GetAttacker()
            set u = CreateUnit(GetOwningPlayer(v), 'o00R', GetUnitX(v), GetUnitY(v), 270.0)
            call UnitRemoveAbility(v, 'A0VU')
            call SetUnitAnimation(v, "Attack Slam")
            call UnitAddAbility(u, 'A08T')
            call IssueTargetOrder(u, "acidbomb", GetTriggerUnit())
            call SaveUnitHandle(udg_sht, StringHash("Wriggle01Dummy"), GetHandleId(GetTriggerUnit()), u)
            call SaveUnitHandle(udg_sht, GetHandleId(u), 0, v)
        endif
        set u = null
        set v = null
        return false
    endif
    set u = null
    set v = null
    if HaveSavedHandle(udg_sht, StringHash("Wriggle01Dummy"), GetHandleId(GetTriggerUnit())) then
        return GetEventDamageSource() == LoadUnitHandle(udg_sht, StringHash("Wriggle01Dummy"), GetHandleId(GetTriggerUnit()))
    endif
    return false
endfunction

function Wriggle_01_Attack_Effect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local integer level = LoadInteger(udg_sht, task, 2)
    call UnitRemoveAbility(caster, 'A0VU')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0FW', true)
    if GetWidgetLife(caster) > 0.405 then
        call UnitPhysicalDamageTarget(caster, target, level * 50)
        call UnitDamageTarget(caster, target, 0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_METAL_HEAVY_SLICE)
        if udg_NewDebuffSys then
            call UnitDebuffTarget(caster, target, (1.5 + 0.25 * level) * 1.0, 1, true, 'A04D', 1, 'B084', "drunkenhaze", 'A05P', "")
        else
            call UnitCurseTarget(caster, target, 1.5 + 0.25 * level, 'A0VV', "drunkenhaze")
        endif
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
    set target = null
endfunction

function Wriggle_01_Attack_Actions takes nothing returns nothing
    local unit dummy = GetEventDamageSource()
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(dummy), 0)
    local integer ctask = GetHandleId(caster)
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0FW')
    local timer t = LoadTimerHandle(udg_sht, StringHash("Wriggle01"), ctask)
    local integer task = GetHandleId(t)
    call RemoveSavedHandle(udg_sht, StringHash("Wriggle01Dummy"), GetHandleId(target))
    call FlushChildHashtable(udg_sht, GetHandleId(dummy))
    call RemoveUnit(dummy)
    call SaveBoolean(udg_sht, StringHash("Wriggle01"), ctask, false)
    call RemoveSavedHandle(udg_sht, StringHash("Wriggle01"), ctask)
    call SaveUnitHandle(udg_sht, task, 1, target)
    call SaveInteger(udg_sht, task, 2, level)
    call TimerStart(t, 0.0, false, function Wriggle_01_Attack_Effect)
    set t = null
    set caster = null
    set target = null
    set dummy = null
endfunction

function InitTrig_Wriggle01_Attack takes nothing returns nothing
endfunction