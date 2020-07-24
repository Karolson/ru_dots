function WordDamagePhysicImmune takes unit caster, unit u returns nothing
    local texttag e
    local real f
    set e = CreateTextTag()
    set f = 10.0
    call SetTextTagTextBJ(e, "Immune", f)
    call SetTextTagPos(e, GetUnitX(u), GetUnitY(u), 130.0)
    call SetTextTagColor(e, 255, 255, 0, 0)
    if IsUnitVisible(u, GetLocalPlayer()) then
        call SetTextTagColor(e, 255, 255, 0, 240)
    endif
    call SetTextTagVelocityBJ(e, 150, 90)
    call SetTextTagPermanent(e, false)
    call SetTextTagLifespan(e, 1.67)
    set e = null
endfunction

function WordDamageCriticalBlock takes unit caster, unit u returns nothing
    local texttag e
    local real f
    set e = CreateTextTag()
    set f = 10.0
    call SetTextTagTextBJ(e, "Crit block", f)
    call SetTextTagPos(e, GetUnitX(u), GetUnitY(u), 130.0)
    call SetTextTagColor(e, 255, 255, 0, 0)
    if IsUnitVisible(u, GetLocalPlayer()) then
        call SetTextTagColor(e, 255, 255, 0, 240)
    endif
    call SetTextTagVelocityBJ(e, 150, 90)
    call SetTextTagPermanent(e, false)
    call SetTextTagLifespan(e, 1.67)
    set e = null
endfunction

function WordDamagePhysicGraze takes unit caster, unit u returns nothing
    local texttag e
    local real f
    set e = CreateTextTag()
    set f = 10.0
    call SetTextTagTextBJ(e, "Evasion", f)
    call SetTextTagPos(e, GetUnitX(u), GetUnitY(u), 130.0)
    call SetTextTagColor(e, 255, 255, 0, 0)
    if IsUnitVisible(u, GetLocalPlayer()) then
        call SetTextTagColor(e, 255, 255, 0, 240)
    endif
    call SetTextTagVelocityBJ(e, 150, 90)
    call SetTextTagPermanent(e, false)
    call SetTextTagLifespan(e, 1.67)
    set e = null
endfunction

function WordDamageInPurple takes unit caster, unit u, real tredam returns nothing
    local texttag e
    local real f
    set e = CreateTextTag()
    set f = 8.0
    if tredam <= 50 then
        set f = 6.0
    elseif tredam <= 100 then
        set f = 7.0
    elseif tredam <= 200 then
        set f = 8.0
    elseif tredam <= 400 then
        set f = 9.0
    elseif tredam <= 800 then
        set f = 10.0
    elseif tredam <= 1600 then
        set f = 11.0
    elseif tredam <= 3200 then
        set f = 12.0
    else
        set f = 13.0
    endif
    call SetTextTagTextBJ(e, I2S(R2I(tredam)) + "!", f)
    call SetTextTagPos(e, GetUnitX(u), GetUnitY(u), 130.0)
    call SetTextTagColor(e, 220, 0, 220, 0)
    if IsUnitVisible(u, GetLocalPlayer()) then
        call SetTextTagColor(e, 220, 0, 220, 240)
    endif
    call SetTextTagVelocityBJ(e, 150, 90)
    call SetTextTagPermanent(e, false)
    call SetTextTagLifespan(e, 1.67)
    set e = null
endfunction

function WordHealInNormal_Output takes player ply, unit u, real tredam, boolean critred returns nothing
    local texttag e
    local real f
    set tredam = tredam * -1
    set e = CreateTextTag()
    set f = 7.0
    if tredam <= 50 then
        set f = 8.0
    elseif tredam <= 100 then
        set f = 9.0
    elseif tredam <= 200 then
        set f = 10.0
    elseif tredam <= 400 then
        set f = 11.0
    elseif tredam <= 800 then
        set f = 12.0
    elseif tredam <= 1600 then
        set f = 13.0
    elseif tredam <= 3200 then
        set f = 14.0
    else
        set f = 15.0
    endif
    if critred then
        call SetTextTagTextBJ(e, I2S(R2I(tredam)) + "!", f)
    else
        call SetTextTagTextBJ(e, I2S(R2I(tredam)), f)
    endif
    call SetTextTagPos(e, GetUnitX(u), GetUnitY(u), 100.0)
    if critred then
        call SetTextTagColor(e, 255, 0, 0, 0)
        if IsUnitVisible(u, GetLocalPlayer()) then
            call SetTextTagColor(e, 55, 255, 125, 240)
        endif
    else
        call SetTextTagColor(e, 255, 255, 255, 0)
        if IsUnitVisible(u, ply) and ply == GetLocalPlayer() then
            call SetTextTagColor(e, 255, 255, 255, 240)
        endif
        if GetOwningPlayer(u) == GetLocalPlayer() then
            call SetTextTagColor(e, 55, 255, 55, 240)
        endif
    endif
    call SetTextTagVelocityBJ(e, 150, 90)
    call SetTextTagPermanent(e, false)
    call SetTextTagLifespan(e, 1.67)
    set e = null
endfunction

function WordDamageInNormal_Output takes player ply, unit u, real tredam, boolean critred returns nothing
    local texttag e
    local real f
    if tredam < 1 then
        if tredam < -15 then
            call WordHealInNormal_Output(ply, u, tredam, critred)
            set e = null
            return
        else
            set e = null
            return
        endif
    endif
    set e = CreateTextTag()
    set f = 8.0
    if tredam <= 50 then
        set f = 6.0
    elseif tredam <= 100 then
        set f = 7.0
    elseif tredam <= 200 then
        set f = 8.0
    elseif tredam <= 400 then
        set f = 9.0
    elseif tredam <= 800 then
        set f = 10.0
    elseif tredam <= 1600 then
        set f = 11.0
    elseif tredam <= 3200 then
        set f = 12.0
    else
        set f = 13.0
    endif
    if critred then
        call SetTextTagTextBJ(e, I2S(R2I(tredam)) + "!", f)
    else
        call SetTextTagTextBJ(e, I2S(R2I(tredam)), f)
    endif
    call SetTextTagPos(e, GetUnitX(u), GetUnitY(u), 100.0)
    if critred then
        call SetTextTagColor(e, 255, 0, 0, 0)
        if IsUnitVisible(u, GetLocalPlayer()) then
            call SetTextTagColor(e, 255, 0, 0, 240)
        endif
    else
        call SetTextTagColor(e, 255, 255, 255, 0)
        if IsUnitVisible(u, ply) and ply == GetLocalPlayer() then
            call SetTextTagColor(e, 255, 255, 255, 240)
        endif
        if GetOwningPlayer(u) == GetLocalPlayer() then
            call SetTextTagColor(e, 126, 126, 126, 240)
        endif
    endif
    call SetTextTagVelocityBJ(e, 150, 90)
    call SetTextTagPermanent(e, false)
    call SetTextTagLifespan(e, 1.67)
    set e = null
endfunction

function WordDamageInNormal_Display takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local integer targetask = GetHandleId(u)
    local integer casply = LoadInteger(udg_ht, task, 1)
    local player ply = Player(casply)
    local integer i = 0
    local boolean clearhstb
    local real totaltredam = LoadReal(udg_DSHashtable, targetask, casply)
    local boolean critred = LoadBoolean(udg_DSHashtable, targetask, casply)
    call WordDamageInNormal_Output(ply, u, totaltredam, critred)
    call SaveReal(udg_DSHashtable, targetask, casply, 0)
    set clearhstb = true
    loop
        if HaveSavedReal(udg_DSHashtable, targetask, i) then
            if LoadReal(udg_DSHashtable, targetask, i) > 0 then
                set clearhstb = false
            endif
        endif
        set i = i + 1
    exitwhen i == 16
    endloop
    if clearhstb then
        call FlushChildHashtable(udg_DSHashtable, targetask)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set u = null
endfunction

function WordDamageInNormal takes unit caster, unit u, real tredam returns nothing
    local integer casply = GetPlayerId(GetOwningPlayer(caster))
    local integer targetask = GetHandleId(u)
    local timer t
    local integer task
    local real displaydam = 0.0
    if udg_DamageSystem_WordsOn == false then
        set t = null
        return
    endif
    if udg_DSHashtable == null then
        set udg_DSHashtable = InitHashtable()
    endif
    if HaveSavedReal(udg_DSHashtable, targetask, casply) == false then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, u)
        call SaveInteger(udg_ht, task, 1, casply)
        call TimerStart(t, 0.01, false, function WordDamageInNormal_Display)
        set displaydam = displaydam + tredam
        call SaveReal(udg_DSHashtable, targetask, casply, displaydam)
        call SaveBoolean(udg_DSHashtable, targetask, casply, false)
    else
        set displaydam = displaydam + tredam
        set displaydam = displaydam + LoadReal(udg_DSHashtable, targetask, casply)
        call SaveReal(udg_DSHashtable, targetask, casply, displaydam)
    endif
    set t = null
endfunction

function WordDamageInRed takes unit caster, unit u, real tredam returns nothing
    local integer casply = GetPlayerId(GetOwningPlayer(caster))
    local integer targetask = GetHandleId(u)
    local timer t
    local integer task
    local real displaydam = 0.0
    if udg_DSHashtable == null then
        set udg_DSHashtable = InitHashtable()
    endif
    if HaveSavedReal(udg_DSHashtable, targetask, casply) == false then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, u)
        call SaveInteger(udg_ht, task, 1, casply)
        call TimerStart(t, 0.01, false, function WordDamageInNormal_Display)
        set displaydam = displaydam + tredam
        call SaveReal(udg_DSHashtable, targetask, casply, displaydam)
        call SaveBoolean(udg_DSHashtable, targetask, casply, true)
    else
        set displaydam = displaydam + tredam
        set displaydam = displaydam + LoadReal(udg_DSHashtable, targetask, casply)
        call SaveReal(udg_DSHashtable, targetask, casply, displaydam)
        call SaveBoolean(udg_DSHashtable, targetask, casply, true)
    endif
    set t = null
endfunction

function WordHealInNormal takes unit caster, unit u, real tredam returns nothing
    local integer casply = GetPlayerId(GetOwningPlayer(caster))
    local integer targetask = GetHandleId(u)
    local timer t
    local integer task
    local real displaydam = 0.0
    if udg_DamageSystem_WordsOn == false then
        set t = null
        return
    endif
    if udg_DSHashtable == null then
        set udg_DSHashtable = InitHashtable()
    endif
    if HaveSavedReal(udg_DSHashtable, targetask, casply) == false then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, u)
        call SaveInteger(udg_ht, task, 1, casply)
        call TimerStart(t, 0.01, false, function WordDamageInNormal_Display)
        set displaydam = displaydam + tredam * -1
        call SaveReal(udg_DSHashtable, targetask, casply, displaydam)
        call SaveBoolean(udg_DSHashtable, targetask, casply, false)
    else
        set displaydam = displaydam + tredam * -1
        set displaydam = displaydam + LoadReal(udg_DSHashtable, targetask, casply)
        call SaveReal(udg_DSHashtable, targetask, casply, displaydam)
    endif
    set t = null
endfunction

function InitTrig_DisplayWordsNew takes nothing returns nothing
endfunction