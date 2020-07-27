function Trig_Hourai_Elixir_Drop_Func007C takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetTriggerUnit(), 'I03C') then
        return true
    endif
    if YDWEUnitHasItemOfTypeBJNull(GetTriggerUnit(), 'I03D') then
        return true
    endif
    if YDWEUnitHasItemOfTypeBJNull(GetTriggerUnit(), 'I03E') then
        return true
    endif
    return false
endfunction

function Trig_Hourai_Elixir_Drop_Conditions takes nothing returns boolean
    if not Trig_Hourai_Elixir_Drop_Func007C() then
        return false
    endif
    return true
endfunction

function Trig_Hourai_Elixir_Drop_Actions takes nothing returns nothing
    call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetTriggerUnit(), 'I03C'), 0)
    call RemoveItem(YDWEGetItemOfTypeFromUnitBJNull(GetTriggerUnit(), 'I03C'))
    call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetTriggerUnit(), 'I03D'), 0)
    call RemoveItem(YDWEGetItemOfTypeFromUnitBJNull(GetTriggerUnit(), 'I03D'))
    call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetTriggerUnit(), 'I03E'), 0)
    call RemoveItem(YDWEGetItemOfTypeFromUnitBJNull(GetTriggerUnit(), 'I03E'))
endfunction

function InitTrig_Hourai_Elixir_Drop takes nothing returns nothing
    set gg_trg_Hourai_Elixir_Drop = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hourai_Elixir_Drop, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Hourai_Elixir_Drop, Condition(function Trig_Hourai_Elixir_Drop_Conditions))
    call TriggerAddAction(gg_trg_Hourai_Elixir_Drop, function Trig_Hourai_Elixir_Drop_Actions)
endfunction