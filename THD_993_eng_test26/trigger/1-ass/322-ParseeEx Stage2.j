function Trig_ParseeEx_Stage2_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit illusion = LoadUnitHandle(udg_ht, task, 0)
    local real ox = GetUnitX(udg_SK_Parsee)
    local real oy = GetUnitY(udg_SK_Parsee)
    local real tx = GetUnitX(illusion)
    local real ty = GetUnitY(illusion)
    call SetUnitInvulnerable(udg_SK_Parsee, false)
    call PauseUnit(udg_SK_Parsee, false)
    call ShowUnit(udg_SK_Parsee, true)
    call SetUnitInvulnerable(illusion, false)
    call PauseUnit(illusion, false)
    call ShowUnit(illusion, true)
    call SetUnitXY(udg_SK_Parsee, ox + GetRandomReal(0.0, 300.0) - 150.0, oy + GetRandomReal(0.0, 300.0) - 150.0)
    call SetUnitXY(illusion, tx + GetRandomReal(0.0, 300.0) - 150.0, ty + GetRandomReal(0.0, 300.0) - 150.0)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\AIvi\\AIviTarget.mdl", ox, oy))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\AIvi\\AIviTarget.mdl", tx, ty))
    if GetLocalPlayer() == GetOwningPlayer(udg_SK_Parsee) then
        call ClearSelection()
        call SelectUnit(udg_SK_Parsee, true)
        call SelectUnit(illusion, true)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set illusion = null
endfunction

function Trig_ParseeEx_Conditions_Stage2 takes nothing returns boolean
    if GetUnitTypeId(GetSummonedUnit()) != 'E01U' then
        return false
    endif
    if IsUnitIllusion(GetSummonedUnit()) != true then
        return false
    endif
    if GetUnitTypeId(GetSummoningUnit()) != 'n01X' then
        return false
    endif
    return true
endfunction

function Trig_ParseeEx_Stage2_Actions takes nothing returns nothing
    local unit illusion = GetSummonedUnit()
    local timer t
    local integer task
    call UnitAddAbility(illusion, 'A0W6')
    call SetUnitInvulnerable(udg_SK_Parsee, true)
    call PauseUnit(udg_SK_Parsee, true)
    call ShowUnit(udg_SK_Parsee, false)
    call SetUnitInvulnerable(illusion, true)
    call PauseUnit(illusion, true)
    call ShowUnit(illusion, false)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, illusion)
    call TimerStart(t, 0.2, false, function Trig_ParseeEx_Stage2_Clear)
    set t = null
endfunction

function InitTrig_ParseeEx_Stage2 takes nothing returns nothing
endfunction