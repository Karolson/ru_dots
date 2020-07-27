function THD_ResetSpawnUnitOrder takes unit u returns nothing
    if GetOwningPlayer(u) == udg_SpawnPlayer[0] then
        call SpawnIssueOrderA(u)
    elseif GetOwningPlayer(u) == udg_SpawnPlayer[1] then
        call SpawnIssueOrderB(u)
    endif
endfunction

function GetNow takes nothing returns real
    return udg_NPC_cycleIndex * udg_NPC_GetCycle + TimerGetElapsed(udg_NPC_cycleTimer)
endfunction

function UnitAttackAim takes unit u, unit aim returns nothing
    local integer i = 0
    if GetUnitAbilityLevel(u, 'A10A') != 0 and IsUnitType(aim, UNIT_TYPE_STRUCTURE) == false then
        return
    endif
    if IsUnitInRange(aim, u, GetUnitDefaultAcquireRange(u)) then
        loop
        exitwhen udg_NPC_attackArrayNext[i] == 0
            if udg_NPC_attackArrayUnit[udg_NPC_attackArrayNext[i]] == u then
                if udg_NPC_attackArrayAim[udg_NPC_attackArrayNext[i]] == aim then
                    if udg_NPC_attackArrayNext[i] != udg_NPC_attackArrayEnd then
                        set udg_NPC_attackArrayNext[udg_NPC_attackArrayEnd] = udg_NPC_attackArrayNext[i]
                        set udg_NPC_attackArrayEnd = udg_NPC_attackArrayNext[i]
                        set udg_NPC_attackArrayNext[i] = udg_NPC_attackArrayNext[udg_NPC_attackArrayEnd]
                        set udg_NPC_attackArrayNext[udg_NPC_attackArrayEnd] = 0
                    endif
                    set udg_NPC_attackArrayTime[udg_NPC_attackArrayEnd] = udg_NPC_cycleIndex * udg_NPC_GetCycle + TimerGetElapsed(udg_NPC_cycleTimer)
                endif
                return
            endif
            set i = udg_NPC_attackArrayNext[i]
        endloop
        set udg_NPC_attackArrayNext[udg_NPC_attackArrayEnd] = udg_NPC_attackArrayTop
        set udg_NPC_attackArrayEnd = udg_NPC_attackArrayTop
        if udg_NPC_attackArrayNext[udg_NPC_attackArrayTop] == 0 then
            set udg_NPC_attackArrayTop = udg_NPC_attackArrayTop + 1
        else
            set udg_NPC_attackArrayTop = udg_NPC_attackArrayNext[udg_NPC_attackArrayTop]
        endif
        set udg_NPC_attackArrayUnit[udg_NPC_attackArrayEnd] = u
        set udg_NPC_attackArrayAim[udg_NPC_attackArrayEnd] = aim
        set udg_NPC_attackArrayNext[udg_NPC_attackArrayEnd] = 0
        set udg_NPC_attackArrayTime[udg_NPC_attackArrayEnd] = udg_NPC_cycleIndex * udg_NPC_GetCycle + TimerGetElapsed(udg_NPC_cycleTimer)
        call IssueTargetOrderById(u, 851983, aim)
    endif
endfunction

function Cycle takes nothing returns nothing
    local real lowtime
    local integer i
    set udg_NPC_cycleIndex = udg_NPC_cycleIndex + 1
    set lowtime = udg_NPC_cycleIndex * udg_NPC_GetCycle + TimerGetElapsed(udg_NPC_cycleTimer) - udg_NPC_AttackMaxTime
    loop
        set i = udg_NPC_attackArrayNext[0]
    exitwhen i == 0
        if IsUnitType(udg_NPC_attackArrayUnit[i], UNIT_TYPE_DEAD) or IsUnitType(udg_NPC_attackArrayAim[i], UNIT_TYPE_DEAD) or udg_NPC_attackArrayTime[i] < lowtime then
            set udg_NPC_attackArrayNext[0] = udg_NPC_attackArrayNext[i]
            set udg_NPC_attackArrayNext[i] = udg_NPC_attackArrayTop
            set udg_NPC_attackArrayTop = i
            if IsUnitType(udg_NPC_attackArrayUnit[i], UNIT_TYPE_DEAD) == false then
                call THD_ResetSpawnUnitOrder(udg_NPC_attackArrayUnit[i])
            endif
            set udg_NPC_attackArrayUnit[i] = null
            set udg_NPC_attackArrayAim[i] = null
        else
        exitwhen true
        endif
    endloop
    if i == 0 then
        set udg_NPC_attackArrayEnd = 0
    endif
endfunction

function LowlifeNear takes nothing returns boolean
    local unit u = LoadUnitHandle(udg_Hashtable, GetHandleId(GetTriggeringTrigger()), StringHash("unit"))
    local real life = GetUnitState(u, UNIT_STATE_LIFE)
    if life > 0.0 and life < GetUnitState(u, UNIT_STATE_MAX_LIFE) * udg_NPC_Lowlife and IsUnitEnemy(u, GetOwningPlayer(GetTriggerUnit())) then
        call UnitAttackAim(GetTriggerUnit(), u)
    endif
    set u = null
    return false
endfunction

function HeroInGame takes nothing returns boolean
    local unit u = GetEnteringUnit()
    local trigger t
    if IsUnitType(u, UNIT_TYPE_HERO) and IsUnitIllusion(u) == false then
        set t = CreateTrigger()
        call SaveUnitHandle(udg_Hashtable, GetHandleId(t), StringHash("unit"), u)
        call TriggerAddCondition(t, Condition(function LowlifeNear))
        call TriggerRegisterUnitInRange(t, u, 700, null)
        call TriggerRegisterUnitInRange(t, u, 400, null)
    endif
    set u = null
    set t = null
    return false
endfunction

function LowlifeAttack takes nothing returns boolean
    local group g
    local player p
    local unit u2
    local unit u = GetTriggerUnit()
    local real life = GetUnitState(u, UNIT_STATE_LIFE) - GetEventDamage()
    if life > 0.0 and life < GetUnitState(u, UNIT_STATE_MAX_LIFE) * udg_NPC_Lowlife then
        if IsUnitAlly(u, Player(0)) then
            set p = Player(6)
        else
            set p = Player(0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 800, null)
        loop
            set u2 = FirstOfGroup(g)
        exitwhen u2 == null
            if GetOwningPlayer(u2) == p then
                call UnitAttackAim(u2, u)
            endif
            call GroupRemoveUnit(g, u2)
        endloop
        call DestroyGroup(g)
    endif
    set u = null
    set p = null
    set g = null
    set u2 = null
    return false
endfunction

function AegisHero takes nothing returns boolean
    local unit attacker
    local unit attacked
    local group g
    local player who
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_ATTACKED then
        set attacker = GetAttacker()
        set attacked = GetTriggerUnit()
    elseif GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        set attacker = GetEventDamageSource()
        set attacked = GetTriggerUnit()
    elseif GetIssuedOrderId() == 851983 or GetIssuedOrderId() == 851971 then
        set attacker = GetTriggerUnit()
        set attacked = GetOrderTargetUnit()
    else
        set attacker = null
        set attacked = null
        set g = null
        set who = null
        return false
    endif
    if IsUnitType(attacked, UNIT_TYPE_HERO) and IsUnitEnemy(attacker, GetOwningPlayer(attacked)) then
        if IsUnitAlly(attacker, udg_SpawnPlayer[0]) then
            set who = udg_SpawnPlayer[1]
        else
            set who = udg_SpawnPlayer[0]
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(attacker), GetUnitY(attacker), 800.0, null)
        loop
            set attacked = FirstOfGroup(g)
        exitwhen attacked == null
            call GroupRemoveUnit(g, attacked)
            if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
                if GetOwningPlayer(attacked) == who then
                    call UnitAttackAim(attacked, attacker)
                endif
            else
                if GetOwningPlayer(attacked) == who and IsUnitType(attacked, UNIT_TYPE_STRUCTURE) and GetEventDamage() > 0 then
                    call UnitAttackAim(attacked, attacker)
                endif
            endif
        endloop
        call DestroyGroup(g)
    endif
    set attacker = null
    set attacked = null
    set g = null
    set who = null
    return false
endfunction

function Trig_Spawn_Units_AI_Init takes nothing returns nothing
    local trigger trg
    set udg_NPC_AttackMaxTime = 2
    set udg_NPC_Lowlife = 0.02
    set udg_NPC_GetCycle = 0.33
    set udg_NPC_cycleIndex = 0
    call TimerStart(udg_NPC_cycleTimer, udg_NPC_GetCycle, true, function Cycle)
    set trg = CreateTrigger()
    call TriggerAddCondition(trg, Condition(function HeroInGame))
    call YDWETriggerRegisterEnterRectSimpleNull(trg, bj_mapInitialPlayableArea)
    set gg_trg_Spawn_Units_AI = CreateTrigger()
    call TriggerAddCondition(gg_trg_Spawn_Units_AI, Condition(function AegisHero))
    call RegisterAnyUnitDamage(gg_trg_Spawn_Units_AI)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Spawn_Units_AI, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Spawn_Units_AI, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    set trg = null
endfunction

function InitTrig_Spawn_Units_AI takes nothing returns nothing
endfunction