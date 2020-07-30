function UnitAddDamage takes unit u returns nothing
    set udg_AUD_eventCount = udg_AUD_eventCount + 1
    call TriggerRegisterUnitEvent(udg_AUD_anyUnitDamageTrigger, u, EVENT_UNIT_DAMAGED)
endfunction

function EnumHero takes nothing returns nothing
    call UnitAddDamage(GetEnumUnit())
endfunction

function EnumUnit takes nothing returns boolean
    local unit u = GetFilterUnit()
    if IsUnitInGroup(u, udg_AUD_heroGroup) == false then
        call UnitAddDamage(u)
        if IsUnitType(u, UNIT_TYPE_HERO) and IsUnitIllusion(u) == false then
            call GroupAddUnit(udg_AUD_heroGroup, u)
        endif
    endif
    set u = null
    return false
endfunction

function ShowUnitXumn takes unit u, boolean k returns nothing
    call ShowUnit(u, k)
    if IsUnitInGroup(u, udg_AUD_heroGroup) == false then
        call UnitAddDamage(u)
        if IsUnitType(u, UNIT_TYPE_HERO) and IsUnitIllusion(u) == false then
            call GroupAddUnit(udg_AUD_heroGroup, u)
        endif
    endif
    set u = null
endfunction

function AnyUnitDamageAction takes nothing returns boolean
    local integer i
    if udg_AUD_runCount > udg_AUD_LimitRunTimes then
        return false
    elseif GetUnitTypeId(GetEventDamageSource()) == 'e02X' then
        return false
    endif
    set udg_AUD_runCount = udg_AUD_runCount + 1
    set i = 0
    loop
    exitwhen udg_AUD_trgArray[i] == null
        if IsTriggerEnabled(udg_AUD_trgArray[i]) then
            if TriggerEvaluate(udg_AUD_trgArray[i]) then
                call TriggerExecute(udg_AUD_trgArray[i])
            endif
        endif
        set i = i + 1
    endloop
    set udg_AUD_runCount = 0
    return false
endfunction

function ReBuild takes nothing returns nothing
    local group g = CreateGroup()
    local filterfunc f = Filter(function EnumUnit)
    call DebugMsg("Damage System Rebuild")
    call DestroyTrigger(udg_AUD_anyUnitDamageTrigger)
    set udg_AUD_eventCount = 0
    set udg_AUD_anyUnitDamageTrigger = CreateTrigger()
    call TriggerAddCondition(udg_AUD_anyUnitDamageTrigger, Condition(function AnyUnitDamageAction))
    call ForGroup(udg_AUD_heroGroup, function EnumHero)
    call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, f)
    call DestroyFilter(f)
    call DestroyGroup(g)
    set g = null
    set f = null
endfunction

function UnitInGame takes nothing returns boolean
    local unit u = GetTriggerUnit()
    if GetUnitAbilityLevel(u, 'Aloc') == 0 then
        if GetRandomInt(udg_AUD_eventCount, udg_AUD_LimitEventCount) < udg_AUD_LimitEventCount then
            call UnitAddDamage(u)
        else
            call ReBuild()
        endif
    endif
    set u = null
    return false
endfunction

function RegisterAnyUnitDamage takes trigger t returns nothing
    local integer i
    local group g
    local timer tm
    local filterfunc f
    if udg_AUD_hasInit == false then
        set udg_AUD_hasInit = true
        set udg_AUD_eventCount = 0
        set udg_AUD_LimitRunTimes = 10
        set udg_AUD_LimitEventCount = 7000
        set udg_AUD_anyUnitDamageTrigger = CreateTrigger()
        call TriggerAddCondition(udg_AUD_anyUnitDamageTrigger, Condition(function UnitInGame))
        call YDWETriggerRegisterEnterRectSimpleNull(udg_AUD_anyUnitDamageTrigger, bj_mapInitialPlayableArea)
        set udg_AUD_anyUnitDamageTrigger = CreateTrigger()
        call TriggerAddCondition(udg_AUD_anyUnitDamageTrigger, Condition(function AnyUnitDamageAction))
        set g = CreateGroup()
        set f = Filter(function EnumUnit)
        call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, f)
        call DestroyFilter(f)
        call DestroyGroup(g)
        set g = null
        set tm = CreateTimer()
        call TimerStart(tm, 240, true, function ReBuild)
    endif
    set i = 0
    loop
    exitwhen udg_AUD_trgArray[i] == null or udg_AUD_trgArray[i] == t
        if i > JASS_MAX_ARRAY_SIZE then
            return
        endif
        set i = i + 1
    endloop
    set udg_AUD_trgArray[i] = t
    set g = null
    set tm = null
    set f = null
endfunction

function InitTrig_Any_Unit_Damaged takes nothing returns nothing
endfunction