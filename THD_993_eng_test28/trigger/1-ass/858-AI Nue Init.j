function AI_Item_Nue takes unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if T == 29 then
        set gg_trg_AI_Nue_Attacked = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_AI_Nue_Attacked)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Nue_Attacked, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_AI_Nue_Attacked, Condition(function Trig_AI_Nue_Attacked_Conditions))
        call TriggerAddAction(gg_trg_AI_Nue_Attacked, function Trig_AI_Nue_Attacked_Actions)
    elseif T == 30 then
        call UnitAddItem(h, CreateItem('I08T', ox, oy))
    elseif T == R2I(600 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I043', ox, oy))
    elseif T == R2I(1200 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I07F', ox, oy))
    elseif T == R2I(1800 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I069', ox, oy))
    elseif T == R2I(2400 * (0.25 * (4 - AIDIFF(h)))) then
        call UnitAddItem(h, CreateItem('I07Z', ox, oy))
    endif
endfunction

function AI_Ability_Nue_Pause takes unit h, unit v returns nothing
    local real ox = GetUnitX(v)
    local real oy = GetUnitY(v)
    call TriggerSleepAction(1.75)
    if not IsUnitInRangeXY(v, ox, oy, 300.0) then
        call IssueImmediateOrder(h, "stop")
    endif
endfunction

function AI_Ability_Nue_Go takes unit h, unit v returns nothing
    call IssueImmediateOrder(h, "berserk")
    call UnitBuffTarget(h, h, 1.6, 'A19M', 0)
    call UnitUseItemTarget(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I047'), v)
    call TriggerSleepAction(0.1)
    call UnitUseItemPoint(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I047'), GetUnitX(v), GetUnitY(v))
    call TriggerSleepAction(0.1)
    if YDWEUnitHasItemOfTypeBJNull(h, 'I069') then
        call UnitUseItemPoint(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I069'), GetUnitX(v), GetUnitY(v))
        call TriggerSleepAction(0.1)
    endif
    if YDWEUnitHasItemOfTypeBJNull(h, 'I07Z') then
        call UnitUseItemPoint(h, YDWEGetItemOfTypeFromUnitBJNull(h, 'I07Z'), GetUnitX(v), GetUnitY(v))
        call TriggerSleepAction(0.1)
    endif
    call IssuePointOrder(h, "carrionswarm", GetUnitX(v), GetUnitY(v))
endfunction

function AI_Ability_Nue takes unit h returns nothing
    local integer level01 = GetUnitAbilityLevel(h, 'A0M1')
    local integer level02 = GetUnitAbilityLevel(h, 'A0M2')
    local integer level04 = GetUnitAbilityLevel(h, 'A0M4')
    local integer i = 0
    local unit v
    local boolean tf = false
    local boolean tfr = false
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    if level02 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 70 + level02 * 10 and GetUnitAbilityLevel(h, 'A19M') >= 1 == false then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 500.0 + level02 * 200.0 then
                    if GetRandomReal(0, 100) <= 25 then
                        set tf = IssuePointOrder(h, "carrionswarm", GetUnitX(v), GetUnitY(v))
                    exitwhen tf
                    elseif DistanceBetweenUnits(h, v) <= 450.0 and GetUnitAbilityLevel(v, 'BPSE') >= 1 then
                        call AI_Ability_Nue_Go(h, v)
                    exitwhen true
                    elseif DistanceBetweenUnits(h, v) <= 450.0 and GetRandomReal(0, 100) <= 10 then
                        call AI_Ability_Nue_Go(h, v)
                    exitwhen true
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set tf = false
    if level04 >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 125 + level04 * 25 + 70 + level02 * 10 and GetUnitAbilityLevel(h, 'A19M') >= 1 == false then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) then
                    if GetRandomReal(0, 100) <= 10 or GetUnitState(v, UNIT_STATE_LIFE) <= 900 then
                        set tfr = IssuePointOrder(h, "inferno", GetUnitX(v), GetUnitY(v))
                    exitwhen tfr
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    if tfr then
        call AI_Ability_Nue_Pause(h, v)
        call UnitBuffTarget(h, h, 2.2, 'A19M', 0)
    endif
    set tf = false
    set v = null
endfunction

function InitTrig_AI_Nue_Init takes nothing returns nothing
endfunction