function Trig_AnyUnitGetItem_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Aloc') > 0 then
        return false
    endif
    if THD_GetItemOwner(GetManipulatedItem()) != GetTriggerPlayer() then
        return false
    endif
    return true
endfunction

function Trig_AnyUnitGetItem_Actions takes nothing returns nothing
    local item itm = GetManipulatedItem()
    local player p = GetItemPlayer(itm)
    local unit v = GetTriggerUnit()
    local integer id = GetPlayerId(p)
    local integer itmtype = GetItemTypeId(itm)
    local integer n = 0
    local integer w = 0
    local integer count = 0
    local real i = 0
    local real resist = 0
    local real armor = 0
    local real attack = 0
    local real attackspeed = 0
    local real actualtime = 1
    local real drink = 1
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_PICKUP_ITEM then
        set i = 1
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_DROP_ITEM then
        set i = -1
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SELL_ITEM then
        set i = -1
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_PAWN_ITEM then
        set i = 1
    endif
    if i != 0 and IsUnitType(v, UNIT_TYPE_HERO) then
        if itmtype == 'I015' then
            set resist = resist + 2 * i
        elseif itmtype == 'I018' then
            set resist = resist + 4 * i
        elseif itmtype == 'I04B' then
            set resist = resist + 10 * i
        elseif itmtype == 'I05W' then
            set resist = resist + 6 * i
        elseif itmtype == 'I02W' then
            set resist = resist + 18 * i
        elseif itmtype == 'I08D' then
            set resist = resist + 12 * i
        elseif itmtype == 'I00W' then
            set resist = resist + 10 * i
        elseif itmtype == 'I08J' then
            set resist = resist + 4 * i
        elseif itmtype == 'I04A' then
            set resist = resist + 4 * i
        elseif itmtype == 'I05T' then
            set resist = resist + 4 * i
        elseif itmtype == 'I08Q' then
            set resist = resist + 6 * i
        elseif itmtype == 'I01T' then
            set resist = resist + 12 * i
        elseif itmtype == 'I087' then
            set resist = resist + 10 * i
        elseif itmtype == 'I07D' then
            set resist = resist + 6 * i
        elseif itmtype == 'I08X' then
            set resist = resist + 3 * i
        endif
        set udg_DMG_AllItemMagicResist[id] = resist + udg_DMG_AllItemMagicResist[id]
        call DebugMsg("Resist:" + R2S(resist))
        set resist = 0
        if itmtype == 'I08Q' then
            set armor = armor + 6 * i
        elseif itmtype == 'I00I' then
            set armor = armor + 18 * i
        elseif itmtype == 'I04F' then
            set armor = armor + 4 * i
        elseif itmtype == 'I04G' then
            set armor = armor + 12 * i
        elseif itmtype == 'I04O' then
            set armor = armor + 4 * i
        elseif itmtype == 'I06K' then
            set armor = armor + 20 * i
        elseif itmtype == 'I04N' then
            set armor = armor + 4 * i
        elseif itmtype == 'I05W' then
            set armor = armor + 4 * i
        elseif itmtype == 'I08D' then
            set armor = armor + 12 * i
        elseif itmtype == 'I015' then
            set armor = armor + 2 * i
        elseif itmtype == 'I01F' then
            set armor = armor + 4 * i
        elseif itmtype == 'I01H' then
            set armor = armor + 10 * i
        elseif itmtype == 'I04X' then
            set armor = armor + 4 * i
        elseif itmtype == 'I08X' then
            set resist = armor + 3 * i
        endif
        set udg_DMG_AllItemArmor[id] = armor + udg_DMG_AllItemArmor[id]
        set armor = 0
        if itmtype == 'I051' then
            set attack = attack + 5 * i
        elseif itmtype == 'I05T' then
            set attack = attack + 30 * i
        elseif itmtype == 'I069' then
            set attack = attack + 14 * i
        elseif itmtype == 'I07D' then
            set attack = attack + 9 * i
        elseif itmtype == 'I066' then
            set attack = attack + 20 * i
        elseif itmtype == 'I04O' then
            set attack = attack + 30 * i
        elseif itmtype == 'I00C' then
            set attack = attack + 9 * i
        elseif itmtype == 'I00K' then
            set attack = attack + 30 * i
        elseif itmtype == 'I061' then
            set attack = attack + 12 * i
        elseif itmtype == 'I00Q' then
            set attack = attack + 26 * i
        elseif itmtype == 'I00M' then
            set attack = attack + 26 * i
        elseif itmtype == 'I08P' then
            set attack = attack + 20 * i
        elseif itmtype == 'I037' then
            set attack = attack + 50 * i
        elseif itmtype == 'I036' then
            set attack = attack + 5 * i
        elseif itmtype == 'I04T' then
            set attack = attack + 22 * i
        elseif itmtype == 'I04Q' then
            set attack = attack + 32 * i
        elseif itmtype == 'I08M' then
            set attack = attack + 11 * i
        elseif itmtype == 'I03S' then
            set attack = attack + 42 * i
        elseif itmtype == 'I008' then
            set attack = attack + 68 * i
        elseif itmtype == 'I07D' then
            set attack = attack + 18 * i
        elseif itmtype == 'I01V' then
            set attack = attack + 9 * i
        elseif itmtype == 'I019' then
            set attack = attack + 16 * i
        elseif itmtype == 'I01C' then
            set attack = attack + 22 * i
        elseif itmtype == 'I01B' then
            set attack = attack + 30 * i
        elseif itmtype == 'I011' then
            set attack = attack + 9 * i
        elseif itmtype == 'I06R' then
            set attack = attack + 15 * i
        elseif itmtype == 'I032' then
            set attack = attack + 5 * i
        elseif itmtype == 'I02Y' then
            set attack = attack + 5 * i
        elseif itmtype == 'I07Z' then
            set attack = attack + 14 * i
        elseif itmtype == 'I077' then
            set attack = attack + 10 * i
        elseif itmtype == 'I06X' then
            set attack = attack + 5 * i
        elseif itmtype == 'I06Q' then
            set attack = attack + 13 * i
        elseif itmtype == 'I04X' then
            set attack = attack + 10 * i
        elseif itmtype == 'I08V' then
            set attack = attack + 20 * i
        elseif itmtype == 'I094' then
            set attack = attack + 25 * i
        elseif itmtype == 'I095' then
            set attack = attack + 25 * i
        elseif itmtype == 'I026' then
            set attack = attack + 30 * i
        elseif itmtype == 'I033' then
            set attack = attack + 60 * i
        endif
        set udg_DMG_AllItemAttack[id] = attack + udg_DMG_AllItemAttack[id]
        set attack = 0
        if itmtype == 'I07H' then
            set attackspeed = attackspeed + 0.15 * i
        elseif itmtype == 'I08P' then
            set attackspeed = attackspeed + 0.4 * i
        elseif itmtype == 'I00J' then
            set attackspeed = attackspeed + 0.15 * i
        elseif itmtype == 'I07D' then
            set attackspeed = attackspeed + 0.09 * i
        elseif itmtype == 'I00K' then
            set attackspeed = attackspeed + 0.4 * i
        elseif itmtype == 'I036' then
            set attackspeed = attackspeed + 0.4 * i
        elseif itmtype == 'I00M' then
            set attackspeed = attackspeed + 0.15 * i
        elseif itmtype == 'I069' then
            set attackspeed = attackspeed + 0.52 * i
        elseif itmtype == 'I017' then
            set attackspeed = attackspeed + 0.15 * i
        elseif itmtype == 'I011' then
            set attackspeed = attackspeed + 0.09 * i
        elseif itmtype == 'I00C' then
            set attackspeed = attackspeed + 0.09 * i
        elseif itmtype == 'I06X' then
            set attackspeed = attackspeed + 0.4 * i
        elseif itmtype == 'I08V' then
            set attackspeed = attackspeed + 0.4 * i
        elseif itmtype == 'I075' then
            set attackspeed = attackspeed + 0.3 * i
        elseif itmtype == 'I094' then
            set attackspeed = attackspeed + 0.6 * i
        elseif itmtype == 'I095' then
            set attackspeed = attackspeed + 0.6 * i
        endif
        set udg_DMG_AllItemAttackSpeed[id] = attackspeed + udg_DMG_AllItemAttackSpeed[id]
        set attackspeed = 0
        loop
            set w = GetItemTypeId(UnitItemInSlot(v, n))
            if w == itmtype then
                set count = count + 1
            endif
            set n = n + 1
        exitwhen n >= 6
        endloop
        if (count == 1 and i == 1) or (count == 1 and i == -1) then
            if itmtype == 'I031' then
                set actualtime = actualtime * 0.9
            endif
            if itmtype == 'I090' then
                set actualtime = actualtime * 0.9
            endif
            if itmtype == 'I00H' then
                set actualtime = actualtime * 0.9
            endif
            if itmtype == 'I00E' then
                set actualtime = actualtime * 0.9
            endif
            if itmtype == 'I00B' then
                set actualtime = actualtime * 0.72
            endif
            if itmtype == 'I041' then
                set actualtime = actualtime * 0.8
            endif
            if i == 1 then
                set udg_DMG_AllItemCoolDownReset[id] = udg_DMG_AllItemCoolDownReset[id] * actualtime
            elseif i == -1 then
                set udg_DMG_AllItemCoolDownReset[id] = udg_DMG_AllItemCoolDownReset[id] / actualtime
            endif
            call DebugMsg("actualtime:" + R2S(actualtime))
            set actualtime = 1
            if itmtype == 'I00P' then
                if i == 1 then
                    set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] * 1.2
                else
                    set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] / 1.2
                endif
            endif
            if itmtype == 'I02V' then
                if i == 1 then
                    set udg_DMG_AllUnitDamageReduce[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllUnitDamageReduce[GetPlayerId(GetOwningPlayer(v))] * 0.5
                elseif i == -1 then
                    set udg_DMG_AllUnitDamageReduce[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllUnitDamageReduce[GetPlayerId(GetOwningPlayer(v))] / 0.5
                endif
            endif
            if itmtype == 'I037' then
                set drink = drink * (1 - 0.215)
            elseif itmtype == 'I06Y' then
                set drink = drink * (1 - 0.125)
            elseif itmtype == 'I01U' then
                set drink = drink * (1 - 0.125)
            elseif itmtype == 'I06R' then
                set drink = drink * (1 - 0.09)
            elseif itmtype == 'I08P' then
                set drink = drink * (1 - 0.09)
            elseif itmtype == 'I033' then
                set drink = drink * (1 - 0.15)
            endif
            if i == 1 then
                set udg_DMG_AllItemPhysicalDrink[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllItemPhysicalDrink[GetPlayerId(GetOwningPlayer(v))] * drink
            elseif i == -1 then
                set udg_DMG_AllItemPhysicalDrink[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllItemPhysicalDrink[GetPlayerId(GetOwningPlayer(v))] / drink
            endif
            set drink = 1
        endif
    endif
    set itm = null
    set p = null
    set v = null
endfunction

function InitTrig_AnyUnitGetItem takes nothing returns nothing
    set gg_trg_AnyUnitGetItem = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AnyUnitGetItem, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AnyUnitGetItem, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AnyUnitGetItem, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AnyUnitGetItem, EVENT_PLAYER_UNIT_PAWN_ITEM)
    call TriggerAddCondition(gg_trg_AnyUnitGetItem, Condition(function Trig_AnyUnitGetItem_Conditions))
    call TriggerAddAction(gg_trg_AnyUnitGetItem, function Trig_AnyUnitGetItem_Actions)
endfunction