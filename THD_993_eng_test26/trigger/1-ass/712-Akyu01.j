function AKYU01 takes nothing returns integer
    return 'A0P1'
endfunction

function Akyu01_OnHit takes nothing returns boolean
    local unit source = udg_PS_Source
    local unit target = udg_PS_Target
    set udg_PS_Source = null
    set udg_PS_Target = null
    call UnitMagicDamageTarget(source, target, (1.0 + udg_SK_Akyu01) * (45.0 + GetUnitAbilityLevel(source, 'A0P1') * 45.0 + 1.75 * GetHeroInt(source, true)), 1)
    set udg_SK_Akyu01 = 0.99 * udg_SK_Akyu01
    set source = null
    set target = null
    return false
endfunction

function Akyu01_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local unit v
    if IsUnitInRange(u, udg_SK_Akyu, 1200.0) and IsUnitEnemy(u, GetOwningPlayer(udg_SK_Akyu)) and IsUnitType(u, UNIT_TYPE_HERO) then
        if udg_GameMode / 100 == 3 or udg_NewMid then
            set udg_SK_Akyu01 = udg_SK_Akyu01 + 0.006
        else
            set udg_SK_Akyu01 = udg_SK_Akyu01 + 0.006 * 0.5
        endif
        call DisplayTextToPlayer(GetOwningPlayer(udg_SK_Akyu), 0, 0, "'Gensokyo Cycle' bonus damage: " + R2S(udg_SK_Akyu01 * 100.0) + "%")
    elseif GetSpellAbilityId() == 'A0P1' then
        call AbilityCoolDownResetion(u, 'A0P1', 14 - 2 * GetUnitAbilityLevel(u, 'A0P1'))
        call DisplayTextToPlayer(GetOwningPlayer(udg_SK_Akyu), 0, 0, "'Gensokyo Cycle' bonus damage: " + R2S(0.97 * udg_SK_Akyu01 * 100.0) + "%")
        set v = GetSpellTargetUnit()
        if IsUnitEnemy(v, GetTriggerPlayer()) then
            if IsUnitType(v, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(v))] and IsUnitIllusion(v) == false then
                call Item_BLTalismanicRunningCD(v)
                set u = null
                set v = null
                return false
            endif
        endif
        call LaunchProjectileToUnit("Abilities\\Weapons\\ProcMissile\\ProcMissile.mdl", 1.0, u, 1400.0, v, "Akyu01_OnHit")
    endif
    set u = null
    set v = null
    return false
endfunction

function InitTrig_Akyu01 takes nothing returns nothing
endfunction