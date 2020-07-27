function Trig_Kisume04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RB'
endfunction

function Trig_Skill_W_OnTimer takes nothing returns nothing
    local integer id = GetHandleId(GetExpiredTimer())
    local integer n = LoadInteger(udg_ht, id, 0)
    local integer k = 1
    local real x = LoadReal(udg_ht, id, 1)
    local real y = LoadReal(udg_ht, id, 2)
    local real dx = 0.0
    local real dy = 0.0
    local string fx1 = "Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl"
    local string fx2 = "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl"
    if n > 25 then
        call FlushChildHashtable(udg_ht, id)
        call ReleaseTimer(GetExpiredTimer())
        return
    endif
    if n <= 12 and n / 2 * 2 == n then
        loop
            set dx = x + 450.0 / 25.0 * 2 * n * Cos(bj_DEGTORAD * (360.0 * k / 6.0 - 90.0 * (2 * n / 25.0)))
            set dy = y + 450.0 / 25.0 * 2 * n * Sin(bj_DEGTORAD * (360.0 * k / 6.0 - 90.0 * (2 * n / 25.0)))
            call DestroyEffect(AddSpecialEffect(fx1, dx, dy))
            set k = k + 1
        exitwhen k > 6
        endloop
    elseif n > 12 and n / 2 * 2 == n then
        loop
            set dx = x + 450.0 * Cos(bj_DEGTORAD * (360.0 * k / 6.0 + 90.0 * ((2 * n - 25.0) / 25.0 - 1.0)))
            set dy = y + 450.0 * Sin(bj_DEGTORAD * (360.0 * k / 6.0 + 90.0 * ((2 * n - 25.0) / 25.0 - 1.0)))
            call DestroyEffect(AddSpecialEffect(fx2, dx, dy))
            set k = k + 1
        exitwhen k > 6
        endloop
    endif
    call SaveInteger(udg_ht, id, 0, n + 1)
endfunction

function Trig_Kisume04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit w
    local unit v
    local integer level = GetUnitAbilityLevel(caster, 'A0RB')
    local group g
    local boolexpr iff
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local boolean instun = false
    local timer t = CreateTimer()
    local integer id = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 140 - level * 20)
    call VE_Spellcast(caster)
    call SaveInteger(udg_ht, id, 0, 0)
    call SaveReal(udg_ht, id, 1, ox)
    call SaveReal(udg_ht, id, 2, oy)
    call TimerStart(t, 0.02, true, function Trig_Skill_W_OnTimer)
    call DestroyEffect(AddSpecialEffectTarget("Units\\NightElf\\Wisp\\WispExplode.mdl", caster, "chest"))
    if udg_SK_KisumeEX_Count >= 4 then
        set udg_SK_KisumeEX_Count = 0
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Well Bucket 'Well Destructor' stacks: |r" + I2S(udg_SK_KisumeEX_Count) + " |r")
        set instun = true
    else
        set udg_SK_KisumeEX_Count = udg_SK_KisumeEX_Count + 1
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Well Bucket 'Well Destructor' stacks: |r" + I2S(udg_SK_KisumeEX_Count) + " |r")
        set instun = false
    endif
    if udg_SK_KisumeEX_Count == 4 then
        call UnitAddAbility(caster, 'A08L')
    endif
    if udg_SK_KisumeEX_Count == 0 then
        call UnitRemoveAbility(caster, 'A08L')
    endif
    call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.05)
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, ox, oy, 450, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 150 + level * 250, 3.0), 5)
            if instun then
                call UnitStunTarget(caster, v, 1.7, 0, 0)
            endif
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set u = null
    set v = null
    set w = null
    set g = null
    set iff = null
    set t = null
endfunction

function InitTrig_Kisume04 takes nothing returns nothing
endfunction