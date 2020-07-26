function WRIGGLE03 takes nothing returns integer
    return 'A1AR'
endfunction

function WRIGGLE03_INVIS_SKILL takes nothing returns integer
    return 'A09L'
endfunction

function WRIGGLE03_ANTI_MAGIC_SKILL takes nothing returns integer
    return 'A0FY'
endfunction

function WRIGGLE03_ANTI_MAGIC_BUFF takes nothing returns integer
    return 'B01Y'
endfunction

function Wriggle03_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        return GetLearnedSkill() == 'A1AR'
    endif
    return true
endfunction

function Wriggle03_Switch takes nothing returns nothing
    local unit u = GetEnumUnit()
    local integer level = LoadInteger(udg_sht, StringHash("Wriggle03"), GetHandleId(u))
    local real time = GetFloatGameState(GAME_STATE_TIME_OF_DAY)
    if time < 6.0 or time >= 18.0 then
        call UnitRemoveAbility(u, 'A09L')
        call UnitAddAttackDamage(u, 10 + 10 * level)
        call UnitAddAbility(u, 'A0FY')
        call SetUnitAbilityLevel(u, 'A0FY', level)
        call UnitMakeAbilityPermanent(u, true, 'A0FY')
    else
        call UnitReduceAttackDamage(u, 10 + 10 * level)
        call UnitRemoveAbility(u, 'A0FY')
        call UnitRemoveAbility(u, 'B01Y')
        call UnitAddAbility(u, 'A09L')
        call SetUnitAbilityLevel(u, 'A09L', level)
    endif
    set u = null
endfunction

function Wriggle03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer ctask = GetHandleId(caster)
    local real time = GetFloatGameState(GAME_STATE_TIME_OF_DAY)
    local integer stask = StringHash("Wriggle03")
    local integer level = LoadInteger(udg_sht, stask, ctask)
    local group g = LoadGroupHandle(udg_sht, stask, StringHash("GroupOfUsers"))
    if time < 6.0 or time >= 18.0 then
        call UnitReduceAttackDamage(caster, 10 + 10 * level)
        call UnitRemoveAbility(caster, 'A0FY')
        call UnitRemoveAbility(caster, 'B01Y')
    else
        call UnitRemoveAbility(caster, 'A09L')
    endif
    call GroupRemoveUnit(g, caster)
    call RemoveSavedInteger(udg_sht, stask, ctask)
    if FirstOfGroup(g) == null then
        call DestroyGroup(g)
        call RemoveSavedHandle(udg_sht, stask, StringHash("GroupOfUsers"))
    endif
    call RemoveSavedHandle(udg_sht, stask, ctask)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
    set g = null
endfunction

function Wriggle03_Actions takes nothing returns nothing
    local unit caster
    local integer level
    local real time = GetFloatGameState(GAME_STATE_TIME_OF_DAY)
    local integer stask = StringHash("Wriggle03")
    local integer ctask
    local integer i
    local group g
    local timer t
    local integer task
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        set caster = GetTriggerUnit()
        set level = GetUnitAbilityLevel(caster, 'A1AR')
        set ctask = GetHandleId(caster)
        call AbilityCoolDownResetion(caster, 'A1AR', 20.0)
        if HaveSavedHandle(udg_sht, stask, ctask) then
            set t = LoadTimerHandle(udg_sht, stask, ctask)
            set i = LoadInteger(udg_sht, stask, ctask)
            if time < 6.0 or time >= 18.0 then
                if level > i then
                    call UnitAddAttackDamage(caster, (level - i) * 10)
                endif
            endif
            call SaveInteger(udg_sht, stask, ctask, level)
        else
            set t = CreateTimer()
            set task = GetHandleId(t)
            call SaveTimerHandle(udg_sht, stask, ctask, t)
            call SaveUnitHandle(udg_sht, task, 0, caster)
            call SaveInteger(udg_sht, stask, ctask, level)
            if time < 6.0 or time >= 18.0 then
                call UnitAddAttackDamage(caster, 10 + 10 * level)
                call UnitAddAbility(caster, 'A0FY')
                call SetUnitAbilityLevel(caster, 'A0FY', level)
            else
                call UnitAddAbility(caster, 'A09L')
                call SetUnitAbilityLevel(caster, 'A09L', level)
            endif
            if HaveSavedHandle(udg_sht, stask, StringHash("GroupOfUsers")) then
                set g = LoadGroupHandle(udg_sht, stask, StringHash("GroupOfUsers"))
            else
                set g = CreateGroup()
                call SaveGroupHandle(udg_sht, stask, StringHash("GroupOfUsers"), g)
            endif
            call GroupAddUnit(g, caster)
        endif
    else
        if HaveSavedHandle(udg_sht, stask, StringHash("GroupOfUsers")) then
            set g = LoadGroupHandle(udg_sht, stask, StringHash("GroupOfUsers"))
            call ForGroup(g, function Wriggle03_Switch)
        endif
    endif
    set t = null
    set g = null
    set caster = null
endfunction

function InitTrig_Wriggle03 takes nothing returns nothing
endfunction