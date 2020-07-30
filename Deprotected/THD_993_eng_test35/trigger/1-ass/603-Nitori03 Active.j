function Trig_Nitori03_Active_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetEventDamageSource()) != 'H00M' and GetUnitTypeId(GetEventDamageSource()) != 'H00S' then
        return false
    elseif IsUnitType(GetEventDamageSource(), UNIT_TYPE_HERO) == false then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return GetUnitAbilityLevel(GetEventDamageSource(), 'A096') > 0
endfunction

function Trig_Nitori03_Filter takes nothing returns boolean
    local player p = LoadPlayerHandle(udg_sht, StringHash("Trig_Nitori03_Filter"), 0)
    local unit target = LoadUnitHandle(udg_sht, StringHash("Trig_Nitori03_Filter"), 1)
    local unit u = GetFilterUnit()
    if IsUnitAlly(u, p) or u == target or GetUnitAbilityLevel(u, 'A0IL') > 0 then
        set u = null
        set target = null
        return false
    endif
    set u = null
    set target = null
    return true
endfunction

function Trig_Nitori03_Active_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real attackdamage = GetUnitAttack(caster)
    local group g = CreateGroup()
    local filterfunc filter = Filter(function Trig_Nitori03_Filter)
    local unit v
    call SavePlayerHandle(udg_sht, StringHash("Trig_Nitori03_Filter"), 0, GetOwningPlayer(caster))
    call SaveUnitHandle(udg_sht, StringHash("Trig_Nitori03_Filter"), 1, target)
    call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 250, filter)
    call UnitRemoveAbility(caster, 'A096')
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitPhysicalDamageTarget(caster, v, attackdamage)
    endloop
    call FlushChildHashtable(udg_sht, StringHash("Trig_Nitori03_Filter"))
    call DestroyGroup(g)
    call DestroyFilter(filter)
    set filter = null
    set g = null
    set v = null
    set caster = null
    set target = null
endfunction

function InitTrig_Nitori03_Active takes nothing returns nothing
endfunction