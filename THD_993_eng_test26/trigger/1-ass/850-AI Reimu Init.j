function AI_Item_Reimu takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Reimu_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Reimu_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Reimu_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Reimu_Attacked, Condition(function Trig_AI_Reimu_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Reimu_Attacked, function Trig_AI_Reimu_Attacked_Actions)
    endif
    if T == 30 then
        call UnitAddItem(h, CreateItem('I085', ox, oy))
    endif
    if T == R2I(250 * (0.25 * (4 - AIDIFF(h)))) then
        if GetRandomReal(0, 100) <= 75 then
            call UnitAddItem(h, CreateItem('I03B', ox, oy))
        else
            call UnitAddItem(h, CreateItem('I08T', ox, oy))
        endif
    endif
    if T == R2I(550 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I007', ox, oy))
    endif
    if T == R2I(850 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I064', ox, oy))
    endif
    if T == R2I(1200 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I03V', ox, oy))
    endif
    if T == R2I(1550 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I049', ox, oy))
    endif
    if T == R2I(1800 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I049', ox, oy))
    endif
    if T == R2I(2400 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I065', ox, oy))
    endif
    if T == R2I(2900 * (0.25 * (4 - AIDIFF(h)))) then
        if GetRandomReal(0, 100) <= 50 then
            call UnitAddItem(h, CreateItem('I08Q', ox, oy))
        else
            call UnitAddItem(h, CreateItem('I00E', ox, oy))
        endif
    endif
endfunction

function AI_Ability_Reimu takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A048')
    local integer level02 = GetUnitAbilityLevel(h, 'A049')
    local integer level03 = GetUnitAbilityLevel(h, 'A04A')
    local integer level04 = GetUnitAbilityLevel(h, 'A04B')
    local integer i = 0
    local unit v
    local boolean tf = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local real tx
    local real ty
    local real ram
    if level01 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 60 + level01 * 20 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 700.0 then
                    if GetUnitCurrentOrder(v) != OrderId("walk") and DistanceBetweenUnits(h, v) <= 500.0 then
                        if GetRandomReal(0, 100) <= 45 or GetUnitAbilityLevel(v, 'B00N') >= 1 then
                            set tf = IssuePointOrder(h, "clusterrockets", GetUnitX(v), GetUnitY(v))
                        exitwhen tf
                        endif
                    elseif GetUnitCurrentOrder(v) == OrderId("walk") then
                        if GetRandomReal(0, 100) <= 25 then
                            set ram = GetRandomReal(0, 100) * 2
                            set tx = GetUnitX(v) + Cos(GetUnitFacing(v) / bj_RADTODEG) * ram
                            set ty = GetUnitY(v) + Sin(GetUnitFacing(v) / bj_RADTODEG) * ram
                            if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) < 575.0 then
                                set tf = IssuePointOrder(h, "clusterrockets", tx, ty)
                            exitwhen tf
                            endif
                        endif
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if level02 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 80 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 400.0 then
                    if GetUnitCurrentOrder(v) != OrderId("walk") and DistanceBetweenUnits(h, v) <= 200.0 then
                        if GetRandomReal(0, 100) <= 75 then
                            set tf = IssueImmediateOrder(h, "waterelemental")
                        exitwhen tf
                        endif
                    elseif GetUnitCurrentOrder(v) == OrderId("walk") then
                        if GetRandomReal(0, 100) <= 25 then
                            set ram = GetRandomReal(0, 100) * 2
                            set tx = GetUnitX(v) + Cos(GetUnitFacing(v) / bj_RADTODEG) * ram
                            set ty = GetUnitY(v) + Sin(GetUnitFacing(v) / bj_RADTODEG) * ram
                            if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) < 250.0 then
                                set tf = IssueImmediateOrder(h, "waterelemental")
                            exitwhen tf
                            endif
                        endif
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if level03 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 25 + level03 * 25 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) > 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 550.0 then
                    if GetRandomReal(0, 100) <= 25 then
                        set tf = IssueTargetOrder(h, "frostarmor", v)
                    exitwhen tf
                    endif
                elseif IsUnitInRange(h, v, 550.0) then
                    if GetUnitState(v, UNIT_STATE_LIFE) / GetUnitState(v, UNIT_STATE_MAX_LIFE) < 0.25 then
                        set tf = IssueTargetOrder(h, "frostarmor", v)
                    exitwhen tf
                    elseif GetRandomReal(0, 100) <= 15 then
                        set tf = IssueTargetOrder(h, "frostarmor", v)
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if level04 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 100 + level04 * 100 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 450.0 then
                    if GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.2 then
                        set tf = IssueImmediateOrder(h, "tranquility")
                    exitwhen tf
                    elseif GetRandomReal(0, 100) <= 5 then
                        set tf = IssueImmediateOrder(h, "tranquility")
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if YDWEUnitHasItemOfTypeBJNull(h, 'I04J') then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 550.0 then
                    if GetRandomReal(0, 100) <= 10 then
                        set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I04J'), v)
                    exitwhen tf
                    elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.15 then
                        set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I04J'), v)
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if YDWEUnitHasItemOfTypeBJNull(h, 'I034') then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 500.0 then
                    if GetRandomReal(0, 100) <= 10 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I034'))
                    exitwhen tf
                    elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.25 then
                        set tf = UnitUseItem(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I034'))
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set v = null
endfunction

function InitTrig_AI_Reimu_Init takes nothing returns nothing
endfunction