function Trig_Renko02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A12R'
endfunction

function Renko02_Magic_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g2 = LoadGroupHandle(udg_ht, task, 0)
    local unit v
    loop
        set v = FirstOfGroup(g2)
    exitwhen v == null
        call GroupRemoveUnit(g2, v)
        set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] / 0.6
    endloop
    call DestroyGroup(g2)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
endfunction

function Trig_Renko02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A12R')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a = GetUnitFacing(caster) * 0.017454
    local integer i
    local group g
    local group g2 = CreateGroup()
    local group m
    local filterfunc f
    local unit v
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real damage = 15 + 25 * level + GetUnitAttack(caster) * 0.35
    local integer renko_buff_count = LoadInteger(udg_sht, StringHash("RenkoEx"), GetHandleId(caster))
    call AbilityCoolDownResetion(caster, 'A12R', 11 - 1.5 * level - renko_buff_count * 0.4)
    call Trig_RenkoEx_TurnsOn(caster)
    set u = CreateUnit(GetOwningPlayer(caster), 'e02F', ox + 300 * Cos(a), oy + 300 * Sin(a), bj_RADTODEG * a + 90)
    set m = CreateGroup()
    set f = Filter(function Trig_Renko01_Target02)
    set i = 0
    loop
    exitwhen i == 12
        set i = i + 1
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox + i * 50 * Cos(a), oy + i * 50 * Sin(a), 150.0, f)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitInGroup(v, m) == false then
                call UnitPhysicalDamageTarget(caster, v, damage)
                if udg_SK_Renko_LastSpell == 1 then
                    call UnitSlowTarget(caster, v, 4.0, 'A14F', 0)
                    if IsUnitType(v, UNIT_TYPE_HERO) then
                        set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(v))] * 0.6
                        call GroupAddUnit(g2, v)
                    endif
                    if udg_NewDebuffSys then
                        call UnitSlowTargetMspd(caster, v, 30, 4.0, 3, 0)
                    else
                        call UnitSlowTarget(caster, v, 4.0, 'A1AU', 'B09B')
                    endif
                elseif udg_SK_Renko_LastSpell == 2 then
                    if udg_NewDebuffSys then
                        call UnitDebuffTarget(caster, v, 1.5 * 1.0, 2, true, 'A0QV', 1, 'B07U', "firebolt", 0, "")
                    else
                        call UnitStunTarget(caster, v, 1.5, 0, 0)
                    endif
                elseif udg_SK_Renko_LastSpell == 3 then
                    call UnitSlowTarget(caster, v, 4.0, 'A14G', 0)
                elseif udg_SK_Renko_LastSpell == 4 then
                    if udg_NewDebuffSys then
                        call UnitSlowTargetMspd(caster, v, 75, 4.0, 3, 0)
                    else
                        call UnitSlowTarget(caster, v, 4.0, 'A14H', 'B06S')
                    endif
                endif
            endif
            call GroupAddUnit(m, v)
        endloop
        call DestroyGroup(g)
    endloop
    call SaveGroupHandle(udg_ht, task, 0, g2)
    call TimerStart(t, 4, false, function Renko02_Magic_Clear)
    call DestroyFilter(f)
    call DestroyGroup(m)
    set udg_SK_Renko_LastSpell = 2
    set caster = null
    set g2 = null
    set g = null
    set m = null
    set f = null
    set v = null
    set u = null
endfunction

function InitTrig_Renko02 takes nothing returns nothing
endfunction