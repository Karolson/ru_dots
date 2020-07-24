function Trig_Sunny02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0VA'
endfunction

function Trig_Sunny02_ClearLightning takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local lightning e = LoadLightningHandle(udg_ht, task, 0)
    call DestroyLightning(e)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set e = null
endfunction

function Trig_Sunny02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0VA')
    local integer i
    local real ltx1 = GetUnitX(caster)
    local real ltx2
    local real lty1 = GetUnitY(caster)
    local real lty2
    local real ltz1 = GetPositionZ(ltx1, lty1) + 135.0
    local real ltz2
    local lightning e
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, 'A0VA', 17 - level)
    call UnitStunArea(caster, 2, ltx1, lty1, 200 + level * 25, 0, 0)
    call UnitMagicDamageArea(caster, ltx1, lty1, 175 + level * 50, ABCIAllInt(caster, 50 + 35 * level, 1.9), 5)
    set i = 0
    loop
        set ltx2 = ltx1 + (175 + level * 50) * Cos(i * 60 * 0.017454)
        set lty2 = lty1 + (175 + level * 50) * Sin(i * 60 * 0.017454)
        set ltz2 = GetPositionZ(ltx2, lty2)
        set e = AddLightningEx("TCLE", false, ltx1, lty1, ltz1, ltx2, lty2, ltz2)
        call SetLightningColor(e, 1.0, 1.0, 0.0, 1.0)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveLightningHandle(udg_ht, task, 0, e)
        call TimerStart(t, 0.4, false, function Trig_Sunny02_ClearLightning)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", ltx2, lty2))
        set i = i + 1
    exitwhen i == 6
    endloop
    set caster = null
    set e = null
    set t = null
endfunction

function InitTrig_Sunny02 takes nothing returns nothing
endfunction