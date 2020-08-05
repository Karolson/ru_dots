function s__Flandre2_01_create takes unit caster returns integer
    local timer t = CreateTimer()
    call SaveUnitHandle(udg_sht, GetHandleId(t), 0, caster)
    call TimerStart(t, 1.0, false, function sc__Flandre2_01_countIllusion)
    set caster = null
    return 0
endfunction

function s__Flandre2_01_onDestory takes nothing returns nothing
endfunction

function s__Flandre2_01_countIllusion takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local timer t2
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    local group g = CreateGroup()
    local unit tmpunit
    local integer id = GetUnitTypeId(caster)
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set tmpunit = FirstOfGroup(g)
    exitwhen tmpunit == null
        call GroupRemoveUnit(g, tmpunit)
        if GetUnitTypeId(tmpunit) == id and IsUnitIllusion(tmpunit) then
            call GroupAddUnit(udg_s__Flandre2_01_IllusionGroup, tmpunit)
            set t2 = CreateTimer()
            call SaveUnitHandle(udg_sht, GetHandleId(t2), 0, tmpunit)
            call TimerStart(t2, 10.5, false, function sc__Flandre2_01_RemoveIllusionFromGroup)
        endif
    endloop
    call DestroyGroup(g)
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    set t = null
    set t2 = null
    set caster = null
    set g = null
    set tmpunit = null
endfunction

function s__Flandre2_01_RemoveIllusionFromGroup takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit v = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    call GroupRemoveUnit(udg_s__Flandre2_01_IllusionGroup, v)
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    set t = null
    set v = null
endfunction

function s__Flandre2_01_trg_onAttack takes nothing returns boolean
    local unit s = GetEventDamageSource()
    local unit d = GetTriggerUnit()
    local real damage = GetEventDamage()
    if IsDamageNotUnitAttack(s) or damage == 0 then
        set s = null
        set d = null
        return false
    endif
    if IsUnitType(s, UNIT_TYPE_STRUCTURE) and IsUnitInGroup(d, udg_s__Flandre2_01_IllusionGroup) then
        call UnitAbsDamageTarget(s, d, damage * 3.0)
    elseif IsUnitType(d, UNIT_TYPE_STRUCTURE) and IsUnitInGroup(s, udg_s__Flandre2_01_IllusionGroup) then
        call SetUnitState(d, UNIT_STATE_LIFE, RMinBJ(GetUnitState(d, UNIT_STATE_MAX_LIFE), GetUnitState(d, UNIT_STATE_LIFE) + damage))
    endif
    set s = null
    set d = null
    return true
endfunction

function s__Flandre2_02_create takes unit caster, unit target returns integer
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer lvl = GetUnitAbilityLevel(caster, udg_Flandre2__FLANDRE2_02)
    local real a
    local real damage
    local real dx = GetUnitX(caster) - GetUnitX(target)
    local real dy = GetUnitY(caster) - GetUnitY(target)
    local real dis = SquareRoot(dx * dx + dy * dy)
    local unit dummy
    set a = Atan2(GetUnitY(target) - GetUnitY(caster), GetUnitX(target) - GetUnitX(caster))
    loop
    exitwhen dis < 30
        call AddTimedEffectToPoint(GetUnitX(caster) + dis * Cos(a), GetUnitY(caster) + dis * Sin(a), 1, "Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl")
        set dis = dis - 60
    endloop
    call UnitSlowTarget(caster, target, udg_Flandre2__FLANDRE2_02_SLOW_DURATION, 'A1EL', 'B012')
    set dummy = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0.0)
    call UnitAddAbility(dummy, 'A1EM')
    set damage = GetUnitAttack(caster) * 1.2
    call UnitMagicDamageTarget(caster, target, damage, 1)
    call SetUnitState(caster, UNIT_STATE_LIFE, RMinBJ(GetUnitState(caster, UNIT_STATE_MAX_LIFE), GetUnitState(caster, UNIT_STATE_LIFE)) + damage)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveUnitHandle(udg_sht, task, 1, target)
    call SaveInteger(udg_sht, task, 2, IMinBJ(4, lvl))
    call SaveReal(udg_sht, task, 3, udg_Flandre2__FLANDRE2_02_SLOW_DURATION)
    call SaveUnitHandle(udg_sht, task, 4, dummy)
    call TimerStart(t, 0.1, true, function sc__Flandre2_02_onSlow)
    set t = null
    set caster = null
    set target = null
    set dummy = null
    return 0
endfunction

function s__Flandre2_02_onDestory takes nothing returns nothing
endfunction

function s__Flandre2_02_onSlow takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local integer lvl = LoadInteger(udg_sht, task, 2)
    local real duration = LoadReal(udg_sht, task, 3) - 0.1
    local unit dummy = LoadUnitHandle(udg_sht, task, 4)
    local real dx = GetUnitX(caster) - GetUnitX(target)
    local real dy = GetUnitY(caster) - GetUnitY(target)
    local real dis = SquareRoot(dx * dx + dy * dy)
    local integer id
    call SaveReal(udg_sht, task, 3, duration)
    set id = 'A1EL'
    if dis <= udg_Flandre2__FLANDRE2_02_DOUBLE_SLOW_RANGE and GetUnitAbilityLevel(target, id) > 0 then
        call DebugMsg("DOUBLE SLOW")
        call IssueTargetOrder(dummy, "slow", target)
    endif
    if duration <= 0.0 or IsUnitDeadBJ(target) or GetUnitAbilityLevel(target, id) == 0 then
        call RemoveSavedHandle(udg_sht, task, 0)
        call RemoveSavedHandle(udg_sht, task, 1)
        call RemoveSavedInteger(udg_sht, task, 2)
        call RemoveSavedReal(udg_sht, task, 3)
        call RemoveSavedHandle(udg_sht, task, 4)
        call UnitRemoveAbility(dummy, 'A1EM')
        call ReleaseDummy(dummy)
        call ReleaseTimer(t)
    endif
    set t = null
    set caster = null
    set target = null
    set dummy = null
endfunction

function s__Flandre2_02_trg_onAttack takes nothing returns boolean
    local unit s = GetEventDamageSource()
    local unit d = GetTriggerUnit()
    local integer lvl = GetUnitAbilityLevel(s, udg_Flandre2__FLANDRE2_02)
    local real damage
    if lvl < 1 or IsUnitType(d, UNIT_TYPE_STRUCTURE) then
        set s = null
        set d = null
        return false
    endif
    if IsDamageNotUnitAttack(s) or IsUnitAlly(d, GetOwningPlayer(s)) or GetEventDamage() == 0 then
        set s = null
        set d = null
        return false
    endif
    set damage = GetUnitState(d, UNIT_STATE_MAX_LIFE) * (udg_Flandre2__FLANDRE2_02_ATTACK_DAMAGE_BASE + lvl * udg_Flandre2__FLANDRE2_02_ATTACK_DAMAGE_SCALC) * 0.01
    if IsUnitIllusion(s) then
        set damage = damage * 0.2
    endif
    call UnitPhysicalDamageTarget(s, d, damage)
    set s = null
    set d = null
    return false
endfunction

function s__Flandre2_03_create takes unit caster returns integer
    local boolexpr f = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer lvl = GetUnitAbilityLevel(caster, udg_Flandre2__FLANDRE2_03)
    local integer lvl02 = GetUnitAbilityLevel(caster, udg_Flandre2__FLANDRE2_02)
    local group g = CreateGroup()
    local group damageg = CreateGroup()
    local unit tmpunit
    local unit v
    local real damage
    local real damage02
    local integer id = GetUnitTypeId(caster)
    call ClearAllNegativeBuff(caster, false)
    set damage = udg_Flandre2__FLANDRE2_03_DAMAGE_BASE + lvl * udg_Flandre2__FLANDRE2_03_DAMAGE_SCALC
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set tmpunit = FirstOfGroup(g)
    exitwhen tmpunit == null
        call GroupRemoveUnit(g, tmpunit)
        if GetUnitTypeId(tmpunit) == id then
            call GroupEnumUnitsInRange(damageg, GetUnitX(tmpunit), GetUnitY(tmpunit), udg_Flandre2__FLANDRE2_03_RANGE, f)
            if IsUnitIllusion(tmpunit) then
                loop
                    set v = FirstOfGroup(damageg)
                exitwhen v == null
                    call GroupRemoveUnit(damageg, v)
                    call UnitMagicDamageTarget(tmpunit, v, damage * 0.5, 1)
                endloop
            else
                loop
                    set v = FirstOfGroup(damageg)
                exitwhen v == null
                    call GroupRemoveUnit(damageg, v)
                    call UnitMagicDamageTarget(tmpunit, v, damage, 1)
                    if lvl02 > 0 then
                        set damage02 = GetUnitState(v, UNIT_STATE_MAX_LIFE) * (udg_Flandre2__FLANDRE2_02_ATTACK_DAMAGE_BASE + lvl02 * udg_Flandre2__FLANDRE2_02_ATTACK_DAMAGE_SCALC) * 0.01
                        call UnitPhysicalDamageTarget(tmpunit, v, damage02)
                        call DebugMsg("Skill02 Damage : " + R2S(damage02))
                        call DebugMsg("Skill03 Damage : " + R2S(damage))
                    endif
                endloop
            endif
        endif
    endloop
    call DestroyGroup(g)
    call DestroyGroup(damageg)
    set f = null
    set g = null
    set damageg = null
    set v = null
    set tmpunit = null
    set caster = null
    return 0
endfunction

function s__Flandre2_03_onDestory takes nothing returns nothing
endfunction

function s__Flandre2_04_create takes unit caster returns integer
    local integer lvl = GetUnitAbilityLevel(caster, udg_Flandre2__FLANDRE2_04)
    local integer ctask = GetHandleId(caster)
    local timer t
    local effect e1
    local effect e2
    local group g
    local unit tmpunit
    local integer i = 0
    local integer id = GetUnitTypeId(caster)
    local integer playerId = StringHash("Player" + I2S(GetPlayerId(GetOwningPlayer(caster))))
    if HaveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04Timer")) then
        set t = LoadTimerHandle(udg_sht, playerId, StringHash("Flandre2_04Timer"))
        call TimerStart(t, 0.0, false, function sc__Flandre2_04_onClear)
        set t = null
    endif
    set g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set tmpunit = FirstOfGroup(g)
    exitwhen tmpunit == null
        call GroupRemoveUnit(g, tmpunit)
        if GetUnitTypeId(tmpunit) == id and IsUnitIllusion(tmpunit) then
            call KillUnit(tmpunit)
            set i = i + 1
        endif
    endloop
    call DestroyGroup(g)
    call SaveInteger(udg_sht, playerId, StringHash("Flandre2_04"), i)
    set e1 = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\TrollBerserk\\HeadhunterWEAPONSRight.mdl", caster, "hand left")
    set e2 = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\TrollBerserk\\HeadhunterWEAPONSLeft.mdl", caster, "hand left")
    set t = CreateTimer()
    call SaveUnitHandle(udg_sht, GetHandleId(t), 0, caster)
    call TimerStart(t, udg_Flandre2__FLANDRE2_04_DURATION, false, function sc__Flandre2_04_onClear)
    call SaveUnitHandle(udg_sht, playerId, StringHash("Flandre2_04caster"), caster)
    call SaveEffectHandle(udg_sht, playerId, StringHash("Flandre2_04Effect01"), e1)
    call SaveEffectHandle(udg_sht, playerId, StringHash("Flandre2_04Effect02"), e2)
    call SaveTimerHandle(udg_sht, playerId, StringHash("Flandre2_04Timer"), t)
    call SaveInteger(udg_sht, playerId, StringHash("Flandre2_04level"), lvl)
    if udg_s__Flandre2_04_AttackTrgUse == 0 then
        set udg_s__Flandre2_04_AttackTrgUse = 1
        call EnableTrigger(udg_s__Flandre2_04_trgAttack)
    else
        set udg_s__Flandre2_04_AttackTrgUse = udg_s__Flandre2_04_AttackTrgUse + 1
    endif
    set e1 = null
    set e2 = null
    set t = null
    set g = null
    set tmpunit = null
    return 0
endfunction

function s__Flandre2_04_onDestory takes nothing returns nothing
endfunction

function s__Flandre2_04_onClear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    local integer playerId = StringHash("Player" + I2S(GetPlayerId(GetOwningPlayer(caster))))
    local effect e1 = LoadEffectHandle(udg_sht, playerId, StringHash("Flandre2_04Effect01"))
    local effect e2 = LoadEffectHandle(udg_sht, playerId, StringHash("Flandre2_04Effect02"))
    local group g
    local unit tmpunit
    call DebugMsg("Clear Skill04")
    call DestroyEffect(e1)
    call DestroyEffect(e2)
    call RemoveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04"))
    call RemoveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04level"))
    call RemoveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04caster"))
    call RemoveSavedHandle(udg_sht, playerId, StringHash("Flandre2_04Timer"))
    call RemoveSavedHandle(udg_sht, playerId, StringHash("Flandre2_04Effect01"))
    call RemoveSavedHandle(udg_sht, playerId, StringHash("Flandre2_04Effect02"))
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    set udg_s__Flandre2_04_AttackTrgUse = udg_s__Flandre2_04_AttackTrgUse - 1
    if udg_s__Flandre2_04_AttackTrgUse <= 0 then
        call DisableTrigger(udg_s__Flandre2_04_trgAttack)
    endif
    call ReleaseTimer(t)
    set t = null
    set e1 = null
    set e2 = null
    set caster = null
    set g = null
    set tmpunit = null
endfunction

function s__Flandre2_04_trg_onAttack_Conditions takes nothing returns boolean
    local unit s = GetEventDamageSource()
    local unit d = GetTriggerUnit()
    local integer playerId = StringHash("Player" + I2S(GetPlayerId(GetOwningPlayer(s))))
    if not HaveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04")) then
        set s = null
        set d = null
        return false
    endif
    if IsUnitAlly(d, GetOwningPlayer(s)) or not IsUnitType(d, UNIT_TYPE_HERO) or IsUnitIllusion(s) or IsDamageNotUnitAttack(s) or GetEventDamage() == 0 or IsUnitType(d, UNIT_TYPE_STRUCTURE) then
        set s = null
        set d = null
        return false
    endif
    set s = null
    set d = null
    return true
endfunction

function s__Flandre2_04_trg_onAttack_Action takes nothing returns nothing
    local unit s = GetEventDamageSource()
    local unit d = GetTriggerUnit()
    local integer playerId = StringHash("Player" + I2S(GetPlayerId(GetOwningPlayer(s))))
    local unit caster = LoadUnitHandle(udg_sht, playerId, StringHash("Flandre2_04caster"))
    local timer t
    local integer num = LoadInteger(udg_sht, playerId, StringHash("Flandre2_04"))
    local integer lvl = LoadInteger(udg_sht, playerId, StringHash("Flandre2_04level"))
    local real damage
    local real attack = GetUnitAttack(caster)
    set damage = udg_Flandre2__FLANDRE2_04_DAMAGE_BASE + udg_Flandre2__FLANDRE2_04_DAMAGE_SCALC * lvl
    set damage = damage + attack * (udg_Flandre2__FLANDRE2_04_DAMAGE_BONUS_ATTACK_BASE + udg_Flandre2__FLANDRE2_04_DAMAGE_BONUS_ATTACK_SCALC * lvl)
    set damage = damage + attack * num * (udg_Flandre2__FLANDRE2_04_DAMAGE_BONUS_ILLUSION_BASE + udg_Flandre2__FLANDRE2_04_DAMAGE_BONUS_ILLUSION_SCALC * lvl)
    call UnitPhysicalDamageTarget(s, d, damage)
    call DebugMsg("Skill04 damage :  " + R2S(damage))
    set t = LoadTimerHandle(udg_sht, playerId, StringHash("Flandre2_04Timer"))
    call TimerStart(t, 0.0, false, function s__Flandre2_04_onClear)
    if GetUnitState(d, UNIT_STATE_LIFE) < GetEventDamage() then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", GetUnitX(d), GetUnitY(d)))
        set lvl = GetUnitAbilityLevel(s, udg_Flandre2__FLANDRE2_04)
        call UnitRemoveAbility(s, udg_Flandre2__FLANDRE2_04)
        call UnitAddAbility(s, udg_Flandre2__FLANDRE2_04)
        call SetUnitAbilityLevel(s, udg_Flandre2__FLANDRE2_04, lvl)
    else
        call UnitAddAbility(d, udg_Flandre2__FLANDRE2_04_DEBUFF)
        call UnitMakeAbilityPermanent(d, TRUE, udg_Flandre2__FLANDRE2_04_DEBUFF)
        set t = CreateTimer()
        call SaveTimerHandle(udg_ht, GetHandleId(d), StringHash("Flandre2_04TargetTimer"), t)
        call SaveUnitHandle(udg_sht, GetHandleId(t), 0, caster)
        call SaveUnitHandle(udg_sht, GetHandleId(t), 1, d)
        call TimerStart(t, udg_Flandre2__FLANDRE2_04_CHECK_TARGET_LIFE_DURATION, false, function sc__Flandre2_04_onClearTargetDebuff)
        if udg_s__Flandre2_04_DeathTrgUse == 0 then
            set udg_s__Flandre2_04_DeathTrgUse = 1
            call EnableTrigger(udg_s__Flandre2_04_trgDeath)
        else
            set udg_s__Flandre2_04_DeathTrgUse = udg_s__Flandre2_04_DeathTrgUse + 1
        endif
    endif
    set s = null
    set d = null
    set t = null
    set caster = null
endfunction

function s__Flandre2_04_trg_onDeath_Conditions takes nothing returns boolean
    local unit target = GetTriggerUnit()
    if GetUnitAbilityLevel(target, udg_Flandre2__FLANDRE2_04_DEBUFF) == 0 or not HaveSavedHandle(udg_ht, GetHandleId(target), StringHash("Flandre2_04TargetTimer")) then
        set target = null
        return false
    endif
    set target = null
    return true
endfunction

function s__Flandre2_04_trg_onDeath_Action takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local unit target = GetTriggerUnit()
    local unit caster
    local timer t
    local integer lvl
    call DebugMsg("Skill 04 ResetCD")
    set t = LoadTimerHandle(udg_ht, GetHandleId(target), StringHash("Flandre2_04TargetTimer"))
    set caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", GetUnitX(target), GetUnitY(target)))
    set lvl = GetUnitAbilityLevel(caster, udg_Flandre2__FLANDRE2_04)
    call UnitRemoveAbility(caster, udg_Flandre2__FLANDRE2_04)
    call UnitAddAbility(caster, udg_Flandre2__FLANDRE2_04)
    call SetUnitAbilityLevel(caster, udg_Flandre2__FLANDRE2_04, lvl)
    call TimerStart(t, 0.0, false, function sc__Flandre2_04_onClearTargetDebuff)
    set trg = null
    set caster = null
    set target = null
    set t = null
endfunction

function s__Flandre2_04_onClearTargetDebuff takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    call DebugMsg("Clear Target Debuff")
    call UnitRemoveAbility(target, udg_Flandre2__FLANDRE2_04_DEBUFF)
    call ReleaseTimer(t)
    call RemoveSavedHandle(udg_sht, task, 0)
    call RemoveSavedHandle(udg_sht, task, 1)
    call RemoveSavedHandle(udg_sht, GetHandleId(target), StringHash("Flandre2_04TargetTimer"))
    call FlushChildHashtable(udg_sht, task)
    set udg_s__Flandre2_04_DeathTrgUse = udg_s__Flandre2_04_DeathTrgUse - 1
    if udg_s__Flandre2_04_DeathTrgUse <= 0 then
        call DisableTrigger(udg_s__Flandre2_04_trgDeath)
    endif
    set t = null
    set target = null
endfunction

function Flandre2__Skill takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(caster, id)
    call DebugMsg("skill open")
    if id == udg_Flandre2__FLANDRE2_01 then
        call DebugMsg("skill 01 open")
        call s__Flandre2_01_create(caster)
    elseif id == udg_Flandre2__FLANDRE2_02 then
        call DebugMsg("skill 02 open")
        call s__Flandre2_02_create(caster, target)
    elseif id == udg_Flandre2__FLANDRE2_03 then
        call DebugMsg("skill 03 open")
        call s__Flandre2_03_create(caster)
    elseif id == udg_Flandre2__FLANDRE2_04 and GetUnitTypeId(caster) != udg_Flandre2__FLANDRE2_04_UNIT_TYPEID then
        call DebugMsg("skill 04 open")
        call s__Flandre2_04_create(caster)
    endif
    set caster = null
    set target = null
    return false
endfunction

function Flandre2_Init takes unit hero returns nothing
    local trigger SkillTrg = CreateTrigger()
    call DebugMsg("Flandre Register Trigger!")
    call TriggerAddCondition(SkillTrg, Condition(function Flandre2__Skill))
    call TriggerRegisterUnitEvent(SkillTrg, hero, EVENT_UNIT_SPELL_EFFECT)
    if udg_Flandre2__IsInitSkill == false then
        set udg_Flandre2__IsInitSkill = true
        set udg_s__Flandre2_01_IllusionGroup = CreateGroup()
        set udg_s__Flandre2_01_trgAttack = CreateTrigger()
        call TriggerAddCondition(udg_s__Flandre2_01_trgAttack, Condition(function s__Flandre2_01_trg_onAttack))
        call RegisterAnyUnitDamage(udg_s__Flandre2_01_trgAttack)
        set udg_s__Flandre2_02_trgAttack = CreateTrigger()
        call TriggerAddCondition(udg_s__Flandre2_02_trgAttack, Condition(function s__Flandre2_02_trg_onAttack))
        call RegisterAnyUnitDamage(udg_s__Flandre2_02_trgAttack)
        set udg_s__Flandre2_04_trgAttack = CreateTrigger()
        set udg_s__Flandre2_04_AttackTrgUse = 0
        call TriggerAddCondition(udg_s__Flandre2_04_trgAttack, Condition(function s__Flandre2_04_trg_onAttack_Conditions))
        call TriggerAddAction(udg_s__Flandre2_04_trgAttack, function s__Flandre2_04_trg_onAttack_Action)
        call RegisterAnyUnitDamage(udg_s__Flandre2_04_trgAttack)
        call DisableTrigger(udg_s__Flandre2_04_trgAttack)
        set udg_s__Flandre2_04_trgDeath = CreateTrigger()
        set udg_s__Flandre2_04_DeathTrgUse = 0
        call TriggerAddCondition(udg_s__Flandre2_04_trgDeath, Condition(function s__Flandre2_04_trg_onDeath_Conditions))
        call TriggerAddAction(udg_s__Flandre2_04_trgDeath, function s__Flandre2_04_trg_onDeath_Action)
        call TriggerRegisterAnyUnitEventBJ(udg_s__Flandre2_04_trgDeath, EVENT_PLAYER_UNIT_DEATH)
        call DisableTrigger(udg_s__Flandre2_04_trgDeath)
    endif
    call SetHeroLifeIncreaseValue(hero, 10)
    call SetHeroManaIncreaseValue(hero, 8)
    call SetHeroManaBaseRegenValue(hero, 0.4)
    set SkillTrg = null
endfunction

function Trig_Initial_Flandre22_Actions takes nothing returns nothing
    call Flandre2_Init(GetCharacterHandle(udg_FLANDRE2_CODE))
    call FirstAbilityInit('A062')
    call FirstAbilityInit('A0EI')
    call FirstAbilityInit('A0EJ')
    call FirstAbilityInit('A0EK')
    call FirstAbilityInit('A0EQ')
    call FirstAbilityInit('A1EL')
    call FirstAbilityInit('A1EM')
endfunction

function InitTrig_Initial_Flandre2 takes nothing returns nothing
    set gg_trg_Initial_Flandre2 = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Flandre2, function Trig_Initial_Flandre22_Actions)
endfunction