function ReimuAb03 takes nothing returns integer
    return 'A04A'
endfunction

function Trig_Reimu03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A04A'
endfunction

function Trig_Reimu03_Functioned takes unit caster, unit target, real d1, real d2 returns nothing
    if IsUnitAlly(target, GetTriggerPlayer()) then
        call UnitBuffTarget(caster, target, d2, 'A01T', 0)
    else
        if udg_NewDebuffSys then
            call UnitDebuffTarget(caster, target, d1 * 1.0, 1, true, 'A04D', 1, 'B084', "drunkenhaze", 'A05M', "")
        else
            call UnitCurseTarget(caster, target, d1, 'A04E', "drunkenhaze")
            call CE_Input(caster, target, 200)
        endif
    endif
endfunction

function Trig_Reimu03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer abid = GetSpellAbilityId()
    local integer level = GetUnitAbilityLevel(caster, abid)
    local real d1 = 2.0 + 1.0 * level
    local real d2 = 2.0 + 1.0 * level
    call AbilityCoolDownResetion(caster, abid, 15)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
        endif
    endif
    call Trig_Reimu03_Functioned(caster, target, d1, d2)
    set caster = null
    set target = null
endfunction

function InitTrig_Reimu03 takes nothing returns nothing
endfunction