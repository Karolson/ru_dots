function Trig_SpawnAttackSpeedIncrease_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit mida = LoadUnitHandle(udg_ht, task, 0)
    local unit midb = LoadUnitHandle(udg_ht, task, 1)
    local unit hero
    local integer i
    local integer level
    set level = 0
    set i = 5
    loop
        set hero = GetPlayerCharacter(GetSortedPlayer(i))
        if hero != null and IsUnitType(hero, UNIT_TYPE_DEAD) then
            if GetHeroLevel(hero) <= 4 then
                set level = level + 1
            elseif GetHeroLevel(hero) <= 8 then
                set level = level + 2
            elseif GetHeroLevel(hero) <= 12 then
                set level = level + 3
            elseif GetHeroLevel(hero) <= 16 then
                set level = level + 4
            elseif GetHeroLevel(hero) <= 20 then
                set level = level + 5
            endif
        endif
        set i = i + 1
    exitwhen i == 10
    endloop
    call SetUnitAbilityLevel(mida, 'A0ZG', level)
    call SetUnitAbilityLevel(mida, 'A0ZH', level)
    call SetUnitAbilityLevel(mida, 'A0ZI', level)
    set level = 0
    set i = 0
    loop
        set hero = GetPlayerCharacter(GetSortedPlayer(i))
        if hero != null and IsUnitType(hero, UNIT_TYPE_DEAD) then
            if GetHeroLevel(hero) <= 4 then
                set level = level + 1
            elseif GetHeroLevel(hero) <= 8 then
                set level = level + 2
            elseif GetHeroLevel(hero) <= 12 then
                set level = level + 3
            elseif GetHeroLevel(hero) <= 16 then
                set level = level + 4
            elseif GetHeroLevel(hero) <= 20 then
                set level = level + 5
            endif
        endif
        set i = i + 1
    exitwhen i == 5
    endloop
    call SetUnitAbilityLevel(midb, 'A0ZG', level)
    call SetUnitAbilityLevel(midb, 'A0ZH', level)
    call SetUnitAbilityLevel(midb, 'A0ZI', level)
    set t = null
    set mida = null
    set midb = null
    set hero = null
endfunction

function Trig_SpawnAbility_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit u1
    local unit u2
    local real ox
    local real oy
    set ox = GetUnitX(udg_BaseA[0])
    set oy = GetUnitY(udg_BaseA[0])
    set u1 = CreateUnit(GetOwningPlayer(udg_BaseA[0]), 'n00X', ox, oy, 0)
    call UnitAddAbility(u1, 'A0ZG')
    call UnitAddAbility(u1, 'A0ZH')
    call UnitAddAbility(u1, 'A0ZI')
    set ox = GetUnitX(udg_BaseB[0])
    set oy = GetUnitY(udg_BaseB[0])
    set u2 = CreateUnit(GetOwningPlayer(udg_BaseB[0]), 'n00X', ox, oy, 0)
    call UnitAddAbility(u2, 'A0ZG')
    call UnitAddAbility(u2, 'A0ZH')
    call UnitAddAbility(u2, 'A0ZI')
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, u1)
    call SaveUnitHandle(udg_ht, task, 1, u2)
    call TimerStart(t, 1.0, true, function Trig_SpawnAttackSpeedIncrease_Main)
    set t = null
    set u1 = null
    set u2 = null
endfunction

function InitTrig_SpawnAbility takes nothing returns nothing
    set gg_trg_SpawnAbility = CreateTrigger()
    call TriggerAddAction(gg_trg_SpawnAbility, function Trig_SpawnAbility_Actions)
endfunction