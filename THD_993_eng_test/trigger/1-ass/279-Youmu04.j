function Trig_Youmu04_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_SPELL_CAST and GetSpellAbilityId() == 'A065' then
        call VE_SwordCharge(GetTriggerUnit())
        return false
    endif
    return GetSpellAbilityId() == 'A065'
endfunction

function Trig_Youmu04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 1)
    local integer i = LoadInteger(udg_Hashtable, task, 1)
    local real damage = LoadReal(udg_Hashtable, task, 0)
    local real a = LoadReal(udg_Hashtable, task, 1)
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real px
    local real py
    local unit u
    if i > 1 then
        if i == 10 then
            set px = ox
            set py = oy
            call PauseUnit(target, true)
        else
            set px = ox + 250.0 * CosBJ(210.0 * i)
            set py = oy + 250.0 * SinBJ(210.0 * i)
        endif
        call SetUnitPosition(caster, px, py)
        call SetUnitAnimation(caster, "attack")
        if i == 9 or i == 7 or i == 5 or i == 3 then
            call UnitPhysicalDamageTarget(caster, target, damage * 0.2)
            call VE_Sword_Special(target, 2)
        endif
        call UnitDamageTarget(caster, target, 0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_METAL_HEAVY_SLICE)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", px, py))
        call SaveInteger(udg_Hashtable, task, 1, i - 1)
        call TimerStart(t, 0.1, false, function Trig_Youmu04_Main)
    else
        set px = ox + 100.0 * CosBJ(a)
        set py = oy + 100.0 * SinBJ(a)
        call SetUnitX(caster, px)
        call SetUnitY(caster, py)
        call SetUnitAnimation(caster, "attack")
        call KillUnit(CreateUnit(Player(15), 'e00H', ox, oy, 0))
        call UnitPhysicalDamageTarget(caster, target, damage * 0.2)
        call VE_Sword_Special(target, 2)
        call UnitDamageTarget(caster, target, 0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_METAL_HEAVY_SLICE)
        call PauseUnit(target, false)
        call DestroyEffect(AddSpecialEffectTarget("shot.mdl", caster, "chest"))
        call DestroyEffect(LoadEffectHandle(udg_Hashtable, task, 2))
        call DestroyEffect(LoadEffectHandle(udg_Hashtable, task, 3))
        call DestroyEffect(LoadEffectHandle(udg_Hashtable, task, 4))
        call SetUnitTimeScale(caster, 1.0)
        call SetUnitInvulnerable(caster, false)
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        call SetUnitPathing(caster, true)
        call SetUnitFlag(caster, 1, false)
        call CastSpell(caster, "Human Oni 'Slash of the Eternal Future'!")
        call IssueImmediateOrder(caster, "phaseshiftoff")
        call IssueTargetOrder(caster, "attack", target)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Youmu04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local integer task
    local real damage
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local effect array e
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 75 - 15 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set t = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SetUnitVertexColor(caster, 255, 255, 255, 0)
    call SetUnitInvulnerable(caster, true)
    call SetUnitAnimation(caster, "stand ready")
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", caster, "chest"))
    set e[0] = AddSpecialEffectTarget("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", caster, "weapon")
    set e[1] = AddSpecialEffectTarget("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", caster, "weapon")
    set e[2] = AddSpecialEffectTarget("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", caster, "weapon")
    call SetUnitPathing(caster, false)
    if level == 1 then
        set damage = ABCIAllAtk(caster, 150, 1.8)
    elseif level == 2 then
        set damage = ABCIAllAtk(caster, 300, 1.8)
    elseif level == 3 then
        set damage = ABCIAllAtk(caster, 450, 1.8)
    endif
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveUnitHandle(udg_Hashtable, task, 1, target)
    call SaveEffectHandle(udg_Hashtable, task, 2, e[0])
    call SaveEffectHandle(udg_Hashtable, task, 3, e[1])
    call SaveEffectHandle(udg_Hashtable, task, 4, e[2])
    call SaveInteger(udg_Hashtable, task, 1, 10)
    call SaveReal(udg_Hashtable, task, 0, damage)
    call SaveReal(udg_Hashtable, task, 1, a)
    if GetUnitAbilityLevel(caster, 'A0E1') == 0 then
        call UnitAddAbility(caster, 'A0E1')
    endif
    call SetUnitFlag(caster, 1, true)
    call VE_Spellcast(caster)
    call TimerStart(t, 0.1, true, function Trig_Youmu04_Main)
    set caster = null
    set target = null
    set e[0] = null
    set e[1] = null
    set e[2] = null
    set t = null
endfunction

function InitTrig_Youmu04 takes nothing returns nothing
endfunction