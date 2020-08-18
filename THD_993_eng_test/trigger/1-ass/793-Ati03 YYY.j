function Trig_Ati03_YYY_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit())),'I04T')==true or YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit())),'I06Y')==true then
        if IsUnitAlly(GetKillingUnit(), GetOwningPlayer(GetTriggerUnit())) then
            return false
        elseif GetUnitTypeId(GetTriggerUnit()) == 'n01Y' then
            return false
        endif
    else
        return false  
    endif
    return true
endfunction

function Trig_Ati03_YYY_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer k = LoadInteger(udg_ht, task, 0)
    set udg_SK_YYY[k] = 0
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
endfunction

function Trig_Ati03_YYY_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit killer = GetKillingUnit()
    local unit dyer = GetTriggerUnit()
    local unit u1
    local unit u2
    local integer k = GetPlayerId(GetOwningPlayer(GetKillingUnit())) + 1
    if udg_SK_YYY[k] == 0 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Transmute\\GoldBottleMissile.mdl", GetUnitX(dyer), GetUnitY(dyer)))
        call THD_AddCredit(GetOwningPlayer(killer), 8)
        set udg_SK_YYY[k] = 1
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveInteger(udg_ht, task, 0, k)
        call TimerStart(t, 0, false, function Trig_Ati03_YYY_Clear)
    endif
    set t = null
    set killer = null
    set dyer = null
    set u1 = null
    set u2 = null
endfunction

function InitTrig_Ati03_YYY takes nothing returns nothing
    set gg_trg_Ati03_YYY = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ati03_YYY, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Ati03_YYY, Condition(function Trig_Ati03_YYY_Conditions))
    call TriggerAddAction(gg_trg_Ati03_YYY, function Trig_Ati03_YYY_Actions)
endfunction