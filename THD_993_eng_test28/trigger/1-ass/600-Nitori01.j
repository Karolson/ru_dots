function Trig_Nitori01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A094' and GetUnitTypeId(GetTriggerUnit()) == 'H00M'
endfunction

function Trig_Nitori01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local real facing = GetUnitFacing(caster) * bj_DEGTORAD
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real speed = 320 / 50
    if GetUnitAbilityLevel(caster, 'B051') > 0 then
        if IsUnitLimited(caster) == false then
            if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
                call SetUnitXY(caster, ox, oy)
            else
                call SetUnitXY(caster, ox + speed * Cos(facing), oy + speed * Sin(facing))
            endif
        endif
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0GF', true)
        call UnitRemoveAbility(caster, 'A0LL')
    endif
    set t = null
    set caster = null
endfunction

function Trig_Nitori01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    call SaveTimerHandle(udg_Hashtable, task, 0, t)
    call SaveUnitHandle(udg_Hashtable, task, 1, caster)
    call TimerStart(t, 0.02, true, function Trig_Nitori01_Main)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0GF', false)
    call UnitAddAbility(caster, 'A0LL')
    call UnitMakeAbilityPermanent(caster, true, 'A0LL')
    call PlayUnitAnimeNoLoop(caster, "Stand Alternate")
    set t = null
    set caster = null
endfunction

function InitTrig_Nitori01 takes nothing returns nothing
endfunction