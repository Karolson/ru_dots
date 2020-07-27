function Trig_Cirno04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0MW'
endfunction

function Trig_Cirno04_Filter takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), bj_groupEnumOwningPlayer) and GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(GetFilterUnit(), 'B04B') == 0 and GetUnitAbilityLevel(GetFilterUnit(), 'BOvc') == 0 and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') == 0 and not IsUnitType(GetFilterUnit(), UNIT_TYPE_ANCIENT)
endfunction

function Trig_Cirno04_Taunt_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer count = LoadInteger(udg_sht, task, 0)
    local integer threshold = LoadInteger(udg_sht, task, 1)
    local integer level = LoadInteger(udg_sht, task, 2)
    local real ox = GetUnitX(udg_SK_Cirno_Cirno)
    local real oy = GetUnitY(udg_SK_Cirno_Cirno)
    local real ranX = GetRandomReal(-500, 500)
    local real ranY = GetRandomReal(-500, 500)
    local unit target = LoadUnitHandle(udg_sht, task, 2)
    call SelectUnit(target, false)
    call IssueTargetOrder(target, "attack", udg_SK_Cirno_Cirno)
    if count / 15 * 15 == count then
        call UnitMagicDamageArea(udg_SK_Cirno_Cirno, ox + ranX, oy + ranY, 250, 30 * level + 0.03 * GetUnitState(udg_SK_Cirno_Cirno, UNIT_STATE_MAX_LIFE), 5)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", ox + ranX, oy + ranY))
    endif
    set count = count + 1
    if count > threshold or GetUnitCurrentOrder(udg_SK_Cirno_Cirno) != OrderId("starfall") then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
    else
        call SaveInteger(udg_sht, task, 0, count)
    endif
    set t = null
    set target = null
endfunction

function Trig_Cirno04_Taunt takes nothing returns nothing
    local unit target = GetEnumUnit()
    local integer count = LoadInteger(udg_sht, StringHash("Cirno04"), 0)
    local group taunted = LoadGroupHandle(udg_sht, StringHash("Cirno04"), 1)
    local real duration
    local timer t
    local integer task
    if IsUnitInGroup(target, taunted) == false then
        call SelectUnit(target, false)
        call IssueTargetOrder(target, "attack", udg_SK_Cirno_Cirno)
        call GroupAddUnit(taunted, target)
        if IsUnitType(target, UNIT_TYPE_HERO) then
            set duration = RMinBJ(1.0 + GetHeroInt(target, true) * 0.0444, 5.0 - 0.02 * count)
        else
            set duration = RMinBJ(1.0, 5.0 - 0.02 * count)
        endif
        set duration = DebuffDuration(target, duration)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveInteger(udg_sht, task, 0, 1)
        call SaveInteger(udg_sht, task, 1, R2I(duration * 50))
        call SaveUnitHandle(udg_sht, task, 2, target)
        call TimerStart(t, 0.02, true, function Trig_Cirno04_Taunt_Main)
    endif
    set target = null
    set taunted = null
    set t = null
endfunction

function Trig_Cirno04_Duration takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit cirno = LoadUnitHandle(udg_sht, task, 0)
    local integer count = LoadInteger(udg_sht, task, 1)
    local integer level = LoadInteger(udg_sht, task, 2)
    local group taunted = LoadGroupHandle(udg_sht, task, 3)
    local effect ice = LoadEffectHandle(udg_sht, task, 4)
    local boolexpr filter = LoadBooleanExprHandle(udg_sht, task, 6)
    local group newtaunt = LoadGroupHandle(udg_sht, task, 5)
    call SaveInteger(udg_sht, StringHash("Cirno04"), 0, count)
    set bj_groupEnumOwningPlayer = GetOwningPlayer(cirno)
    call GroupEnumUnitsInRange(newtaunt, GetUnitX(cirno), GetUnitY(cirno), 250 + 50 * level, filter)
    set bj_groupEnumOwningPlayer = null
    call ForGroup(newtaunt, function Trig_Cirno04_Taunt)
    set count = count + 1
    if count > 250 or GetUnitCurrentOrder(udg_SK_Cirno_Cirno) != OrderId("starfall") then
        call DestroyEffect(ice)
        call UnitRemoveAbility(cirno, 'A0C6')
        call ReleaseTimer(t)
        call DestroyGroup(taunted)
        call DestroyGroup(newtaunt)
        call DestroyBoolExpr(filter)
        call FlushChildHashtable(udg_sht, task)
        call FlushChildHashtable(udg_sht, StringHash("Cirno04"))
    else
        call SaveInteger(udg_sht, task, 1, count)
    endif
    set filter = null
    set newtaunt = null
    set taunted = null
    set ice = null
    set t = null
    set cirno = null
endfunction

function Trig_Cirno04_Actions takes nothing returns nothing
    local group newtaunt = CreateGroup()
    local group taunted = CreateGroup()
    local unit cirno = GetTriggerUnit()
    local boolexpr filter = Filter(function Trig_Cirno04_Filter)
    local integer level = GetUnitAbilityLevel(cirno, 'A0MW')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer count = 0
    local effect e = AddSpecialEffect("Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl", GetUnitX(cirno), GetUnitY(cirno))
    local effect ice = AddSpecialEffectTarget("FreezingBreathTargetArt.mdx", cirno, "origin")
    call AbilityCoolDownResetion(cirno, 'A0MW', 129 - level * 10)
    call VE_Spellcast(cirno)
    call UnitAddAbility(cirno, 'A0C6')
    call CastSpell(cirno, "I'm not dumb! YOU are all stupid!")
    call SaveInteger(udg_sht, StringHash("Cirno04"), 0, count)
    call SaveGroupHandle(udg_sht, StringHash("Cirno04"), 1, taunted)
    set bj_groupEnumOwningPlayer = GetOwningPlayer(cirno)
    call GroupEnumUnitsInRange(newtaunt, GetUnitX(cirno), GetUnitY(cirno), 350 + 50 * level, filter)
    call ForGroup(newtaunt, function Trig_Cirno04_Taunt)
    set count = count + 1
    call SaveUnitHandle(udg_sht, task, 0, cirno)
    call SaveInteger(udg_sht, task, 1, count)
    call SaveInteger(udg_sht, task, 2, level)
    call SaveGroupHandle(udg_sht, task, 3, taunted)
    call SaveEffectHandle(udg_sht, task, 4, ice)
    call SaveGroupHandle(udg_sht, task, 5, newtaunt)
    call SaveBooleanExprHandle(udg_sht, task, 6, filter)
    call TimerStart(t, 0.02, true, function Trig_Cirno04_Duration)
    call DestroyEffect(e)
    set filter = null
    set newtaunt = null
    set taunted = null
    set cirno = null
    set t = null
    set e = null
    set ice = null
endfunction

function InitTrig_Cirno04 takes nothing returns nothing
endfunction