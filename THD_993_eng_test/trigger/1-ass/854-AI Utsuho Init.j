function AI_Item_Utsuho takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Utsuho_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Utsuho_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Utsuho_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Utsuho_Attacked, Condition(function Trig_AI_Utsuho_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Utsuho_Attacked, function Trig_AI_Utsuho_Attacked_Actions)
    elseif T == 30 then
        call UnitAddItem(h, CreateItem('I08T', ox, oy))
    elseif T == R2I(850 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I06V', ox, oy))
    elseif T == R2I(1150 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I0O1', ox, oy))
    elseif T == R2I(1350 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I0O1', ox, oy))
    elseif T == R2I(1550 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I003', ox, oy))
    elseif T == R2I(2150 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I040', ox, oy))
    elseif T == R2I(2950 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I00W', ox, oy))
    endif
endfunction

function AI_Ability_Utsuho takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A0QN')
    local integer level02 = GetUnitAbilityLevel(h, 'A076')
    local integer level03 = GetUnitAbilityLevel(h, 'A079')
    local integer level04 = GetUnitAbilityLevel(h, 'A07B')
    local integer i = 0
    local unit v
    local boolean tf = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if udg_AIUtsuho03_Time > 20 then
        set udg_AIUtsuho03_Time = udg_AIUtsuho03_Time - 1
    else
        set udg_AIUtsuho03_Time = 0
    endif
    if GetUnitCurrentOrder(h) == OrderId("cyclone") then
        set v = null
        return
    endif
    if level01 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 50 + level01 * 10 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 600.0 then
                    set tf = IssueTargetOrder(h, "acidbomb", v)
                exitwhen tf
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    if level02 >= 0 and GetUnitState(h, UNIT_STATE_MANA) <= 400 then
        set tf = IssueImmediateOrder(h, "avatar")
    endif
    set tf = false
    if level03 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 155 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 1000.0 then
                    if GetRandomReal(0, 100) <= 25 then
                        set tf = IssueImmediateOrder(h, "stomp")
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if tf then
        set udg_AIUtsuho03_Time = 45 - level03 * 5
    endif
    set tf = false
    if udg_AIUtsuho03_Time > 20 and udg_AIUtsuho03_Time <= 25 and AI_IsLowHP(h) == false then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 300 + 200 * (udg_AIUtsuho03_Time - 20) then
                    if GetRandomReal(0, 100) <= 85 then
                        set tf = IssuePointOrder(h, "move", GetUnitX(v), GetUnitY(v))
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    if level04 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 160 + level04 * 70 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 750.0 then
                    if GetUnitAbilityLevel(v, 'Bprg') >= 1 or GetUnitAbilityLevel(v, 'A13G') >= 1 then
                        set tf = IssuePointOrder(h, "cyclone", GetUnitX(v), GetUnitY(v))
                    exitwhen tf
                    elseif GetRandomReal(0, 100) <= 100 - GetUnitState(v, UNIT_STATE_LIFE) / GetUnitState(v, UNIT_STATE_MAX_LIFE) * 100 then
                        set tf = IssuePointOrder(h, "cyclone", GetUnitX(v), GetUnitY(v))
                    exitwhen tf
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
    if YDWEUnitHasItemOfTypeBJNull(h, 'I040') then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 500.0 then
                    if GetRandomReal(0, 100) <= 15 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I040'))
                    exitwhen tf
                    elseif GetUnitState(v, UNIT_STATE_LIFE) / GetUnitState(v, UNIT_STATE_MAX_LIFE) < 0.25 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I040'))
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    if YDWEUnitHasItemOfTypeBJNull(h, 'I00W') then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 200.0 then
                    if GetRandomReal(0, 100) <= 10 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I00W'))
                    exitwhen tf
                    elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) > 0.75 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I00W'))
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    set v = null
endfunction

function InitTrig_AI_Utsuho_Init takes nothing returns nothing
endfunction