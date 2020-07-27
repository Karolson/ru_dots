function Trig_Shikieiki01_Active_Conditions takes nothing returns boolean
    local unit target
    if GetKillingUnit() == null then
        set target = null
        return false
    elseif GetUnitAbilityLevel(GetTriggerUnit(), 'Aloc') > 0 then
        set target = null
        return false
    elseif IsUnitIllusion(GetTriggerUnit()) then
        set target = null
        return false
    endif
    set target = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    if target == null then
        return false
    endif
    if GetWidgetLife(target) > 0.405 and GetUnitAbilityLevel(target, 'B02A') > 0 then
        set target = null
        return true
    endif
    set target = null
    return false
endfunction

function Trig_Shikieiki01_Active_Actions takes nothing returns nothing
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(GetTriggeringTrigger()), 0)
    local unit target = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    local integer level = GetUnitAbilityLevel(caster, 'A0B7')
    local real damage
    local unit u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) then
        set damage = GetUnitState(target, UNIT_STATE_MAX_LIFE) * (0.16 + 0.06 * level)
    else
        set damage = GetUnitState(target, UNIT_STATE_MAX_LIFE) * (0.03 + 0.01 * level)
        if GetUnitState(u, UNIT_STATE_MAX_LIFE) < 200 then
            set damage = damage * 0.5
        endif
    endif
    call DebugMsg("Punished by " + R2S(damage))
    call UnitAbsDamageTarget(caster, target, damage)
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl", target, "origin"))
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Shikieiki01_Active takes nothing returns nothing
endfunction