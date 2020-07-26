function Trig_Neutral_Die_Conditions takes nothing returns boolean
    if GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) then
        return false
    endif
    if GetUnitTypeId(GetTriggerUnit()) == 'o000' then
        return false
    endif
    return GetUnitTypeId(GetTriggerUnit()) != 'n001'
endfunction

function Trig_Neutral_Die_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer i = GetUnitTypeId(u)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local item itm = null
    if i == 'o001' or i == 'o00K' then
        set itm = CreateItem('I06O', x, y)
    elseif i == 'n006' then
        set itm = CreateItem('I06P', x, y)
        set itm = CreateItem('I06O', x, y)
        set itm = CreateItem('I06O', x, y)
        set itm = CreateItem('I06O', x, y)
    elseif i == 'h003' or i == 'n005' then
        set itm = CreateItem('I08K', x, y)
    elseif i == 'e005' or i == 'e006' or i == 'h007' then
        set itm = CreateItem('I03H', x, y)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl", x, y))
    call RemoveUnit(u)
    set u = null
    set itm = null
endfunction

function InitTrig_Neutral_Die takes nothing returns nothing
    set gg_trg_Neutral_Die = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(gg_trg_Neutral_Die, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(gg_trg_Neutral_Die, Condition(function Trig_Neutral_Die_Conditions))
    call TriggerAddAction(gg_trg_Neutral_Die, function Trig_Neutral_Die_Actions)
endfunction