function Trig_Minoriko01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0JF'
endfunction

function Trig_Minoriko01_Heal takes unit caster, unit target, integer level returns nothing
    local real idi = 2.2 * GetHeroInt(caster, true)
    local real idh = (0.03 + level * 0.02) * GetUnitState(target, UNIT_STATE_MAX_LIFE)
    local real a = 25.0 + level * 50.0 + RMaxBJ(idi, idh)
    call UnitHealingTarget(caster, target, a)
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIhe\\AIheTarget.mdl", target, "origin"))
endfunction

function Trig_Minoriko01_Damage takes unit caster, unit target, integer level returns nothing
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real damage = 25.0 + level * 50.0 + 2.2 * GetHeroInt(caster, true)
    local unit v
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call UnitMagicDamageTarget(caster, target, damage, 1)
    call UnitStunTarget(caster, target, 1.0, 0, 0)
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_Minoriko01_Hit takes nothing returns nothing
    local unit caster
    local unit target
    local real tx
    local real ty
    local trigger trg
    local triggeraction tga
    local integer task
    local integer level
    local integer c
    if GetTriggerEventId() == EVENT_UNIT_DEATH then
        set trg = GetTriggeringTrigger()
        set task = GetHandleId(trg)
        set tga = LoadTriggerActionHandle(udg_ht, task, 1)
        call TriggerRemoveAction(trg, tga)
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set caster = null
        set target = null
        set trg = null
        set tga = null
        return
    endif
    if GetUnitTypeId(GetEventDamageSource()) != 'o00R' then
        set caster = null
        set target = null
        set trg = null
        set tga = null
        return
    endif
    call RemoveUnit(GetEventDamageSource())
    set trg = GetTriggeringTrigger()
    set task = GetHandleId(trg)
    set caster = LoadUnitHandle(udg_ht, task, 0)
    set target = GetTriggerUnit()
    set tx = GetUnitX(target)
    set ty = GetUnitY(target)
    set tga = LoadTriggerActionHandle(udg_ht, task, 1)
    set level = LoadInteger(udg_ht, task, 0)
    set c = LoadInteger(udg_ht, task, 1)
    call TriggerRemoveAction(trg, tga)
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    if c == 0 then
        call Trig_Minoriko01_Heal(caster, target, level)
    else
        call Trig_Minoriko01_Damage(caster, target, level)
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", tx, ty))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", target, "chest"))
    endif
    set caster = null
    set target = null
    set trg = null
    set tga = null
endfunction

function Trig_Minoriko01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local real s
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local trigger trg
    local triggeraction tga
    local integer task
    local integer level = GetUnitAbilityLevel(caster, 'A0JF')
    call AbilityCoolDownResetion(caster, 'A0JF', 14 - level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set trg = null
            set tga = null
            set u = null
            return
        endif
    endif
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Minoriko01_Hit)
    set task = GetHandleId(trg)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveTriggerActionHandle(udg_ht, task, 1, tga)
    call SaveInteger(udg_ht, task, 0, level)
    set u = CreateUnit(GetOwningPlayer(caster), 'o00R', ox, oy, 270.0)
    call UnitApplyTimedLife(u, 'BTLF', 7.0)
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
    set s = 1.6 + 0.1 * level
    call SetUnitScale(u, s, s, s)
    if IsUnitAlly(target, GetOwningPlayer(caster)) then
        call SaveInteger(udg_ht, task, 1, 0)
        call IssueTargetOrder(u, "shadowstrike", target)
    else
        call CE_Input(caster, target, 100)
        call SaveInteger(udg_ht, task, 1, 1)
        call UnitRemoveAbility(u, 'A0JG')
        call UnitAddAbility(u, 'A0UZ')
        call IssueTargetOrder(u, "shadowstrike", target)
    endif
    set caster = null
    set target = null
    set trg = null
    set tga = null
    set u = null
endfunction

function InitTrig_Minoriko01 takes nothing returns nothing
endfunction