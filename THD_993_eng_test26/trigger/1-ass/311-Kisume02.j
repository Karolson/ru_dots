function Trig_Kisume02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0R9'
endfunction

function Trig_Kisume02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real tx = LoadReal(udg_ht, task, 1)
    local real ty = LoadReal(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 3)
    local boolean instun = LoadBoolean(udg_ht, task, 4)
    local integer i = LoadInteger(udg_ht, task, 5)
    local integer j
    local real ox = LoadReal(udg_ht, task, 6)
    local real oy = LoadReal(udg_ht, task, 7)
    local unit v
    local unit w
    local group g
    local boolexpr iff
    local real damage
    if i > 0 then
        set i = i - 1
        if i > 25 then
            call SetUnitXY(caster, ox, oy)
            call SetUnitFlyHeight(caster, (50 - i) * 80, 0)
        endif
        if i == 25 then
            call SetUnitXY(caster, tx, ty)
        endif
        if i != 0 and i < 25 then
            call SetUnitXY(caster, tx, ty)
            call SetUnitFlyHeight(caster, i * 80, 0)
        endif
        if i == 0 then
            call PauseUnit(caster, false)
            call SetUnitInvulnerable(caster, false)
            set tx = GetUnitX(caster)
            set ty = GetUnitY(caster)
            call DestroyEffect(AddSpecialEffect("abilities\\weapons\\DemolisherMissile\\DemolisherMissile.mdl", tx, ty))
            set i = 0
            loop
                set i = i + 1
                call DestroyEffect(AddSpecialEffect("abilities\\weapons\\DemolisherMissile\\DemolisherMissile.mdl", tx + 275 * CosBJ(i * 15), ty + 275 * SinBJ(i * 15)))
            exitwhen i == 24
            endloop
            set i = 0
            loop
                set i = i + 1
                set j = 0
                loop
                    set j = j + 1
                    call DestroyEffect(AddSpecialEffect("abilities\\weapons\\DemolisherMissile\\DemolisherMissile.mdl", tx + j * 45.83 * CosBJ(i * 120), ty + j * 45.83 * SinBJ(i * 120)))
                exitwhen j == 5
                endloop
            exitwhen i == 3
            endloop
            set i = 0
            call SetUnitFlyHeight(caster, GetUnitDefaultFlyHeight(caster), 0)
            call SetUnitPathing(caster, true)
            set g = CreateGroup()
            set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
            call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 300, iff)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                    set damage = ABCIAllAtk(caster, 75 * level, 2) * (300 - SquareRoot((GetUnitX(caster) - GetUnitX(v)) * (GetUnitX(caster) - GetUnitX(v)) + (GetUnitY(caster) - GetUnitY(v)) * (GetUnitY(caster) - GetUnitY(v)))) / 250
                    call UnitPhysicalDamageTarget(caster, v, damage * 1.0)
                    if instun then
                        call UnitStunTarget(caster, v, 1.7, 0, 0)
                    endif
                endif
            endloop
            call DestroyGroup(g)
        endif
        call SaveInteger(udg_ht, task, 5, i)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set v = null
    set w = null
    set g = null
    set iff = null
endfunction

function Trig_Kisume02_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local real d = SquareRoot(Pow(ty - oy, 2) + Pow(tx - ox, 2))
    local integer level = GetUnitAbilityLevel(caster, 'A0R9')
    local boolean instun = false
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 24 - 2 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set t = null
        set caster = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call PauseUnit(caster, true)
    call SetUnitPathing(caster, false)
    call EnableHeight(caster)
    call SetUnitInvulnerable(caster, true)
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
    call Trig_BlinkPlaceRealer(ox + d * Cos(a), oy + d * Sin(a), d, a)
    set tx = udg_SK_BlinkPlace_x
    set ty = udg_SK_BlinkPlace_y
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, tx)
    call SaveReal(udg_ht, task, 2, ty)
    call SaveInteger(udg_ht, task, 3, level)
    call SaveBoolean(udg_ht, task, 4, instun)
    call SaveInteger(udg_ht, task, 5, 50)
    call SaveReal(udg_ht, task, 6, ox)
    call SaveReal(udg_ht, task, 7, oy)
    call TimerStart(t, 0.02, true, function Trig_Kisume02_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Kisume02 takes nothing returns nothing
endfunction