function AKYU02 takes nothing returns integer
    return 'A0P5'
endfunction

function AKYU02_DEBUFF_SKILL takes nothing returns integer
    return 'A0PE'
endfunction

function AKYU02_DEBUFF_SKILL_ALLY takes nothing returns integer
    return 'A0IV'
endfunction

function AKYU02_DEBUFF takes nothing returns integer
    return 'B07V'
endfunction

function Akyu02_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local unit v
    if GetSpellAbilityId() == 'A0P5' then
        call AbilityCoolDownResetion(u, 'A0P5', 14 - 2 * GetUnitAbilityLevel(u, 'A0P5'))
        set v = GetSpellTargetUnit()
        if IsUnitEnemy(v, GetTriggerPlayer()) then
            call CE_Input(u, v, 200)
            if IsUnitType(v, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(v))] and IsUnitIllusion(v) == false then
                call Item_BLTalismanicRunningCD(v)
                set u = null
                set v = null
                return false
            endif
        endif
        call UnitHealingTarget(u, v, 50.0 + 50.0 * GetUnitAbilityLevel(u, 'A0P5') + 1.5 * GetHeroInt(u, true))
        if IsUnitEnemy(v, GetTriggerPlayer()) then
            if udg_NewDebuffSys then
                call UnitSlowTargetMspd(u, v, 70, 2.0 + 1.0 * GetUnitAbilityLevel(u, 'A0P5'), 3, 'A0CH')
            else
                call UnitSlowTarget(u, v, 2.0 + 1.0 * GetUnitAbilityLevel(u, 'A0P5'), 'A0PE', 'B07V')
            endif
        else
            if udg_NewDebuffSys then
                call UnitSlowTargetMspd(u, v, 35, 2.0 + 1.0 * GetUnitAbilityLevel(u, 'A0P5'), 3, 'A0CH')
            else
                call UnitSlowTarget(u, v, 2.0 + 1.0 * GetUnitAbilityLevel(u, 'A0P5'), 'A0IV', 'B07V')
            endif
        endif
    endif
    set u = null
    set v = null
    return false
endfunction

function InitTrig_Akyu02 takes nothing returns nothing
endfunction