function YAMAME03 takes nothing returns integer
    return 'A0FF'
endfunction

function YAMAME03_DEBUFF_SKILL takes nothing returns integer
    return 'A0ER'
endfunction

function YAMAME03_DEBUFF takes nothing returns integer
    return 'B07P'
endfunction

function YAMAME03_DAMAGE_TICK_RATE takes nothing returns real
    return 1.0
endfunction

function YAMAME03_DURATION takes nothing returns real
    return 9.0
endfunction

function YAMAME03_TARGET_EFFECT takes nothing returns string
    return "Units\\Undead\\PlagueCloud\\PlagueCloudtarget.mdl"
endfunction

function YAMAME03_PROJECTILE takes nothing returns string
    return "Units\\Undead\\PlagueCloud\\PlagueCloudtarget.mdl"
endfunction

function YAMAME03_DEATH_DISEASE_SPREAD_RANGE takes nothing returns real
    return 450.0
endfunction

function YAMAME03_DAMAGE_PER_TICK takes integer slvl, integer int returns real
    return (9.0 + 9.0 * slvl + 0.3 * int) * 1.0
endfunction

function Yamame03_Filter takes nothing returns boolean
    return GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitEnemy(GetFilterUnit(), bj_groupEnumOwningPlayer) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') <= 0 and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') <= 0 and GetUnitAbilityLevel(GetFilterUnit(), 'A0ER') <= 0
endfunction

function Yamame03_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit source = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local real elapsed = LoadReal(udg_sht, task, 0)
    if target != null and GetWidgetLife(target) > 0.405 and not IsUnitType(target, UNIT_TYPE_DEAD) then
        call UnitMagicDamageTarget(source, target, (9.0 + 9.0 * GetUnitAbilityLevel(source, 'A0FF') + 0.3 * GetHeroInt(source, true)) * 1.0, 5)
        set elapsed = elapsed + 1.0
        if elapsed < 9.0 then
            call SaveReal(udg_sht, task, 0, elapsed)
        else
            call DebugMsg("Yamame03 End (Time Expired) " + R2S(elapsed))
            call UnitRemoveAbility(target, 'A0ER')
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_sht, task)
            call RemoveSavedHandle(udg_sht, StringHash("Yamame03"), GetHandleId(target))
        endif
    else
        call DebugMsg("Yamame03 End (Unit Died) " + R2S(elapsed))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
        call UnitRemoveAbility(target, 'A0ER')
        call RemoveSavedHandle(udg_sht, StringHash("Yamame03"), GetHandleId(target))
    endif
    set t = null
    set source = null
    set target = null
endfunction

function Yamame03_OnHit takes nothing returns nothing
    local unit u = udg_PS_Source
    local unit v = udg_PS_Target
    local integer ctask = GetHandleId(u)
    local integer ttask = GetHandleId(v)
    local integer stask = StringHash("Yamame03")
    local timer t
    local integer task
    set udg_PS_Source = null
    set udg_PS_Target = null
    if HaveSavedHandle(udg_sht, stask, ttask) then
        set t = LoadTimerHandle(udg_sht, stask, ttask)
    else
        set t = CreateTimer()
        call SaveTimerHandle(udg_sht, stask, ttask, t)
        call TimerStart(t, 1.0, true, function Yamame03_Damage)
    endif
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_sht, task, 0, u)
    call SaveUnitHandle(udg_sht, task, 1, v)
    call SaveUnitHandle(udg_sht, ttask, stask, u)
    call SaveReal(udg_sht, task, 0, 1.0)
    call UnitAddAbility(v, 'A0ER')
    call UnitMakeAbilityPermanent(v, true, 'A0ER')
    set u = null
    set v = null
    set t = null
endfunction

function Yamame03_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local unit v = null
    local unit w = null
    local unit e = null
    local timer t
    local group g
    local filterfunc f
    local integer task
    local integer stask = StringHash("Yamame03")
    local integer ttask
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        if GetSpellAbilityId() == 'A0FF' then
            call AbilityCoolDownResetion(u, 'A0FF', 17 - 2 * GetUnitAbilityLevel(u, 'A0FF'))
            set v = GetSpellTargetUnit()
            call LaunchProjectileToUnit("Units\\Undead\\PlagueCloud\\PlagueCloudtarget.mdl", 1.0, u, 1200.0, v, "Yamame03_OnHit")
        endif
        set u = null
        set v = null
        set w = null
        set e = null
        set g = null
        set t = null
        set f = null
        return false
    elseif GetUnitAbilityLevel(u, 'A0ER') > 0 then
        call DebugMsg("Yamame03 Unit Death, Seek Random Unit In Range")
        call UnitRemoveAbility(u, 'A0ER')
        set ttask = GetHandleId(u)
        set w = LoadUnitHandle(udg_sht, ttask, StringHash("Yamame03"))
        call RemoveSavedHandle(udg_sht, ttask, StringHash("Yamame03"))
        set g = CreateGroup()
        set f = Filter(function Yamame03_Filter)
        set bj_groupEnumOwningPlayer = GetOwningPlayer(w)
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 450.0, f)
        set bj_groupEnumOwningPlayer = null
        set v = GroupPickRandomUnit(g)
        if v != null then
            call GroupRemoveUnit(g, v)
            set t = CreateTimer()
            set task = GetHandleId(t)
            call UnitAddAbility(v, 'A0ER')
            call UnitMakeAbilityPermanent(v, true, 'A0ER')
            call SaveUnitHandle(udg_sht, task, 0, w)
            call SaveUnitHandle(udg_sht, task, 1, v)
            call SaveReal(udg_sht, task, 0, 1.0)
            call SaveUnitHandle(udg_sht, GetHandleId(v), StringHash("Yamame03"), w)
            call TimerStart(t, 1.0, true, function Yamame03_Damage)
            set e = GroupPickRandomUnit(g)
            if e != null then
                set t = CreateTimer()
                set task = GetHandleId(t)
                call UnitAddAbility(e, 'A0ER')
                call UnitMakeAbilityPermanent(e, true, 'A0ER')
                call SaveUnitHandle(udg_sht, task, 0, w)
                call SaveUnitHandle(udg_sht, task, 1, e)
                call SaveReal(udg_sht, task, 0, 1.0)
                call SaveUnitHandle(udg_sht, GetHandleId(e), StringHash("Yamame03"), w)
                call TimerStart(t, 1.0, true, function Yamame03_Damage)
            endif
        endif
        call DestroyFilter(f)
        call DestroyGroup(g)
    endif
    set u = null
    set v = null
    set w = null
    set e = null
    set g = null
    set t = null
    set f = null
    return false
endfunction

function InitTrig_Yamame03 takes nothing returns nothing
endfunction