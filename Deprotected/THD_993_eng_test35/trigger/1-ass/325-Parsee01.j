function Trig_Parsee01_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A03Q'
endfunction

function Trig_Parsee01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local player w = GetOwningPlayer(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A03Q')
    local integer i = 0
    set udg_SK_Parsee01 = 0.0
    if GetWidgetLife(caster) > 0.405 then
        loop
        exitwhen i >= 12
            if udg_PlayerHeroes[i] != null and IsUnitEnemy(udg_PlayerHeroes[i], w) and GetWidgetLife(udg_PlayerHeroes[i]) > 0.405 and IsUnitInRange(caster, udg_PlayerHeroes[i], 900.0) then
                set udg_SK_Parsee01 = udg_SK_Parsee01 + 0.01 * level + 0.01
            endif
            set i = i + 1
        endloop
        call DebugMsg("Parsee01 " + R2S(udg_SK_Parsee01))
    endif
    set t = null
    set caster = null
    set w = null
endfunction

function Trig_Parsee01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, 'A03Q')
    if level == 1 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call TimerStart(t, 0.5, true, function Trig_Parsee01_Main)
    endif
    call SetUnitAnimation(caster, "spell")
    set caster = null
    set t = null
endfunction

function InitTrig_Parsee01 takes nothing returns nothing
endfunction