function Seiga04 takes nothing returns integer
    return 'A1FM'
endfunction

function Trig_Seiga04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FM'
endfunction

function Trig_Seiga04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A1FM')
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call VE_Spellcast(caster)
        call AbilityCoolDownResetion(caster, 'A1FM', 150 - 30 * level)
        call SaveUnitHandle(udg_ht, GetHandleId(caster), StringHash("Seiga04"), GetSpellTargetUnit())
    elseif GetTriggerEventId() == EVENT_UNIT_SPELL_FINISH then
        set target = LoadUnitHandle(udg_ht, GetHandleId(caster), StringHash("Seiga04"))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", x, y))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", GetUnitX(target), GetUnitY(target)))
        call SetUnitX(target, x)
        call SetUnitY(target, y)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Seiga04 takes nothing returns nothing
endfunction