function KomachiO01_Time_Basic takes nothing returns integer
    return 6
endfunction

function KomachiO01_Time_Income takes nothing returns integer
    return -1
endfunction

function KomachiXO01_CallBack takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local unit target = LoadUnitHandle(udg_ht, task, 2)
    local real ox
    local real oy
    local real tx
    local real ty
    if GetUnitCurrentOrder(caster) != OrderId("ensnare") then
        call UnitRemoveAbility(caster, 'A1E3')
        call UnitRemoveAbility(target, 'A1E3')
        call FlushChildHashtable(udg_ht, task)
        call PauseTimer(t)
        call ReleaseTimer(t)
        set t = null
        set caster = null
        set target = null
        return
    elseif i == 0 then
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
       set tx = GetUnitX(target)
      set ty = GetUnitY(target)
      if GetWidgetLife(target) >= 0.405 and GetWidgetLife(caster) >= 0.405 then
            call SetUnitX(caster, tx)
            call SetUnitY(caster, ty)
           call SetUnitX(target, ox)
           call SetUnitY(target, oy)
        endif
        call UnitRemoveAbility(caster, 'A1E3')
        call UnitRemoveAbility(target, 'A1E3')
        call IssueImmediateOrder(caster, "stop")
       call FlushChildHashtable(udg_ht, task)
       call PauseTimer(t)
       call ReleaseTimer(t)
        set t = null
       set caster = null
       set target = null
        return
   endif
    call SaveInteger(udg_ht, task, 1, i - 1)
   set t = null
   set caster = null
    set target = null
endfunction

function Trig_Komachi01_Conditions takes nothing returns boolean
    local unit u
    local unit target
    local timer t
    local integer task
    local integer level
    local unit caster
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL and GetLearnedSkill() == 'A0CK' then
        set u = GetTriggerUnit()
        if GetLearnedSkillLevel() == 1 then
            call UnitAddBonusArm(u, 2)
        else
            call UnitAddBonusArm(u, 1)
        endif
        set u = null
        return false
    endif
    set u = null
    if GetSpellAbilityId() == 'A1E2' then
        set caster = GetTriggerUnit()
        set level = GetUnitAbilityLevel(caster, 'A1E2')
        call AbilityCoolDownResetion(caster, 'A1E2', 22 - level * 2)
        set target = GetSpellTargetUnit()
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 1, 6 + level * -1)
        call SaveUnitHandle(udg_ht, task, 2, target)
        call TimerStart(t, 0.5, true, function KomachiXO01_CallBack)
        call UnitAddAbility(caster, 'A1E3')
        call UnitAddAbility(target, 'A1E3')
        set target = null
        set t = null
        set caster = null
        return false
    endif
    return GetSpellAbilityId() == 'A0CK'
endfunction

function Trig_Komachi01_BuffClear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer level = LoadInteger(udg_sht, task, 1)
    call UnitAddMaxLife(caster, -(30 + level * 30))
    call UnitAddBonusArm(caster, -1 - level)
    call UnitRemoveAbility(caster, 'A19D')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
endfunction

function Trig_Komachi01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local timer t
    local integer task
    local real ox
    local real oy
    local real px
    local real py
    local effect e1
    local effect e2
    local real angle
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 22 - 2 * level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set e1 = null
            set e2 = null
            return
        endif
    endif
    if GetUnitTypeId(target) == 'n006' then
        set caster = null
        set target = null
        set e1 = null
        set e2 = null
        return
    endif
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set target = null
        set e1 = null
        set e2 = null
        return
    endif
    set e1 = AddSpecialEffectTarget("Abilities\\Spells\\Items\\OrbCorruption\\OrbCorruptionMissile.mdl", caster, "overhead")
    set e2 = AddSpecialEffectTarget("Abilities\\Spells\\Items\\OrbCorruption\\OrbCorruptionMissile.mdl", target, "overhead")
    call TriggerSleepAction(2.0)
    if IsUnitInRange(caster, target, 3600.0) and not (IsUnitType(caster, UNIT_TYPE_DEAD) or IsUnitType(target, UNIT_TYPE_DEAD)) and GetCustomState(target, 7) != 0 == false then
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
        set px = GetUnitX(target)
        set py = GetUnitY(target)
        call SetUnitX(caster, px)
        call SetUnitY(caster, py)
        call SetUnitPosition(target, ox, oy)
        set angle = bj_RADTODEG * Atan2(oy - py, ox - px)
        call SetUnitFacing(caster, angle)
        call UnitAddMaxLife(caster, 30 + level * 30)
        call UnitAddBonusArm(caster, 1 + level)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call SaveInteger(udg_sht, task, 1, level)
        call TimerStart(t, 6.0, false, function Trig_Komachi01_BuffClear)
    endif
    call DestroyEffect(e1)
    call DestroyEffect(e2)
    set e1 = AddSpecialEffectTarget("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", caster, "origin")
    set e2 = AddSpecialEffectTarget("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", target, "origin")
    call DestroyEffect(e1)
    call DestroyEffect(e2)
    set e1 = AddSpecialEffectTarget("Komachi_Change.mdl", caster, "origin")
    set e2 = AddSpecialEffectTarget("Komachi_Change.mdl", target, "origin")
    call DestroyEffect(e1)
    call DestroyEffect(e2)
    set caster = null
    set target = null
    set e1 = null
    set e2 = null
    set t = null
endfunction

function InitTrig_Komachi01 takes nothing returns nothing
endfunction