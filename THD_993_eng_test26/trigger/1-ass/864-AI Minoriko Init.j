function AI_Item_Minoriko takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Minoriko_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Minoriko_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Minoriko_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Minoriko_Attacked, Condition(function Trig_AI_Minoriko_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Minoriko_Attacked, function Trig_AI_Minoriko_Attacked_Actions)
    elseif T == 30 then
        call UnitAddItem(h, CreateItem('I030', ox, oy))
    elseif T == R2I(240 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I039', ox, oy))
    elseif T == R2I(600 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I06V', ox, oy))
    elseif T == R2I(1200 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I00D', ox, oy))
    elseif T == R2I(1800 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I04N', ox, oy))
    elseif T == R2I(2400 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I08J', ox, oy))
    endif
endfunction

function AI_Ability_Minoriko takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A0JF')
    local integer level02 = GetUnitAbilityLevel(h, 'A0JI')
    local integer level04 = GetUnitAbilityLevel(h, 'A06A')
    local integer i = 0
    local group g
    local unit v
    local boolean tf = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(h))]
    if level01 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 90 + level01 * 10 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if DistanceBetweenUnits(h, v) <= 600.0 and GetRandomReal(0, 100) <= 15 then
                    set tf = IssueTargetOrder(h, "deathcoil", v)
                exitwhen tf
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    if level02 >= 0 and GetUnitState(h, UNIT_STATE_MANA) < GetUnitState(h, UNIT_STATE_MAX_MANA) - 200 then
        set tf = IssuePointOrder(h, "healingward", GetUnitX(h), GetUnitY(h))
    endif
    set tf = false
    if level04 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 300 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 200.0 then
                    if DistanceBetweenUnits(h, v) <= 200.0 then
                        if GetRandomReal(0, 100) <= 5 then
                            set tf = IssuePointOrder(h, "cyclone", GetUnitX(v), GetUnitY(v))
                        exitwhen tf
                        endif
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 then
            if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 550.0 then
                if GetRandomReal(0, 100) <= 15 then
                    set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I06V'), v)
                exitwhen tf
                elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.15 then
                    set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I06V'), v)
                exitwhen tf
                endif
            endif
        endif
        set i = i + 1
    endloop
    set tf = false
    if YDWEUnitHasItemOfTypeBJNull(h, 'I00D') then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 500.0 then
                    if GetRandomReal(0, 100) <= 10 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I00D'))
                    exitwhen tf
                    elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.25 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I00D'))
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if YDWEUnitHasItemOfTypeBJNull(h, 'I030') then
        if GetRandomReal(0, 100) <= 10 and GetUnitState(h, UNIT_STATE_MANA) < GetUnitState(h, UNIT_STATE_MAX_MANA) - 300 then
            set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I030'))
        endif
    endif
    set g = null
    set v = null
    set iff = null
endfunction

function Trig_AI_Minoriko_Init takes nothing returns nothing
endfunction

function InitTrig_AI_Minoriko_Init takes nothing returns nothing
endfunction