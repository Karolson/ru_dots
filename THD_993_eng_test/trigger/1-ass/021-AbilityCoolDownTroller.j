function AbilityCoolDownReduce takes unit caster, integer abilityid, real reducetime returns nothing
    local integer task = GetHandleId(caster)
    local integer i = 0
    local integer j = 0
    if HaveSavedInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 1) then
        set i = LoadInteger(udg_Hashtable_CDInReimu, GetHandleId(caster), abilityid * 10 + 0)
        if i > 0 then
            set j = i - R2I(reducetime * 100)
            if j < 0 then
                set j = 0
            endif
            call SaveInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 1, j)
        endif
    endif
endfunction

function AbilityCoolDownReset takes unit caster, integer abilityid returns nothing
    local integer task = GetHandleId(caster)
    local integer abilitylevel = GetUnitAbilityLevel(caster, abilityid)
    if abilitylevel != 0 then
        call UnitRemoveAbility(caster, abilityid)
        call UnitAddAbility(caster, abilityid)
        call SetUnitAbilityLevel(caster, abilityid, abilitylevel)
    endif
    if udg_ACDShow then
        if IsUnitAlly(caster, udg_PlayerA[0]) or udg_smodestat then
            call DisplayTextToPlayer(udg_PlayerA[0], 0, 0, GetAbilityName(abilityid) + " cooldown reset")
        endif
        if IsUnitAlly(caster, udg_PlayerB[0]) or udg_smodestat then
            call DisplayTextToPlayer(udg_PlayerB[0], 0, 0, GetAbilityName(abilityid) + " cooldown reset")
        endif
    endif
    call SaveInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 1, -1)
endfunction

function AbilityCoolDownResetion_Resolve takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timertask = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, timertask, 1)
    local integer task = GetHandleId(caster)
    local integer abilityid = LoadInteger(udg_ht, timertask, 2)
    local integer abcast = LoadInteger(udg_ht, timertask, 3)
    local integer abcastrecord = LoadInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 0)
    local integer i = LoadInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 1)
    local boolean k = false
    local boolean isultkanako = LoadBoolean(udg_Hashtable_CDInReimu, task, abilityid * 10 + 2)
    if abcast == abcastrecord then
        if i > 0 then
            call SaveInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 1, i - 1)
        else
            if i == 0 then
                if isultkanako and GetUnitTypeId(caster) != 'U00M' then
                    set k = true
                else
                    call AbilityCoolDownReset(caster, abilityid)
                    set k = true
                endif
            endif
        endif
    else
        set k = true
    endif
    if k then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, timertask)
    endif
    set t = null
    set caster = null
endfunction

function GetAbilityCoolDownTime takes unit caster, integer abilityid, real loadtime returns real
    local real cdtime = loadtime
    local real basicdeduce = 1.0
    local real runningtime
    if GetUnitAbilityLevel(caster, 'B089') != 0 then
        set cdtime = cdtime * (0.85 - 0.1 * GetUnitAbilityLevel(caster, 'B089'))
    endif
    if GetUnitAbilityLevel(caster, 'A02L') != 0 then
        set cdtime = cdtime - 6.0
    endif
    if GetUnitAbilityLevel(caster, 'B05O') != 0 then
        set cdtime = cdtime - (1.5 + 0.5 * GetUnitAbilityLevel(caster, 'A05A'))
    endif
    if GetUnitAbilityLevel(caster, 'A076') != 0 then
        set cdtime = cdtime * (1.0 - Pow(2, GetUnitAbilityLevel(caster, 'A076') - 1) * 0.035)
    endif
    set basicdeduce = basicdeduce * udg_DMG_AllItemCoolDownReset[GetPlayerId(GetOwningPlayer(caster))]
    if UnitHasBuffBJ(caster, 'B08V') then
        set basicdeduce = basicdeduce * 0.85
    endif
    if UnitHasBuffBJ(caster, 'B08T') then
        set basicdeduce = basicdeduce * 0.8
    endif
    if UnitHasBuffBJ(caster, 'B08W') then
        set basicdeduce = basicdeduce * 0.75
    endif
    if GetUnitAbilityLevel(caster, 'A0WB') > 0 then
        set basicdeduce = basicdeduce * 0.8
    endif
    if basicdeduce < 0.6 then
        set basicdeduce = 0.6
    endif
    set runningtime = cdtime * basicdeduce
    return runningtime
endfunction

function AbilityCoolDownResetion takes unit caster, integer abilityid, real loadtime returns nothing
    local timer t
    local integer task = GetHandleId(caster)
    local integer timertask
    local integer abcast
    local real runningtime
    local boolean isultkanako = false
    if GetUnitTypeId(caster) == 'U00M' then
        set isultkanako = true
    endif
    set runningtime = GetAbilityCoolDownTime(caster, abilityid, loadtime)
    if HaveSavedInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 0) == false then
        set abcast = 1
        call SaveInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 0, abcast)
        call SaveInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 1, R2I(runningtime * 100))
        call SaveBoolean(udg_Hashtable_CDInReimu, task, abilityid * 10 + 2, isultkanako)
    else
        set abcast = LoadInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 0) + 1
        call SaveInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 0, abcast)
        call SaveInteger(udg_Hashtable_CDInReimu, task, abilityid * 10 + 1, R2I(runningtime * 100))
        call SaveBoolean(udg_Hashtable_CDInReimu, task, abilityid * 10 + 2, isultkanako)
    endif
    set t = CreateTimer()
    set timertask = GetHandleId(t)
    call SaveTimerHandle(udg_ht, timertask, 0, t)
    call SaveUnitHandle(udg_ht, timertask, 1, caster)
    call SaveInteger(udg_ht, timertask, 2, abilityid)
    call SaveInteger(udg_ht, timertask, 3, abcast)
    call TimerStart(t, 0.01, true, function AbilityCoolDownResetion_Resolve)
    set t = null
endfunction

function InitTrig_AbilityCoolDownTroller takes nothing returns nothing
endfunction