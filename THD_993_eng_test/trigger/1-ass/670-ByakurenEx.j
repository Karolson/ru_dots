function Trig_ByakurenEx_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = GetUnitAbilityLevel(caster, 'A0O1')
    local integer extrlife = R2I(GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.7)
    local integer origlife = LoadInteger(udg_ht, task, 1)
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        return
    endif
    if IsUnitType(caster, UNIT_TYPE_DEAD) == false and extrlife != origlife then
        call UnitAddMaxLife(caster, extrlife - origlife)
        call SaveInteger(udg_ht, task, 1, extrlife)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_ByakurenEx takes nothing returns nothing
endfunction