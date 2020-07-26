function Trig_Utsuho02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A076'
endfunction

function Trig_Utsuho02_Main_Target takes nothing returns boolean
    return true
endfunction

function Trig_Utsuho02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local real damage = LoadReal(udg_ht, task, 3)
    local group g
    local unit v
    local boolexpr iff
    if i > 0 and IsUnitType(caster, UNIT_TYPE_DEAD) == false and GetUnitAbilityLevel(caster, 'B01F') > 0 then
        call SetUnitX(u, GetUnitX(caster))
        call SetUnitY(u, GetUnitY(caster))
        if i / 5 * 5 == i then
            set g = CreateGroup()
            set iff = Filter(function Trig_Utsuho02_Main_Target)
            call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 450, iff)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and v != caster and IsUnitAlly(v, GetOwningPlayer(caster)) == false then
                    if GetUnitAbilityLevel(v, 'B02K') == 0 and GetUnitAbilityLevel(v, 'B01P') == 0 and GetUnitAbilityLevel(v, 'Binv') == 0 then
                        call UnitMagicDamageTarget(u, v, damage / 2, 6)
                    endif
                endif
            endloop
            call DestroyGroup(g)
        endif
        call SaveInteger(udg_ht, task, 2, i - 1)
    else
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set g = null
    set v = null
    set iff = null
endfunction

function Trig_Utsuho02_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real damage
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A076')
    local integer time
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 20 * Trig_UtsuhoCD(caster))
    if level == 1 then
        set time = 10
        set damage = 5
    elseif level == 2 then
        set time = 10
        set damage = 10
    elseif level == 3 then
        set time = 10
        set damage = 20
    else
        set time = 10
        set damage = 40
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'n00X', ox, oy, 0)
    call UnitAddAbility(u, 'A077')
    call SetUnitAbilityLevel(u, 'A077', level)
    call PauseUnit(u, true)
    call PauseUnit(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, time * 10)
    call SaveReal(udg_ht, task, 3, damage)
    call TimerStart(t, 0.1, true, function Trig_Utsuho02_Main)
    set u = CreateUnit(GetOwningPlayer(caster), 'o000', ox, oy, 0)
    call UnitAddAbility(u, 'A078')
    call SetUnitAbilityLevel(u, 'A078', level)
    call IssueTargetOrder(u, "rejuvination", caster)
    set t = null
    set caster = null
    set u = null
endfunction

function InitTrig_Utsuho02 takes nothing returns nothing
endfunction