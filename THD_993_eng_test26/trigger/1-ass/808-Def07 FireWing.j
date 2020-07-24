function Trig_Def07_FireWing_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I04G' and udg_SK_FireWing[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 0 and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer()
endfunction

function Trig_Def07_FireWing_RemoveAbi takes nothing returns nothing
    local unit u = GetEnumUnit()
    call UnitRemoveAbility(GetEnumUnit(), 'A17J')
    set u = null
endfunction

function Trig_Def07_FireWing_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer k = LoadInteger(udg_ht, task, 1)
    local player w = GetOwningPlayer(caster)
    local group m = LoadGroupHandle(udg_ht, task, 2)
    local group g = LoadGroupHandle(udg_ht, task, 3)
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call ForGroup(m, function Trig_Def07_FireWing_RemoveAbi)
    call GroupClear(m)
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I04G') == 0 then
        set udg_SK_FireWing[k] = 0
        call DebugMsg("Phoenix Wing Effect Stop")
        call DestroyGroup(m)
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        set m = null
        set g = null
        set w = null
        set v = null
        set iff = null
        return
    endif
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 600.0, iff)
    if GetWidgetLife(caster) > 0.405 then
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, 'A0ZU') > 0 == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                if GetUnitAbilityLevel(v, 'A17J') == 0 then
                    call GroupAddUnit(m, v)
                    call UnitAddAbility(v, 'A17J')
                    if GetUnitAbilityLevel(v, 'B02K') == 0 and GetUnitAbilityLevel(v, 'B01P') == 0 and GetUnitAbilityLevel(v, 'Binv') == 0 then
                        if GetUnitAbilityLevel(v, 'BUsl') == 0 then
                            call UnitMagicDamageTarget(caster, v, 40, 8)
                        endif
                    endif
                endif
            endif
        endloop
    endif
    set t = null
    set caster = null
    set m = null
    set g = null
    set w = null
    set v = null
    set iff = null
endfunction

function Trig_Def07_FireWing_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    local group m = CreateGroup()
    set udg_SK_FireWing[k] = 1
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, k)
    call SaveGroupHandle(udg_ht, task, 2, m)
    call SaveGroupHandle(udg_ht, task, 3, g)
    call TimerStart(t, 1.0, true, function Trig_Def07_FireWing_Main)
    call DebugMsg("Phoenix Wing Effect Start")
    set caster = null
    set t = null
    set m = null
    set g = null
endfunction

function InitTrig_Def07_FireWing takes nothing returns nothing
    set gg_trg_Def07_FireWing = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Def07_FireWing, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Def07_FireWing, Condition(function Trig_Def07_FireWing_Conditions))
    call TriggerAddAction(gg_trg_Def07_FireWing, function Trig_Def07_FireWing_Actions)
endfunction