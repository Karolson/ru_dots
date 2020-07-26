function Trig_MerlinAttack_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetEventDamageSource()) != 'E01W' then
        return false
    endif
    if IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    if IsUnitType(GetEventDamageSource(), UNIT_TYPE_HERO) == false then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_MerlinAttack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetAttackedUnitBJ()
    if target == caster then
       call DebugMsg("Merlin Trying to attack herself!")
    elseif udg_SK_MerlinEx_Count < 4 then
        set udg_SK_MerlinEx_Count = udg_SK_MerlinEx_Count + 1
        call PlaySoundOnUnitBJ(gg_snd_TrumpetChorusA_u, 100, caster)
    else
        set udg_SK_MerlinEx_Count = 1
        call PlaySoundOnUnitBJ(gg_snd_TrumpetChorusD, 100, caster)
        call UnitMagicDamageTarget(caster, target, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.07, 2)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_MerlinAttack takes nothing returns nothing
endfunction