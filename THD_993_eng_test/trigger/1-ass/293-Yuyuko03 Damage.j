function Trig_Yuyuko03_Damage_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0MN'
endfunction

function Trig_Yuyuko03_Damage_Target takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return true
endfunction

function Trig_Yuyuko03_Damage_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = GetUnitAbilityLevel(caster, 'A0MN')
    local real damage
    local boolexpr f = LoadBooleanExprHandle(udg_ht, task, 2)
    local group g = LoadGroupHandle(udg_ht, task, 1)
    local unit v
    if GetWidgetLife(caster) >= 0.405 and udg_SK_uuz03_switch == 1 then
        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 400 + 4 * GetHeroInt(caster, true), f)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            set damage = GetUnitState(v, UNIT_STATE_MAX_LIFE) * (1.0 + level * 0.5) / 100
            set damage = RMinBJ(damage, 200)
            set damage = damage * 0.5
            if GetUnitAbilityLevel(v, 'B02K') == 0 and GetUnitAbilityLevel(v, 'B01P') == 0 and GetUnitAbilityLevel(v, 'Binv') == 0 then
                if GetUnitAbilityLevel(v, 'BUsl') > 0 and GetUnitState(v, UNIT_STATE_LIFE) > damage then
                    call SetUnitState(v, UNIT_STATE_LIFE, GetUnitState(v, UNIT_STATE_LIFE) - damage)
                else
                    call UnitMagicDamageTarget(caster, v, damage, 6)
                endif
            endif
        endloop
    endif
    set t = null
    set caster = null
    set f = null
    set g = null
    set v = null
endfunction

function Trig_Yuyuko03_Damage_Learn takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0MN')
    local group g
    local boolexpr f
    if level == 1 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        set g = CreateGroup()
        set f = Filter(function Trig_Yuyuko03_Damage_Target)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveGroupHandle(udg_ht, task, 1, g)
        call SaveBooleanExprHandle(udg_ht, task, 2, f)
        call TimerStart(t, 0.5, true, function Trig_Yuyuko03_Damage_Main)
    endif
    set f = null
    set g = null
    set t = null
    set caster = null
endfunction

function InitTrig_Yuyuko03_Damage takes nothing returns nothing
endfunction