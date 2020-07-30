function Trig_LyricaAttack_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetEventDamageSource()) != 'E020' then
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

function Trig_LyricaAttack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetAttackedUnitBJ()
    if udg_SK_LyricaEx_Count < 4 then
        set udg_SK_LyricaEx_Count = udg_SK_LyricaEx_Count + 1
        call PlaySoundOnUnitBJ(gg_snd_PianoChorusE, 100, caster)
    else
        set udg_SK_LyricaEx_Count = 1
        call PlaySoundOnUnitBJ(gg_snd_PianoChorusF_u, 100, caster)
        call UnitMagicDamageArea(caster, GetUnitX(target), GetUnitY(target), 300, 65, 6)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_LyricaAttack takes nothing returns nothing
endfunction