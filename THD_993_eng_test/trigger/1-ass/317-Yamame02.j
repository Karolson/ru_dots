function YAMAME02 takes nothing returns integer
    return 'A0JW'
endfunction

function YAMAME02_DEBUFF_SKILL takes nothing returns integer
    return 'A0JX'
endfunction

function YAMAME02_DEBUFF takes nothing returns integer
    return 'B07Q'
endfunction

function YAMAME02_RANGE takes nothing returns real
    return 600.0
endfunction

function YAMAME02_SPIDER_SPEED takes nothing returns real
    return 1400.0
endfunction

function YAMAME02_EFFECT takes nothing returns string
    return "Abilities\\Spells\\Items\\OrbCorruption\\OrbCorruptionMissile.mdl"
endfunction

function YAMAME02_DURATION takes nothing returns real
    return 6.0
endfunction

function YAMAME02_ADDITIONAL_MAGIC_DAMAGE takes integer level, real damage returns real
    return (0.03 + 0.03 * level) * damage
endfunction

function YAMAME02_FIRST_MAGIC_DAMAGE takes integer level, integer int returns real
    return 35.0 + 35.0 * level + 1.2 * int
endfunction

function YAMAME02_REMOVAL_PHYSICAL_DAMAGE takes integer level, integer damage returns real
    return 35.0 + 35.0 * level + 0.65 * damage
endfunction

function Yamame02_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    if GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, bj_groupEnumOwningPlayer) and GetUnitAbilityLevel(u, 'A0ER') > 0 or GetUnitAbilityLevel(u, 'A08A') > 0 then
        set u = null
        return true
    endif
    set u = null
    return false
endfunction

function Yamame02_OnHit takes nothing returns nothing
    local unit source = udg_PS_Source
    local unit target = udg_PS_Target
    set udg_PS_Source = null
    set udg_PS_Target = null
    call DebugMsg("Yamame02 Hit")
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\HowlOfTerror\\HowlTarget.mdl", target, "origin"))
    call UnitBuffTarget(source, target, 6.0, 'A0JX', 'B07Q')
    call UnitMagicDamageTarget(source, target, 35.0 + 35.0 * GetUnitAbilityLevel(source, 'A0JW') + 1.2 * GetHeroInt(source, true), 1)
    call DebugMsg("Hit For Damage of " + R2S(35.0 + 35.0 * GetUnitAbilityLevel(source, 'A0JW') + 1.2 * GetHeroInt(source, true)))
    set source = null
    set target = null
endfunction

function Yamame02_Conditions takes nothing returns boolean
    local unit u
    local unit v = GetTriggerUnit()
    local unit w
    local group g
    local filterfunc f
    local real d
    local integer i
    local player p
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        if GetSpellAbilityId() == 'A0JW' then
            call AbilityCoolDownResetion(v, 'A0JW', 10 - GetUnitAbilityLevel(v, 'A0JW'))
            set g = CreateGroup()
            set i = GetUnitAbilityLevel(v, 'A0JW')
            set p = GetOwningPlayer(v)
            call GroupEnumUnitsInRange(g, GetUnitX(v), GetUnitY(v), 600.0, null)
            loop
                set u = FirstOfGroup(g)
            exitwhen u == null
                call GroupRemoveUnit(g, u)
                if GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, p) and GetUnitAbilityLevel(u, 'A0ER') > 0 or GetUnitAbilityLevel(u, 'A08A') > 0 then
                    call LaunchProjectileToUnit("Abilities\\Spells\\Items\\OrbCorruption\\OrbCorruptionMissile.mdl", 0.35, v, 1400.0, u, "Yamame02_OnHit")
                endif
                call DebugMsg("Yamame02 Launched")
            endloop
            call DestroyGroup(g)
        endif
    else
        set u = GetEventDamageSource()
        set v = GetTriggerUnit()
        set d = GetEventDamage()
        set i = GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(u)), 'A0JW')
        if i > 0 and IsUnitEnemy(v, GetOwningPlayer(u)) and d > 1 and IsDamagePhsyicalAbilityDamage(u) or not IsDamageNotUnitAttack(u) then
            call DisableTrigger(gg_trg_Yamame02)
            set w = NewSpecialDummy(GetOwningPlayer(u), GetUnitX(v), GetUnitY(v), 0.0)
            call UnitMagicDamageTarget(w, v, (0.03 + 0.03 * i) * (d * 1.0), 2)
            call ReleaseSpecialDummy(w)
            call DebugMsg("Additional Damage On Hit of " + R2S((0.03 + 0.03 * i) * (d * 1.0)))
            call EnableTrigger(gg_trg_Yamame02)
        endif
        if i > 0 and d > 1 and GetUnitAbilityLevel(v, 'A0JX') > 0 and not IsDamageNotUnitAttack(u) then
            call UnitRemoveAbility(v, 'A0JX')
            call UnitRemoveAbility(v, 'B07Q')
            call DisableTrigger(gg_trg_Yamame02)
            call UnitPhysicalDamageTarget(u, v, 35.0 + 35.0 * i + 0.65 * GetUnitAttack(u))
            call DebugMsg("Removal Physical Damage of " + R2S(35.0 + 35.0 * i + 0.65 * GetUnitAttack(u)))
            call EnableTrigger(gg_trg_Yamame02)
        endif
    endif
    set u = null
    set v = null
    set g = null
    set f = null
    return false
endfunction

function InitTrig_Yamame02 takes nothing returns nothing
endfunction