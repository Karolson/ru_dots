function Trig_ReimuN03_Functioned takes unit caster, unit target, integer level, real dur returns nothing
    call SetUnitX(caster, GetUnitX(target))
    call SetUnitY(caster, GetUnitY(target))
    call KillUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e014', GetUnitX(caster), GetUnitY(caster), 22.5))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(caster), GetUnitY(caster)))
    call UnitStunTarget(caster, target, 0.3, 0, 0)
    call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 30 + 30 * level, 3.4), 5)
endfunction

function Trig_ReimuN03_Conditions takes nothing returns boolean
    local unit caster
    local unit target
    local integer abid = GetSpellAbilityId()
    local integer level
    if abid != 'A1G7' then
        return false
    endif
    set caster = GetTriggerUnit()
    set target = GetSpellTargetUnit()
    set level = GetUnitAbilityLevel(caster, abid)
    call AbilityCoolDownResetion(caster, abid, 18 - level * 2)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
        endif
    endif
    call Trig_ReimuN03_Functioned(caster, target, level, 2.5)
    set caster = null
    set target = null
    return false
endfunction

function Trig_ReimuN03_Actions takes nothing returns nothing
endfunction

function InitTrig_ReimuN03 takes nothing returns nothing
    set gg_trg_ReimuN03 = CreateTrigger()
    call DisableTrigger(gg_trg_ReimuN03)
    call TriggerAddCondition(gg_trg_ReimuN03, Condition(function Trig_ReimuN03_Conditions))
    call TriggerAddAction(gg_trg_ReimuN03, function Trig_ReimuN03_Actions)
endfunction