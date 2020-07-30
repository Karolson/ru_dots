function Trig_LunasaDamage takes unit caster, unit v, real damage, integer dtype returns nothing
    local integer id = GetConvertedPlayerId(GetOwningPlayer(caster))
    local real k = 1 + udg_SK_Lunasa02_Buff[id] * 0.01
    call UnitMagicDamageTarget(caster, v, damage * k, dtype)
endfunction

function Trig_LunasaAttack_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetEventDamageSource()) != 'E01N' then
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

function Trig_LunasaAttack_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer difflevel = LoadInteger(udg_ht, task, 2)
    local integer armorlevel
    if IsUnitDead(target) then
        call UnitRemoveAbility(target, 'A0V6')
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    elseif i == 0 then
        set armorlevel = GetUnitAbilityLevel(target, 'A0V5') - difflevel
        if armorlevel <= 0 then
            call UnitRemoveAbility(target, 'A0V6')
        else
            call SetUnitAbilityLevel(target, 'A0V5', armorlevel)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        call SaveInteger(udg_ht, task, 1, i - 1)
    endif
    set t = null
    set target = null
endfunction

function Trig_LunasaAttack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real damage = 0
    local timer t
    local boolean b
    local integer level
    local integer changelevel
    local integer armorlevel
    local integer oldlevel
    local integer difflevel
    local integer id = GetConvertedPlayerId(GetOwningPlayer(caster))
    if udg_SK_LunasaEx_Count[id] == 1 or udg_SK_LunasaEx_Count[id] == 3 then
        set udg_SK_LunasaEx_Count[id] = udg_SK_LunasaEx_Count[id] + 1
        call PlaySoundOnUnitBJ(gg_snd_ViolinChorusG, 100, caster)
    elseif udg_SK_LunasaEx_Count[id] == 2 then
        set udg_SK_LunasaEx_Count[id] = udg_SK_LunasaEx_Count[id] + 1
        call PlaySoundOnUnitBJ(gg_snd_ViolinChorusG2, 100, caster)
    else
        set udg_SK_LunasaEx_Count[id] = 1
        call PlaySoundOnUnitBJ(gg_snd_ViolinChorusF_u, 100, caster)
        set damage = damage + 20 + 3 * GetHeroLevel(caster)
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
        set level = GetUnitAbilityLevel(caster, 'A0OH')
        if level > 0 and IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
            set damage = damage + ABCIExtraInt(caster, 10 * level, 0.2)
            set b = false
            set changelevel = level
            set oldlevel = GetUnitAbilityLevel(target, 'A0V5')
            set armorlevel = oldlevel + changelevel
            if armorlevel > level * 16 then
                set armorlevel = level * 16
            endif
            if armorlevel > oldlevel then
                set difflevel = armorlevel - oldlevel
                if GetUnitAbilityLevel(target, 'A0V6') == 0 then
                    call UnitAddAbility(target, 'A0V6')
                endif
                call SetUnitAbilityLevel(target, 'A0V5', armorlevel)
                set b = true
            endif
            if b then
                set t = CreateTimer()
                call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
                call SaveInteger(udg_ht, GetHandleId(t), 1, 9)
                call SaveInteger(udg_ht, GetHandleId(t), 2, difflevel)
                call TimerStart(t, 1.0, true, function Trig_LunasaAttack_Fade)
            endif
        endif
    endif
    if damage > 0 then
        call Trig_LunasaDamage(caster, target, damage, 2)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", GetUnitX(target), GetUnitY(target)))
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_LunasaAttack takes nothing returns nothing
endfunction