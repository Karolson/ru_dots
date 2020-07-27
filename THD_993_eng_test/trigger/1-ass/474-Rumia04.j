function Trig_Rumia04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A07J'
endfunction

function Trig_Rumia04_Actions takes nothing returns nothing
    local unit hero = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real heroX = GetUnitX(hero)
    local real heroY = GetUnitY(hero)
    local integer level = GetUnitAbilityLevel(hero, 'A07J')
    local real targetLife = GetUnitState(target, UNIT_STATE_LIFE)
    local real gainLife
    local real damage
    local boolean uuz = false
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(hero, 'A07J', 75 - 10 * level)
    else
        call AbilityCoolDownResetion(hero, 'A07J', (75 - 10 * level) * 0.5)
    endif
    set damage = level * 175.0 + 175.0
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set gainLife = UnitDelDamageTarget(hero, target, damage)
        if GetUnitAbilityLevel(target, 'A0MM') != 0 then
            set uuz = true
        endif
        if IsUnitType(target, UNIT_TYPE_DEAD) or uuz then
            call UnitAddMaxLife(hero, R2I(40 + 25 * Pow(1.2, (1 - udg_SK_Rumia04_Life / 400) * 8)))
            call UnitAddBonusDmg(hero, 5)
            set udg_SK_Rumia04_Life = udg_SK_Rumia04_Life + R2I(40 + 25 * Pow(1.2, (1 - udg_SK_Rumia04_Life / 400) * 8))
        endif
    else
        set gainLife = damage
        call InstantKill(hero, target)
        call UnitAddMaxLife(hero, 20)
        call UnitAddBonusDmg(hero, 1)
        set udg_SK_Rumia04_Life = udg_SK_Rumia04_Life + 20
    endif
    call UnitHealingTarget(hero, hero, gainLife)
    set hero = null
    set target = null
endfunction

function InitTrig_Rumia04 takes nothing returns nothing
endfunction