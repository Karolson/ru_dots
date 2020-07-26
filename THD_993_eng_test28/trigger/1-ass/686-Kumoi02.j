function Kumoi02 takes nothing returns integer
    return 'A10D'
endfunction

function Kumoi02_mj takes nothing returns integer
    return 'o00Z'
endfunction

function Trig_Kumoi02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A10D'
endfunction

function Trig_Kumoi02_Main takes player a, unit target, real x, real y returns nothing
    local unit u = CreateUnit(a, 'o00Z', x, y, 0.0)
    call IssueTargetOrder(u, "forkedlightning", target)
    call UnitApplyTimedLife(u, 'BHwe', 5)
    set u = null
endfunction

function Trig_Kumoi02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A10D')
    local real x1 = GetUnitX(caster)
    local real y1 = GetUnitY(caster)
    local real x2 = GetUnitX(target)
    local real y2 = GetUnitY(target)
    local real x
    local real y
    local real s = SquareRoot((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
    call AbilityCoolDownResetion(caster, 'A10D', 17 - 2 * level)
    if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
        call Item_BLTalismanicRunningCD(target)
        set caster = null
        set target = null
        return
    endif
    set x = 100.0 / s * (x1 - x2) + x1
    set y = y1 - 100.0 / s * (y1 - y2)
    set x = x1 - 100.0 / s * (x1 - x2)
    set y = y1 + 100.0 / s * (y1 - y2)
    call Trig_Kumoi02_Main(GetOwningPlayer(caster), target, x, y)
    call CE_Input(caster, target, 500)
    call UnitStunTarget(caster, target, 0.5 + level * 0.5, 0, 0)
    set caster = null
    set target = null
endfunction

function InitTrig_Kumoi02 takes nothing returns nothing
endfunction