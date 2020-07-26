function AI_Item_Parsee takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Parsee_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Parsee_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Parsee_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Parsee_Attacked, Condition(function Trig_AI_Parsee_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Parsee_Attacked, function Trig_AI_Parsee_Attacked_Actions)
    endif
    if T == 30 then
        call UnitAddItem(h, CreateItem('I08T', ox, oy))
    endif
    if T == R2I(750 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I00V', ox, oy))
    endif
    if T == R2I(1200 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I064', ox, oy))
    endif
    if T == R2I(1800 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I051', ox, oy))
    endif
    if T == R2I(2400 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I049', ox, oy))
    endif
    if T == R2I(2700 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I049', ox, oy))
    endif
    if T == R2I(3000 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I065', ox, oy))
    endif
endfunction

function AI_Ability_Parsee_Wind takes nothing returns nothing
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = udg_AIParseeWind_Time - 0.3
    call TriggerSleepAction(0.3)
    set udg_AIParseeWind_Time = 0
endfunction

function AI_Ability_Parsee takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A03Q')
    local integer level02 = GetUnitAbilityLevel(h, 'A0PM')
    local integer level03 = GetUnitAbilityLevel(h, 'A0RO')
    local integer level04 = GetUnitAbilityLevel(h, 'A0PO')
    local integer i = 0
    local unit v
    local boolean tf = false
    local boolean tfr = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local real tx
    local real ty
    local real ram
    if level02 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 60 + level01 * 20 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 1050.0 then
                    if GetUnitCurrentOrder(v) != OrderId("walk") and DistanceBetweenUnits(h, v) <= 850.0 then
                        if GetRandomReal(0, 100) <= 45 or GetUnitAbilityLevel(v, 'B00N') >= 1 or GetUnitAbilityLevel(v, 'B057') >= 1 or udg_AIParsee04_Target == v then
                            if udg_AIParseeWind_Time < 0.9 then
                                set tf = IssuePointOrder(h, "carrionswarm", GetUnitX(v), GetUnitY(v))
                            exitwhen tf
                            endif
                        endif
                    elseif GetUnitCurrentOrder(v) == OrderId("walk") then
                        if GetRandomReal(0, 100) <= 25 or GetUnitAbilityLevel(v, 'B00N') >= 1 or udg_AIParsee04_Target == v then
                            set ram = GetRandomReal(0, 100) * 2
                            set tx = GetUnitX(v) + Cos(GetUnitFacing(v) / bj_RADTODEG) * ram
                            set ty = GetUnitY(v) + Sin(GetUnitFacing(v) / bj_RADTODEG) * ram
                            if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) < 850.0 then
                                set tf = IssuePointOrder(h, "carrionswarm", tx, ty)
                            exitwhen tf
                            endif
                        endif
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if level01 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 100 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 550.0 then
                    if GetRandomReal(0, 100) <= 30 or GetUnitState(v, UNIT_STATE_LIFE) <= level01 * 50 or udg_AIParsee04_Target == v then
                        set tf = IssueTargetOrder(h, "spellsteal", v)
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if level03 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 60 + level03 * 25 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) > 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 650.0 or udg_AIParsee04_Target == v then
                    if GetRandomReal(0, 100) <= DistanceBetweenUnits(h, v) / 650 * 80 then
                        set tf = IssueTargetOrder(h, "charm", v)
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if level04 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 200 + level04 * 100 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) > 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 400.0 then
                    if GetRandomReal(0, 100) <= 10 then
                        set tf = IssueTargetOrder(h, "chainlightning", v)
                        set udg_AIParsee04_Target = v
                    exitwhen tf
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 then
            if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 550.0 and GetUnitAbilityLevel(v, 'B00N') != 1 or GetUnitAbilityLevel(v, 'B057') != 1 then
                if GetRandomReal(0, 100) <= 10 or udg_AIParsee04_Target == v then
                    set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I064'), v)
                exitwhen tf
                elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.15 then
                    set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I064'), v)
                exitwhen tf
                endif
            endif
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 then
            if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 550.0 and GetUnitAbilityLevel(v, 'B00N') != 1 or GetUnitAbilityLevel(v, 'B057') != 1 then
                if GetRandomReal(0, 100) <= 10 or udg_AIParsee04_Target == v then
                    set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I051'), v)
                exitwhen tf
                elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.15 then
                    set tf = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I051'), v)
                exitwhen tf
                endif
            endif
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 then
            if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 550.0 and GetUnitAbilityLevel(v, 'B00N') != 1 or GetUnitAbilityLevel(v, 'B057') != 1 then
                if GetRandomReal(0, 100) <= 10 or udg_AIParsee04_Target == v then
                    set tfr = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I00V'), v)
                exitwhen tfr
                elseif GetUnitState(h, UNIT_STATE_LIFE) / GetUnitState(h, UNIT_STATE_MAX_LIFE) < 0.15 then
                    set tfr = UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I00V'), v)
                exitwhen tfr
                endif
            endif
        endif
        set i = i + 1
    endloop
    if tfr then
        set udg_AIParseeWind_Time = 3.0
        call AI_Ability_Parsee_Wind()
    endif
    set v = null
endfunction

function InitTrig_AI_Parsee_Init takes nothing returns nothing
endfunction