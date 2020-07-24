function KOISHI01 takes nothing returns integer
    return 'A0GT'
endfunction

function KoishiToggleSkillEffect takes unit caster, integer i, boolean on returns nothing
    local timer t = LoadTimerHandle(udg_sht, StringHash("KoishiSkillEffect"), GetHandleId(caster))
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), i)
    if on then
        call ShowUnit(u, true)
        call UnitAddAbility(u, 'Aloc')
        call DebugMsg("Koishi Skill Effect " + I2S(i) + " turned on")
    else
        call ShowUnit(u, false)
        call UnitRemoveAbility(u, 'Aloc')
        call DebugMsg("Koishi Skill Effect " + I2S(i) + " turned off")
    endif
    set t = null
    set u = null
endfunction

function KoishiSkillEffectLoop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, -1)
    local real y = LoadReal(udg_ht, task, -2)
    local integer i = 1
    loop
        set a = a + 0.05236
        call SetUnitX(u, x + 120 * Cos(a))
        call SetUnitY(u, y + 120 * Sin(a))
        call SaveReal(udg_ht, task, i, a)
        set i = i + 1
    exitwhen i > 3
        set u = LoadUnitHandle(udg_ht, task, i)
        set a = LoadReal(udg_ht, task, i)
    endloop
    if GetWidgetLife(caster) > 0.405 then
        call SaveReal(udg_ht, task, -1, GetUnitX(caster))
        call SaveReal(udg_ht, task, -2, GetUnitY(caster))
    else
        if IsPlayerInForce(GetOwningPlayer(caster), udg_TeamA) then
            call SaveReal(udg_ht, task, -1, GetLocationX(udg_BirthPoint[0]))
            call SaveReal(udg_ht, task, -2, GetLocationY(udg_BirthPoint[0]))
        else
            call SaveReal(udg_ht, task, -1, GetLocationX(udg_BirthPoint[1]))
            call SaveReal(udg_ht, task, -2, GetLocationY(udg_BirthPoint[1]))
        endif
        set i = 1
        loop
        exitwhen i > 3
            set u = LoadUnitHandle(udg_ht, task, i)
            if not IsUnitHidden(u) then
                if i == 1 then
                    call KillUnit(CreateUnit(GetOwningPlayer(caster), 'e030', GetUnitX(u), GetUnitY(u), a * 57.29578))
                elseif i == 2 then
                    call KillUnit(CreateUnit(GetOwningPlayer(caster), 'e031', GetUnitX(u), GetUnitY(u), a * 57.29578))
                elseif i == 3 then
                    call KillUnit(CreateUnit(GetOwningPlayer(caster), 'e032', GetUnitX(u), GetUnitY(u), a * 57.29578))
                endif
            endif
            call ShowUnit(u, false)
            call UnitRemoveAbility(u, 'Aloc')
            set i = i + 1
        endloop
    endif
    set t = null
    set u = null
    set caster = null
endfunction

function KoishiSkillEffect takes unit caster returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real a = 0.0
    local integer i = 1
    local unit u
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local real tx
    local real ty
    local player p = GetOwningPlayer(caster)
    loop
    exitwhen i > 3
        set a = 120 * i * 0.017454
        set tx = x + 120.0 * Cos(a)
        set ty = y + 120.0 * Sin(a)
        if i == 1 then
            set u = CreateUnit(p, 'e030', tx, ty, a * 57.29578)
        elseif i == 2 then
            set u = CreateUnit(p, 'e031', tx, ty, a * 57.29578)
        elseif i == 3 then
            set u = CreateUnit(p, 'e032', tx, ty, a * 57.29578)
        endif
        call SaveUnitHandle(udg_ht, task, i, u)
        call SaveReal(udg_ht, task, i, a)
        call ShowUnit(u, false)
        call UnitRemoveAbility(u, 'Aloc')
        set i = i + 1
    endloop
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, -1, x)
    call SaveReal(udg_ht, task, -2, y)
    call SaveTimerHandle(udg_sht, StringHash("KoishiSkillEffect"), GetHandleId(caster), t)
    call TimerStart(t, 0.0325, true, function KoishiSkillEffectLoop)
    set t = null
    set u = null
    set p = null
endfunction

function Koishi01_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        return GetLearnedSkill() == 'A0GT'
    endif
    return GetSpellAbilityId() == 'A0GT'
endfunction

function Koishi01_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer factor = LoadInteger(udg_sht, task, 0)
    local integer currentbonus = LoadInteger(udg_sht, task, 1)
    local boolean normalstate = LoadBoolean(udg_sht, task, 2)
    local integer newbonus
    local integer delta
    local real elapsed
    local integer i = 0
    local integer n = 0
    if GetWidgetLife(caster) > 0.405 then
        loop
        exitwhen i >= 12
            if udg_PlayerHeroes[i] != null and udg_PlayerHeroes[i] != caster and GetWidgetLife(udg_PlayerHeroes[i]) > 0.405 and IsUnitInRange(udg_PlayerHeroes[i], caster, 1000.0) then
                set n = n + 1
            endif
            set i = i + 1
        endloop
        if normalstate then
            set newbonus = factor * n
        else
            set newbonus = factor * (12 - n)
        endif
        set delta = newbonus - currentbonus
        call SaveInteger(udg_sht, task, 1, newbonus)
        if delta > 0 then
            call UnitAddAttackDamage(caster, delta)
        elseif delta < 0 then
            call UnitReduceAttackDamage(caster, -delta)
        endif
    else
        call UnitReduceAttackDamage(caster, currentbonus)
        call SaveInteger(udg_sht, task, 1, 0)
    endif
    if not normalstate then
        set elapsed = LoadReal(udg_sht, task, 2) + 0.2
        if elapsed <= 8.0 then
            call SaveReal(udg_sht, task, 2, elapsed)
        else
            call SaveReal(udg_sht, task, 2, 0.0)
            call SaveBoolean(udg_sht, task, 2, true)
            call KoishiToggleSkillEffect(caster, 1, false)
        endif
    endif
    set t = null
    set caster = null
endfunction

function Koishi01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer ctask = GetHandleId(caster)
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, 'A0GT')
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        if level == 1 then
            set t = CreateTimer()
            set task = GetHandleId(t)
            call SaveTimerHandle(udg_sht, StringHash("Koishi01Timer"), ctask, t)
            call SaveUnitHandle(udg_sht, task, 0, caster)
            if udg_GameMode / 100 != 3 and udg_NewMid == false then
                call SaveInteger(udg_sht, task, 0, 4)
            else
                call SaveInteger(udg_sht, task, 0, 3)
            endif
            call SaveInteger(udg_sht, task, 1, 0)
            call SaveBoolean(udg_sht, task, 2, true)
            call SaveReal(udg_sht, task, 2, 0.0)
            call TimerStart(t, 0.2, true, function Koishi01_Loop)
        else
            set t = LoadTimerHandle(udg_sht, StringHash("Koishi01Timer"), ctask)
            set task = GetHandleId(t)
            if udg_GameMode / 100 != 3 and udg_NewMid == false then
                call SaveInteger(udg_sht, task, 0, 1 + 3 * level)
            else
                call SaveInteger(udg_sht, task, 0, 1 + 2 * level)
            endif
        endif
    elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call AbilityCoolDownResetion(caster, 'A0GT', 15)
        call KoishiToggleSkillEffect(caster, 1, true)
        set t = LoadTimerHandle(udg_sht, StringHash("Koishi01Timer"), ctask)
        set task = GetHandleId(t)
        call SaveBoolean(udg_sht, task, 2, false)
    endif
    set caster = null
    set t = null
endfunction

function InitTrig_Koishi01 takes nothing returns nothing
endfunction