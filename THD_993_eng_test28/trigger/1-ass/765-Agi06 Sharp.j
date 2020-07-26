function Agi06_BuffClear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    call UnitRemoveAbility(u, 'A0NJ')
    call UnitRemoveAbility(u, 'A0OQ')
    call UnitRemoveAbility(u, 'B087')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call RemoveSavedHandle(udg_sht, StringHash("Agi06"), GetHandleId(u))
    set t = null
    set u = null
endfunction

function Agi06_Condition takes nothing returns boolean
    local unit u = GetAttacker()
    local unit v
    local timer t
    local integer stask
    local integer ctask
    if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I041') > 0 and false then
        set v = GetTriggerUnit()
        set stask = StringHash("Agi06")
        set ctask = GetHandleId(u)
        if IsUnitType(v, UNIT_TYPE_HERO) and IsUnitEnemy(v, GetOwningPlayer(u)) then
            if GetUnitAbilityLevel(u, 'A0NJ') > 0 then
                call UnitRemoveAbility(u, 'A0NJ')
                call UnitRemoveAbility(u, 'B087')
            endif
            if GetUnitAbilityLevel(u, 'A0OQ') == 0 then
                call UnitAddAbility(u, 'A0OQ')
                call UnitMakeAbilityPermanent(u, true, 'A0OQ')
            endif
            if HaveSavedHandle(udg_sht, stask, ctask) then
                set t = LoadTimerHandle(udg_sht, stask, ctask)
            else
                set t = CreateTimer()
                call SaveTimerHandle(udg_sht, stask, ctask, t)
                call SaveUnitHandle(udg_ht, GetHandleId(t), 0, u)
            endif
            call TimerStart(t, 6.0, false, function Agi06_BuffClear)
        elseif not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
            if GetUnitAbilityLevel(u, 'A0NJ') == 0 and GetUnitAbilityLevel(u, 'A0OQ') == 0 then
                call UnitAddAbility(u, 'A0NJ')
                call UnitMakeAbilityPermanent(u, true, 'A0NJ')
                set t = CreateTimer()
                call SaveTimerHandle(udg_sht, stask, ctask, t)
                call SaveUnitHandle(udg_ht, GetHandleId(t), 0, u)
                call TimerStart(t, 3.0, false, function Agi06_BuffClear)
            elseif GetUnitAbilityLevel(u, 'A0NJ') > 0 then
                set t = LoadTimerHandle(udg_sht, stask, ctask)
                call TimerStart(t, 3.0, false, function Agi06_BuffClear)
            endif
        endif
        set v = null
        set t = null
    endif
    set u = null
    return false
endfunction

function InitTrig_Agi06_Sharp takes nothing returns nothing
    set gg_trg_Agi06_Sharp = CreateTrigger()
    call TriggerAddCondition(gg_trg_Agi06_Sharp, Condition(function Agi06_Condition))
endfunction