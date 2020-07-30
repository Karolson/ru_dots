function UnitStunTarget takes unit caster, unit target, real time, integer a, integer b returns nothing
    local real outcometime = time
    local integer outcomelevel
    local unit w
    if GetUnitAbilityLevel(target, 'A17X') > 0 or GetUnitAbilityLevel(target, 'A0PF') > 0 or GetUnitAbilityLevel(target, 'A0AN') > 0 or GetUnitCurrentOrder(target) == OrderId("metamorphosis") then
        return
    endif
    if udg_NewDebuffSys then
        call UnitDebuffTarget(caster, target, time * 1.0, 4, true, 'A0QV', 1, 'B07U', "firebolt", 0, "")
        set w = null
        return
    endif
    set outcometime = outcometime * GetUnitControlAllReduce(caster, target)
    if outcometime > 5.0 then
        set outcometime = 5.0
    endif
    if outcometime > 0 then
        call CCSystem_textshow("Stun", target, outcometime)
        set outcomelevel = R2I(outcometime * 20)
        set w = NewDummy(GetOwningPlayer(target), GetUnitX(target), GetUnitY(target), 0)
        if GetUnitTypeId(target) == 'U006' and udg_YuyukoBool[GetPlayerId(GetOwningPlayer(target))] then
            call SetUnitTimeScale(target, 0.01)
            set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(target))] = 0
            set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(target))] = udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(target))] + outcometime
        endif
        call UnitAddAbility(w, 'A0UM')
        call SetUnitAbilityLevel(w, 'A0UM', outcomelevel)
        call IssueTargetOrder(w, "thunderbolt", target)
        call DebugMsg("Skill Level Set To " + I2S(outcomelevel) + " for stun time of " + R2S(outcometime))
        call UnitRemoveAbility(w, 'A0UM')
        call ReleaseDummy(w)
    endif
    set w = null
endfunction

function UnitStunArea takes unit caster, real time, real x, real y, real range, integer a, integer b returns nothing
    local unit v
    local timer t
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, range, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitStunTarget(caster, v, time, a, b)
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set t = null
endfunction

function InitTrig_StunningSystem takes nothing returns nothing
endfunction