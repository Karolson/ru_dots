function Trig_SakuyaClock_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0QT'
endfunction

function Trig_SakuyaClock_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    local real abilitycooldownlv01 = 9
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I00B') then
        call Item_KeineAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv01)
    endif
    if udg_SK_SakuyaEX_ClockSwitch[k] == false then
        set udg_SK_SakuyaEX_Effect[k] = AddSpecialEffectTarget("Abilities\\Weapons\\SpiritOfVengeanceMissile\\SpiritOfVengeanceMissile.mdl", GetTriggerUnit(), "hand")
        set udg_SK_SakuyaEX_ClockSwitch[k] = true
    endif
    set caster = null
endfunction

function InitTrig_SakuyaClock takes nothing returns nothing
endfunction