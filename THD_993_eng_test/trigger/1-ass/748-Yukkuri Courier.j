function Trig_Yukkuri_Courier_Acitions takes nothing returns boolean
    local unit u
    local integer id = GetSpellAbilityId()
    local integer count
    local integer courierType
    if id == 'A1IE' or id == 'A1IL' then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())))
    elseif id == 'A1IM' then
        set count = LoadInteger(udg_Hashtable_UnitStatus, StringHash("YukkuriSummoned"), 1) + 1
        if (count <= 10 and GetRandomInt(1, 100) == 1) or (count > 10 and GetRandomInt(1, 10000) == 1) then
            set courierType = 'h02N'
        else
            set courierType = 'h00B'
        endif
        set u = GetTriggerUnit()
        set u = CreateUnit(GetOwningPlayer(u), courierType, GetUnitX(u) + 128 * CosBJ(GetUnitFacing(u)), GetUnitY(u) + 128 * SinBJ(GetUnitFacing(u)), 180 + GetUnitFacing(u))
        call SaveInteger(udg_Hashtable_UnitStatus, StringHash("YukkuriSummoned"), 1, count)
        call SaveBoolean(udg_Hashtable_UnitStatus, GetHandleId(u), StringHash("IsCourier"), true)
        set u = null
    endif
    return false
endfunction

function InitTrig_Yukkuri_Courier takes nothing returns nothing
    set gg_trg_Yukkuri_Courier = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Yukkuri_Courier, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yukkuri_Courier, Condition(function Trig_Yukkuri_Courier_Acitions))
endfunction