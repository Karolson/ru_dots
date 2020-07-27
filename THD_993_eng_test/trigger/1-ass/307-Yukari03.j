function YUKARI03 takes nothing returns integer
    return 'A0IQ'
endfunction

function YUKARI03_COOLDOWN_BASE takes nothing returns real
    return 16.0
endfunction

function YUKARI03_COOLDOWN_SCALE takes nothing returns real
    return -1.0
endfunction

function YUKARI03_DAMAGE_BASE takes nothing returns real
    return 75.0
endfunction

function YUKARI03_DAMAGE_SCALE takes nothing returns real
    return 30.0
endfunction

function YUKARI03_DAMAGE_SCALE_FACTOR takes nothing returns real
    return 1.6
endfunction

function YUKARI03_STUN_DURATION_BASE takes nothing returns real
    return 1.2
endfunction

function YUKARI03_STUN_DURATION_SCALE takes nothing returns real
    return 0.1
endfunction

function YUKARI03_DELAY takes nothing returns real
    return 2.0
endfunction

function YUKARI03_DISTANCE takes nothing returns real
    return 550.0
endfunction

function YUKARI03_EFFECT_ON_STUN takes nothing returns string
    return "Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl"
endfunction

function YUKARI03_EFFECT_ON_END takes nothing returns string
    return "Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl"
endfunction

function YUKARI03_EFFECT_ON_TARGET takes nothing returns string
    return "Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl"
endfunction

function Trig_Yukari03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0IQ'
endfunction

function Trig_Yukari03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local effect e
    local real damage
    local real duration
    local real threshold = LoadReal(udg_sht, task, 5)
    local real count = LoadReal(udg_sht, task, 6)
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    if GetWidgetLife(caster) > 0 and GetWidgetLife(target) > 0 then
        if not IsUnitInRange(caster, target, 550.0) then
            set e = LoadEffectHandle(udg_sht, task, 2)
            call DestroyEffect(e)
            set duration = LoadReal(udg_sht, task, 4)
            call UnitStunTarget(caster, target, duration, 0, 0)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_sht, task)
        elseif count >= 2.0 then
            set damage = LoadReal(udg_sht, task, 3)
            set e = LoadEffectHandle(udg_sht, task, 2)
            call DestroyEffect(e)
            set e = AddSpecialEffectTarget("Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl", target, "origin")
            call DestroyEffect(e)
            call UnitMagicDamageTarget(caster, target, damage, 5)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_sht, task)
        elseif count < 2.0 then
            set count = count + 0.03125
            call SaveReal(udg_sht, task, 6, count)
        endif
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Yukari03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A0IQ')
    local real damage = ABCIAllInt(caster, 75.0 + (level - 1) * 30.0, 1.6)
    local real duration = 1.2 + (level - 1) * 0.1
    local effect e
    local unit u = CreateUnit(GetOwningPlayer(caster), 'e034', GetUnitX(target), GetUnitY(target), 0.0)
    call AbilityCoolDownResetion(caster, 'A0IQ', 16.0 + level * -1.0)
    call UnitMagicDamageTarget(caster, target, damage, 5)
    call AttachUnitToTarget(u, target, 2.0, true, true, true)
    set e = AddSpecialEffectTarget("Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl", target, "origin")
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveUnitHandle(udg_sht, task, 1, target)
    call SaveEffectHandle(udg_sht, task, 2, e)
    call SaveReal(udg_sht, task, 3, damage)
    call SaveReal(udg_sht, task, 4, duration)
    call SaveReal(udg_sht, task, 5, 550.0 * 550.0)
    call SaveReal(udg_sht, task, 6, 0.03125)
    call TimerStart(t, 0.03125, true, function Trig_Yukari03_Main)
    set e = null
    set caster = null
    set target = null
    set t = null
    set u = null
endfunction

function InitTrig_Yukari03 takes nothing returns nothing
endfunction