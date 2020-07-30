function Trig_Yuyuko02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0QM'
endfunction

function Trig_Yuyuko02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 15)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call UnitDebuffTarget(caster, target, 2.0 + I2R(level), 1, true, 'A05B', level, 'BUsl', "sleep", 0, "")
    call CCSystem_textshow("Sleep", target, DebuffDuration(target, 2.0 + I2R(level)))
    set caster = null
    set target = null
endfunction

function InitTrig_Yuyuko02 takes nothing returns nothing
endfunction