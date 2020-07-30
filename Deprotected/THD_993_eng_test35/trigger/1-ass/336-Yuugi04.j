function Trig_Yuugi04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A08D'
endfunction

function Yuugi04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 2)
    local integer i = LoadInteger(udg_Hashtable, task, 3)
    local location loc1 = LoadLocationHandle(udg_Hashtable, task, 4)
    local real distance = LoadReal(udg_Hashtable, task, 5)
    local location loc2 = GetUnitLoc(target)
    local real inc = DistanceBetweenPoints(loc1, loc2)
    local effect e
    local texttag tt = LoadTextTagHandle(udg_Hashtable, task, 6)
    set i = i - 1
    call SaveInteger(udg_Hashtable, task, 3, i)
    call RemoveLocation(loc1)
    call SaveLocationHandle(udg_Hashtable, task, 4, loc2)
    if GetCustomState(target, 3) != 0 == false and GetUnitAbilityLevel(target, 'B05F') == 0 and GetUnitAbilityLevel(target, 'BPSE') == 0 and GetUnitAbilityLevel(target, 'A17W') == 0 then
        set distance = distance + inc
        call SaveReal(udg_Hashtable, task, 5, distance)
        call SetTextTagText(tt, R2SW(333.0 - distance, 3, 1), 0.0276)
        call SetTextTagPosUnit(tt, target, 100.0)
        if IsLocationVisibleToPlayer(loc2, GetLocalPlayer()) == false and IsUnitVisible(target, GetLocalPlayer()) == false then
            call SetTextTagVisibility(tt, false)
        else
            call SetTextTagVisibility(tt, true)
        endif
    endif
    if distance > 333 and IsUnitType(target, UNIT_TYPE_DEAD) == false and IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        call SetUnitFlag(target, 7, false)
        call SetUnitInvulnerable(target, false)
        call UnitRemoveBuffs(target, true, true)
        call InstantKill(caster, target)
        set e = AddSpecialEffectLoc("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", loc2)
        call DestroyEffect(e)
        set e = AddSpecialEffectLoc("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", loc2)
        call DestroyEffect(e)
        call DestroyTextTag(tt)
        call RemoveLocation(loc2)
        call ReleaseTimer(t)
        set tt = null
        set t = null
        set caster = null
        set target = null
        set loc1 = null
        set loc2 = null
        set e = null
        return
    endif
    if i < 0 or IsUnitType(target, UNIT_TYPE_DEAD) then
        if IsUnitType(caster, UNIT_TYPE_DEAD) == false and i < 0 then
            call UnitDelDamageTarget(caster, target, 0.2 * GetUnitState(target, UNIT_STATE_MAX_LIFE))
            set e = AddSpecialEffectLoc("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", loc2)
            call DestroyEffect(e)
            set e = AddSpecialEffectLoc("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", loc2)
            call DestroyEffect(e)
        endif
        call DestroyTextTag(tt)
        call SetUnitFlag(target, 7, false)
        call RemoveLocation(loc2)
        call ReleaseTimer(t)
        set tt = null
        set t = null
        set caster = null
        set target = null
        set loc1 = null
        set loc2 = null
        set e = null
        return
    endif
    set tt = null
    set t = null
    set caster = null
    set target = null
    set loc1 = null
    set loc2 = null
    set e = null
endfunction

function Trig_Yuugi04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local location loc = GetUnitLoc(target)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local player PLY = GetOwningPlayer(caster)
    local unit u
    local integer i = 50 + 25 * GetUnitAbilityLevel(caster, 'A08D')
    local integer level = GetUnitAbilityLevel(caster, 'A08D')
    local texttag tt
    call AbilityCoolDownResetion(caster, 'A08D', 70 - 10 * level)
    call VE_Spellcast(caster)
    call CE_Input(caster, target, 150)
    set u = CreateUnitAtLoc(PLY, 'n02A', loc, 0)
    call SetUnitPathing(u, false)
    call SetUnitFlag(target, 7, true)
    call SetUnitX(u, GetLocationX(loc))
    call SetUnitY(u, GetLocationY(loc))
    call AttachSoundToUnit(gg_snd_Yuugi, target)
    call SetSoundVolume(gg_snd_Yuugi, 127)
    call StartSound(gg_snd_Yuugi)
    set tt = CreateTextTag()
    call SetTextTagText(tt, R2SW(333.0, 3, 1), 0.0276)
    call SetTextTagColor(tt, 0, 255, 255, 255)
    call SetTextTagPosUnit(tt, target, 100.0)
    call SaveTimerHandle(udg_Hashtable, task, 0, t)
    call SaveUnitHandle(udg_Hashtable, task, 1, caster)
    call SaveUnitHandle(udg_Hashtable, task, 2, target)
    call SaveInteger(udg_Hashtable, task, 3, i)
    call SaveLocationHandle(udg_Hashtable, task, 4, loc)
    call SaveReal(udg_Hashtable, task, 5, 0)
    call SaveTextTagHandle(udg_Hashtable, task, 6, tt)
    call TimerStart(t, 0.04, true, function Yuugi04_Main)
    if GetUnitAbilityLevel(target, 'A17X') == 0 and GetUnitAbilityLevel(target, 'A0PF') == 0 and GetUnitAbilityLevel(target, 'A0AN') == 0 and GetUnitCurrentOrder(target) != OrderId("metamorphosis") then
        call IssueImmediateOrder(target, "stop")
    endif
    call CastSpell(caster, "Omae wa mou shindeiru!!!")
    set tt = null
    set t = null
    set caster = null
    set target = null
    set loc = null
    set PLY = null
    set u = null
endfunction

function InitTrig_Yuugi04 takes nothing returns nothing
endfunction