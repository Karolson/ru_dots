function Trig_UtsuhoCD takes unit caster returns real
    if GetUnitAbilityLevel(caster, 'A076') == 1 then
        return 0.98
    elseif GetUnitAbilityLevel(caster, 'A076') == 2 then
        return 0.96
    elseif GetUnitAbilityLevel(caster, 'A076') == 3 then
        return 0.92
    elseif GetUnitAbilityLevel(caster, 'A076') == 4 then
        return 0.84
    endif
    return 1.0
endfunction

function Trig_Utsuho01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0QN'
endfunction

function Trig_Utsuho01_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit target = LoadUnitHandle(udg_ht, task, 6)
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer count = LoadInteger(udg_ht, task, 5)
    local real damageA
    local real damageB
    set damageA = (15 + level * 10 + 0.02 * GetUnitState(caster, UNIT_STATE_MAX_LIFE)) / 4
    set damageB = (15 + level * 10 + 0.8 * GetHeroInt(caster, true)) / 4
    call UnitMagicDamageArea(caster, GetUnitX(target), GetUnitY(target), 250, damageB, 6)
    call SaveInteger(udg_ht, task, 5, count + 1)
    if count == 3 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Utsuho01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local integer task
    local real damageA
    local real damageB
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), (17 - 2 * level) * Trig_UtsuhoCD(caster))
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call UnitDebuffTarget(caster, target, 3.1, 1, true, 'A074', level, 'B01E', "acidbomb", 0, "")
    set t = CreateTimer()
    set task = GetHandleId(t)
    set damageA = 45 + level * 50 + 0.065 * GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    set damageB = 45 + level * 50 + 2.0 * GetHeroInt(caster, true)
    call UnitMagicDamageTarget(caster, target, damageB, 1)
    set damageA = (20 + level * 15 + 0.021 * GetUnitState(caster, UNIT_STATE_MAX_LIFE)) / 4
    set damageB = (20 + level * 15 + 0.8 * GetHeroInt(caster, true)) / 4
    call UnitMagicDamageArea(caster, GetUnitX(target), GetUnitY(target), 250, damageB, 6)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveReal(udg_ht, task, 3, GetUnitX(target))
    call SaveReal(udg_ht, task, 4, GetUnitY(target))
    call SaveInteger(udg_ht, task, 5, 0)
    call SaveUnitHandle(udg_ht, task, 6, target)
    call TimerStart(t, 1, true, function Trig_Utsuho01_Damage)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Utsuho01 takes nothing returns nothing
endfunction