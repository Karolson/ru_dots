function Trig_Lyrica02Attack_Conditions takes nothing returns boolean
    local integer i
    if IsUnitType(GetEventDamageSource(), UNIT_TYPE_HERO) == false then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == false then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    set i = 0
    loop
        if udg_SK_Lyrica02_Unit[i] == GetEventDamageSource() and udg_SK_Lyrica02_Attack[i] then
            call PlaySoundOnUnitBJ(gg_snd_PianoChorus02b, 128, GetEventDamageSource())
            return true
        endif
        if udg_SK_Lyrica02_Unit[i] == GetTriggerUnit() and udg_SK_Lyrica02_Defend[i] then
            call PlaySoundOnUnitBJ(gg_snd_PianoChorus02c, 128, GetTriggerUnit())
            return true
        endif
        set i = i + 1
    exitwhen i > 6
    endloop
    return false
endfunction

function Trig_Lyrica02Attack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level
    local integer i
    local integer j
    set level = GetUnitAbilityLevel(udg_SK_Lyrica, 'A0TS')
    set i = 0
    loop
        if udg_SK_Lyrica02_Unit[i] == GetEventDamageSource() then
            set j = i
        endif
        if udg_SK_Lyrica02_Unit[i] == GetTriggerUnit() then
            set j = i
        endif
        set i = i + 1
    exitwhen i > 6
    endloop
    if udg_SK_Lyrica02_Unit[j] == caster and udg_SK_Lyrica02_Attack[j] then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnBirthMissile.mdl", GetUnitX(target), GetUnitY(target)))
        if udg_NewDebuffSys then
            call UnitSlowTargetNew(udg_SK_Lyrica, target, 35, 1.5 + level * 0.5, 2, 0)
        else
            call UnitSlowTarget(udg_SK_Lyrica, target, 1.5 + level * 0.5, 'A0BD', 'B02D')
        endif
        call UnitMagicDamageTarget(udg_SK_Lyrica, target, ABCIAllInt(caster, level * 30 + 30, 1.6), 1)
        set udg_SK_Lyrica02_Attack[j] = false
        if udg_SK_Lyrica02_Defend[j] == false then
            set udg_SK_Lyrica02_Unit[j] = null
            call DestroyEffect(udg_SK_Lyrica02_Effect[j])
            set udg_SK_Lyrica02_Effect[j] = null
        endif
    endif
    if udg_SK_Lyrica02_Unit[j] == target and udg_SK_Lyrica02_Defend[j] then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnBirthMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
        if udg_NewDebuffSys then
            call UnitSlowTargetNew(udg_SK_Lyrica, caster, 35, 1.5 + level * 0.5, 2, 0)
        else
            call UnitSlowTarget(udg_SK_Lyrica, caster, 1.5 + level * 0.5, 'A0BD', 'B02D')
        endif
        call UnitMagicDamageTarget(udg_SK_Lyrica, caster, ABCIAllInt(caster, level * 30 + 30, 1.6), 1)
        set udg_SK_Lyrica02_Defend[j] = false
        if udg_SK_Lyrica02_Attack[j] == false then
            set udg_SK_Lyrica02_Unit[j] = null
            call DestroyEffect(udg_SK_Lyrica02_Effect[j])
            set udg_SK_Lyrica02_Effect[j] = null
        endif
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Lyrica02Attack takes nothing returns nothing
endfunction