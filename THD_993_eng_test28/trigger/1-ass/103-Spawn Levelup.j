function Trig_Spawn_Levelup_Actions takes nothing returns nothing
    local integer techA = GetPlayerTechCount(udg_SpawnPlayer[0], 'R003', true)
    local integer techB = GetPlayerTechCount(udg_SpawnPlayer[1], 'R003', true)
    call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R003', GetPlayerTechCount(udg_SpawnPlayer[0], 'R003', true) + 1)
    call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R002', GetPlayerTechCount(udg_SpawnPlayer[0], 'R002', true) + 1)
    call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R003', GetPlayerTechCount(udg_SpawnPlayer[1], 'R003', true) + 1)
    call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R002', GetPlayerTechCount(udg_SpawnPlayer[1], 'R002', true) + 1)
    if techA == 6 then
        set udg_SU_No_A[2] = udg_SU_No_A[2] + 1
    endif
    if techB == 6 then
        set udg_SU_No_B[2] = udg_SU_No_B[2] + 1
    endif
    if techA >= 20 then
        call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R003', techA + 1)
        call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R002', techA + 1)
    endif
    if techB >= 20 then
        call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R003', techB + 1)
        call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R002', techB + 1)
    endif
    if techA >= 40 then
        call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R003', techA + 1)
        call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R002', techA + 1)
    endif
    if techB >= 40 then
        call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R003', techB + 1)
        call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R002', techB + 1)
    endif
    if techA >= 60 then
        call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R003', techA + 1)
        call SetPlayerTechResearched(udg_SpawnPlayer[0], 'R002', techA + 1)
    endif
    if techB >= 60 then
        call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R003', techB + 1)
        call SetPlayerTechResearched(udg_SpawnPlayer[1], 'R002', techB + 1)
    endif
endfunction

function InitTrig_Spawn_Levelup takes nothing returns nothing
    set gg_trg_Spawn_Levelup = CreateTrigger()
    call TriggerAddAction(gg_trg_Spawn_Levelup, function Trig_Spawn_Levelup_Actions)
endfunction