function Trig_Sanae02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A06V'
endfunction

function Trig_Sanae02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local unit u
    local real px = LoadReal(udg_Hashtable, task, 0)
    local real py = LoadReal(udg_Hashtable, task, 1)
    local integer i = LoadInteger(udg_Hashtable, task, 1)
    local integer level = GetUnitAbilityLevel(caster, 'A06V')
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    local real a
    if i > 0 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", px, py))
        if i == 3 then
            call UnitStunArea(caster, 2.0, px, py, 220, 0, 0)
            call UnitMagicDamageArea(caster, px, py, 220.0, 35 * level - 25 + 1.5 * GetHeroInt(caster, true) + 0.25 * GetUnitMoveSpeed(caster), 5)
            set a = 0.0
            loop
            exitwhen a > 6.2831
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", px + 170.0 * Cos(a), py + 170.0 * Sin(a)))
                set a = a + 0.7854
            endloop
        endif
        call SaveInteger(udg_Hashtable, task, 1, i - 1)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set u = null
    set g = null
    set v = null
    set iff = null
endfunction

function Sanae02_Enemy_Filter takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), bj_groupEnumOwningPlayer) and GetOwningPlayer(GetFilterUnit()) != Player(12) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

function Trig_Sanae02_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local group g = CreateGroup()
    local unit u
    local filterfunc f = Filter(function Sanae02_Enemy_Filter)
    set bj_groupEnumOwningPlayer = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 800.0, f)
    set bj_groupEnumOwningPlayer = null
    call DestroyFilter(f)
    set f = null
    set u = FirstOfGroup(g)
    if u != null then
        call AbilityCoolDownResetion(caster, 'A06V', 10)
    endif
    set u = null
    call DestroyGroup(g)
    set g = null
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveInteger(udg_Hashtable, task, 1, 5)
    call SaveReal(udg_Hashtable, task, 0, GetSpellTargetX())
    call SaveReal(udg_Hashtable, task, 1, GetSpellTargetY())
    call TimerStart(t, 0.1, true, function Trig_Sanae02_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Sanae02 takes nothing returns nothing
endfunction