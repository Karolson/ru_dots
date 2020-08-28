function Trig_PachiliAC_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0WC'
endfunction

function Trig_PachiliAC_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer count = LoadInteger(udg_ht, task, 4) + 1
    local unit v
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 2)
    local real y = LoadReal(udg_ht, task, 3)
    local integer level = GetUnitAbilityLevel(caster, 'A0WC')
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real a
    local real r
    local integer i
    set i = 0
    loop
        set a = GetRandomInt(0, 360)
        set r = GetRandomInt(0, 215)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", x + r * CosBJ(a), y + r * SinBJ(a)))
        set i = i + 1
    exitwhen i == 16
    endloop
    call GroupEnumUnitsInRange(g, x, y, 250, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitSlowTargetMspd(caster, v, 15 + 5 * level, 1.0, 3, 0)
            call Public_PacQ_MagicDamage(caster, v, 18 + level * 18 + 0.8 * GetHeroInt(caster, true), 5)
        endif
    endloop
    call DestroyGroup(g)
    if count >= 3 then
        call UnRegisterAreaShow(caster, 'A0X6')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        call SaveInteger(udg_ht, task, 4, count)
    endif
    set v = null
    set g = null
    set iff = null
    set caster = null
    set t = null
endfunction

function Trig_PachiliAC_Actions takes nothing returns nothing
    local unit v
    local unit caster = GetTriggerUnit()
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local group g = CreateGroup()
    local integer level = GetUnitAbilityLevel(caster, 'A0WC')
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real a
    local real r
    local integer i
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0WC')
    call PlaySoundOnUnitBJ(gg_snd_Feedback, 128, caster)
    call RegisterAreaShowXY(caster, 'A0X6', x, y, 250, 12, 1, "Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", 1)
    set i = 0
    loop
        set a = GetRandomInt(0, 360)
        set r = GetRandomInt(0, 215)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", x + r * CosBJ(a), y + r * SinBJ(a)))
        set i = i + 1
    exitwhen i == 16
    endloop
    call GroupEnumUnitsInRange(g, x, y, 250, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitSlowTargetMspd(caster, v, 15 + 5 * level, 1.0, 3, 0)
            call Public_PacQ_MagicDamage(caster, v, 18 + level * 18 + 0.8 * GetHeroInt(caster, true), 5)
        endif
    endloop
    call DestroyGroup(g)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveReal(udg_ht, task, 2, x)
    call SaveReal(udg_ht, task, 3, y)
    call SaveInteger(udg_ht, task, 4, 0)
    call TimerStart(t, 1, true, function Trig_PachiliAC_Main)
    set v = null
    set g = null
    set iff = null
    set caster = null
    set t = null
endfunction

function InitTrig_PachiliAC takes nothing returns nothing
endfunction