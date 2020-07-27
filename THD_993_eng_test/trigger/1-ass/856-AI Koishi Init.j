function AI_Item_Koishi takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Koishi_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Koishi_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Koishi_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Koishi_Attacked, Condition(function Trig_AI_Koishi_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Koishi_Attacked, function Trig_AI_Koishi_Attacked_Actions)
    elseif T == 30 then
        call UnitAddItem(h, CreateItem('I03A', ox, oy))
    elseif T == R2I(850 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I06Y', ox, oy))
    elseif T == R2I(1550 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I037', ox, oy))
    elseif T == R2I(2200 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I041', ox, oy))
    elseif T == R2I(2700 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I060', ox, oy))
    endif
endfunction

function AI_Ability_Koishi takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A0GT')
    local integer level04 = GetUnitAbilityLevel(h, 'A0DY')
    local unit v
    local boolean tf = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if level01 >= 0 and GetUnitState(h, UNIT_STATE_MANA) <= 150 then
        if GetRandomReal(0, 100) <= 10 then
            set tf = IssueImmediateOrder(h, "stomp")
        endif
    endif
    set tf = false
    if level04 >= 0 then
        if GetRandomReal(0, 100) <= 5 then
            set tf = IssueImmediateOrder(h, "metamorphosis")
        endif
    endif
    set tf = false
    set v = null
endfunction

function InitTrig_AI_Koishi_Init takes nothing returns nothing
endfunction