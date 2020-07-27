function Trig_Merlin01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0O3'
endfunction

function Trig_Merlin01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local effect e2 = LoadEffectHandle(udg_ht, task, 3)
    if i > 0 and IsUnitType(caster, UNIT_TYPE_DEAD) == false and IsUnitType(target, UNIT_TYPE_DEAD) == false and GetUnitAbilityLevel(target, 'B065') >= 1 then
        call IssueTargetOrderById(target, 851983, caster)
        set i = i - 1
        call SaveInteger(udg_ht, task, 2, i)
    else
        if GetOwningPlayer(target) == GetLocalPlayer() then
            call EnableUserControl(true)
        endif
        call UnitRemoveAbility(target, 'A0Z1')
        call UnitRemoveAbility(target, 'B065')
        call DestroyEffect(e2)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set e2 = null
endfunction

function Trig_Merlin01_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local effect e2 = LoadEffectHandle(udg_ht, task, 3)
    call DestroyEffect(e2)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set e2 = null
endfunction

function Trig_Merlin01_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local integer level = GetUnitAbilityLevel(caster, 'A0O3')
    local unit e1
    local effect e2
    call AbilityCoolDownResetion(caster, 'A0O3', 12 - level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set t = null
            set caster = null
            set target = null
            set e1 = null
            set e2 = null
            return
        endif
    endif
    call PlaySoundOnUnitBJ(gg_snd_TrumpetChorus_01, 100, caster)
    set e1 = CreateUnit(GetOwningPlayer(caster), 'e01O', tx, ty, 0)
    call SetUnitPathing(e1, false)
    call SetUnitXY(e1, tx, ty)
    call SetUnitVertexColor(e1, 255, 155, 255, 255)
    set e2 = AddSpecialEffectTarget("Abilities\\Spells\\Undead\\Cripple\\CrippleTarget.mdl", target, "head")
    if IsUnitType(target, UNIT_TYPE_HERO) then
        call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, level * 40 + 40, 1.5), 1)
    else
        call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, level * 40 + 40, 1.5) + 500.0, 1)
        call UnitManaingTarget(caster, caster, 70.0)
        call DebugMsg("Mana Added")
    endif
    call UnitRidiculeTarget(caster, target, 0.8 + 0.3 * level)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveEffectHandle(udg_ht, task, 3, e2)
    call TimerStart(t, 0.8 + 0.3 * level, false, function Trig_Merlin01_Clear)
    set t = null
    set e1 = null
    set e2 = null
    set caster = null
    set target = null
endfunction

function InitTrig_Merlin01 takes nothing returns nothing
endfunction