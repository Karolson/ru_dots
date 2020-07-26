function Trig_Satsuki02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1H7'
endfunction

function Trig_Satsuki02_CallBack takes nothing returns nothing
    local unit caster = udg_PS_Source
    local player p = GetOwningPlayer(caster)
    local group g = udg_PS_OnHit_Group
    local integer level = GetUnitAbilityLevel(caster, 'A1H7')
    local integer slowBuffId = 'A1H8'
    local integer armorBuffId = 'A1ID'
    local unit v
    if level == 1 then
        set slowBuffId = 'A1H8'
        set armorBuffId = 'A1ID'
    elseif level == 2 then
        set slowBuffId = 'A1H9'
        set armorBuffId = 'A1II'
    elseif level == 3 then
        set slowBuffId = 'A1HA'
        set armorBuffId = 'A1IJ'
    elseif level == 4 then
        set slowBuffId = 'A1HB'
        set armorBuffId = 'A1IK'
    else
        call BJDebugMsg("bug! Trig_Satsuki02_CallBack")
    endif
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, p) == false then
            call UnitSlowTarget(caster, v, 4, slowBuffId, 'B0A5')
            if IsUnitType(v, UNIT_TYPE_HERO) == false then
                call UnitMagicDamageTarget(caster, v, ABCIAllAtk(caster, 5 - 20 + 15 * level, 0.5) * 2.0, 1)
            else
                call UnitMagicDamageTarget(caster, v, ABCIAllAtk(caster, 5 - 20 + 15 * level, 0.5), 1)
            endif
            call UnitSlowTarget(caster, v, 4, armorBuffId, 0)
        endif
    endloop
    set caster = null
    set p = null
    set g = null
    set v = null
endfunction

function Trig_Satsuki02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox) * bj_RADTODEG - 15
    local integer i = 0
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 14 - 2 * level)
    loop
    exitwhen i >= 5
        call LaunchProjectileFromUnitToPoint("Abilities\\Weapons\\SorceressMissile\\SorceressMissile.mdl", 1.5, caster, ox + Cos(a * bj_DEGTORAD) * (800 + 100), oy + Sin(a * bj_DEGTORAD) * (800 + 100), 1400, 100, "", "Trig_Satsuki02_CallBack", false, true, true)
        set a = a + 7.5
        set i = i + 1
    endloop
    set caster = null
endfunction

function InitTrig_Satsuki02 takes nothing returns nothing
endfunction