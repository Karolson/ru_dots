function SANAE03 takes nothing returns integer
    return 'A0G6'
endfunction

function Trig_Sanae03_onPeriodicCheck takes nothing returns nothing
    if not IsUnitInRange(GetEnumUnit(), udg_Sanae, 900.0) then
        call UnitRemoveAbility(GetEnumUnit(), 'A0AC')
        call GroupRemoveUnit(udg_Sanae03OldGroup, GetEnumUnit())
    endif
endfunction

function Trig_Sanae03_onPeriodic takes nothing returns nothing
    local unit u
    local player p = GetOwningPlayer(udg_Sanae)
    call ForGroup(udg_Sanae03OldGroup, function Trig_Sanae03_onPeriodicCheck)
    if GetWidgetLife(udg_Sanae) > 0.405 then
        call GroupEnumUnitsInRange(udg_Sanae03GroupEnum, GetUnitX(udg_Sanae), GetUnitY(udg_Sanae), 900.0, null)
        loop
            set u = FirstOfGroup(udg_Sanae03GroupEnum)
        exitwhen u == null
            call GroupRemoveUnit(udg_Sanae03GroupEnum, u)
            if IsUnitType(u, UNIT_TYPE_HERO) and GetWidgetLife(u) > 0.405 and IsUnitAlly(u, p) then
                call UnitAddAbility(u, 'A0AC')
                call UnitMakeAbilityPermanent(u, true, 'A0AC')
                call SetUnitAbilityLevel(u, 'A0AC', GetUnitAbilityLevel(udg_Sanae, 'A0G6'))
                call GroupAddUnit(udg_Sanae03OldGroup, u)
            endif
        endloop
    endif
endfunction

function Trig_Sanae03_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        if GetLearnedSkill() == 'A0G6' and GetLearnedSkillLevel() == 1 then
            call UnitAddAbility(GetTriggerUnit(), 'A09C')
            call UnitMakeAbilityPermanent(GetTriggerUnit(), true, 'A09C')
            call TimerStart(CreateTimer(), 0.25, true, function Trig_Sanae03_onPeriodic)
        endif
    endif
    return false
endfunction

function Sanae03_ReAddEffect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    call UnitAddAbility(caster, 'A09C')
    call UnitMakeAbilityPermanent(caster, true, 'A09C')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
endfunction

function Sanae03_DelayedEffect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local real mpheal = LoadReal(udg_sht, task, 0)
    local player p = GetOwningPlayer(caster)
    local integer i = 0
    loop
    exitwhen i >= 12
        if udg_PlayerHeroes[i] != null and GetWidgetLife(udg_PlayerHeroes[i]) > 0.405 and IsUnitAlly(udg_PlayerHeroes[i], p) and LoadBoolean(udg_sht, StringHash("Sanae03"), GetHandleId(udg_PlayerHeroes[i])) then
            call ClearAllNegativeBuff(udg_PlayerHeroes[i], false)
            call UnitRemoveAbility(udg_PlayerHeroes[i], 'A0A1')
            call UnitRemoveAbility(udg_PlayerHeroes[i], 'A0V4')
            call UnitManaingTarget(caster, udg_PlayerHeroes[i], mpheal)
            call RemoveSavedBoolean(udg_sht, StringHash("Sanae03"), GetHandleId(udg_PlayerHeroes[i]))
        endif
        set i = i + 1
    endloop
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
    set p = null
endfunction

function Trig_Sanae03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer i = 0
    local integer level = GetUnitAbilityLevel(caster, 'A0G6')
    local player p = GetOwningPlayer(caster)
    local real mpheal
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real basicdeduce = 1.0
    local real cdtime = 68.0 - level * 8.0
    local timer t2 = CreateTimer()
    local integer task2 = GetHandleId(t2)
    call AbilityCoolDownResetion(caster, 'A0G6', cdtime)
    call UnitRemoveAbility(caster, 'A09C')
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I00H') > 0 then
        set basicdeduce = basicdeduce * 0.9
    endif
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I00E') > 0 then
        set basicdeduce = basicdeduce * 0.9
    endif
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I00B') > 0 then
        set basicdeduce = basicdeduce * 0.75
    endif
    set cdtime = basicdeduce * cdtime
    call SaveUnitHandle(udg_sht, task2, 0, caster)
    call TimerStart(t2, cdtime, false, function Sanae03_ReAddEffect)
    if level == 1 then
        set mpheal = 45.0
    elseif level == 2 then
        set mpheal = 78.0
    elseif level == 3 then
        set mpheal = 99.0
    else
        set mpheal = 108.0
    endif
    loop
    exitwhen i >= 12
        if udg_PlayerHeroes[i] != null and GetWidgetLife(udg_PlayerHeroes[i]) > 0.405 and IsUnitAlly(udg_PlayerHeroes[i], p) and IsUnitInRange(udg_PlayerHeroes[i], caster, 600.0) then
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", udg_PlayerHeroes[i], "origin"))
            call SaveBoolean(udg_sht, StringHash("Sanae03"), GetHandleId(udg_PlayerHeroes[i]), true)
        endif
        set i = i + 1
    endloop
    call SaveReal(udg_sht, task, 0, mpheal)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call TimerStart(t, 0.75, false, function Sanae03_DelayedEffect)
    set caster = null
    set p = null
    set t2 = null
endfunction

function InitTrig_Sanae03 takes nothing returns nothing
endfunction