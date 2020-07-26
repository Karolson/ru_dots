function Trig_AI_Action_Custom_Ability takes player who, unit h returns nothing
    local integer ID = GetUnitTypeId(h)
    if ID == 'H001' or ID == 'H02E' or ID == 'H02D' then
        call AI_Ability_Reimu(h)
    elseif ID == 'O009' then
        call AI_Ability_Utsuho(h)
    elseif ID == 'E01E' then
        call AI_Ability_Koakuma(h)
    elseif ID == 'H01J' then
        call AI_Ability_Nue(h)
    elseif ID == 'E01U' then
        call AI_Ability_Parsee(h)
    elseif ID == 'E010' then
        call AI_Ability_Koishi(h)
    elseif ID == 'H01H' then
        call AI_Ability_Shizuha(h)
    elseif ID == 'H01I' then
        call AI_Ability_Minoriko(h)
    elseif ID == 'H01Y' then
        call AI_Ability_Minoriko2(h)
    endif
    if ID == 'H00W' then
        call AI_Ability_Kaguya(h)
    elseif ID == 'O006' then
        call AI_Ability_Eirin(h)
    elseif ID == 'H002' then
        call AI_Ability_Tensi(h)
    elseif ID == 'N00J' then
        call AI_Ability_Mokou(h)
    elseif ID == 'H000' then
        call AI_Ability_Marisa(h)
    elseif ID == 'E00F' then
        call AI_Ability_Yukari(h)
    elseif ID == 'E00G' then
        call AI_Ability_Ran(h)
    elseif ID == 'E00Z' then
        call AI_Ability_Mystia(h)
    elseif ID == 'E00V' then
        call AI_Ability_Shikieiki(h)
    elseif ID == 'H01A' then
        call AI_Ability_Alice(h)
    elseif ID == 'E00Q' then
        call AI_Ability_Captain(h)
    elseif ID == 'U003' then
        call AI_Ability_Iku(h)
    elseif ID == 'U00K' then
        call AI_Ability_Nazrin(h)
    endif
endfunction

function Trig_AI_AddItems takes player who, unit h, integer T returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local item w
    if AIDIFF(h) == 0 and GetRandomInt(0, 100) <= 1 then
        call AI_RetreatForGank(h)
    elseif AIDIFF(h) == 1 and GetRandomInt(0, 100) <= 4 then
        call AI_RetreatForGank(h)
    elseif AIDIFF(h) == 1 and GetRandomInt(0, 100) <= 16 then
        call AI_RetreatForGank(h)
    endif
    call AI_LastHitMovement(h)
    if T / 300 * 300 == T then
        set udg_TeamWorkingModeA = GetRandomInt(1, 3)
        set udg_TeamWorkingModeB = GetRandomInt(1, 3)
    endif
    if T == 25 then
        if AIDIFF(h) == 0 then
        elseif AIDIFF(h) == 1 then
            call SetHeroStr(h, GetHeroStr(h, false) + GetRandomInt(0, 10), true)
            call SetHeroAgi(h, GetHeroAgi(h, false) + GetRandomInt(0, 10), true)
            call SetHeroInt(h, GetHeroInt(h, false) + GetRandomInt(0, 10), true)
        elseif AIDIFF(h) == 2 then
            call SetHeroStr(h, GetHeroStr(h, false) + GetRandomInt(0, 30), true)
            call SetHeroAgi(h, GetHeroAgi(h, false) + GetRandomInt(0, 30), true)
            call SetHeroInt(h, GetHeroInt(h, false) + GetRandomInt(0, 30), true)
        endif
    endif
    if GetUnitTypeId(h) == 'H001' then
        call AI_Item_Reimu(h, T)
    elseif GetUnitTypeId(h) == 'O009' then
        call AI_Item_Utsuho(h, T)
    elseif GetUnitTypeId(h) == 'E01E' then
        call AI_Item_Koakuma(h, T)
    elseif GetUnitTypeId(h) == 'H01J' then
        call AI_Item_Nue(h, T)
    elseif GetUnitTypeId(h) == 'E01U' then
        call AI_Item_Parsee(h, T)
    elseif GetUnitTypeId(h) == 'E010' then
        call AI_Item_Koishi(h, T)
    elseif GetUnitTypeId(h) == 'H01H' then
        call AI_Item_Shizuha(h, T)
    elseif GetUnitTypeId(h) == 'H01I' then
        call AI_Item_Minoriko(h, T)
    elseif GetUnitTypeId(h) == 'H01Y' then
        call AI_Item_Minoriko2(h, T)
    else
        if T == 30 then
            if GetRandomInt(0, 100) <= 15 then
                set w = CreateItem('I039', ox, oy)
            elseif GetRandomInt(0, 100) <= 15 then
                set w = CreateItem('I03A', ox, oy)
            elseif GetRandomInt(0, 100) <= 15 then
                set w = CreateItem('I03B', ox, oy)
            elseif GetRandomInt(0, 100) <= 15 then
                set w = CreateItem('I08T', ox, oy)
            elseif GetRandomInt(0, 100) <= 15 then
                set w = CreateItem('I00N', ox, oy)
            else
                set w = CreateItem('I031', ox, oy)
            endif
            call UnitAddItem(h, w)
        elseif T == R2I(700 * (0.25 * (4 - AIDIFF(h)))) or T == R2I(1400 * (0.25 * (4 - AIDIFF(h)))) or T == R2I(2100 * (0.25 * (4 - AIDIFF(h)))) or T == R2I(2800 * (0.25 * (4 - AIDIFF(h)))) or T == R2I(3500 * (0.25 * (4 - AIDIFF(h)))) then
            if GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I007', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I02V', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I02W', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00P', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I06V', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I051', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I02Y', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I07H', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I064', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I030', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I07R', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00E', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I026', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I073', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I02X', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00G', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I008', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I075', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00D', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00C', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I03I', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I034', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I08P', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I08Q', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00I', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I07D', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I06N', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00K', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00M', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I069', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I06X', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I06Y', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I04D', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I037', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I04G', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I041', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I07F', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I05T', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I087', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I04T', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I04A', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I04O', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I04Q', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I06K', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I07Z', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I04N', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00U', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00W', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I01T', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I05W', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00B', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I08D', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I07X', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I032', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I060', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I00V', ox, oy)
            elseif GetRandomInt(0, 100) <= 5 then
                set w = CreateItem('I066', ox, oy)
            else
                set w = CreateItem('I014', ox, oy)
            endif
            call UnitAddItem(h, w)
        endif
    endif
    set w = null
endfunction

function Trig_AI_Action_Router takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local player who = GetEnumPlayer()
    local integer i = GetPlayerId(who)
    local integer T = LoadInteger(udg_ht, task, 0) + i
    local unit h = udg_PlayerHeroes[i]
    if h == null then
        set t = null
        set who = null
        return
    endif
    if GetWidgetLife(h) > 0.405 then
        if T / 2 * 2 == T then
            if GetUnitCurrentOrder(h) == OrderId("massteleport") then
                call DebugMsg("AI - TP State")
            elseif GetUnitTypeId(h) == 'O009' and GetUnitCurrentOrder(h) == OrderId("cyclone") then
            elseif GetUnitTypeId(h) == 'H01J' and GetUnitCurrentOrder(h) == OrderId("inferno") then
            elseif GetUnitAbilityLevel(h, 'A19M') >= 1 then
            elseif GetUnitAbilityLevel(h, 'A19L') >= 1 == false then
                call Trig_AI_Action_Offensive(who, h)
            endif
        else
            if GetUnitCurrentOrder(h) == OrderId("massteleport") then
                call DebugMsg("AI - TP State")
            elseif GetUnitTypeId(h) == 'O009' and GetUnitCurrentOrder(h) == OrderId("cyclone") then
            elseif GetUnitTypeId(h) == 'H01J' and GetUnitCurrentOrder(h) == OrderId("inferno") then
            elseif GetUnitAbilityLevel(h, 'A19M') >= 1 then
            elseif not Trig_AI_Action_Maintain(h) then
                call Trig_AI_Action_Offensive(who, h)
            endif
        endif
        call Trig_AI_Action_Custom_Ability(who, h)
    endif
    call Trig_AI_AddItems(who, h, T)
    set t = null
    set who = null
    set h = null
endfunction

function Trig_AI_Action_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer T = LoadInteger(udg_ht, task, 0)
    call ForForce(udg_AI_Players, function Trig_AI_Action_Router)
    call SaveInteger(udg_ht, task, 0, T + 1)
    set t = null
endfunction

function Trig_AI_Action_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveInteger(udg_ht, task, 0, 0)
    call TimerStart(t, 1.0, true, function Trig_AI_Action_Main)
    set t = null
endfunction

function InitTrig_AI_Action takes nothing returns nothing
    set gg_trg_AI_Action = CreateTrigger()
    call TriggerAddAction(gg_trg_AI_Action, function Trig_AI_Action_Actions)
endfunction