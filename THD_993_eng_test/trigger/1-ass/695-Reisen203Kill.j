function Trig_Reisen203Kill_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit())), 'A092') > 0 and IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetKillingUnit()))
endfunction

function Trig_Reisen203Kill_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A092')
    local real olddamage = udg_SK_Reisen203_ExtraDam
    local real newdamage = RMaxBJ(50, GetUnitState(target, UNIT_STATE_MAX_LIFE) - 400) * (0.03 + 0.03 * level)
    if newdamage > olddamage then
        set udg_SK_Reisen203_ExtraDam = newdamage
        call UnitAddAbility(caster, 'A0B5')
        call DebugMsg("Reisen203 Attack Added: " + R2S(udg_SK_Reisen203_ExtraDam))
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Reisen203Kill takes nothing returns nothing
endfunction