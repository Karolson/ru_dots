function SoundSys_Random takes integer low, integer high returns integer
    return low + ModuloInteger(udg_GameTime, high - low + 1)
endfunction

function s__soundresponse_onRelease takes nothing returns nothing
    local integer s = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    call PauseTimer(udg_s__soundresponse_t[s])
    set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[s]))] = true
endfunction

function s__soundresponse_play takes integer this, integer i returns nothing
    if 1 == i then
        set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
        call StartSound(udg_s__soundresponse_pissed1[this])
        call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
        call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_pissed1_duration[this], false, function s__soundresponse_onRelease)
    elseif 2 == i then
        set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
        call StartSound(udg_s__soundresponse_pissed2[this])
        call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
        call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_pissed2_duration[this], false, function s__soundresponse_onRelease)
    elseif 3 == i then
        set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
        call StartSound(udg_s__soundresponse_what1[this])
        call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
        call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_what1_duration[this], false, function s__soundresponse_onRelease)
    elseif 4 == i then
        set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
        call StartSound(udg_s__soundresponse_what2[this])
        call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
        call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_what2_duration[this], false, function s__soundresponse_onRelease)
    elseif 5 == i then
        set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
        call StartSound(udg_s__soundresponse_what3[this])
        call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
        call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_what3_duration[this], false, function s__soundresponse_onRelease)
    elseif 6 == i then
        set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
        call StartSound(udg_s__soundresponse_what4[this])
        call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
        call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_what4_duration[this], false, function s__soundresponse_onRelease)
    elseif 16 == i then
        set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
        call StartSound(udg_s__soundresponse_death[this])
        call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
        call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_death_duration[this], false, function s__soundresponse_onRelease)
    elseif udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] then
        if 0 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_reborn[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_reborn_duration[this], false, function s__soundresponse_onRelease)
        elseif 7 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yes1[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yes1_duration[this], false, function s__soundresponse_onRelease)
        elseif 8 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yes2[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yes2_duration[this], false, function s__soundresponse_onRelease)
        elseif 9 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yes3[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yes3_duration[this], false, function s__soundresponse_onRelease)
        elseif 10 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yes4[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yes4_duration[this], false, function s__soundresponse_onRelease)
        elseif 11 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yesattack1[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yesattack1_duration[this], false, function s__soundresponse_onRelease)
        elseif 12 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yesattack2[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yesattack2_duration[this], false, function s__soundresponse_onRelease)
        elseif 13 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yesattack3[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yesattack3_duration[this], false, function s__soundresponse_onRelease)
        elseif 14 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_yesattack4[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_yesattack4_duration[this], false, function s__soundresponse_onRelease)
        elseif 15 == i then
            set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[this]))] = false
            call StartSound(udg_s__soundresponse_warcry1[this])
            call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[this]), 0, this)
            call TimerStart(udg_s__soundresponse_t[this], udg_s__soundresponse_warcry1_duration[this], false, function s__soundresponse_onRelease)
        endif
    endif
endfunction

function s__soundresponse_onSelect takes nothing returns boolean
    local integer s = GetCharacterIndex(GetTriggerUnit())
    local integer ra = SoundSys_Random(1, 6)
    if udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[s]))] and GetTriggerPlayer() == GetOwningPlayer(GetTriggerUnit()) then
        call s__soundresponse_play(s, ra)
    endif
    return false
endfunction

function s__soundresponse_onOrder takes nothing returns boolean
    local integer s = GetCharacterIndex(GetTriggerUnit())
    local integer oid = GetIssuedOrderId()
    local integer ra = SoundSys_Random(11, 15)
    local integer rb = SoundSys_Random(7, 10)
    if udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(udg_s__soundresponse_u[s]))] and oid == 851971 or oid == 851983 or oid == 851984 or oid == 851986 then
        if oid == 851983 or oid == 851984 or (oid == 851971 and (GetOrderTargetUnit() != null and IsUnitEnemy(GetOrderTargetUnit(), GetOwningPlayer(udg_s__soundresponse_u[s])))) then
            call s__soundresponse_play(s, ra)
        else
            call s__soundresponse_play(s, rb)
        endif
    endif
    return false
endfunction

function s__soundresponse_create takes unit u returns integer
    local integer s = GetCharacterIndex(u)
    set udg_s__soundresponse_ordertrg[s] = CreateTrigger()
    call TriggerRegisterUnitEvent(udg_s__soundresponse_ordertrg[s], u, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(udg_s__soundresponse_ordertrg[s], u, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(udg_s__soundresponse_ordertrg[s], u, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(udg_s__soundresponse_ordertrg[s], Condition(function s__soundresponse_onOrder))
    set udg_s__soundresponse_selecttrg[s] = CreateTrigger()
    call TriggerRegisterUnitEvent(udg_s__soundresponse_selecttrg[s], u, EVENT_UNIT_SELECTED)
    call TriggerAddCondition(udg_s__soundresponse_selecttrg[s], Condition(function s__soundresponse_onSelect))
    set udg_s__soundresponse_t[s] = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(udg_s__soundresponse_t[s]), 0, s)
    set udg_s__soundresponse_u[s] = u
    set udg_s__soundresponse_canplay[s] = true
    set udg_AllPlayerSound[GetPlayerId(GetOwningPlayer(u))] = true
    return s
endfunction

function s__soundresponse_register takes integer this, integer id, string filename returns nothing
    local sound snd
    local integer duration
    if id > 16 or id < 0 then
        return
    endif
    set snd = CreateSound(filename, false, false, true, 12700, 12700, "DefaultEAXON")
    if snd != null then
        set duration = GetSoundFileDuration(filename)
        call SetSoundDuration(snd, duration)
        call SetSoundVolume(snd, 127)
        call SetSoundPitch(snd, 1.0)
        call SetSoundChannel(snd, 0)
        call AttachSoundToUnit(snd, udg_s__soundresponse_u[this])
        if GetLocalPlayer() != GetOwningPlayer(udg_s__soundresponse_u[this]) then
            call SetSoundVolume(snd, 0)
        endif
        if 0 == id then
            set udg_s__soundresponse_reborn[this] = snd
            set udg_s__soundresponse_reborn_duration[this] = duration * 0.0015
        elseif 1 == id then
            set udg_s__soundresponse_pissed1[this] = snd
            set udg_s__soundresponse_pissed1_duration[this] = duration * 0.001
        elseif 2 == id then
            set udg_s__soundresponse_pissed2[this] = snd
            set udg_s__soundresponse_pissed2_duration[this] = duration * 0.001
        elseif 3 == id then
            set udg_s__soundresponse_what1[this] = snd
            set udg_s__soundresponse_what1_duration[this] = duration * 0.001
        elseif 4 == id then
            set udg_s__soundresponse_what2[this] = snd
            set udg_s__soundresponse_what2_duration[this] = duration * 0.001
        elseif 5 == id then
            set udg_s__soundresponse_what3[this] = snd
            set udg_s__soundresponse_what3_duration[this] = duration * 0.001
        elseif 6 == id then
            set udg_s__soundresponse_what4[this] = snd
            set udg_s__soundresponse_what4_duration[this] = duration * 0.0015
        elseif 7 == id then
            set udg_s__soundresponse_yes1[this] = snd
            set udg_s__soundresponse_yes1_duration[this] = duration * 0.0015
        elseif 8 == id then
            set udg_s__soundresponse_yes2[this] = snd
            set udg_s__soundresponse_yes2_duration[this] = duration * 0.0015
        elseif 9 == id then
            set udg_s__soundresponse_yes3[this] = snd
            set udg_s__soundresponse_yes3_duration[this] = duration * 0.0015
        elseif 10 == id then
            set udg_s__soundresponse_yes4[this] = snd
            set udg_s__soundresponse_yes4_duration[this] = duration * 0.0015
        elseif 11 == id then
            set udg_s__soundresponse_yesattack1[this] = snd
            set udg_s__soundresponse_yesattack1_duration[this] = duration * 0.0015
        elseif 12 == id then
            set udg_s__soundresponse_yesattack2[this] = snd
            set udg_s__soundresponse_yesattack2_duration[this] = duration * 0.0015
        elseif 13 == id then
            set udg_s__soundresponse_yesattack3[this] = snd
            set udg_s__soundresponse_yesattack3_duration[this] = duration * 0.0015
        elseif 14 == id then
            set udg_s__soundresponse_yesattack4[this] = snd
            set udg_s__soundresponse_yesattack4_duration[this] = duration * 0.0015
        elseif 15 == id then
            set udg_s__soundresponse_warcry1[this] = snd
            set udg_s__soundresponse_warcry1_duration[this] = duration * 0.0015
        elseif 16 == id then
            set udg_s__soundresponse_death[this] = snd
            set udg_s__soundresponse_death_duration[this] = duration * 0.0015
        endif
    endif
    set snd = null
endfunction

function Trig_Sound_System_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer skill = GetSpellAbilityId()
    local integer p = GetPlayerId(GetOwningPlayer(caster))
    local sound snd = null
    local string str = "THDots\\music\\"+GetCharacterSkillString(skill)+"0.0mp3"
    set snd = CreateSound(str, false, false, true, 12700, 12700, "DefaultEAXON")
    if snd != null then
        call SetSoundVolume(snd, 127)
        call StartSoundForPlayerBJ(GetOwningPlayer(caster), snd)
        call KillSoundWhenDone(snd)
        set snd = null
    endif
endfunction

function InitTrig_Sound_System takes nothing returns nothing
    set gg_trg_Sound_System = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sound_System, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(gg_trg_Sound_System, function Trig_Sound_System_Actions)
endfunction