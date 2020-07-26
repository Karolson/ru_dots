function Trig_Koishi04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0DY'
endfunction

function Trig_Koishi04_View takes unit caster returns nothing
    local real a = GetUnitFacing(caster)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz = GetPositionZ(ox, oy)
    local real tx = ox + 128.0 * CosBJ(a)
    local real ty = oy + 128.0 * SinBJ(a)
    local real dz = oz - GetPositionZ(tx, ty)
    local real o
    set o = bj_RADTODEG * Atan2(-dz, 128.0)
    set o = RMaxBJ(-24.0, o)
    set o = RMinBJ(o, 24.0)
    set dz = dz + 128.0 * SinBJ(o)
    if GetOwningPlayer(caster) == GetLocalPlayer() then
        call PanCameraToTimed(tx, ty, 0.0)
        call SetCameraField(CAMERA_FIELD_ZOFFSET, 270.0, 0)
        call SetCameraField(CAMERA_FIELD_ROTATION, a, 0)
        call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, 348.0 + o, 0)
        call SetCameraField(CAMERA_FIELD_ROLL, 0.0, 0)
        call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 500.0, 0)
        call SetCameraField(CAMERA_FIELD_FARZ, 6000.0, 0)
        call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, 120.0, 0)
    else
        if IsUnitAlly(caster, GetLocalPlayer()) then
            call SelectUnit(caster, false)
        endif
    endif
endfunction

function Trig_Koishi04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local boolean camswitch = LoadBoolean(udg_ht, task, 0)
    local real k0
    local real m0
    local real k1
    local real m1
    if GetUnitTypeId(caster) == 'E011' and IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        if i == 0 and udg_SK_Koishi04_value == false then
            set k0 = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
            set m0 = GetUnitState(caster, UNIT_STATE_MAX_MANA)
            set k1 = GetUnitState(caster, UNIT_STATE_LIFE)
            set m1 = GetUnitState(caster, UNIT_STATE_MANA)
            set udg_SK_Koishi04_value = true
            call SetUnitPathing(caster, false)
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * (k1 / k0))
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MAX_MANA) * (m1 / m0))
            call IssuePointOrder(caster, "attack", ox + GetRandomReal(-100, 100), oy + GetRandomReal(-100, 100))
        endif
        set i = i + 1
        call SaveInteger(udg_ht, task, 1, i)
        if i / 300 * 300 == i then
            call IssuePointOrder(caster, "attack", ox + GetRandomReal(-100, 100), oy + GetRandomReal(-100, 100))
        endif
        call Trig_Koishi04_View(caster)
    else
        if udg_SK_Koishi04_value then
            set k0 = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
            set m0 = GetUnitState(caster, UNIT_STATE_MAX_MANA)
            set k1 = GetUnitState(caster, UNIT_STATE_LIFE)
            set m1 = GetUnitState(caster, UNIT_STATE_MANA)
            set udg_SK_Koishi04_value = false
        endif
        call SelectUnitForPlayerSingle(caster, GetOwningPlayer(caster))
        if GetOwningPlayer(caster) == GetLocalPlayer() then
            call EnableUserControl(true)
            call EnableOcclusion(true)
            if camswitch then
                call CameraAdd(caster)
            else
                call ResetToGameCamera(0.5)
            endif
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_SPELLS, 1.0)
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_COMBAT, 1.0)
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_FIRE, 1.0)
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_UI, 1.0)
        endif
        call DisplayTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, "|cffff66ccSubterranean Rose has ended|r")
        call decreaselife(caster, 500 + level * 500)
        call UnitReduceAttackDamage(caster, 40 + level * 40)
        call UnitAddBonusAspd(caster, -(40 + level * 40))
        call SetUnitPathing(caster, true)
        if GetUnitState(caster, UNIT_STATE_LIFE) > 0 then
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * (k1 / k0))
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MAX_MANA) * (m1 / m0))
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call DisableTrigger(gg_trg_Koishi04_DS)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Koishi04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0DY')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local timer t
    local integer task
    local boolean camswitch = IsUnitInGroup(caster, udg_CameraUnits)
    if GetUnitTypeId(caster) == 'E010' then
        call VE_Spellcast(caster)
        set t = CreateTimer()
        set task = GetHandleId(t)
        if camswitch then
            call CameraRemove(caster)
        endif
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveBoolean(udg_ht, task, 0, camswitch)
        call SaveInteger(udg_ht, task, 0, level)
        call SaveInteger(udg_ht, task, 1, 0)
        call addlife(caster, 500 + level * 500)
        call UnitInitAddAttack(caster)
        call UnitAddAttackDamage(caster, 40 + level * 40)
        call UnitAddBonusAspd(caster, 40 + level * 40)
        call TimerStart(t, 0.02, true, function Trig_Koishi04_Main)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", ox, oy))
        if GetOwningPlayer(caster) == GetLocalPlayer() then
            call EnableUserControl(false)
            call EnableOcclusion(false)
            call ClearTextMessages()
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_SPELLS, 0.0)
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_COMBAT, 0.0)
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_FIRE, 0.0)
            call VolumeGroupSetVolume(SOUND_VOLUMEGROUP_UI, 0.0)
        else
            call SelectUnit(caster, false)
        endif
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, 9.0, "|cffeeeeeeYou lose control...|r")
        call EnableTrigger(gg_trg_Koishi04_DS)
    endif
    set caster = null
    set t = null
endfunction

function InitTrig_Koishi04 takes nothing returns nothing
endfunction