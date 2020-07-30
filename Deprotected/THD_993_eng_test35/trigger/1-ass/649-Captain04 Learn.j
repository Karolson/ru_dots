function Trig_Captain04_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A1AX'
endfunction

function Trig_Captain04_Learn_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1AX')
    local unit oldboat
    local real hppercentage
    local real ox
    local real oy
    if udg_SK_Caption04_Ship != null then
        set oldboat = udg_SK_Caption04_Ship
        set hppercentage = GetUnitState(udg_SK_Caption04_Ship, UNIT_STATE_LIFE) / GetUnitState(udg_SK_Caption04_Ship, UNIT_STATE_MAX_LIFE)
        set ox = GetUnitX(udg_SK_Caption04_Ship)
        set oy = GetUnitY(udg_SK_Caption04_Ship)
        set udg_SK_Caption04_Ship = null
        call KillUnit(oldboat)
        if level == 2 then
            set udg_SK_Caption04_Ship = CreateUnit(GetOwningPlayer(udg_SK_Caption04_Hero), 'n01U', ox, oy, 0)
        else
            set udg_SK_Caption04_Ship = CreateUnit(GetOwningPlayer(udg_SK_Caption04_Hero), 'n01V', ox, oy, 0)
        endif
        call SetUnitState(udg_SK_Caption04_Ship, UNIT_STATE_LIFE, hppercentage * GetUnitState(udg_SK_Caption04_Ship, UNIT_STATE_MAX_LIFE))
        call SetUnitXY(udg_SK_Caption04_Ship, ox, oy)
    endif
    set caster = null
    set oldboat = null
endfunction

function InitTrig_Captain04_Learn takes nothing returns nothing
endfunction