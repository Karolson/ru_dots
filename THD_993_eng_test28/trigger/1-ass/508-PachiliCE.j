function Trig_PachiliCE_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0XI'
endfunction

function Trig_PachiliCE_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local destructable w = LoadDestructableHandle(udg_Hashtable, task, 0)
    call RemoveDestructable(w)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, task)
    set t = null
    set w = null
endfunction

function Trig_PachiliCE_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real px
    local real py
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0XI')
    local integer i
    local integer j
    local timer t
    local integer task
    local destructable w
    local group g
    local group m
    local boolexpr iff
    local unit v
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0XI')
    call PlaySoundOnUnitBJ(gg_snd_FreezingBreathTarget1, 128, caster)
    set m = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    set i = 0
    set j = 3 + level * 2 - 1
    loop
        if i / 2 * 2 == i then
            set px = tx + 64 * (i / 2) * Cos(a + 1.570795)
            set py = ty + 64 * (i / 2) * Sin(a + 1.570795)
        else
            set px = tx + 64 * ((i + 1) / 2) * Cos(a - 1.570795)
            set py = ty + 64 * ((i + 1) / 2) * Sin(a - 1.570795)
        endif
        set w = CreateDestructable('B02V', px, py, a * 57.29578, 0.7, 0)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveDestructableHandle(udg_Hashtable, task, 0, w)
        call TimerStart(t, 5.0 + 1.0 * level, false, function Trig_PachiliCE_Clear)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathMissile.mdl", px, py))
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 175.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                call Public_PacQ_MagicDamage(caster, v, 43 + level * 43 + 1.65 * GetHeroInt(caster, true), 5)
            endif
        endloop
        call DestroyGroup(g)
        set i = i + 1
    exitwhen i > j
    endloop
    call DestroyGroup(m)
    set t = null
    set caster = null
    set g = null
    set m = null
    set iff = null
    set v = null
    set w = null
endfunction

function InitTrig_PachiliCE takes nothing returns nothing
endfunction