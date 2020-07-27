function Trig_YoumuN04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit h
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 1)
    local integer i = LoadInteger(udg_Hashtable, task, 1)
    local real damage = LoadReal(udg_Hashtable, task, 0)
    local real a = LoadReal(udg_Hashtable, task, 1)
    local real ox = LoadReal(udg_Hashtable, task, 2)
    local real oy = LoadReal(udg_Hashtable, task, 3)
    local real px
    local real py
    local unit u
    call DebugMsg("Youmu04Run")
    if GetUnitAbilityLevel(target, 'A1GJ') != 0 then
        set px = ox + 250.0 * CosBJ(210.0 * i + i * 4)
        set py = oy + 250.0 * SinBJ(210.0 * i + i * 4)
        call UnitStunTarget(caster, target, 0.2, 0, 0)
        call SetUnitPosition(caster, px, py)
        call SetUnitAnimation(caster, "attack")
        if i == 9 or i == 7 or i == 5 or i == 3 then
            call VE_Sword_Special(target, 2)
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", px, py))
        call SaveInteger(udg_Hashtable, task, 1, i + 1)
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
        call IssueTargetOrder(caster, "attack", target)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
        set h = GetPlayerCharacter(GetOwningPlayer(caster))
        call SetPlayerAbilityAvailable(GetOwningPlayer(h), 'A1GK', true)
        call UnitRemoveAbility(h, 'A1GL')
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_YoumuN04_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A1GL' then
        call UnitRemoveAbility(LoadUnitHandle(udg_ht, GetHandleId(GetTriggerUnit()), 'A1GJ'), 'A1GJ')
        return false
    endif
    return GetSpellAbilityId() == 'A1GK'
endfunction

function Trig_YoumuN04_Actions takes nothing returns nothing
    local unit caster
    local unit target
    local integer level
    local timer t
    local integer task
    local real ox
    local real oy
    local real tx
    local real ty
    local real a
    local effect array e
    call DebugMsg("CodeRun")
    set caster = GetTriggerUnit()
    set target = GetSpellTargetUnit()
    set level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 60)
    call VE_Spellcast(caster)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1GK', false)
    call UnitAddAbility(caster, 'A1GL')
    call UnitBuffTarget(caster, caster, 10.0, 'A1GJ', 0)
    call SetUnitAbilityLevel(caster, 'A1GJ', 2 + level)
    call AbilityCoolDownResetion(caster, 'A1GG', 0)
    call UnitBuffTarget(caster, target, 0.5 + level * 0.5, 'A1GJ', 0)
    call SaveUnitHandle(udg_ht, GetHandleId(caster), 'A1GJ', target)
    set caster = LoadUnitHandle(udg_sht, GetHandleId(caster), 0)
    call DebugMsg("CodeRun2")
    call ShowUnit(caster, true)
    set ox = GetUnitX(caster)
    set oy = GetUnitY(caster)
    set tx = GetUnitX(target)
    set ty = GetUnitY(target)
    set a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SetUnitVertexColor(caster, 255, 255, 255, 0)
    call SetUnitInvulnerable(caster, true)
    call SetUnitAnimation(caster, "stand ready")
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", caster, "origin"))
    set e[0] = AddSpecialEffectTarget("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", caster, "origin")
    set e[1] = AddSpecialEffectTarget("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", caster, "origin")
    set e[2] = AddSpecialEffectTarget("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", caster, "origin")
    call SetUnitPathing(caster, false)
    call DebugMsg("CodeRun3")
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveUnitHandle(udg_Hashtable, task, 1, target)
    call DebugMsg("CodeRun4")
    call SaveEffectHandle(udg_Hashtable, task, 2, e[0])
    call SaveEffectHandle(udg_Hashtable, task, 3, e[1])
    call SaveEffectHandle(udg_Hashtable, task, 4, e[2])
    call SaveInteger(udg_Hashtable, task, 1, 10)
    call DebugMsg("CodeRun5")
    call SaveReal(udg_Hashtable, task, 0, 0)
    call SaveReal(udg_Hashtable, task, 1, a)
    call SaveReal(udg_Hashtable, task, 2, tx)
    call SaveReal(udg_Hashtable, task, 3, ty)
    call DebugMsg("CodeRun6")
    call TimerStart(t, 0.1, true, function Trig_YoumuN04_Main)
    call DebugMsg("CodeRun7")
    set caster = null
    set target = null
    set e[0] = null
    set e[1] = null
    set e[2] = null
    set t = null
endfunction

function InitTrig_YoumuN04 takes nothing returns nothing
endfunction