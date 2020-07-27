function YUKARI02 takes nothing returns integer
    return 'A04L'
endfunction

function YUKARI02_COOLDOWN_BASE takes nothing returns real
    return 16.0
endfunction

function YUKARI02_COOLDOWN_SCALE takes nothing returns real
    return -1.0
endfunction

function YUKARI02_DAMAGE_BASE takes nothing returns real
    return 95.0
endfunction

function YUKARI02_DAMAGE_SCALE takes nothing returns real
    return 35.0
endfunction

function YUKARI02_DAMAGE_SCALE_FACTOR takes nothing returns real
    return 1.6
endfunction

function YUKARI02_DEBUFF_DURATION_BASE takes nothing returns real
    return 1.6
endfunction

function YUKARI02_DEBUFF_DURATION_SCALE takes nothing returns real
    return 0.3
endfunction

function YUKARI02_RADIUS takes nothing returns real
    return 225.0
endfunction

function YUKARI02_DELAY takes nothing returns real
    return 0.8
endfunction

function YUKARI02_EFFECT takes nothing returns string
    return "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl"
endfunction

function Trig_Yukari02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A04L'
endfunction

function Trig_Yukari02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local real x = LoadReal(udg_sht, task, 1)
    local real y = LoadReal(udg_sht, task, 2)
    local integer level = GetUnitAbilityLevel(caster, 'A04L')
    local group g = CreateGroup()
    local real damage = ABCIAllInt(caster, 95.0 + (level - 1) * 35.0, 1.6)
    local real duration = 1.6 + (level - 1) * 0.3
    local player p = GetOwningPlayer(caster)
    local unit v
    call GroupEnumUnitsInRange(g, x, y, 225.0, null)
    call UnitMagicDamageArea(caster, x, y, 225.0, damage, 5)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, p) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(v, 'Aloc') == 0 and GetUnitAbilityLevel(v, 'Avul') == 0 then
            if IsUnitType(v, UNIT_TYPE_HERO) then
                if udg_NewDebuffSys then
                    call UnitDebuffTarget(caster, v, duration * 1.0, 1, true, 'A0QI', 1, 'B07T', "drunkenhaze", 'A04N', "")
                else
                    call UnitCurseTarget(caster, v, duration, 'A06P', "drunkenhaze")
                endif
            else
                call UnitStunTarget(caster, v, duration, 0, 0)
            endif
        endif
    endloop
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", x, y))
    call ReleaseTimer(t)
    call DestroyGroup(g)
    set t = null
    set caster = null
    set g = null
endfunction

function Trig_Yukari02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A04L', 16.0 + GetUnitAbilityLevel(caster, 'A04L') * -1.0)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveReal(udg_sht, task, 1, GetSpellTargetX())
    call SaveReal(udg_sht, task, 2, GetSpellTargetY())
    call TimerStart(t, 0.8, false, function Trig_Yukari02_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_Yukari02 takes nothing returns nothing
endfunction