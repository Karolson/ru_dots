function AkyuEx_ForceKey takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local player p = LoadPlayerHandle(udg_sht, GetHandleId(t), 0)
    if GetLocalPlayer() == p then
        call ForceUIKey("E")
    endif
    call DisplayTextToPlayer(p, 0, 0, "Please choose the resurrection location")
    call FlushChildHashtable(udg_sht, GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
    set p = null
endfunction

function AkyuEx_Conditions takes nothing returns boolean
    local unit u
    local player p
    local timer t
    if udg_Akyu_Ex then
        set u = GetTriggerUnit()
        set p = GetOwningPlayer(u)
        call ShowUnit(udg_SK_Akyu_Ghost, true)
        if GetLocalPlayer() == p then
            call ClearSelection()
            call SelectUnit(udg_SK_Akyu_Ghost, true)
        endif
        set t = CreateTimer()
        call SavePlayerHandle(udg_sht, GetHandleId(t), 0, p)
        call TimerStart(t, 0.03125, false, function AkyuEx_ForceKey)
    endif
    set u = null
    set p = null
    set t = null
    return false
endfunction

function InitTrig_AkyuEx takes nothing returns nothing
endfunction