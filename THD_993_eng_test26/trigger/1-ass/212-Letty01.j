function Trig_Letty01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A08W'
endfunction

function Trig_Letty01_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real damage = LoadReal(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 2)
    local real y = LoadReal(udg_ht, task, 3)
    local integer count = LoadInteger(udg_ht, task, 4)
    local integer range = LoadInteger(udg_ht, task, 5)
    local integer level = LoadInteger(udg_ht, task, 6)
    call SaveInteger(udg_ht, task, 4, count + 1)
    if count / 4 * 4 == count then
        call UnitMagicDamageArea(caster, x, y, range, damage, 6)
    endif
    if count == 40 then
        call UnRegisterAreaShow(caster, 'A08W')
    endif
    if GetUnitCurrentOrder(caster) != OrderId("blizzard") or count > 44 then
        if count < 40 then
            call UnRegisterAreaShow(caster, 'A08W')
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Letty01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A08W')
    local real ox = GetSpellTargetX()
    local real oy = GetSpellTargetY()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 10)
    call RegisterAreaShowXY(caster, 'A08W', ox, oy, 250 + 50 * level, 12, 1, "Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl", 1)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, ABCIAllInt(caster, 25 + 15 * level, 0.6))
    call SaveReal(udg_ht, task, 2, ox)
    call SaveReal(udg_ht, task, 3, oy)
    call SaveInteger(udg_ht, task, 4, 1)
    call SaveInteger(udg_ht, task, 5, 250 + 50 * level)
    call SaveInteger(udg_ht, task, 6, level)
    call TimerStart(t, 0.25, true, function Trig_Letty01_Damage)
    set caster = null
    set t = null
endfunction

function InitTrig_Letty01 takes nothing returns nothing
endfunction