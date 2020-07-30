function ID_IA_TP takes nothing returns integer
    return 'A07Y'
endfunction

function ID_IA_BoT takes nothing returns integer
    return 'A08I'
endfunction

function Teleport_End takes nothing returns boolean
    local trigger t
    local integer key
    local unit caster
    local unit target
    local real x
    local real y
    if GetTriggerEventId() == EVENT_UNIT_DEATH then
        call DebugMsg("Teleport Target Death")
        call IssueStopOrderEx(LoadUnitHandle(udg_Hashtable, GetHandleId(GetTriggeringTrigger()), StringHash("caster")))
    elseif GetSpellAbilityId() == 'A07Y' or GetSpellAbilityId() == 'A08I' then
        set t = GetTriggeringTrigger()
        set key = GetHandleId(t)
        set caster = GetTriggerUnit()
        if GetTriggerEventId() == EVENT_UNIT_SPELL_ENDCAST then
            call SetUnitFlag(caster, 5, false)
            call DestroyEffect(LoadEffectHandle(udg_Hashtable, key, StringHash("casterEffect")))
            call DestroyUbersplat(LoadUbersplatHandle(udg_Hashtable, key, StringHash("casterUbersplat")))
            call DestroyEffect(LoadEffectHandle(udg_Hashtable, key, StringHash("targetEffect1")))
            call DestroyEffect(LoadEffectHandle(udg_Hashtable, key, StringHash("targetEffect2")))
            call FlushChildHashtable(udg_Hashtable, key)
            call FlushTrigger(t)
        elseif GetTriggerEventId() == EVENT_UNIT_SPELL_FINISH then
            if CanUnitBlink(caster) then
                call DestroyEffect(AddSpecialEffectTargetLoc("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", caster))
                if LoadBoolean(udg_Hashtable, key, StringHash("toStructure")) then
                    set x = LoadReal(udg_Hashtable, key, StringHash("x"))
                    set y = LoadReal(udg_Hashtable, key, StringHash("y"))
                else
                    set target = LoadUnitHandle(udg_Hashtable, key, StringHash("target"))
                    if target == null then
                        call BJDebugMsg("secondary bug! Teleport_End : null target. Removed?")
                        set x = GetUnitX(caster)
                        set y = GetUnitY(caster)
                    else
                        set x = GetUnitX(target)
                        set y = GetUnitY(target)
                    endif
                endif
                if GetUnitTypeId(caster) == 'U00M' then
                    call SetUnitPosition(caster, x, y)
                else
                    call SetUnitX(caster, x)
                    call SetUnitY(caster, y)
                endif
                call DestroyEffect(AddSpecialEffectTargetLoc("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", caster))
            endif
        else
            call BJDebugMsg("bug! Trig_Teleport_1")
        endif
    endif
    set t = null
    set caster = null
    set target = null
    return false
endfunction

function CanUnitTeleport takes unit u returns boolean
    local integer id = GetUnitTypeId(u)
    if id == 'H024' or id == 'H025' then
        return false
    elseif id == 'H00S' then
        return false
    elseif id == 'E01T' or id == 'E02C' then
        return false
    elseif id == 'E00J' then
        return false
    elseif GetUnitAbilityLevel(u, 'A0BC') >= 1 then
        return false
    endif
    return CanUnitBlink(u)
endfunction

function Teleport_SearchTarget_TP takes unit caster, real tx, real ty returns unit
    local unit u
    local group g = CreateGroup()
    local unit target = null
    local real dis = 40000
    call GroupEnumUnitsInRange(g, tx * 1.0, ty * 1.0, 40000.0 * 1.0, Condition(function Return_True))
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitType(u, UNIT_TYPE_STRUCTURE) and IsUnitAlly(u, GetOwningPlayer(caster)) and DistanceBetween(u, tx, ty) < dis and IsUnitDead_Test(u) == false and GetOwningPlayer(u) != Player(15) then
            set dis = DistanceBetween(u, tx, ty)
            set target = u
        endif
    endloop
    call DestroyGroup(g)
    set u = null
    set g = null
    set caster = target
    set target = null
    return caster
endfunction

function Teleport_SearchTarget_BoT takes unit caster, real tx, real ty returns unit
    local unit u
    local group g = CreateGroup()
    local unit target = null
    local real dis = 40000
    call GroupEnumUnitsInRange(g, tx * 1.0, ty * 1.0, 40000.0 * 1.0, Condition(function Return_True))
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitAlly(u, GetOwningPlayer(caster)) and DistanceBetween(u, tx, ty) < dis and IsUnitType(u, UNIT_TYPE_HERO) == false and IsUnitDead_Test(u) == false and GetUnitAbilityLevel(u, 'A0IL') > 0 == false and GetOwningPlayer(u) != Player(15) then
            set dis = DistanceBetween(u, tx, ty)
            set target = u
        endif
    endloop
    call DestroyGroup(g)
    set u = null
    set g = null
    set caster = target
    set target = null
    return caster
endfunction

function CreateTeleportUbersplat takes unit u, ubersplat forReturn returns ubersplat
    set forReturn = CreateUbersplat(GetUnitX(u), GetUnitY(u), "SCTP", 255, 255, 255, 255, false, false)
    call SetUbersplatRenderAlways(forReturn, IsVisibleToPlayer(GetUnitX(u), GetUnitY(u), GetLocalPlayer()))
    return forReturn
endfunction

function Teleport_Effect takes unit caster, real tx, real ty, boolean isTP, boolean isBoT returns boolean
    local unit target
    local boolean toFountain = false
    local boolean toStructure
    local real x = 0
    local real y = 0
    local real angle
    local string baseEff
    local string locEff
    local trigger t
    local integer key
    if CanUnitTeleport(caster) == false then
        call LocalErrorMessage(caster, "You can't teleport in your current state!")
        return false
    endif
    if isTP then
        set target = Teleport_SearchTarget_TP(caster, tx, ty)
    elseif isBoT then
        set target = Teleport_SearchTarget_BoT(caster, tx, ty)
    endif
    if target == null then
        call LocalErrorMessage(caster, "No delivery target found!")
        return false
    else
        set toStructure = IsUnitType(target, UNIT_TYPE_STRUCTURE)
        if toStructure then
            if target == gg_unit_n023_0006 or target == gg_unit_n03O_0079 then
                set toFountain = true
            endif
            if GetUnitTypeId(target) == 'h01Q' and IsUnitAlly(target, GetOwningPlayer(caster)) then
                set target = GetUnitBase(caster)
                set toFountain = true
            endif
            if toFountain then
                set x = GetUnitX(target)
                set y = GetUnitY(target)
            elseif DistanceBetweenUnits(caster, target) > 400 then
                set angle = AngleBetweenUnitXY(target, tx, ty)
                set x = GetUnitX(target) + 400.0 * Cos(angle)
                set y = GetUnitY(target) + 400.0 * Sin(angle)
            else
                set x = GetUnitX(target)
                set y = GetUnitY(target)
            endif
        else
            set x = GetUnitX(target)
            set y = GetUnitY(target)
        endif
        if IsUnitAlly(caster, GetLocalPlayer()) then
            call PlayerPingMinimap_WW(GetOwningPlayer(caster), x, y, 3, false)
        endif
    endif
    set t = CreateTrigger()
    set key = GetHandleId(t)
    call SaveUnitHandle(udg_Hashtable, key, StringHash("caster"), caster)
    call SaveUnitHandle(udg_Hashtable, key, StringHash("target"), target)
    call SaveBoolean(udg_Hashtable, key, StringHash("toStructure"), toStructure)
    call SaveReal(udg_Hashtable, key, StringHash("x"), x)
    call SaveReal(udg_Hashtable, key, StringHash("y"), y)
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl", caster, "origin"))
    call SaveEffectHandle(udg_Hashtable, key, StringHash("casterEffect"), AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", GetUnitX(caster), GetUnitY(caster)))
    call SaveUbersplatHandle(udg_Hashtable, key, StringHash("casterUbersplat"), CreateTeleportUbersplat(caster, null))
    if toStructure then
        if IsUnitAlly(caster, GetLocalPlayer()) then
            set baseEff = ""
            set locEff = "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl"
        else
            set baseEff = "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl"
            set locEff = ""
        endif
        call SaveEffectHandle(udg_Hashtable, key, StringHash("targetEffect1"), AddSpecialEffect(baseEff, GetUnitX(target), GetUnitY(target)))
        call SaveEffectHandle(udg_Hashtable, key, StringHash("targetEffect2"), AddSpecialEffect(locEff, x, y))
    else
        call SaveEffectHandle(udg_Hashtable, key, StringHash("targetEffect1"), AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", target, "origin"))
    endif
    call TriggerRegisterUnitEvent(t, target, EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(t, caster, EVENT_UNIT_SPELL_ENDCAST)
    call TriggerRegisterUnitEvent(t, caster, EVENT_UNIT_SPELL_FINISH)
    call SetUnitFlag(caster, 5, true)
    call TriggerAddCondition(t, Condition(function Teleport_End))
    set t = null
    set target = null
    return true
endfunction

function Trig_Teleport_Conditions takes nothing returns boolean
    local boolean isTP = GetSpellAbilityId() == 'A07Y'
    local boolean isBoT = GetSpellAbilityId() == 'A08I'
    if isTP or isBoT and Teleport_Effect(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY(), isTP, isBoT) == false then
        call IssueStopOrderEx(GetTriggerUnit())
        call DestroyEffect(AddSpecialEffectTargetLoc("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", GetTriggerUnit()))
    endif
    return false
endfunction

function InitTrig_Teleport_Main takes nothing returns nothing
    set gg_trg_Teleport = CreateTrigger()
    call TriggerRegisterAnyUnitEventFix(gg_trg_Teleport, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Teleport, Condition(function Trig_Teleport_Conditions))
endfunction