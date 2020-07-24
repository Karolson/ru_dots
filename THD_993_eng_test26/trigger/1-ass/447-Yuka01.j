function Trig_Yuka01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A068'
endfunction

function Trig_Yuka01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A068')
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx
    local real ty
    local integer i = 0
    local integer k
    local real r
    local real a
    call AbilityCoolDownResetion(caster, 'A068', 16 - level)
    if level == 1 then
        set k = 8
        set r = 125
        set a = 45 * 0.017454
    elseif level == 2 then
        set k = 10
        set r = 150
        set a = 36.0 * 0.017454
    elseif level == 3 then
        set k = 12
        set r = 175
        set a = 30.0 * 0.017454
    elseif level == 4 then
        set k = 14
        set r = 200
        set a = 25.71 * 0.017454
    endif
    loop
    exitwhen i == k
        set tx = ox + r * Cos(i * a)
        set ty = oy + r * Sin(i * a)
        call Yuka_Create_Temp_Flower(caster, tx, ty, 1.2 + 0.8 * level + GetRandomReal(0, 100) * 0.01 - 0.5, R2I(GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.2), R2I(0.3 * GetUnitAttack(caster)))
        set i = i + 1
    endloop
    if udg_SK_Yuka_Unit != null then
        call SetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MANA, GetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MANA) - (80 + level * 10))
        call IssueImmediateOrderById(udg_SK_Yuka_Unit, 851972)
        set ox = GetUnitX(udg_SK_Yuka_Unit)
        set oy = GetUnitY(udg_SK_Yuka_Unit)
        set i = 0
        loop
        exitwhen i == k
            set tx = ox + r * Cos(i * a)
            set ty = oy + r * Sin(i * a)
            call Yuka_Create_Temp_Flower(udg_SK_Yuka_Unit, tx, ty, 1.2 + 0.8 * level + GetRandomReal(0, 100) * 0.01 - 0.5, R2I(GetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MAX_LIFE) * 0.2), R2I(0.3 * GetUnitAttack(udg_SK_Yuka_Unit)))
            set i = i + 1
        endloop
    endif
    set caster = null
    set u = null
endfunction

function InitTrig_Yuka01 takes nothing returns nothing
endfunction