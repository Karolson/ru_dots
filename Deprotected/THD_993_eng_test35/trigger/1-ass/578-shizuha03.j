function SHIZUHA03 takes nothing returns integer
    return 'A0G8'
endfunction

function SHIZUHA03_HIDDEN_SPELLBOOK takes nothing returns integer
    return 'A0GI'
endfunction

function SHIZUHA03_COMMAND_AURA takes nothing returns integer
    return 'A0G9'
endfunction

function SHIZUHA03_BUFF takes nothing returns integer
    return 'B07M'
endfunction

function SHIZUHA03_EFFECT takes nothing returns string
    return "Abilities\\Spells\\Other\\Parasite\\ParasiteMissile.mdl"
endfunction

function Shizuha03_Conditions takes nothing returns boolean
    local unit u
    local effect e
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        if GetLearnedSkill() == 'A0G8' then
            set u = GetTriggerUnit()
            if GetUnitAbilityLevel(u, 'A0GI') == 0 then
                call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'A0GI', false)
                call UnitAddAbility(u, 'A0GI')
                call UnitMakeAbilityPermanent(u, true, 'A0GI')
                call UnitMakeAbilityPermanent(u, true, 'A0G9')
            else
                call SetUnitAbilityLevel(u, 'A0G9', GetUnitAbilityLevel(u, 'A0G8'))
            endif
            set e = null
            set u = null
        endif
        return false
    elseif GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER then
        if GetIssuedOrderId() == 852177 then
            set u = GetTriggerUnit()
            set e = AddSpecialEffectTarget("Abilities\\Spells\\Other\\Parasite\\ParasiteMissile.mdl", u, "hand left")
            call SaveEffectHandle(udg_sht, StringHash("Shizuha03Effect"), GetHandleId(u), e)
        elseif GetIssuedOrderId() == 852178 then
            set u = GetTriggerUnit()
            set e = LoadEffectHandle(udg_sht, StringHash("Shizuha03Effect"), GetHandleId(u))
            call DestroyEffect(e)
            call RemoveSavedHandle(udg_sht, StringHash("Shizuha03Effect"), GetHandleId(u))
        endif
        set e = null
        set u = null
        return false
    endif
    set e = null
    set u = null
    if IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return GetUnitAbilityLevel(GetEventDamageSource(), 'B07M') > 0 and GetUnitState(GetEventDamageSource(), UNIT_STATE_MANA) >= 10
endfunction

function Shizuha03_Damage takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0G8')
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - 5)
    call UnitPhysicalDamageTarget(caster, target, 18 + 9 * level)
    call UnitInjureTarget(caster, target, 1.0 + level)
    set caster = null
    set target = null
endfunction

function InitTrig_shizuha03 takes nothing returns nothing
endfunction