function Trig_Minoriko04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A06A'
endfunction

function Trig_Minoriko04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit u1 = LoadUnitHandle(udg_ht, task, 2)
    local unit u2 = LoadUnitHandle(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local integer level = LoadInteger(udg_ht, task, 5)
    local player w = GetOwningPlayer(caster)
    local integer j = 0
    local unit u
    local unit v
    if i > 0 then
        set i = i - 1
        call SaveInteger(udg_ht, task, 4, i)
        loop
        exitwhen j > 11
            set v = udg_PlayerHeroes[j]
            if v != null and IsUnitAlly(v, w) and IsUnitInRange(v, u1, 475) and IsUnitType(v, UNIT_TYPE_DEAD) == false then
                call UnitBuffTarget(caster, v, 0.5, 'A06C', 'B06J')
                call SetUnitAbilityLevel(v, 'A06C', level)
                call DMG_DamageReduce(v, 1 - (GetUnitAbilityLevel(v, 'A06C') * 0.05 + 0.25), 0.5, "All")
            endif
            set j = j + 1
        endloop
    else
        call UnitMagicDamageArea(caster, GetUnitX(u1), GetUnitY(u1), 475, ABCIAllInt(caster, 50 + 150 * level, 2.8), 5)
        set u = CreateUnit(GetOwningPlayer(caster), 'n01H', GetUnitX(u1), GetUnitY(u1), 0)
        call UnitApplyTimedLife(u, 'BTLF', 15.0)
        call SetUnitTimeScale(u, 3.0)
        call SetUnitVertexColor(u, 255, 255, 255, R2I(255 * i / 126))
        set u = CreateUnit(GetOwningPlayer(caster), 'n01I', GetUnitX(u1), GetUnitY(u1), 0)
        call UnitApplyTimedLife(u, 'BTLF', 15.0)
        call SetUnitTimeScale(u, 0.2)
        call SetUnitVertexColor(u, 255, 255, 255, R2I(255 * i / 126))
        set u = null
        call KillUnit(u1)
        call KillUnit(u2)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u1 = null
    set u2 = null
    set w = null
    set v = null
endfunction

function Trig_Minoriko04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local unit u1
    local unit u2
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 125)
    call VE_Spellcast(caster)
    set u1 = CreateUnit(GetOwningPlayer(caster), 'e02Q', tx, ty, GetRandomInt(0, 360))
    set u2 = CreateUnit(GetOwningPlayer(caster), 'n042', tx, ty, GetRandomInt(0, 360))
    call SetUnitScale(u2, 1.15, 1.15, 1.15)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveTimerHandle(udg_ht, task, 0, t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveUnitHandle(udg_ht, task, 2, u1)
    call SaveUnitHandle(udg_ht, task, 3, u2)
    call SaveInteger(udg_ht, task, 4, 9)
    call SaveInteger(udg_ht, task, 5, level)
    call TimerStart(t, 0.5, true, function Trig_Minoriko04_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Minoriko04 takes nothing returns nothing
endfunction