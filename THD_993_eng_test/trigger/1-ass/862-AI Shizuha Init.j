function AI_Item_Shizuha takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Shizuha_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Shizuha_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Shizuha_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Shizuha_Attacked, Condition(function Trig_AI_Shizuha_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Shizuha_Attacked, function Trig_AI_Shizuha_Attacked_Actions)
    elseif T == 30 then
        call UnitAddItem(h, CreateItem('I03A', ox, oy))
    elseif T == R2I(1100 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I060', ox, oy))
    elseif T == R2I(2100 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I07H', ox, oy))
    elseif T == R2I(2800 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I05T', ox, oy))
    elseif T == R2I(3200 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I04D', ox, oy))
    endif
endfunction

function AI_Ability_Shizuha takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A0J8')
    local integer level02 = GetUnitAbilityLevel(h, 'A0JC')
    local integer level03 = GetUnitAbilityLevel(h, 'A0G8')
    local integer level04 = GetUnitAbilityLevel(h, 'A0XD')
    local integer i = 0
    local unit v
    local boolean tf = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local real tx
    local real ty
    local real ram
    if level01 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 75 + level01 * 15 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 800.0 then
                    if GetUnitCurrentOrder(v) != OrderId("walk") and DistanceBetweenUnits(h, v) <= 800.0 then
                        if GetRandomReal(0, 100) <= 25 then
                            set tf = IssuePointOrder(h, "inferno", GetUnitX(v), GetUnitY(v))
                        exitwhen tf
                        endif
                    elseif GetUnitCurrentOrder(v) == OrderId("walk") then
                        if GetRandomReal(0, 100) <= 15 then
                            set ram = GetRandomReal(0, 100) * 2
                            set tx = GetUnitX(v) + Cos(GetUnitFacing(v) / bj_RADTODEG) * ram
                            set ty = GetUnitY(v) + Sin(GetUnitFacing(v) / bj_RADTODEG) * ram
                            if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) < 800.0 then
                                set tf = IssuePointOrder(h, "inferno", tx, ty)
                            exitwhen tf
                            endif
                        endif
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    if level03 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 100 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 500.0 then
                    if GetRandomReal(0, 100) <= 15 then
                        set tf = IssueImmediateOrder(h, "immolation")
                        set tf = IssueTargetOrder(h, "attack", v)
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if level04 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 400 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 300.0 then
                    if GetUnitCurrentOrder(v) != OrderId("walk") and DistanceBetweenUnits(h, v) <= 300.0 then
                        if GetRandomReal(0, 100) <= 15 then
                            set tf = IssuePointOrder(h, "stampede", GetUnitX(v), GetUnitY(v))
                        exitwhen tf
                        endif
                    elseif GetUnitCurrentOrder(v) == OrderId("walk") then
                        if GetRandomReal(0, 100) <= 5 then
                            set ram = GetRandomReal(0, 100) * 2
                            set tx = GetUnitX(v) + Cos(GetUnitFacing(v) / bj_RADTODEG) * ram
                            set ty = GetUnitY(v) + Sin(GetUnitFacing(v) / bj_RADTODEG) * ram
                            if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) < 300.0 then
                                set tf = IssuePointOrder(h, "stampede", tx, ty)
                            exitwhen tf
                            endif
                        endif
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    set v = null
endfunction

function InitTrig_AI_Shizuha_Init takes nothing returns nothing
endfunction