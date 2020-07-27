function Trig_Kisume03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RA'
endfunction

function Trig_Kisume03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    if udg_SK_Kisume03_Effect != null then
        call DestroyEffect(udg_SK_Kisume03_Effect)
        set udg_SK_Kisume03_Effect = null
    endif
    set udg_SK_Kisume03_Count = 0
    call ReleaseTimer(t)
    set t = null
endfunction

function Trig_Kisume03_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local unit caster = GetTriggerUnit()
    local unit u
    local unit w
    local unit v
    local integer level = GetUnitAbilityLevel(caster, 'A0RA')
    local integer i
    local group g
    local boolexpr iff
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local boolean instun = false
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 14)
    if udg_SK_Kisume03_Effect != null then
        call DestroyEffect(udg_SK_Kisume03_Effect)
        set udg_SK_Kisume03_Effect = null
    endif
    set udg_SK_Kisume03_Effect = AddSpecialEffectTarget("Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedTarget.mdl", caster, "chest")
    set udg_SK_Kisume03_Count = ABCIAllAtk(caster, 50 * level, 1.25)
    call TimerStart(t, 7.0, false, function Trig_Kisume03_Main)
    set i = 0
    loop
        set i = i + 1
        set u = CreateUnit(GetOwningPlayer(caster), 'n03S', ox + 180 * CosBJ(i * 40), oy + 180 * SinBJ(i * 40), 0)
    exitwhen i == 9
    endloop
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
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, ox, oy, 200, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 20 + 20 * level, 0.95), 5)
            if instun then
                call UnitStunTarget(caster, v, 1.7, 0, 0)
            endif
        endif
    endloop
    call DestroyGroup(g)
    set t = null
    set caster = null
    set u = null
    set w = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Kisume03 takes nothing returns nothing
endfunction