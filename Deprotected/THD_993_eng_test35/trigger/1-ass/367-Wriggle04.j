function WRIGGLE04 takes nothing returns integer
    return 'A0FZ'
endfunction

function WRIGGLE04_KICK_SPEED takes nothing returns real
    return 1600.0
endfunction

function WRIGGLE04_COLLISION_RADIUS takes nothing returns real
    return 128.0
endfunction

function WRIGGLE04_EFFECT takes nothing returns string
    return "Abilities\\Spells\\Human\\slow\\slowtarget.mdl"
endfunction

function Wriggle04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0FZ'
endfunction

function Wriggle04_Effect_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local effect e = LoadEffectHandle(udg_sht, task, 0)
    call DestroyEffect(e)
    call FlushChildHashtable(udg_sht, task)
    call ReleaseTimer(t)
    set t = null
    set e = null
endfunction

function Wriggle04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local real damage = LoadReal(udg_sht, task, 2)
    local real threshold = LoadReal(udg_sht, task, 3)
    local real distancetick = LoadReal(udg_sht, task, 4)
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - cy, tx - cx)
    local real dx = distancetick * Cos(a)
    local real dy = distancetick * Sin(a)
    local integer level = GetUnitAbilityLevel(caster, 'A0FZ')
    local effect e
    if GetWidgetLife(target) > 0.405 and not IsUnitType(target, UNIT_TYPE_DEAD) and not IsUnitInRange(caster, target, threshold) then
        call SetUnitFacing(caster, 57.29577951 * a)
        call SetUnitX(caster, cx + dx)
        call SetUnitY(caster, cy + dy)
    else
        call SetUnitAnimation(caster, "stand")
        call SetUnitPathing(caster, true)
        call PauseUnit(caster, false)
        call FlushChildHashtable(udg_sht, task)
        if GetWidgetLife(target) > 0.405 and not IsUnitType(target, UNIT_TYPE_STRUCTURE) then
            call UnitPhysicalDamageTarget(caster, target, damage)
            if udg_NewDebuffSys then
                call UnitSlowTargetMspd(caster, target, 5 + 15 * level, 2.0, 2, 0)
            else
                if level == 1 then
                    call UnitSlowTarget(caster, target, 2.0, 'A0JS', 'B07W')
                elseif level == 2 then
                    call UnitSlowTarget(caster, target, 2.0, 'A0JT', 'B07W')
                else
                    call UnitSlowTarget(caster, target, 2.0, 'A0JU', 'B07W')
                endif
            endif
            call CastSpell(target, "Wow~!")
            call IssueTargetOrder(caster, "attack", target)
            set e = AddSpecialEffectTarget("Abilities\\Spells\\Human\\slow\\slowtarget.mdl", target, "origin")
            call SaveEffectHandle(udg_sht, task, 0, e)
            call TimerStart(t, DebuffDuration(target, 2.0), false, function Wriggle04_Effect_Clear)
        endif
    endif
    set caster = null
    set target = null
    set t = null
    set e = null
endfunction

function Wriggle04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = 57.29577951 * Atan2(ty - cy, tx - cx)
    local real threshold = 128.0
    local real damage = 30.0 + 70.0 * GetUnitAbilityLevel(caster, 'A0FZ') + GetUnitAttack(caster) * 1.1
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call CE_Input(caster, target, 100)
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, 'A0FZ', 7 - GetUnitAbilityLevel(caster, 'A0FZ'))
    else
        call AbilityCoolDownResetion(caster, 'A0FZ', (7 - GetUnitAbilityLevel(caster, 'A0FZ')) * 0.5)
    endif
    call SetUnitFacing(caster, a)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveUnitHandle(udg_sht, task, 1, target)
    call SaveReal(udg_sht, task, 2, damage)
    call SaveReal(udg_sht, task, 3, threshold)
    call SaveReal(udg_sht, task, 4, 1600.0 * 0.02)
    call PauseUnit(caster, true)
    call SetUnitPathing(caster, false)
    call SetUnitAnimation(caster, "Attack Slam")
    call TimerStart(t, 0.02, true, function Wriggle04_Main)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Wriggle04 takes nothing returns nothing
endfunction