function Trig_Marisa04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A042'
endfunction

function Trig_Marisa04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer duration = LoadInteger(udg_ht, task, 7)
    local real ox = LoadReal(udg_ht, task, 3)
    local real oy = LoadReal(udg_ht, task, 4)
    local real tx = LoadReal(udg_ht, task, 5)
    local real ty = LoadReal(udg_ht, task, 6)
    local unit eu1 = LoadUnitHandle(udg_ht, task, 8)
    local unit eu2 = LoadUnitHandle(udg_ht, task, 9)
    local real a = Atan2(ty - oy, tx - ox)
    local real px
    local real py
    local integer i
    local group g
    local group m
    local boolexpr iff
    local unit v
    local real damage
    set damage = ABCIAllInt(caster, level * 95 + 150, 2.3)
    if duration > 0 and GetUnitCurrentOrder(caster) == OrderId("carrionswarm") then
        set duration = duration - 1
        call SaveInteger(udg_ht, task, 7, duration)
        set m = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        set i = 1
        loop
        exitwhen i == 18
            set px = ox + i * 50 * Cos(a)
            set py = oy + i * 50 * Sin(a)
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, px, py, 150.0, iff)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                    call GroupAddUnit(m, v)
                    call UnitMagicDamageTarget(caster, v, damage / 4, 5)
                    if GetUnitAbilityLevel(v, 'A05T') == 0 then
                        call UnitStunTarget(caster, v, duration * 0.25, 0, 0)
                        call UnitBuffTarget(caster, v, 5.0, 'A05T', 0)
                    endif
                endif
            endloop
            call DestroyGroup(g)
            set i = i + 1
        endloop
        call DestroyGroup(m)
    else
        call RemoveUnit(eu1)
        call RemoveUnit(eu2)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set g = null
    set m = null
    set iff = null
    set v = null
    set eu1 = null
    set eu2 = null
endfunction

function Trig_Marisa04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local integer task
    local unit eu1
    local unit eu2
    if GetUnitAbilityLevel(caster, 'A02L') > 0 then
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 85 - 15 * level - 19)
    else
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 85 - 15 * level)
    endif
    call MarisaEx_ColdTimer(caster)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set eu1 = CreateUnit(GetOwningPlayer(caster), 'n00Q', ox + 440 * Cos(a), oy + 440 * Sin(a), bj_RADTODEG * a)
    set eu2 = CreateUnit(GetOwningPlayer(caster), 'n00P', ox + 70 * Cos(a), oy + 70 * Sin(a), bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveReal(udg_ht, task, 3, ox)
    call SaveReal(udg_ht, task, 4, oy)
    call SaveReal(udg_ht, task, 5, tx)
    call SaveReal(udg_ht, task, 6, ty)
    call SaveInteger(udg_ht, task, 7, 8)
    call SaveUnitHandle(udg_ht, task, 8, eu1)
    call SaveUnitHandle(udg_ht, task, 9, eu2)
    call TimerStart(t, 0.25, true, function Trig_Marisa04_Main)
    call VE_Spellcast(caster)
    set caster = null
    set t = null
    set eu1 = null
    set eu2 = null
endfunction

function InitTrig_Marisa04 takes nothing returns nothing
endfunction