function Trig_KogasaEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real life = GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02
    local real mana = GetUnitState(caster, UNIT_STATE_MANA) + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.02
    local boolean isVisible = false
    local group g
    local unit v
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        return
    endif
    if IsUnitEnemy(caster, udg_PlayerA[0]) and IsUnitVisible(caster, udg_PlayerA[0]) then
        set isVisible = true
    elseif IsUnitEnemy(caster, udg_PlayerB[0]) and IsUnitVisible(caster, udg_PlayerB[0]) then
        set isVisible = true
    else
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 500.0, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetOwningPlayer(v) == Player(PLAYER_NEUTRAL_AGGRESSIVE) then
                set isVisible = true
                exitwhen true
            endif
        endloop
        call DestroyGroup(g)
    endif
    if not isVisible then
        call UnitHealingTarget(caster, caster, life)
        call SetUnitState(caster, UNIT_STATE_MANA, mana)
    endif
    set t = null
    set caster = null
    set g = null
endfunction

function InitTrig_KogasaEx takes nothing returns nothing
endfunction