function Trig_TowerAttackSpeedIncrease_Target takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    elseif GetFilterUnit() == LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    return true
endfunction

function Trig_TowerAttackSpeedIncrease_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit tower = LoadUnitHandle(udg_ht, task, 0)
    local unit spawnplayerunit = LoadUnitHandle(udg_ht, task, 1)
    local boolean hasabilityon = false
    local boolean hasvaluespawn = false
    local boolean hasvaluehero = false
    local boolean removeab = false
    local boolean enddingloop = false
    local boolean hasalldie = false
    local unit hero
    local integer i
    local group g = LoadGroupHandle(udg_ht, task, 2)
    local boolexpr f = LoadBooleanExprHandle(udg_ht, task, 3)
    local unit v
    local real ox
    local real oy
    if tower == null or IsUnitType(tower, UNIT_TYPE_DEAD) then
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set tower = null
        set g = null
        set f = null
        set v = null
    endif
    set ox = GetUnitX(tower)
    set oy = GetUnitY(tower)
    call GroupEnumUnitsInRange(g, ox, oy, 1200, f)
    loop
        set v = FirstOfGroup(g)
        if v == null then
            set hasvaluespawn = false
            set enddingloop = true
        else
            if GetOwningPlayer(v) == GetOwningPlayer(spawnplayerunit) then
                if GetUnitAbilityLevel(v, 'A0EL') == 0 then
                    set hasvaluespawn = true
                    set enddingloop = true
                endif
            endif
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set hasvaluehero = true
            endif
        endif
    exitwhen enddingloop
        call GroupRemoveUnit(g, v)
    endloop
    if GetUnitAbilityLevel(tower, 'A0ZE') == 0 then
        set hasabilityon = false
    else
        set hasabilityon = true
    endif
    if spawnplayerunit == udg_BaseA[0] then
        set i = 5
        set hasalldie = true
        loop
            set hero = GetPlayerCharacter(GetSortedPlayer(i))
            if hero != null and IsUnitType(hero, UNIT_TYPE_DEAD) == false then
                set hasalldie = false
            endif
            set i = i + 1
        exitwhen i == 10
        endloop
    else
        set i = 0
        set hasalldie = true
        loop
            set hero = GetPlayerCharacter(GetSortedPlayer(i))
            if hero != null and IsUnitType(hero, UNIT_TYPE_DEAD) == false then
                set hasalldie = false
            endif
            set i = i + 1
        exitwhen i == 5
        endloop
    endif
    if hasalldie then
        set removeab = true
    endif
    if hasvaluespawn then
        set removeab = true
    endif
    if hasvaluehero and hasabilityon == false then
        set removeab = true
    endif
    if removeab then
        if hasabilityon then
            call UnitRemoveAbility(tower, 'A0ZD')
            call UnitRemoveAbility(tower, 'A0ZE')
            call UnitRemoveAbility(tower, 'A0ZF')
        endif
    else
        if hasabilityon == false then
            call UnitAddAbility(tower, 'A0ZE')
            if GetUnitTypeId(tower) == 'h00C' or GetUnitTypeId(tower) == 'h00Y' then
                call UnitAddAbility(tower, 'A0ZD')
                call UnitAddAbility(tower, 'A0ZF')
            elseif GetUnitTypeId(tower) == 'h019' or GetUnitTypeId(tower) == 'h017' then
                call UnitAddAbility(tower, 'A0ZD')
                call UnitAddAbility(tower, 'A0ZF')
                call SetUnitAbilityLevel(tower, 'A0ZF', 2)
            elseif GetUnitTypeId(tower) == 'h016' or GetUnitTypeId(tower) == 'h018' or GetUnitTypeId(tower) == 'h028' or GetUnitTypeId(tower) == 'h027' then
                call UnitAddAbility(tower, 'A0ZD')
                call UnitAddAbility(tower, 'A0ZF')
                call SetUnitAbilityLevel(tower, 'A0ZF', 3)
            elseif GetUnitTypeId(tower) == 'h00Z' then
                call UnitAddAbility(tower, 'A0ZD')
                call UnitAddAbility(tower, 'A0ZF')
                call SetUnitAbilityLevel(tower, 'A0ZF', 4)
            elseif GetUnitTypeId(tower) == 'h010' then
                call UnitAddAbility(tower, 'A0ZD')
                call UnitAddAbility(tower, 'A0ZF')
                call SetUnitAbilityLevel(tower, 'A0ZF', 5)
            elseif GetUnitTypeId(tower) == 'h013' or GetUnitTypeId(tower) == 'h00A' then
                call SetUnitState(tower, UNIT_STATE_LIFE, GetUnitState(tower, UNIT_STATE_LIFE) + 10)
            elseif GetUnitTypeId(tower) == 'h00D' or GetUnitTypeId(tower) == 'h00U' then
                call SetUnitState(tower, UNIT_STATE_LIFE, GetUnitState(tower, UNIT_STATE_LIFE) + 15)
            endif
        endif
    endif
    set t = null
    set f = null
    set tower = null
    set spawnplayerunit = null
    set hero = null
    set g = null
    set v = null
endfunction

function Trig_Initialization_TowerAbility_Actions takes nothing returns nothing
    local timer t
    local integer task
    local integer i
    local unit u
    local group g
    local boolexpr f = Filter(function Trig_TowerAttackSpeedIncrease_Target)
    local integer array tri
    set tri[0] = 1
    set tri[1] = 2
    set tri[2] = 6
    set tri[3] = 8
    set tri[4] = 9
    set tri[5] = 11
    set tri[6] = 12
    set tri[7] = 14
    set tri[8] = 0
    set tri[9] = 3
    set tri[10] = 4
    set tri[11] = 5
    set i = 0
    loop
        set u = udg_BaseA[tri[i]]
        set g = CreateGroup()
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, u)
        call SaveUnitHandle(udg_ht, task, 1, udg_BaseB[0])
        call SaveGroupHandle(udg_ht, task, 2, g)
        call SaveBooleanExprHandle(udg_ht, task, 3, f)
        call TimerStart(t, 1.0, true, function Trig_TowerAttackSpeedIncrease_Main)
        set i = i + 1
    exitwhen i == 12
    endloop
    set tri[12] = 1
    set tri[13] = 2
    set tri[14] = 6
    set tri[15] = 8
    set tri[16] = 9
    set tri[17] = 11
    set tri[18] = 12
    set tri[19] = 14
    set tri[20] = 0
    set tri[21] = 3
    set tri[22] = 4
    set tri[23] = 5
    loop
        set u = udg_BaseB[tri[i]]
        set t = CreateTimer()
        set g = CreateGroup()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, u)
        call SaveUnitHandle(udg_ht, task, 1, udg_BaseA[0])
        call SaveGroupHandle(udg_ht, task, 2, g)
        call SaveBooleanExprHandle(udg_ht, task, 3, f)
        call TimerStart(t, 1.0, true, function Trig_TowerAttackSpeedIncrease_Main)
        set i = i + 1
    exitwhen i == 24
    endloop
    set t = null
    set u = null
    set g = null
    set f = null
endfunction

function Tower_Set_Target takes unit tower, unit target returns nothing
    call SaveUnitHandle(udg_ht, GetHandleId(tower), 0, target)
endfunction

function TowerAI_Stage_1_Conditions takes nothing returns boolean
    local unit u = GetSpellTargetUnit()
    local unit v = GetTriggerUnit()
    local unit w = null
    local player p = GetTriggerPlayer()
    local unit target = null
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED and IsUnitType(v, UNIT_TYPE_HERO) and IsUnitEnemy(GetEventDamageSource(), p) and not IsUnitType(GetEventDamageSource(), UNIT_TYPE_STRUCTURE) and IsUnitType(GetEventDamageSource(), UNIT_TYPE_HERO) then
        set target = GetEventDamageSource()
        call GroupEnumUnitsInRange(udg_TowerAIGroup, GetUnitX(target), GetUnitY(target), 750.0, null)
        if IsPlayerInForce(p, udg_TeamB) then
            loop
                set w = FirstOfGroup(udg_TowerAIGroup)
            exitwhen w == null
                call GroupRemoveUnit(udg_TowerAIGroup, w)
                if GetUnitTypeId(w) == 'h019' or GetUnitTypeId(w) == 'h028' or GetUnitTypeId(w) == 'h016' or GetUnitTypeId(w) == 'h00Z' or GetUnitTypeId(w) == 'h00C' then
                    call GroupAddUnit(udg_TowerGroup, w)
                    call SaveUnitHandle(udg_ht, GetHandleId(w), 0, target)
                endif
            endloop
        elseif IsPlayerInForce(p, udg_TeamA) then
            loop
                set w = FirstOfGroup(udg_TowerAIGroup)
            exitwhen w == null
                call GroupRemoveUnit(udg_TowerAIGroup, w)
                if GetUnitTypeId(w) == 'h010' or GetUnitTypeId(w) == 'h017' or GetUnitTypeId(w) == 'h027' or GetUnitTypeId(w) == 'h018' or GetUnitTypeId(w) == 'h00Y' or GetUnitTypeId(w) == 'h02M' or GetUnitTypeId(w) == 'h02L' then
                    call GroupAddUnit(udg_TowerGroup, w)
                    call SaveUnitHandle(udg_ht, GetHandleId(w), 0, target)
                endif
            endloop
        endif
        call GroupTargetOrder(udg_TowerGroup, "attack", target)
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT and IsUnitType(u, UNIT_TYPE_HERO) and IsUnitEnemy(u, p) then
        call GroupEnumUnitsInRange(udg_TowerAIGroup, GetUnitX(v), GetUnitY(v), 700.0, null)
        if IsPlayerInForce(p, udg_TeamB) then
            loop
                set w = FirstOfGroup(udg_TowerAIGroup)
            exitwhen w == null
                call GroupRemoveUnit(udg_TowerAIGroup, w)
                if GetUnitTypeId(w) == 'h010' or GetUnitTypeId(w) == 'h017' or GetUnitTypeId(w) == 'h027' or GetUnitTypeId(w) == 'h018' or GetUnitTypeId(w) == 'h00Y' or GetUnitTypeId(w) == 'h02M' or GetUnitTypeId(w) == 'h02L' then
                    call GroupAddUnit(udg_TowerGroup, w)
                    call SaveUnitHandle(udg_ht, GetHandleId(w), 0, target)
                endif
            endloop
        elseif IsPlayerInForce(p, udg_TeamA) then
            loop
                set w = FirstOfGroup(udg_TowerAIGroup)
            exitwhen w == null
                call GroupRemoveUnit(udg_TowerAIGroup, w)
                if GetUnitTypeId(w) == 'h019' or GetUnitTypeId(w) == 'h028' or GetUnitTypeId(w) == 'h016' or GetUnitTypeId(w) == 'h00Z' or GetUnitTypeId(w) == 'h00C' then
                    call GroupAddUnit(udg_TowerGroup, w)
                    call SaveUnitHandle(udg_ht, GetHandleId(w), 0, target)
                endif
            endloop
        endif
        call GroupTargetOrder(udg_TowerGroup, "attack", v)
    endif
    call GroupClear(udg_TowerAIGroup)
    call GroupClear(udg_TowerGroup)
    set u = null
    set v = null
    set p = null
    return false
endfunction

function TowerAI_Save_Order_Target takes nothing returns boolean
    local unit u = GetAttacker()
    local unit v = GetTriggerUnit()
    local integer i = 0
    loop
    exitwhen i > 7
        if u == udg_TowerA[i] or u == udg_TowerB[i] then
            call SaveUnitHandle(udg_ht, GetHandleId(u), 0, v)
        endif
        set i = i + 1
    endloop
    set u = null
    set v = null
    return false
endfunction

function TowerAI_Stage2_and_3 takes nothing returns nothing
    local integer i = 0
    local unit u = null
    local unit tower = null
    local unit target = null
    local player allyplayer = null
    local boolean havesummoned = false
    local boolean havehero = false
    local boolean nothingelse = true
    loop
    exitwhen i > 15
        if i < 8 then
            set tower = udg_TowerA[i]
            set allyplayer = Player(5)
        else
            set tower = udg_TowerB[i - 8]
            set allyplayer = Player(11)
        endif
        if tower != null and GetWidgetLife(tower) > 0.405 then
            if HaveSavedHandle(udg_ht, GetHandleId(tower), 0) then
                set target = LoadUnitHandle(udg_ht, GetHandleId(tower), 0)
            else
                set target = null
            endif
            if target == null or GetWidgetLife(target) <= 0.405 or IsUnitInvulnerable(target) or not IsUnitInRange(target, tower, 700.0) then
                set havesummoned = false
                set havehero = false
                set nothingelse = true
                call GroupClear(udg_TowerGroup)
                call GroupClear(udg_TowerGroup2)
                call GroupClear(udg_TowerGroup3)
                call GroupEnumUnitsInRange(udg_TowerAIGroup, GetUnitX(tower), GetUnitY(tower), 700.0, null)
                loop
                    set u = FirstOfGroup(udg_TowerAIGroup)
                exitwhen u == null
                    call GroupRemoveUnit(udg_TowerAIGroup, u)
                    if IsUnitEnemy(u, allyplayer) then
                        if IsUnitType(u, UNIT_TYPE_SUMMONED) then
                            set havesummoned = true
                            call GroupAddUnit(udg_TowerGroup, u)
                        elseif IsUnitType(u, UNIT_TYPE_HERO) then
                            set havehero = true
                            call GroupAddUnit(udg_TowerGroup2, u)
                        else
                            set nothingelse = false
                            call GroupAddUnit(udg_TowerGroup3, u)
                        endif
                    endif
                endloop
                if havesummoned then
                    set target = FirstOfGroup(udg_TowerGroup)
                elseif havehero and nothingelse then
                    set target = FirstOfGroup(udg_TowerGroup2)
                elseif not nothingelse then
                    set target = FirstOfGroup(udg_TowerGroup3)
                endif
                call SaveUnitHandle(udg_ht, GetHandleId(tower), 0, target)
            else
            endif
            if target != null then
                call IssueTargetOrder(tower, "attack", target)
            endif
        endif
        set i = i + 1
    endloop
endfunction

function InitTrig_TowerAbility takes nothing returns nothing
    local trigger t = CreateTrigger()
    local timer tm = CreateTimer()
    local integer i = 0
    set gg_trg_TowerAbility = CreateTrigger()
    call TriggerAddAction(gg_trg_TowerAbility, function Trig_Initialization_TowerAbility_Actions)
    set udg_TowerAIGroup = CreateGroup()
    set udg_TowerGroup = CreateGroup()
    set udg_TowerGroup2 = CreateGroup()
    set udg_TowerGroup3 = CreateGroup()
    set udg_TowerA[0] = gg_unit_h02M_0043
    set udg_TowerA[1] = gg_unit_h02L_0073
    set udg_TowerA[2] = gg_unit_h027_0068
    set udg_TowerA[3] = gg_unit_h027_0046
    set udg_TowerA[4] = gg_unit_h018_0000
    set udg_TowerA[5] = gg_unit_h00Y_0050
    set udg_TowerA[6] = gg_unit_h017_0107
    set udg_TowerA[7] = gg_unit_h00Y_0089
    set udg_TowerB[0] = gg_unit_h00Z_0091
    set udg_TowerB[1] = gg_unit_h00Z_0092
    set udg_TowerB[2] = gg_unit_h028_0023
    set udg_TowerB[3] = gg_unit_h028_0069
    set udg_TowerB[4] = gg_unit_h016_0024
    set udg_TowerB[5] = gg_unit_h019_0038
    set udg_TowerB[6] = gg_unit_h00C_0008
    set udg_TowerB[7] = gg_unit_h00C_0042
    if udg_GameMode / 100 == 3 then
        set udg_TowerA[0] = udg_BaseA[1]
        set udg_TowerA[1] = udg_BaseA[2]
        set udg_TowerA[2] = udg_BaseA[6]
        set udg_TowerA[3] = udg_BaseA[8]
        set udg_TowerA[4] = null
        set udg_TowerA[5] = null
        set udg_TowerA[6] = null
        set udg_TowerA[7] = null
        set udg_TowerB[0] = udg_BaseB[1]
        set udg_TowerB[1] = udg_BaseB[2]
        set udg_TowerB[2] = udg_BaseB[6]
        set udg_TowerB[3] = udg_BaseB[8]
        set udg_TowerB[4] = null
        set udg_TowerB[5] = null
        set udg_TowerB[6] = null
        set udg_TowerB[7] = null
    endif
    set t = null
    set tm = null
endfunction