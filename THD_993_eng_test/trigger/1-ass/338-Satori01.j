function Trig_Satori01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0IW'
endfunction

function Trig_Satori01_Max takes unit caster returns integer
    return 6
endfunction

function Trig_Satori01_Damage_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetEventDamageSource()) == 'n03R'
endfunction

function Trig_Satori01_Damage_Actions takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer id = GetHandleId(trg)
    local unit caster = LoadUnitHandle(udg_ht, id, 0)
    local unit target = LoadUnitHandle(udg_ht, id, 1)
    local integer level = GetUnitAbilityLevel(caster, 'A0IW')
    call DisableTrigger(trg)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\StormBolt\\StormBoltMissile.mdl", GetUnitX(target), GetUnitY(target)))
    call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 10 + level * 10, 0.4), 1)
    call UnitStunTarget(caster, target, 1.0, 0, 0)
    call UnitShareVision(target, GetOwningPlayer(caster), true)
    call TriggerSleepAction(3.0)
    call UnitShareVision(target, GetOwningPlayer(caster), false)
    call FlushChildHashtable(udg_ht, id)
    call TriggerClearActions(trg)
    call DestroyTrigger(trg)
    set target = null
    set caster = null
    set trg = null
endfunction

function Trig_Satori01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(u)
    local real ty = GetUnitY(u)
    local real px
    local real py
    local real dx
    local real dy
    local real r
    local real a
    local real d
    local real e
    local integer level
    local integer n = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local trigger trg
    if GetWidgetLife(u) > 0.405 then
        set target = LoadUnitHandle(udg_ht, GetHandleId(u), 0)
        set level = LoadInteger(udg_ht, GetHandleId(u), 0)
        if IsUnitVisible(caster, GetLocalPlayer()) == false then
            call SetUnitVertexColor(u, 255, 255, 255, 0)
        else
            call SetUnitVertexColor(u, 255, 255, 255, 255)
        endif
        if target != null then
            call SaveUnitHandle(udg_ht, task, 2, target)
            call SaveInteger(udg_ht, task, 2, level)
            call FlushChildHashtable(udg_ht, GetHandleId(u))
            call SetUnitAbilityLevel(u, 'A08R', level)
            call SetUnitScale(u, 1.5, 1.5, 1.5)
            call SaveInteger(udg_ht, task, 1, 2)
        elseif i == 0 then
            set dx = ox - tx
            set dy = oy - ty
            set r = 120.0
            set d = SquareRoot(dx * dx + dy * dy)
            if d > r + 5.0 then
                set a = Atan2(dy, dx) + (bj_DEGTORAD * 90.0 - Acos(r / d))
                set px = tx + 20.0 * Cos(a)
                set py = ty + 20.0 * Sin(a)
                call SetUnitFacing(u, bj_RADTODEG * a)
                if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
                    call SetUnitX(u, px)
                    call SetUnitY(u, py)
                endif
            else
                call SaveInteger(udg_ht, task, 1, 1)
            endif
        elseif i == 1 then
            set dx = tx - ox
            set dy = ty - oy
            set r = 120.0
            set a = bj_RADTODEG * Atan2(dy, dx) - 5.0
            set px = ox + r * CosBJ(a)
            set py = oy + r * SinBJ(a)
            if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
                call SetUnitX(u, px)
                call SetUnitY(u, py)
            endif
        elseif i == 2 then
            set target = LoadUnitHandle(udg_ht, task, 2)
            set level = LoadInteger(udg_ht, task, 2)
            if GetWidgetLife(target) >= 0.405 then
                set ox = GetUnitX(u)
                set oy = GetUnitY(u)
                set tx = GetUnitX(target)
                set ty = GetUnitY(target)
                set dx = tx - ox
                set dy = ty - oy
                set a = GetUnitFacing(u)
                set e = YawError(a, bj_RADTODEG * Atan2(dy, dx))
                if RAbsBJ(e) > 15.0 then
                    call IssueTargetOrder(u, "move", target)
                else
                    call SetUnitAbilityLevel(u, 'A08R', level)
                    if not IsUnitCCImmune(target) then
                        call IssueTargetOrder(u, "thunderbolt", target)
                    endif
                    call UnitApplyTimedLife(u, 'BTLF', 8.0)
                    call ShowUnit(u, false)
                    set trg = CreateTrigger()
                    call TriggerAddCondition(trg, Condition(function Trig_Satori01_Damage_Conditions))
                    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
                    call TriggerAddAction(trg, function Trig_Satori01_Damage_Actions)
                    call SaveUnitHandle(udg_ht, GetHandleId(trg), 0, caster)
                    call SaveUnitHandle(udg_ht, GetHandleId(trg), 1, target)
                    call SaveInteger(udg_ht, task, 1, 3)
                    call TimerStart(t, 0.1, true, function Trig_Satori01_Main)
                endif
            else
                call SaveInteger(udg_ht, task, 1, 3)
            endif
        elseif i == 3 then
            call ShowUnit(u, false)
            call UnitApplyTimedLife(u, 'BTLF', 6.0)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
    set trg = null
endfunction

function Trig_Satori01_Check takes unit caster, unit target, integer skill returns boolean
    local integer task = GetHandleId(caster)
    local integer i
    if skill == 0 then
        return false
    endif
    set i = 1
    loop
        if skill == LoadInteger(udg_sht, task, i) then
            return false
        endif
        set i = i + 1
    exitwhen i > 6
    endloop
    return true
endfunction

function Trig_Satori01_Add takes unit caster, unit target, integer skill returns boolean
    local integer task = GetHandleId(caster)
    local integer n = LoadInteger(udg_sht, task, 0)
    local real px = GetUnitX(target)
    local real py = GetUnitY(target)
    local unit u
    local timer t
    if n >= Trig_Satori01_Max(caster) then
        return false
    endif
    set t = CreateTimer()
    set u = CreateUnit(GetOwningPlayer(caster), 'n03R', px, py, GetUnitFacing(target))
    set n = n + 1
    call SaveUnitHandle(udg_sht, task, n, u)
    call SaveInteger(udg_sht, task, n, skill)
    call SaveInteger(udg_sht, task, 0, n)
    call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "Spellcards collected: " + I2S(n))
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 0, n)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 0.02, true, function Trig_Satori01_Main)
    set t = null
    set u = null
    return true
endfunction

function Trig_Satori01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local integer task = GetHandleId(caster)
    local integer level
    local integer i
    local integer n
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 8)
    if GetTriggerEventId() == EVENT_UNIT_SPELL_CAST then
        if LoadInteger(udg_sht, task, 0) == 0 then
            call PauseUnit(caster, true)
            call IssueImmediateOrder(caster, "stop")
            call PauseUnit(caster, false)
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "There are currently no spellcards collected")
            return
        endif
    else
        set level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set n = Trig_Satori01_Max(caster)
        set i = 1
        loop
        exitwhen i > n
            set u = LoadUnitHandle(udg_sht, task, i)
            if u != caster then
                call SaveUnitHandle(udg_sht, task, i, caster)
                call SaveInteger(udg_sht, task, i, 0)
                call SaveUnitHandle(udg_ht, GetHandleId(u), 0, target)
                call SaveInteger(udg_ht, GetHandleId(u), 0, level)
            endif
            set i = i + 1
        endloop
        call SaveInteger(udg_sht, task, 0, 0)
    endif
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Satori01 takes nothing returns nothing
endfunction