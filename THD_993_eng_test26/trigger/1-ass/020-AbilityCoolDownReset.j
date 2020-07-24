function Item_HeroAbilityCoolDownReset_Resolve takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer abilityid = LoadInteger(udg_ht, task, 1)
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
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Item_HeroAbilityCoolDownReset takes unit caster, integer abilityid, real loadtime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, abilityid)
    call SaveTimerHandle(udg_ht, task, 99, t)
    call TimerStart(t, loadtime * 0.75, false, function Item_HeroAbilityCoolDownReset_Resolve)
    set t = null
endfunction

function Item_KanakoAbilityCoolDownReset_Resolve takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer abilityid = LoadInteger(udg_ht, task, 1)
    local integer abilitylevel = GetUnitAbilityLevel(caster, abilityid)
    if abilitylevel != 0 then
        if GetUnitTypeId(caster) != 'U00L' then
            call UnitRemoveAbility(caster, abilityid)
            call UnitAddAbility(caster, abilityid)
            call SetUnitAbilityLevel(caster, abilityid, abilitylevel)
        endif
    endif
    if udg_ACDShow then
        if IsUnitAlly(caster, udg_PlayerA[0]) or udg_smodestat then
            call DisplayTextToPlayer(udg_PlayerA[0], 0, 0, GetAbilityName(abilityid) + " cooldown reset")
        endif
        if IsUnitAlly(caster, udg_PlayerB[0]) or udg_smodestat then
            call DisplayTextToPlayer(udg_PlayerB[0], 0, 0, GetAbilityName(abilityid) + " cooldown reset")
        endif
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Item_KanakoAbilityCoolDownReset takes unit caster, integer abilityid, real loadtime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real actualtime = loadtime
    set actualtime = udg_DMG_AllItemCoolDownReset[GetPlayerId(GetOwningPlayer(caster))]
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, abilityid)
    call TimerStart(t, actualtime, false, function Item_KanakoAbilityCoolDownReset_Resolve)
    set t = null
endfunction

function Item_KeineAbilityCoolDownReset_Resolve takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer abilityid = LoadInteger(udg_ht, task, 1)
    local integer abnum = LoadInteger(udg_ht, task, 2)
    local integer abcast = LoadInteger(udg_ht, task, 3)
    local integer abcastrecord = LoadInteger(udg_Hashtable_CDForKeine, GetHandleId(caster), abnum)
    local integer abilitylevel = GetUnitAbilityLevel(caster, abilityid)
    if abilitylevel != 0 then
        if abcast == abcastrecord then
            call UnitRemoveAbility(caster, abilityid)
            call UnitAddAbility(caster, abilityid)
            call SetUnitAbilityLevel(caster, abilityid, abilitylevel)
        endif
    endif
    if udg_ACDShow then
        if IsUnitAlly(caster, udg_PlayerA[0]) or udg_smodestat then
            call DisplayTextToPlayer(udg_PlayerA[0], 0, 0, GetAbilityName(abilityid) + " cooldown reset")
        endif
        if IsUnitAlly(caster, udg_PlayerB[0]) or udg_smodestat then
            call DisplayTextToPlayer(udg_PlayerB[0], 0, 0, GetAbilityName(abilityid) + " cooldown reset")
        endif
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Item_KeineAbilityCoolDownReset takes unit caster, integer abilityid, real loadtime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer abnum
    local integer abcast
    if udg_Hashtable_CDForKeine == null then
        set udg_Hashtable_CDForKeine = InitHashtable()
    endif
    if abilityid == 'A0M5' then
        set abnum = 1
    elseif abilityid == 'A0M6' then
        set abnum = 2
    elseif abilityid == 'A0M7' then
        set abnum = 3
    endif
    if abilityid == 'A0LZ' then
        set abnum = 1
    elseif abilityid == 'A0M1' then
        set abnum = 2
    elseif abilityid == 'A0M2' then
        set abnum = 3
    elseif abilityid == 'A0M4' then
        set abnum = 4
    endif
    if abilityid == 'A0QT' then
        set abnum = 1
    elseif abilityid == 'A04H' then
        set abnum = 2
    elseif abilityid == 'A099' then
        set abnum = 3
    elseif abilityid == 'A09A' then
        set abnum = 4
    elseif abilityid == 'A09C' then
        set abnum = 5
    endif
    if HaveSavedInteger(udg_Hashtable_CDForKeine, GetHandleId(caster), abnum) == false then
        set abcast = 1
        call SaveInteger(udg_Hashtable_CDForKeine, GetHandleId(caster), abnum, abcast)
    else
        set abcast = LoadInteger(udg_Hashtable_CDForKeine, GetHandleId(caster), abnum) + 1
        call SaveInteger(udg_Hashtable_CDForKeine, GetHandleId(caster), abnum, abcast)
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, abilityid)
    call SaveInteger(udg_ht, task, 2, abnum)
    call SaveInteger(udg_ht, task, 3, abcast)
    call SaveTimerHandle(udg_ht, task, 99, t)
    call TimerStart(t, loadtime * 0.75, false, function Item_KeineAbilityCoolDownReset_Resolve)
    set t = null
endfunction

function InitTrig_AbilityCoolDownReset takes nothing returns nothing
endfunction