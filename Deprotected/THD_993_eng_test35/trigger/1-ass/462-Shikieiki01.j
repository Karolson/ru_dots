function Trig_Shikieiki01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0B7'
endfunction

function Trig_Shikieiki01_Debuff_Degree takes unit h returns integer
    return GetUnitAbilityLevel(h, 'A0B0')
endfunction

function Trig_Shikieiki01_Debuff_Display takes unit caster, unit target returns nothing
    local string msg = GetHeroProperName(target)
    local integer degree = GetUnitAbilityLevel(target, 'A0B0')
    set msg = msg + ":|cffff0000"
    set msg = msg + udg_SK_Shikieiki_Degree[degree] + "|r"
    call DisplayTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, msg)
    set msg = null
endfunction

function Trig_Shikieiki01_Debuff_Clear takes unit caster, unit target returns nothing
    if IsUnitIllusion(target) or not IsUnitType(target, UNIT_TYPE_HERO) then
        set caster = null
        set target = null
        return
    endif
    call SaveInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 1, LoadInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 0))
    call UnitRemoveAbility(target, 'A0B0')
    call Trig_Shikieiki01_Debuff_Display(caster, target)
    call Trig_Shikieiki01_Debuff_Display(target, target)
    set caster = null
    set target = null
endfunction

function Trig_Shikieiki01_Debuff_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer d = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 1)
    local integer level
    if LoadInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 2) != 0 then
        call SaveInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 2, LoadInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 2) - 1)
    elseif d > i then
        set level = GetUnitAbilityLevel(target, 'A0B0')
        if level > 1 then
            call SetUnitAbilityLevel(target, 'A0B0', level - 1)
        else
            call UnitRemoveAbility(target, 'A0B0')
        endif
        call Trig_Shikieiki01_Debuff_Display(caster, target)
        call Trig_Shikieiki01_Debuff_Display(target, target)
    endif
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Shikieiki01_Debuff_Add takes unit caster, unit target, real bufftime returns nothing
    local timer t
    local integer task
    if IsUnitIllusion(target) or not IsUnitType(target, UNIT_TYPE_HERO) then
        set t = null
        set caster = null
        set target = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    if HaveSavedInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 0) then
        call SaveInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 0, LoadInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 0) + 1)
    else
        call SaveInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 0, 1)
        call SaveInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 1, 0)
        call SaveInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 2, 0)
    endif
    if GetUnitAbilityLevel(target, 'A0B0') <= 0 then
        call UnitAddAbility(target, 'A0B0')
        call UnitMakeAbilityPermanent(target, true, 'A0B0')
    else
        if GetUnitAbilityLevel(target, 'A0B0') < 10 then
            call SetUnitAbilityLevel(target, 'A0B0', GetUnitAbilityLevel(target, 'A0B0') + 1)
        else
            call SaveInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 2, LoadInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 2) + 1)
        endif
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 2, LoadInteger(udg_SK_Shikieiki_Count, GetHandleId(target), 0))
    call TimerStart(t, bufftime, false, function Trig_Shikieiki01_Debuff_Fade)
    call Trig_Shikieiki01_Debuff_Display(caster, target)
    call Trig_Shikieiki01_Debuff_Display(target, target)
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Shikieiki01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local integer level = GetUnitAbilityLevel(caster, 'A0B7')
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, 'A0B7', 12 - 2 * level)
    else
        call AbilityCoolDownResetion(caster, 'A0B7', (12 - 2 * level) * 0.65)
    endif
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set u = null
            return
        endif
    endif
    set u = NewDummy(GetOwningPlayer(caster), tx - 5.0, ty, 0.0)
    call UnitAddAbility(u, 'A0B8')
    call IssuePointOrder(u, "breathoffrost", tx, ty)
    call UnitRemoveAbility(u, 'A0B8')
    call ReleaseDummy(u)
    if IsUnitType(target, UNIT_TYPE_HERO) then
        call Trig_Shikieiki01_Debuff_Add(caster, target, 330.0)
    endif
    if GetUnitAbilityLevel(caster, 'A0I1') == 0 then
        call UnitAddAbility(caster, 'A0I1')
        call UnitMakeAbilityPermanent(caster, true, 'A0I1')
    endif
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Shikieiki01 takes nothing returns nothing
endfunction