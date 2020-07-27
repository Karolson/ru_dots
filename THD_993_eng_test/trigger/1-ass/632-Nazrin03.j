function Trig_Nazrin03_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetAttacker()) != 'U00K' then
        return false
    elseif IsUnitIllusion(GetAttacker()) then
        return false
    endif
    return GetRandomInt(0, 100) <= 7 + 7 * GetUnitAbilityLevel(GetAttacker(), 'A0D7')
endfunction

function Trig_Nazrin03_Sync takes unit h, unit u returns nothing
    local item v
    local item w
    local integer i
    local integer d
    call SetHeroLevel(u, GetHeroLevel(h), false)
    call SetHeroStr(u, GetHeroStr(h, false), true)
    call SetHeroAgi(u, GetHeroAgi(h, false), true)
    call SetHeroInt(u, GetHeroInt(h, false), true)
    call SetUnitAbilityLevel(u, 'A03Y', GetUnitAbilityLevel(h, 'A03Y'))
    set i = 0
    loop
    exitwhen i >= bj_MAX_INVENTORY
        set w = UnitItemInSlot(u, i)
        set v = UnitItemInSlot(h, i)
        if w == null then
            if v != null then
                set w = CreateItem(GetItemTypeId(v), GetUnitX(u), GetUnitY(u))
                call UnitAddItem(u, w)
            endif
        else
            if v == null then
                call UnitRemoveItem(u, w)
                call RemoveItem(w)
            else
                set d = GetItemTypeId(v)
                if d != GetItemTypeId(w) then
                    call UnitRemoveItem(u, w)
                    call RemoveItem(w)
                    set w = CreateItem(d, GetUnitX(u), GetUnitY(u))
                    call UnitAddItem(u, w)
                endif
            endif
        endif
        set i = i + 1
    endloop
    set v = null
    set w = null
endfunction

function Trig_Nazrin03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i == 0 and GetWidgetLife(target) > 0.405 and GetWidgetLife(caster) > 0.405 then
        call SetUnitX(u, GetUnitX(caster))
        call SetUnitY(u, GetUnitY(caster))
        call PauseUnit(u, false)
        call IssueTargetOrderById(u, 851985, target)
        call SaveInteger(udg_ht, task, 1, 2)
        call TimerStart(t, 0.5, false, function Trig_Nazrin03_Main)
    else
        call ShowUnit(u, false)
        call PauseUnit(u, true)
        call SetUnitPositionLoc(u, udg_BackStage)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call EnableTrigger(gg_trg_Nazrin03)
    endif
    set caster = null
    set target = null
    set u = null
    set t = null
endfunction

function Trig_Nazrin03_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local unit u = LoadUnitHandle(udg_sht, GetHandleId(caster), 0)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call DisableTrigger(gg_trg_Nazrin03)
    call ShowUnit(u, true)
    call UnitRemoveAbility(u, 'Aloc')
    call UnitAddAbility(u, 'Aloc')
    call SetUnitFacing(u, GetUnitFacing(caster))
    call Trig_Nazrin03_Sync(caster, u)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 0.1, false, function Trig_Nazrin03_Main)
    set caster = null
    set target = null
    set u = null
    set t = null
endfunction

function Trig_Nazrin03_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0D7'
endfunction

function Trig_Nazrin03_Learn_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    call DestroyTrigger(gg_trg_Nazrin03)
    set gg_trg_Nazrin03 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nazrin03, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Nazrin03, Condition(function Trig_Nazrin03_Conditions))
    call TriggerAddAction(gg_trg_Nazrin03, function Trig_Nazrin03_Actions)
    set u = CreateUnitAtLoc(GetOwningPlayer(caster), 'U00R', udg_BackStage, 0.0)
    call ShowUnit(u, false)
    call PauseUnit(u, true)
    call SaveUnitHandle(udg_sht, GetHandleId(caster), 0, u)
    set udg_SK_Nazirin = u
    call DebugMsg("Nazrin03")
    set caster = null
    set u = null
endfunction

function InitTrig_Nazrin03 takes nothing returns nothing
endfunction