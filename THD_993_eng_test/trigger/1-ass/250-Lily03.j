function Trig_Lily03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0X3' or GetSpellAbilityId() == 'A1A8'
endfunction

function Trig_Lily03_Abstyle00_Target takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) == false then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    endif
    return true
endfunction

function Trig_Lily03_Abstyle01_Target takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    endif
    return true
endfunction

function Trig_Lily03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer abstyle = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 4)
    local real ox
    local real oy
    local real px
    local real py
    local group g
    local unit v
    local unit w
    if i > 0 then
        set i = i - 1
        call SaveInteger(udg_ht, task, 3, i)
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set g = CreateGroup()
        if abstyle == 0 then
            call GroupEnumUnitsInRange(g, ox, oy, 99999.0, Filter(function Trig_Lily03_Abstyle00_Target))
        else
            call GroupEnumUnitsInRange(g, ox, oy, 99999.0, Filter(function Trig_Lily03_Abstyle01_Target))
        endif
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            set px = GetUnitX(v)
            set py = GetUnitY(v)
            if SquareRoot(Pow(py - oy, 2) + Pow(px - ox, 2)) < 375.0 then
                if abstyle == 0 then
                    call UnitHealingTarget(caster, v, ABCIAllInt(caster, 14 * level, 0.3) / 2)
                else
                    call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 14 * level, 0.6) / 2, 6)
                endif
                if GetUnitAbilityLevel(v, 'A0X4') == 0 then
                    call UnitAddAbility(v, 'A0X4')
                elseif GetUnitAbilityLevel(v, 'A0X4') <= 6 then
                    call SetUnitAbilityLevel(v, 'A0X4', GetUnitAbilityLevel(v, 'A0X4') + 1)
                elseif GetUnitAbilityLevel(v, 'A0X4') == 7 then
                    if abstyle == 0 and GetUnitAbilityLevel(v, 'B06B') == 0 then
                        set w = CreateUnit(GetOwningPlayer(caster), 'n001', GetUnitX(v), GetUnitY(v), 0)
                        call UnitBuffTarget(u, u, 0.5, 'A0VT', 'B06B')
                        call DMG_DamageReduce(v, 0.01, 0.5, "Magic")
                        call UnitAddAbility(w, 'A0X5')
                        call IssueTargetOrder(w, "antimagicshell", v)
                    elseif abstyle == 1 then
                        call UnitStunTarget(caster, v, 0.5, 0, 0)
                    endif
                endif
            else
                if GetUnitAbilityLevel(v, 'A0X4') > 0 then
                    call UnitRemoveAbility(v, 'A0X4')
                endif
                if GetUnitAbilityLevel(v, 'B06B') > 0 then
                    call UnitRemoveAbility(v, 'B06B')
                endif
            endif
        endloop
        call DestroyGroup(g)
    else
        set g = CreateGroup()
        if abstyle == 0 then
            call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 99999.0, Filter(function Trig_Lily03_Abstyle00_Target))
        else
            call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 99999.0, Filter(function Trig_Lily03_Abstyle01_Target))
        endif
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetUnitAbilityLevel(v, 'A0X4') > 0 then
                call UnitRemoveAbility(v, 'A0X4')
            endif
            if GetUnitAbilityLevel(v, 'B06B') > 0 then
                call UnitRemoveAbility(v, 'B06B')
            endif
        endloop
        call KillUnit(u)
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set g = null
    set v = null
    set w = null
endfunction

function Trig_Lily03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local integer abstyle
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer cost = 150
    local timer t
    local integer task
    if GetUnitTypeId(caster) == 'E023' then
        if GetUnitState(caster, UNIT_STATE_MANA) < cost then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Not enough MP to cast this spell|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set u = null
            set t = null
            return
        else
            set abstyle = 0
        endif
    elseif GetUnitTypeId(caster) == 'E024' then
        if GetUnitState(caster, UNIT_STATE_LIFE) < cost then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Not enough HP to cast this spell|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set u = null
            set t = null
            return
        else
            set abstyle = 1
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) - cost)
        endif
    endif
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 18 - level * 1)
    if abstyle == 0 then
        set u = CreateUnit(GetOwningPlayer(caster), 'n04B', GetUnitX(caster), GetUnitY(caster), 270)
    else
        set u = CreateUnit(GetOwningPlayer(caster), 'n04C', GetUnitX(caster), GetUnitY(caster), 270)
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, abstyle)
    call SaveInteger(udg_ht, task, 3, 9 + level)
    call SaveInteger(udg_ht, task, 4, level)
    call TimerStart(t, 0.5, true, function Trig_Lily03_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Lily03 takes nothing returns nothing
endfunction