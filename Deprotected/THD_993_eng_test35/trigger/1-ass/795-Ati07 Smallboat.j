function RemoveSkill takes unit u, boolean k returns nothing
    if GetUnitAbilityLevel(u, 'A09S') >= 1 then
        call UnitRemoveAbility(u, 'A09S')
    endif
    if GetUnitAbilityLevel(u, 'A0QB') >= 2 then
        call SetUnitAbilityLevel(u, 'A0QB', 1)
    endif
    if k then
        call UnitRemoveAbility(u, 'A0R4')
    endif
    call SaveInteger(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("SkillLevel"), 0)
    call SaveReal(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("DamAll"), 0)
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Cancel")
    return
endfunction

function TimerOut takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_Hashtable, StringHash("Unit" + I2S(GetHandleId(t))), StringHash("u"))
    call ReleaseTimer(t)
    call RemoveSkill(u, false)
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Finish")
    set t = null
    set u = null
endfunction

function GetDamFunc takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local real damnow = GetEventDamage()
    local real damall = LoadReal(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("DamAll"))
    local integer lv = LoadInteger(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("SkillLevel"))
    local timer t = LoadTimerHandle(udg_Hashtable, StringHash("Timer" + I2S(GetHandleId(u))), StringHash("t"))
    if GetInventoryIndexOfItemType(u, 'I04Q') > 0 then
        if damnow > 0.0 then
            set damall = damall + damnow
            if damall > 300 then
                set damall = damall - 300
                set lv = lv + 1
                call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Critical chance:" + I2S(IMinBJ(5, lv)))
                if lv == 1 then
                    call UnitMakeAbilityPermanent(u, true, 'A0QB')
                    call SetUnitAbilityLevel(u, 'A0QB', 2)
                else
                    call SetUnitAbilityLevel(u, 'A0QB', IMinBJ(6, lv + 1))
                endif
                call ReleaseTimer(t)
                call FlushChildHashtable(udg_Hashtable, StringHash("Timer" + I2S(GetHandleId(u))))
                call FlushChildHashtable(udg_Hashtable, StringHash("Unit" + I2S(GetHandleId(t))))
                set t = CreateTimer()
                call TimerStart(t, 12, false, function TimerOut)
                call SaveTimerHandle(udg_Hashtable, StringHash("Timer" + I2S(GetHandleId(u))), StringHash("t"), t)
                call SaveUnitHandle(udg_Hashtable, StringHash("Unit" + I2S(GetHandleId(t))), StringHash("u"), u)
            endif
            call SaveInteger(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("SkillLevel"), lv)
            call SaveReal(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("DamAll"), damall)
        endif
    endif
    set u = null
    set t = null
    return false
endfunction

function Unit_PickOrDropItem takes nothing returns boolean
    if GetItemPlayer(GetManipulatedItem()) != GetTriggerPlayer() then
        return false
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I04Q' then
        if GetTriggerEventId() == EVENT_UNIT_PICKUP_ITEM then
            call RemoveSkill(GetManipulatingUnit(), false)
            if GetUnitAbilityLevel(GetManipulatingUnit(), 'A0R4') == 0 and GetItemTypeId(GetManipulatedItem()) == 'I04Q' then
                call UnitAddAbility(GetManipulatingUnit(), 'A0R4')
            endif
        else
            call RemoveSkill(GetManipulatingUnit(), true)
        endif
    endif
    return false
endfunction

function Trig_Peach_Register_Conditions takes nothing returns boolean
    if GetItemTypeId(GetManipulatedItem()) != 'I04Q' then
        return false
    endif
    return not LoadBoolean(udg_Hashtable, StringHash(I2S(GetHandleId(GetTriggerUnit())) + "Peach"), StringHash("R"))
endfunction

function Trig_Peach_Register takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local trigger trg
    local timer t
    if GetItemPlayer(GetManipulatedItem()) != GetTriggerPlayer() then
        set u = null
        set t = null
        set trg = null
        return
    endif
    set t = CreateTimer()
    set trg = CreateTrigger()
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Register")
    if GetItemTypeId(GetManipulatedItem()) == 'I04Q' then
        call UnitAddAbility(u, 'A0R4')
        call UnitMakeAbilityPermanent(u, true, 'A0R4')
        call UnitMakeAbilityPermanent(u, true, 'A0QB')
    endif
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DAMAGED)
    call TriggerAddCondition(trg, Condition(function GetDamFunc))
    call SaveInteger(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("SkillLevel"), 0)
    call SaveTimerHandle(udg_Hashtable, StringHash("Timer" + I2S(GetHandleId(u))), StringHash("t"), t)
    call SaveUnitHandle(udg_Hashtable, StringHash("Unit" + I2S(GetHandleId(t))), StringHash("u"), u)
    call SaveReal(udg_Hashtable, StringHash("Dam" + I2S(GetHandleId(u))), StringHash("DamAll"), 0)
    call SaveBoolean(udg_Hashtable, StringHash(I2S(GetHandleId(u)) + "Peach"), StringHash("R"), true)
    set trg = CreateTrigger()
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_PICKUP_ITEM)
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DROP_ITEM)
    call TriggerAddCondition(trg, Condition(function Unit_PickOrDropItem))
    set u = null
    set t = null
    set trg = null
endfunction

function InitTrig_Ati07_Smallboat takes nothing returns nothing
    set gg_trg_Ati07_Smallboat = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ati07_Smallboat, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Ati07_Smallboat, Condition(function Trig_Peach_Register_Conditions))
    call TriggerAddAction(gg_trg_Ati07_Smallboat, function Trig_Peach_Register)
endfunction