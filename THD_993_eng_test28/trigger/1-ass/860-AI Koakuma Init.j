function AI_Item_Koakuma takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Koakuma_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Koakuma_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Koakuma_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Koakuma_Attacked, Condition(function Trig_AI_Koakuma_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Koakuma_Attacked, function Trig_AI_Koakuma_Attacked_Actions)
    elseif T == 30 then
        call UnitAddItem(h, CreateItem('I083', ox, oy))
    elseif T == R2I(300 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I08T', ox, oy))
    elseif T == R2I(600 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I014', ox, oy))
    elseif T == R2I(1400 * (0.25 * (4 - AIDIFF(h)))) then
        if GetRandomReal(0, 100) <= 75 then
            call UnitAddItem(h, CreateItem('I00E', ox, oy))
        else
            call UnitAddItem(h, CreateItem('I04G', ox, oy))
        endif
    elseif T == R2I(1900 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I07W', ox, oy))
    elseif T == R2I(2100 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I049', ox, oy))
    elseif T == R2I(2350 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I049', ox, oy))
    elseif T == R2I(2500 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I065', ox, oy))
    elseif T == R2I(3000 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I06N', ox, oy))
    endif
endfunction

function AI_Ability_Koakuma takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A0MT')
    local integer level02 = GetUnitAbilityLevel(h, 'A0NH')
    local integer level04 = GetUnitAbilityLevel(h, 'A0NI')
    local integer i = 0
    local group g
    local unit v
    local boolean tf = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(h))]
    if level01 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 55 + 15 * level01 then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 575.0, iff)
        set v = FirstOfGroup(g)
        if v != null then
            if IsUnitType(v, UNIT_TYPE_DEAD) == false then
                set tf = IssueTargetOrder(h, "thunderbolt", v)
            endif
        endif
        call DestroyGroup(g)
    endif
    set tf = false
    if level02 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 55 + 15 * level02 then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 575.0, iff)
        set v = FirstOfGroup(g)
        if v != null then
            if IsUnitType(v, UNIT_TYPE_DEAD) == false then
                set tf = IssueTargetOrder(h, "antimagicshell", v)
            endif
        endif
        call DestroyGroup(g)
    endif
    set tf = false
    if level04 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 50 + level04 * 50 + 200 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 575.0 then
                    if GetRandomReal(0, 100) <= 15 then
                        set tf = IssueImmediateOrder(h, "berserk")
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    set g = null
    set v = null
    set iff = null
endfunction

function Trig_AI_Koakuma_Init takes nothing returns nothing
endfunction

function InitTrig_AI_Koakuma_Init takes nothing returns nothing
endfunction