function AI_Ability_Target_Enemy_Units takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    return IsUnitEnemy(GetFilterUnit(), GetEnumPlayer())
endfunction

function AI_Ability_Nazrin takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A0D8')
    local integer i
    local unit v
    local group g
    local real mp = GetUnitState(h, UNIT_STATE_MANA)
    if level == 0 or mp < 60.0 + level * 25.0 then
        set v = null
        set g = null
        return
    endif
    set g = AI_GetAllFoes(h, 900.0)
    if AI_CountUnitsInGroup(g) > 0 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitAlly(v, GetOwningPlayer(h)) and GetUnitLifePercent(v) < 60.0 then
                    if DistanceBetweenUnits(h, v) < 500.0 and GetRandomReal(0, 100) > 30.0 then
                        call IssueTargetOrder(h, "frostarmor", v)
                    exitwhen true
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    call DestroyGroup(g)
    set g = null
    set v = null
endfunction

function AI_Ability_Alice_Doll takes nothing returns nothing
    if GetRandomReal(0, 100.0) < 40.0 then
        call IssueImmediateOrder(GetEnumUnit(), "ravenform")
    endif
endfunction

function AI_Ability_Alice takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A0GW')
    local unit v
    local group g
    if AI_IsLowHP(h) then
        set v = null
        set g = null
        return
    endif
    if level >= 2 then
        if GetRandomReal(0, 100.0) < 50.0 then
            set g = LoadGroupHandle(udg_sht, GetHandleId(h), 2)
            call ForGroup(g, function AI_Ability_Alice_Doll)
        endif
    endif
    set g = null
    set v = null
endfunction

function AI_Ability_Iku takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A04S')
    local unit v
    local integer i
    if level >= 1 and GetUnitState(h, UNIT_STATE_MANA) >= 155.0 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and IsUnitInRange(h, v, 200.0) then
                    call IssueImmediateOrder(h, "metamorphosis")
                exitwhen true
                endif
            endif
            set i = i + 1
        endloop
    endif
    set v = null
endfunction

function AI_Ability_Captain takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A0A6')
    local unit v
    local integer i
    if level >= 1 and GetUnitState(h, UNIT_STATE_MANA) >= 50.0 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) > 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and IsUnitInRange(h, v, 300.0) then
                    call IssueImmediateOrder(h, "battleroar")
                exitwhen true
                endif
            endif
            set i = i + 1
        endloop
    endif
    set v = null
endfunction

function AI_Ability_Marisa takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A042')
    local integer i
    local unit v
    if GetUnitLifePercent(h) < 30.0 then
        set v = null
        return
    endif
    if level >= 0 and GetUnitState(h, UNIT_STATE_MANA) > 125.0 + level * 125.0 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 700.0 then
                    if GetUnitState(v, UNIT_STATE_LIFE) < 150.0 + level * 180.0 and GetUnitLifePercent(v) >= 10.0 then
                        call IssuePointOrder(h, "carrionswarm", GetUnitX(v), GetUnitY(v))
                    exitwhen true
                    elseif GetRandomReal(0.0, 100.0) < 30.0 then
                        if GetUnitLifePercent(v) < 70.0 then
                            call IssuePointOrder(h, "carrionswarm", GetUnitX(v), GetUnitY(v))
                        exitwhen true
                        endif
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set level = GetUnitAbilityLevel(h, 'A041')
    if level == 0 then
        set v = null
        return
    endif
    if GetUnitState(h, UNIT_STATE_MANA) < 65 + 25.0 * level then
        set v = null
        return
    endif
    if GetUnitCurrentOrder(h) != OrderId("carrionswarm") then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) > 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 200.0 then
                    call IssuePointOrder(h, "breathoffire", GetUnitX(v), GetUnitY(v))
                    set v = null
                    return
                endif
            endif
            set i = i + 1
        endloop
    endif
    set v = null
endfunction

function AI_Ability_Shikieiki takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A0B9')
    local integer i
    local unit v
    local real mp = GetUnitState(h, UNIT_STATE_MANA)
    if GetUnitLifePercent(h) < 20.0 then
        set v = null
        return
    endif
    if level >= 4 then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) >= 0.405 and IsUnitEnemy(v, GetOwningPlayer(h)) then
                if IsUnitInRange(h, v, 800.0) then
                    if GetUnitAbilityLevel(v, 'A0B0') >= 10 then
                        call IssueTargetOrder(h, "cripple", v)
                    elseif GetRandomReal(0, 100) <= 2.0 * GetUnitAbilityLevel(v, 'A0B0') then
                        call IssueTargetOrder(h, "cripple", v)
                    endif
                endif
            endif
            set i = i + 1
        endloop
    endif
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 and IsUnitEnemy(v, GetOwningPlayer(h)) then
            if IsUnitInRange(h, v, 800.0) then
                call IssueTargetOrder(h, "faeriefire", v)
            endif
        endif
        set i = i + 1
    endloop
    set v = null
endfunction

function AI_Ability_Yukari takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A04J')
    local integer i
    local unit v
    local real mp = GetUnitState(h, UNIT_STATE_MANA)
    local location shelter
    if level == 0 then
        return
    endif
    if GetUnitLifePercent(h) < 20.0 then
        if mp > 110.0 + level * 10.0 then
            call IssueTargetOrder(h, "drunkenhaze", h)
        elseif GetUnitCurrentOrder(h) <= 852032 then
            set level = GetUnitAbilityLevel(h, 'A04N')
            if level >= 0 and mp >= 60.0 - 10.0 * level then
                if IsPlayerInForce(GetOwningPlayer(h), udg_TeamA) then
                    set shelter = udg_RevivePoint[0]
                else
                    set shelter = udg_RevivePoint[1]
                endif
                call IssuePointOrderLoc(h, "blink", shelter)
                set shelter = null
            endif
        endif
        return
    endif
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 then
            if IsUnitAlly(v, GetOwningPlayer(h)) and GetUnitLifePercent(v) < 20.0 then
                if DistanceBetweenUnits(h, v) < 750.0 then
                    call IssueTargetOrder(h, "drunkenhaze", v)
                exitwhen true
                endif
            endif
            if IsUnitEnemy(v, GetOwningPlayer(h)) and DistanceBetweenUnits(h, v) <= 700.0 then
                if GetUnitCurrentOrder(v) >= 852032 then
                    call IssueTargetOrder(h, "drunkenhaze", v)
                exitwhen true
                endif
                if GetUnitLifePercent(v) >= 80.0 and GetUnitManaPercent(v) >= 25.0 then
                    call IssueTargetOrder(h, "banish", v)
                exitwhen true
                endif
                if GetUnitLifePercent(v) >= 20.0 and GetRandomReal(0, 100) <= 66.6 then
                    call IssueTargetOrder(h, "drunkenhaze", v)
                exitwhen true
                endif
            endif
        endif
        set i = i + 1
    endloop
    set v = null
endfunction

function AI_Ability_Ran takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A0EG')
    local integer i
    local unit v
    local unit target
    local integer n
    local integer m
    if level == 0 or GetUnitLifePercent(h) < 20.0 then
        return
    endif
    if GetUnitState(h, UNIT_STATE_MANA) < 80.0 + level * 20.0 then
        return
    endif
    set target = null
    set m = 0
    set n = 0
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) > 0.405 and DistanceBetweenUnits(h, v) <= 550.0 then
            if IsUnitAlly(v, GetOwningPlayer(h)) then
                set m = m + 1
            else
                if target == null then
                    set target = v
                endif
                set n = n + 1
            endif
        endif
        set i = i + 1
    endloop
    if m >= 3 and n >= 2 then
        set level = GetUnitAbilityLevel(h, 'A0EH')
        if level > 0 then
            if GetUnitState(h, UNIT_STATE_MANA) > 90 + level * 70.0 then
                call IssueImmediateOrder(h, "tranquility")
                set v = null
                set target = null
                return
            endif
        endif
    endif
    if n >= 2 then
        call IssueTargetOrder(h, "chainlightning", target)
    endif
    set v = null
    set target = null
endfunction

function AI_Ability_Eirin takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A083')
    local integer i
    local real px
    local real py
    local real a
    local real d
    local unit v
    if level == 0 or GetUnitLifePercent(h) < 15.0 then
        return
    endif
    if GetUnitState(h, UNIT_STATE_MANA) < 75.0 then
        return
    endif
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and v != h and GetWidgetLife(v) > 0.405 then
            if IsUnitAlly(v, GetOwningPlayer(h)) and GetUnitLifePercent(v) < 60.0 then
                set d = DistanceBetweenUnits(h, v)
                if d <= 1200.0 then
                    set px = GetUnitX(v)
                    set py = GetUnitY(v)
                    if GetUnitCurrentOrder(v) == OrderId("move") then
                        set a = GetUnitFacing(v)
                        set px = px + 300.0 * (d / 900.0) * Cos(a * 0.017454)
                        set py = py + 300.0 * (d / 900.0) * Sin(a * 0.017454)
                    endif
                    call IssuePointOrder(h, "healingspray", px, py)
                exitwhen true
                endif
            endif
            if IsUnitEnemy(v, GetOwningPlayer(h)) and GetUnitState(h, UNIT_STATE_LIFE) < 60.0 * level then
                set d = DistanceBetweenUnits(h, v)
                if d <= 1500.0 then
                    set px = GetUnitX(v)
                    set py = GetUnitY(v)
                    if GetUnitCurrentOrder(v) == OrderId("move") then
                        set a = GetUnitFacing(v)
                        set px = px + 300.0 * (d / 900.0) * Cos(a * 0.017454)
                        set py = py + 300.0 * (d / 900.0) * Sin(a * 0.017454)
                    endif
                    call IssuePointOrder(h, "healingspray", px, py)
                exitwhen true
                endif
            endif
        endif
        set i = i + 1
    endloop
    set v = null
endfunction

function AI_Ability_Tensi takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A0AJ')
    local integer i
    local integer n
    local unit v
    if level == 0 or GetUnitLifePercent(h) < 40.0 then
        return
    endif
    if GetUnitState(h, UNIT_STATE_MANA) < level * 280.0 then
        return
    endif
    set n = 0
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) > 0.405 then
            if IsUnitEnemy(v, GetOwningPlayer(h)) and GetUnitState(v, UNIT_STATE_LIFE) < 100.0 + level * 150.0 then
                set n = n + 1
            endif
        endif
        set i = i + 1
    endloop
    if n >= 2 then
        call IssueImmediateOrder(h, "starfall")
    endif
    set v = null
endfunction

function AI_Ability_Mokou takes unit h returns nothing
    local unit v
    local integer n
    local boolexpr iff
    local group enemy
    if GetUnitAbilityLevel(h, 'A052') == 0 then
        return
    endif
    if GetUnitState(h, UNIT_STATE_MANA) < 150.0 then
        return
    endif
    if GetUnitLifePercent(h) < 50.0 then
        set enemy = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(h))]
        call GroupEnumUnitsInRange(enemy, GetUnitX(h), GetUnitY(h), 1000.0, iff)
        set n = 0
        loop
            set v = FirstOfGroup(enemy)
        exitwhen v == null
            call GroupRemoveUnit(enemy, v)
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set n = n + 2
            else
                set n = n + 1
            endif
        endloop
        call DestroyGroup(enemy)
        if n <= 1 then
            call IssueImmediateOrder(h, "burrow")
        endif
    endif
    set enemy = null
    set iff = null
    set v = null
endfunction

function AI_Ability_Kaguya takes unit h returns nothing
    local unit v
    local integer n
    local boolexpr f
    local group enemy
    if AI_IsLowHP(h) then
        return
    endif
    if GetUnitAbilityLevel(h, 'A0D0') == 0 then
        return
    endif
    if GetUnitManaPercent(h) > 30.0 then
        set enemy = CreateGroup()
        set f = Filter(function AI_Ability_Target_Enemy_Units)
        call GroupEnumUnitsInRange(enemy, GetUnitX(h), GetUnitY(h), 500.0, f)
        set n = 0
        loop
            set v = FirstOfGroup(enemy)
        exitwhen v == null
            call GroupRemoveUnit(enemy, v)
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set n = n + 3
            else
                set n = n + 1
            endif
        endloop
        call DestroyGroup(enemy)
        call DestroyBoolExpr(f)
        if n >= 3 then
            call IssueImmediateOrder(h, "fanofknives")
        endif
    endif
    set enemy = null
    set f = null
    set v = null
endfunction

function AI_Ability_Mystia takes unit h returns nothing
    local integer level = GetUnitAbilityLevel(h, 'A0DI')
    local integer i
    local unit v
    local unit target
    local integer n
    local integer m
    if level == 0 then
        return
    endif
    if GetUnitState(h, UNIT_STATE_MANA) < 40 then
        return
    endif
    set target = null
    set m = 0
    set n = 0
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) > 0.405 and DistanceBetweenUnits(h, v) <= 550.0 then
            if IsUnitAlly(v, GetOwningPlayer(h)) then
                if GetUnitLifePercent(h) < 20.0 then
                    set n = n + 1
                endif
                set m = m + 1
            endif
        endif
        set i = i + 1
    endloop
    if n >= 1 then
        call IssueImmediateOrder(h, "roar")
    elseif m >= 3 and GetRandomReal(0, 100.0) > 50.0 then
        call IssueImmediateOrder(h, "roar")
    endif
    set v = null
    set target = null
endfunction

function InitTrig_AI_Ability takes nothing returns nothing
endfunction