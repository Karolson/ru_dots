function Trig_Toramaru03_Kill_Conditions takes nothing returns boolean
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetKillingUnit())) then
        return false
    endif
    return GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit())), 'A0P3') != 0
endfunction

function Trig_Toramaru03_Kill_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0P3')
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local unit e1 = CreateUnit(GetOwningPlayer(caster), 'e01R', tx, ty, 0)
    local unit v
    local unit w
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if udg_SK_ToramaruDB_Count < 6 then
        set udg_SK_ToramaruDB_Count = udg_SK_ToramaruDB_Count + 1
        call Trig_ToramaruDB_Change()
    endif
    call SetUnitPathing(e1, false)
    call SetUnitXY(e1, tx, ty)
    call GroupEnumUnitsInRange(g, tx, ty, 250, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and target != v then
            call UnitMagicDamageTarget(caster, v, 24 + 24 * level, 6)
            call UnitStunTarget(caster, v, 0.15 + 0.15 * level, 0, 0)
        endif
    endloop
    call DestroyGroup(g)
    if level == 2 then
        if udg_SK_Toramaru03_Counter == 0 then
            set udg_SK_Toramaru03_Counter = 1
            call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 4)
        else
            set udg_SK_Toramaru03_Counter = 0
            call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 5)
        endif
    elseif level == 4 then
        if udg_SK_Toramaru03_Counter == 0 then
            set udg_SK_Toramaru03_Counter = 1
            call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 7)
        else
            set udg_SK_Toramaru03_Counter = 0
            call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 8)
        endif
    elseif level == 1 then
        call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 3)
    elseif level == 3 then
        call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 6)
    endif
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
    else
        if level == 2 then
            if udg_SK_Toramaru03_Counter == 0 then
                set udg_SK_Toramaru03_Counter = 1
                call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 4)
            else
                set udg_SK_Toramaru03_Counter = 0
                call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 5)
            endif
        elseif level == 4 then
            if udg_SK_Toramaru03_Counter == 0 then
                set udg_SK_Toramaru03_Counter = 1
                call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 7)
            else
                set udg_SK_Toramaru03_Counter = 0
                call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 8)
            endif
        elseif level == 1 then
            call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 3)
        elseif level == 3 then
            call SetPlayerStateBJ(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 6)
        endif
    endif
    set caster = null
    set target = null
    set e1 = null
    set v = null
    set w = null
    set g = null
    set iff = null
endfunction

function InitTrig_Toramaru03_Kill takes nothing returns nothing
endfunction