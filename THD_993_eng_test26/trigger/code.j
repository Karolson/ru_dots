function s__coin__allocate takes nothing returns integer
    local integer this=udg_si__coin_F
    if this!=0 then
        set udg_si__coin_F=udg_si__coin_V[this]
    else
        set udg_si__coin_I=udg_si__coin_I+1
        set this=udg_si__coin_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__coin_V[this]=-1
    return this
endfunction

function s__coin_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__coin_V[this]!=-1 then
        return
    endif
    set udg_si__coin_V[this]=udg_si__coin_F
    set udg_si__coin_F=this
endfunction

function s__grayalpaca__allocate takes nothing returns integer
    local integer this=udg_si__grayalpaca_F
    if this!=0 then
        set udg_si__grayalpaca_F=udg_si__grayalpaca_V[this]
    else
        set udg_si__grayalpaca_I=udg_si__grayalpaca_I+1
        set this=udg_si__grayalpaca_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__grayalpaca_V[this]=-1
    return this
endfunction

function s__grayalpaca_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__grayalpaca_V[this]!=-1 then
        return
    endif
    set udg_si__grayalpaca_V[this]=udg_si__grayalpaca_F
    set udg_si__grayalpaca_F=this
endfunction

function sc__Kagerou_w_wSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__Kagerou_w_wSkill_Action)
endfunction

function sc__Kagerou_w_wSkill_AOE_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__Kagerou_w_wSkill_AOE_Action)
endfunction

function sc__Kagerou_w_wSkill_AOE_Main takes nothing returns nothing
    call TriggerEvaluate(udg_st__Kagerou_w_wSkill_AOE_Main)
endfunction

function s__Kagerou_w__allocate takes nothing returns integer
    local integer this=udg_si__Kagerou_w_F
    if this!=0 then
        set udg_si__Kagerou_w_F=udg_si__Kagerou_w_V[this]
    else
        set udg_si__Kagerou_w_I=udg_si__Kagerou_w_I+1
        set this=udg_si__Kagerou_w_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Kagerou_w_V[this]=-1
    return this
endfunction

function s__Kagerou_w_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Kagerou_w_V[this]!=-1 then
        return
    endif
    set udg_si__Kagerou_w_V[this]=udg_si__Kagerou_w_F
    set udg_si__Kagerou_w_F=this
endfunction

function sc__Kagerou_f_fSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__Kagerou_f_fSkill_Action)
endfunction

function s__Kagerou_f__allocate takes nothing returns integer
    local integer this=udg_si__Kagerou_f_F
    if this!=0 then
        set udg_si__Kagerou_f_F=udg_si__Kagerou_f_V[this]
    else
        set udg_si__Kagerou_f_I=udg_si__Kagerou_f_I+1
        set this=udg_si__Kagerou_f_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Kagerou_f_V[this]=-1
    return this
endfunction

function s__Kagerou_f_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Kagerou_f_V[this]!=-1 then
        return
    endif
    set udg_si__Kagerou_f_V[this]=udg_si__Kagerou_f_F
    set udg_si__Kagerou_f_F=this
endfunction

function sc__Kagerou_d_dSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__Kagerou_d_dSkill_Action)
endfunction

function s__Kagerou_d__allocate takes nothing returns integer
    local integer this=udg_si__Kagerou_d_F
    if this!=0 then
        set udg_si__Kagerou_d_F=udg_si__Kagerou_d_V[this]
    else
        set udg_si__Kagerou_d_I=udg_si__Kagerou_d_I+1
        set this=udg_si__Kagerou_d_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Kagerou_d_V[this]=-1
    return this
endfunction

function s__Kagerou_d_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Kagerou_d_V[this]!=-1 then
        return
    endif
    set udg_si__Kagerou_d_V[this]=udg_si__Kagerou_d_F
    set udg_si__Kagerou_d_F=this
endfunction

function sc__Kulumi02_projectile_Kulumi02Sleep takes nothing returns nothing
    call TriggerEvaluate(udg_st__Kulumi02_projectile_Kulumi02Sleep)
endfunction

function s__Kulumi02_projectile__allocate takes nothing returns integer
    local integer this=udg_si__Kulumi02_projectile_F
    if this!=0 then
        set udg_si__Kulumi02_projectile_F=udg_si__Kulumi02_projectile_V[this]
    else
        set udg_si__Kulumi02_projectile_I=udg_si__Kulumi02_projectile_I+1
        set this=udg_si__Kulumi02_projectile_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Kulumi02_projectile_V[this]=-1
    return this
endfunction

function s__Kulumi02_projectile_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Kulumi02_projectile_V[this]!=-1 then
        return
    endif
    set udg_si__Kulumi02_projectile_V[this]=udg_si__Kulumi02_projectile_F
    set udg_si__Kulumi02_projectile_F=this
endfunction

function s__mugetsu03_projectile__allocate takes nothing returns integer
    local integer this=udg_si__mugetsu03_projectile_F
    if this!=0 then
        set udg_si__mugetsu03_projectile_F=udg_si__mugetsu03_projectile_V[this]
    else
        set udg_si__mugetsu03_projectile_I=udg_si__mugetsu03_projectile_I+1
        set this=udg_si__mugetsu03_projectile_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__mugetsu03_projectile_V[this]=-1
    return this
endfunction

function s__mugetsu03_projectile_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__mugetsu03_projectile_V[this]!=-1 then
        return
    endif
    set udg_si__mugetsu03_projectile_V[this]=udg_si__mugetsu03_projectile_F
    set udg_si__mugetsu03_projectile_F=this
endfunction

function sc__Futo05_EffectLoop takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo05_EffectLoop)
endfunction

function sc__Futo05_trg_attack_func takes nothing returns boolean
    call TriggerEvaluate(udg_st__Futo05_trg_attack_func)
    return udg_f__result_boolean
endfunction

function sc__Futo05_AddFlag takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit caster=LoadUnitHandle(udg_ht,GetHandleId(t),0)
    call RemoveSavedHandle(udg_ht,GetHandleId(t),0)
    call UnitAddAbility(caster,udg_Futo___Futo05_FLAG_ID)
endfunction

function sc__Futo05_onDestroy takes integer this returns nothing
endfunction

function s__Futo05__allocate takes nothing returns integer
    local integer this=udg_si__Futo05_F
    if this!=0 then
        set udg_si__Futo05_F=udg_si__Futo05_V[this]
    else
        set udg_si__Futo05_I=udg_si__Futo05_I+1
        set this=udg_si__Futo05_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Futo05_V[this]=-1
    return this
endfunction

function sc__Futo05_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Futo05_V[this]!=-1 then
        return
    endif
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo05_onDestroy)
    set udg_si__Futo05_V[this]=udg_si__Futo05_F
    set udg_si__Futo05_F=this
endfunction

function sc__Futo04_ready takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo04_ready)
endfunction

function sc__Futo04_cast takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo04_cast)
endfunction

function sc__Futo04_SlowTarget takes integer this,unit target,integer slowAbiliLvl returns nothing
    set udg_f__arg_this=this
    set udg_f__arg_unit1=target
    set udg_f__arg_integer1=slowAbiliLvl
    call TriggerEvaluate(udg_st__Futo04_SlowTarget)
endfunction

function sc__Futo04_onDestroy takes integer this returns nothing
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo04_onDestroy)
endfunction

function s__Futo04__allocate takes nothing returns integer
    local integer this=udg_si__Futo04_F
    if this!=0 then
        set udg_si__Futo04_F=udg_si__Futo04_V[this]
    else
        set udg_si__Futo04_I=udg_si__Futo04_I+1
        set this=udg_si__Futo04_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_s__Futo04_readyTimercount[this]=0
    set udg_s__Futo04_end[this]=false
    set udg_si__Futo04_V[this]=-1
    return this
endfunction

function sc__Futo04_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Futo04_V[this]!=-1 then
        return
    endif
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo04_onDestroy)
    set udg_si__Futo04_V[this]=udg_si__Futo04_F
    set udg_si__Futo04_F=this
endfunction

function sc__Futo03_ClearProtect takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo03_ClearProtect)
endfunction

function sc__Futo03_flyup takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo03_flyup)
endfunction

function sc__Futo03_move takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo03_move)
endfunction

function sc__Futo03_onDestroy takes integer this returns nothing
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo03_onDestroy)
endfunction

function s__Futo03__allocate takes nothing returns integer
    local integer this=udg_si__Futo03_F
    if this!=0 then
        set udg_si__Futo03_F=udg_si__Futo03_V[this]
    else
        set udg_si__Futo03_I=udg_si__Futo03_I+1
        set this=udg_si__Futo03_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_s__Futo03_flyupTimercount[this]=0
    set udg_s__Futo03_moveTimercount[this]=0
    set udg_s__Futo03_setLoc[this]=false
    set udg_si__Futo03_V[this]=-1
    return this
endfunction

function sc__Futo03_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Futo03_V[this]!=-1 then
        return
    endif
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo03_onDestroy)
    set udg_si__Futo03_V[this]=udg_si__Futo03_F
    set udg_si__Futo03_F=this
endfunction

function sc__Futo02_dotLoop takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo02_dotLoop)
endfunction

function sc__Futo02_trg_spelloruseitem_func takes nothing returns boolean
    call TriggerEvaluate(udg_st__Futo02_trg_spelloruseitem_func)
    return udg_f__result_boolean
endfunction

function sc__Futo02_resetCando takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer this=LoadInteger(udg_ht,GetHandleId(t),0)
    call RemoveSavedInteger(udg_ht,GetHandleId(t),0)
    set udg_s__Futo02_cando[this]=true
    set t=null
endfunction

function sc__Futo02_clearTrg takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo02_clearTrg)
endfunction

function sc__Futo02_onDestroy takes integer this returns nothing
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo02_onDestroy)
endfunction

function s__Futo02__allocate takes nothing returns integer
    local integer this=udg_si__Futo02_F
    if this!=0 then
        set udg_si__Futo02_F=udg_si__Futo02_V[this]
    else
        set udg_si__Futo02_I=udg_si__Futo02_I+1
        set this=udg_si__Futo02_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_s__Futo02_spelloruseitemTrg[this]=null
    set udg_s__Futo02_dotTimercount[this]=0
    set udg_s__Futo02_cando[this]=true
    set udg_si__Futo02_V[this]=-1
    return this
endfunction

function CCSystem_textshow takes string s,unit target,real outcometime returns nothing
    local texttag e
    if IsUnitVisible(target,GetLocalPlayer()) then
        set e=CreateTextTag()
        call SetTextTagTextBJ(e,s+"! ("+R2SW(outcometime,1,1)+"s)",10)
        call SetTextTagPos(e,GetUnitX(target),GetUnitY(target),50.)
        call SetTextTagColor(e,255,255,255,255)
        call SetTextTagVelocityBJ(e,150,90)
        call SetTextTagPermanent(e,false)
        call SetTextTagLifespan(e,2.)
    endif
    set e=null
endfunction

function sc__Futo02_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Futo02_V[this]!=-1 then
        return
    endif
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo02_onDestroy)
    set udg_si__Futo02_V[this]=udg_si__Futo02_F
    set udg_si__Futo02_F=this
endfunction

function sc__Futo01_timerPushFunc takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo01_timerPushFunc)
endfunction

function sc__Futo01_timerMainFunc takes nothing returns nothing
    call TriggerEvaluate(udg_st__Futo01_timerMainFunc)
endfunction

function sc__Futo01_onDestroy takes integer this returns nothing
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo01_onDestroy)
endfunction

function s__Futo01__allocate takes nothing returns integer
    local integer this=udg_si__Futo01_F
    if this!=0 then
        set udg_si__Futo01_F=udg_si__Futo01_V[this]
    else
        set udg_si__Futo01_I=udg_si__Futo01_I+1
        set this=udg_si__Futo01_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Futo01_V[this]=-1
    return this
endfunction

function sc__Futo01_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Futo01_V[this]!=-1 then
        return
    endif
    set udg_f__arg_this=this
    call TriggerEvaluate(udg_st__Futo01_onDestroy)
    set udg_si__Futo01_V[this]=udg_si__Futo01_F
    set udg_si__Futo01_F=this
endfunction

function sc__FutoEx_follwLoop takes nothing returns nothing
    call SetUnitX(udg_s__FutoEx_FutoExEffectUnit,GetUnitX(udg_Futo))
    call SetUnitY(udg_s__FutoEx_FutoExEffectUnit,GetUnitY(udg_Futo))
endfunction

function s__FutoEx__allocate takes nothing returns integer
    local integer this=udg_si__FutoEx_F
    if this!=0 then
        set udg_si__FutoEx_F=udg_si__FutoEx_V[this]
    else
        set udg_si__FutoEx_I=udg_si__FutoEx_I+1
        set this=udg_si__FutoEx_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__FutoEx_V[this]=-1
    return this
endfunction

function s__FutoEx_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__FutoEx_V[this]!=-1 then
        return
    endif
    set udg_si__FutoEx_V[this]=udg_si__FutoEx_F
    set udg_si__FutoEx_F=this
endfunction

function sc__Flandre2_04_onClear takes nothing returns nothing
    call TriggerEvaluate(udg_st__Flandre2_04_onClear)
endfunction

function sc__Flandre2_04_onClearTargetDebuff takes nothing returns nothing
    call TriggerEvaluate(udg_st__Flandre2_04_onClearTargetDebuff)
endfunction

function s__Flandre2_04__allocate takes nothing returns integer
    local integer this=udg_si__Flandre2_04_F
    if this!=0 then
        set udg_si__Flandre2_04_F=udg_si__Flandre2_04_V[this]
    else
        set udg_si__Flandre2_04_I=udg_si__Flandre2_04_I+1
        set this=udg_si__Flandre2_04_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Flandre2_04_V[this]=-1
    return this
endfunction

function s__Flandre2_04_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Flandre2_04_V[this]!=-1 then
        return
    endif
    set udg_si__Flandre2_04_V[this]=udg_si__Flandre2_04_F
    set udg_si__Flandre2_04_F=this
endfunction

function s__Flandre2_03__allocate takes nothing returns integer
    local integer this=udg_si__Flandre2_03_F
    if this!=0 then
        set udg_si__Flandre2_03_F=udg_si__Flandre2_03_V[this]
    else
        set udg_si__Flandre2_03_I=udg_si__Flandre2_03_I+1
        set this=udg_si__Flandre2_03_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Flandre2_03_V[this]=-1
    return this
endfunction

function s__Flandre2_03_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Flandre2_03_V[this]!=-1 then
        return
    endif
    set udg_si__Flandre2_03_V[this]=udg_si__Flandre2_03_F
    set udg_si__Flandre2_03_F=this
endfunction

function sc__Flandre2_02_onSlow takes nothing returns nothing
    call TriggerEvaluate(udg_st__Flandre2_02_onSlow)
endfunction

function s__Flandre2_02__allocate takes nothing returns integer
    local integer this=udg_si__Flandre2_02_F
    if this!=0 then
        set udg_si__Flandre2_02_F=udg_si__Flandre2_02_V[this]
    else
        set udg_si__Flandre2_02_I=udg_si__Flandre2_02_I+1
        set this=udg_si__Flandre2_02_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Flandre2_02_V[this]=-1
    return this
endfunction

function s__Flandre2_02_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Flandre2_02_V[this]!=-1 then
        return
    endif
    set udg_si__Flandre2_02_V[this]=udg_si__Flandre2_02_F
    set udg_si__Flandre2_02_F=this
endfunction

function sc__Flandre2_01_countIllusion takes nothing returns nothing
    call TriggerEvaluate(udg_st__Flandre2_01_countIllusion)
endfunction

function sc__Flandre2_01_RemoveIllusionFromGroup takes nothing returns nothing
    call TriggerEvaluate(udg_st__Flandre2_01_RemoveIllusionFromGroup)
endfunction

function s__Flandre2_01__allocate takes nothing returns integer
    local integer this=udg_si__Flandre2_01_F
    if this!=0 then
        set udg_si__Flandre2_01_F=udg_si__Flandre2_01_V[this]
    else
        set udg_si__Flandre2_01_I=udg_si__Flandre2_01_I+1
        set this=udg_si__Flandre2_01_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__Flandre2_01_V[this]=-1
    return this
endfunction

function s__Flandre2_01_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__Flandre2_01_V[this]!=-1 then
        return
    endif
    set udg_si__Flandre2_01_V[this]=udg_si__Flandre2_01_F
    set udg_si__Flandre2_01_F=this
endfunction

function s__darklightningstorm__allocate takes nothing returns integer
    local integer this=udg_si__darklightningstorm_F
    if this!=0 then
        set udg_si__darklightningstorm_F=udg_si__darklightningstorm_V[this]
    else
        set udg_si__darklightningstorm_I=udg_si__darklightningstorm_I+1
        set this=udg_si__darklightningstorm_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__darklightningstorm_V[this]=-1
    return this
endfunction

function s__darklightningstorm_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__darklightningstorm_V[this]!=-1 then
        return
    endif
    set udg_si__darklightningstorm_V[this]=udg_si__darklightningstorm_F
    set udg_si__darklightningstorm_F=this
endfunction

function s__celestialcage__allocate takes nothing returns integer
    local integer this=udg_si__celestialcage_F
    if this!=0 then
        set udg_si__celestialcage_F=udg_si__celestialcage_V[this]
    else
        set udg_si__celestialcage_I=udg_si__celestialcage_I+1
        set this=udg_si__celestialcage_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__celestialcage_V[this]=-1
    return this
endfunction

function s__celestialcage_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__celestialcage_V[this]!=-1 then
        return
    endif
    set udg_si__celestialcage_V[this]=udg_si__celestialcage_F
    set udg_si__celestialcage_F=this
endfunction

function s__launchunits__allocate takes nothing returns integer
    local integer this=udg_si__launchunits_F
    if this!=0 then
        set udg_si__launchunits_F=udg_si__launchunits_V[this]
    else
        set udg_si__launchunits_I=udg_si__launchunits_I+1
        set this=udg_si__launchunits_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__launchunits_V[this]=-1
    return this
endfunction

function s__launchunits_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__launchunits_V[this]!=-1 then
        return
    endif
    set udg_si__launchunits_V[this]=udg_si__launchunits_F
    set udg_si__launchunits_F=this
endfunction

function s__flytotarget__allocate takes nothing returns integer
    local integer this=udg_si__flytotarget_F
    if this!=0 then
        set udg_si__flytotarget_F=udg_si__flytotarget_V[this]
    else
        set udg_si__flytotarget_I=udg_si__flytotarget_I+1
        set this=udg_si__flytotarget_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__flytotarget_V[this]=-1
    return this
endfunction

function s__flytotarget_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__flytotarget_V[this]!=-1 then
        return
    endif
    set udg_si__flytotarget_V[this]=udg_si__flytotarget_F
    set udg_si__flytotarget_F=this
endfunction

function s__fadelightning__allocate takes nothing returns integer
    local integer this=udg_si__fadelightning_F
    if this!=0 then
        set udg_si__fadelightning_F=udg_si__fadelightning_V[this]
    else
        set udg_si__fadelightning_I=udg_si__fadelightning_I+1
        set this=udg_si__fadelightning_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__fadelightning_V[this]=-1
    return this
endfunction

function s__fadelightning_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__fadelightning_V[this]!=-1 then
        return
    endif
    set udg_si__fadelightning_V[this]=udg_si__fadelightning_F
    set udg_si__fadelightning_F=this
endfunction

function s__statbonus__allocate takes nothing returns integer
    local integer this=udg_si__statbonus_F
    if this!=0 then
        set udg_si__statbonus_F=udg_si__statbonus_V[this]
    else
        set udg_si__statbonus_I=udg_si__statbonus_I+1
        set this=udg_si__statbonus_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__statbonus_V[this]=-1
    return this
endfunction

function s__statbonus_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__statbonus_V[this]!=-1 then
        return
    endif
    set udg_si__statbonus_V[this]=udg_si__statbonus_F
    set udg_si__statbonus_F=this
endfunction

function s__ensnared__allocate takes nothing returns integer
    local integer this=udg_si__ensnared_F
    if this!=0 then
        set udg_si__ensnared_F=udg_si__ensnared_V[this]
    else
        set udg_si__ensnared_I=udg_si__ensnared_I+1
        set this=udg_si__ensnared_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ensnared_V[this]=-1
    return this
endfunction

function s__ensnared_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ensnared_V[this]!=-1 then
        return
    endif
    set udg_si__ensnared_V[this]=udg_si__ensnared_F
    set udg_si__ensnared_F=this
endfunction

function s__kaguya03__allocate takes nothing returns integer
    local integer this=udg_si__kaguya03_F
    if this!=0 then
        set udg_si__kaguya03_F=udg_si__kaguya03_V[this]
    else
        set udg_si__kaguya03_I=udg_si__kaguya03_I+1
        set this=udg_si__kaguya03_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__kaguya03_V[this]=-1
    return this
endfunction

function s__kaguya03_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__kaguya03_V[this]!=-1 then
        return
    endif
    set udg_si__kaguya03_V[this]=udg_si__kaguya03_F
    set udg_si__kaguya03_F=this
endfunction

function sc__ReisenNew_laser_laserloop takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReisenNew_laser_laserloop)
endfunction

function s__ReisenNew_laser__allocate takes nothing returns integer
    local integer this=udg_si__ReisenNew_laser_F
    if this!=0 then
        set udg_si__ReisenNew_laser_F=udg_si__ReisenNew_laser_V[this]
    else
        set udg_si__ReisenNew_laser_I=udg_si__ReisenNew_laser_I+1
        set this=udg_si__ReisenNew_laser_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReisenNew_laser_V[this]=-1
    return this
endfunction

function s__ReisenNew_laser_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReisenNew_laser_V[this]!=-1 then
        return
    endif
    set udg_si__ReisenNew_laser_V[this]=udg_si__ReisenNew_laser_F
    set udg_si__ReisenNew_laser_F=this
endfunction

function sc__ReisenNew_spell_skill01loop takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReisenNew_spell_skill01loop)
endfunction

function s__ReisenNew_spell__allocate takes nothing returns integer
    local integer this=udg_si__ReisenNew_spell_F
    if this!=0 then
        set udg_si__ReisenNew_spell_F=udg_si__ReisenNew_spell_V[this]
    else
        set udg_si__ReisenNew_spell_I=udg_si__ReisenNew_spell_I+1
        set this=udg_si__ReisenNew_spell_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReisenNew_spell_V[this]=-1
    return this
endfunction

function s__ReisenNew_spell_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReisenNew_spell_V[this]!=-1 then
        return
    endif
    set udg_si__ReisenNew_spell_V[this]=udg_si__ReisenNew_spell_F
    set udg_si__ReisenNew_spell_F=this
endfunction

function sc__ReisenNew_projectile_startloop takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReisenNew_projectile_startloop)
endfunction

function s__ReisenNew_projectile__allocate takes nothing returns integer
    local integer this=udg_si__ReisenNew_projectile_F
    if this!=0 then
        set udg_si__ReisenNew_projectile_F=udg_si__ReisenNew_projectile_V[this]
    else
        set udg_si__ReisenNew_projectile_I=udg_si__ReisenNew_projectile_I+1
        set this=udg_si__ReisenNew_projectile_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReisenNew_projectile_V[this]=-1
    return this
endfunction

function s__ReisenNew_projectile_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReisenNew_projectile_V[this]!=-1 then
        return
    endif
    set udg_si__ReisenNew_projectile_V[this]=udg_si__ReisenNew_projectile_F
    set udg_si__ReisenNew_projectile_F=this
endfunction

function sc__YoumuNew_w_wSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__YoumuNew_w_wSkill_Action)
endfunction

function s__YoumuNew_w__allocate takes nothing returns integer
    local integer this=udg_si__YoumuNew_w_F
    if this!=0 then
        set udg_si__YoumuNew_w_F=udg_si__YoumuNew_w_V[this]
    else
        set udg_si__YoumuNew_w_I=udg_si__YoumuNew_w_I+1
        set this=udg_si__YoumuNew_w_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__YoumuNew_w_V[this]=-1
    return this
endfunction

function s__YoumuNew_w_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__YoumuNew_w_V[this]!=-1 then
        return
    endif
    set udg_si__YoumuNew_w_V[this]=udg_si__YoumuNew_w_F
    set udg_si__YoumuNew_w_F=this
endfunction

function sc__YoumuNew_d_dSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__YoumuNew_d_dSkill_Action)
endfunction

function s__YoumuNew_d__allocate takes nothing returns integer
    local integer this=udg_si__YoumuNew_d_F
    if this!=0 then
        set udg_si__YoumuNew_d_F=udg_si__YoumuNew_d_V[this]
    else
        set udg_si__YoumuNew_d_I=udg_si__YoumuNew_d_I+1
        set this=udg_si__YoumuNew_d_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__YoumuNew_d_V[this]=-1
    return this
endfunction

function s__YoumuNew_d_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__YoumuNew_d_V[this]!=-1 then
        return
    endif
    set udg_si__YoumuNew_d_V[this]=udg_si__YoumuNew_d_F
    set udg_si__YoumuNew_d_F=this
endfunction

function sc__ReimuMother_ULT06_dSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_ULT06_dSkill_Action)
endfunction

function s__ReimuMother_ULT06__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_ULT06_F
    if this!=0 then
        set udg_si__ReimuMother_ULT06_F=udg_si__ReimuMother_ULT06_V[this]
    else
        set udg_si__ReimuMother_ULT06_I=udg_si__ReimuMother_ULT06_I+1
        set this=udg_si__ReimuMother_ULT06_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_ULT06_V[this]=-1
    return this
endfunction

function s__ReimuMother_ULT06_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_ULT06_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_ULT06_V[this]=udg_si__ReimuMother_ULT06_F
    set udg_si__ReimuMother_ULT06_F=this
endfunction

function sc__ReimuMother_ULT05_ULT05_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_ULT05_ULT05_Action)
endfunction

function s__ReimuMother_ULT05__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_ULT05_F
    if this!=0 then
        set udg_si__ReimuMother_ULT05_F=udg_si__ReimuMother_ULT05_V[this]
    else
        set udg_si__ReimuMother_ULT05_I=udg_si__ReimuMother_ULT05_I+1
        set this=udg_si__ReimuMother_ULT05_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_ULT05_V[this]=-1
    return this
endfunction

function s__ReimuMother_ULT05_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_ULT05_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_ULT05_V[this]=udg_si__ReimuMother_ULT05_F
    set udg_si__ReimuMother_ULT05_F=this
endfunction

function s__ReimuMother_ULT04__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_ULT04_F
    if this!=0 then
        set udg_si__ReimuMother_ULT04_F=udg_si__ReimuMother_ULT04_V[this]
    else
        set udg_si__ReimuMother_ULT04_I=udg_si__ReimuMother_ULT04_I+1
        set this=udg_si__ReimuMother_ULT04_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_ULT04_V[this]=-1
    return this
endfunction

function s__ReimuMother_ULT04_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_ULT04_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_ULT04_V[this]=udg_si__ReimuMother_ULT04_F
    set udg_si__ReimuMother_ULT04_F=this
endfunction

function sc__ReimuMother_ULT03_Clear takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_ULT03_Clear)
endfunction

function s__ReimuMother_ULT03__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_ULT03_F
    if this!=0 then
        set udg_si__ReimuMother_ULT03_F=udg_si__ReimuMother_ULT03_V[this]
    else
        set udg_si__ReimuMother_ULT03_I=udg_si__ReimuMother_ULT03_I+1
        set this=udg_si__ReimuMother_ULT03_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_ULT03_V[this]=-1
    return this
endfunction

function s__ReimuMother_ULT03_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_ULT03_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_ULT03_V[this]=udg_si__ReimuMother_ULT03_F
    set udg_si__ReimuMother_ULT03_F=this
endfunction

function sc__ReimuMother_ULT02_startloop takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_ULT02_startloop)
endfunction

function s__ReimuMother_ULT02__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_ULT02_F
    if this!=0 then
        set udg_si__ReimuMother_ULT02_F=udg_si__ReimuMother_ULT02_V[this]
    else
        set udg_si__ReimuMother_ULT02_I=udg_si__ReimuMother_ULT02_I+1
        set this=udg_si__ReimuMother_ULT02_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_ULT02_V[this]=-1
    return this
endfunction

function s__ReimuMother_ULT02_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_ULT02_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_ULT02_V[this]=udg_si__ReimuMother_ULT02_F
    set udg_si__ReimuMother_ULT02_F=this
endfunction

function sc__ReimuMother_ULT01_ULT01_loop takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_ULT01_ULT01_loop)
endfunction

function s__ReimuMother_ULT01__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_ULT01_F
    if this!=0 then
        set udg_si__ReimuMother_ULT01_F=udg_si__ReimuMother_ULT01_V[this]
    else
        set udg_si__ReimuMother_ULT01_I=udg_si__ReimuMother_ULT01_I+1
        set this=udg_si__ReimuMother_ULT01_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_ULT01_V[this]=-1
    return this
endfunction

function s__ReimuMother_ULT01_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_ULT01_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_ULT01_V[this]=udg_si__ReimuMother_ULT01_F
    set udg_si__ReimuMother_ULT01_F=this
endfunction

function sc__ReimuMother_w_wSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_w_wSkill_Action)
endfunction

function s__ReimuMother_w__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_w_F
    if this!=0 then
        set udg_si__ReimuMother_w_F=udg_si__ReimuMother_w_V[this]
    else
        set udg_si__ReimuMother_w_I=udg_si__ReimuMother_w_I+1
        set this=udg_si__ReimuMother_w_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_w_V[this]=-1
    return this
endfunction

function s__ReimuMother_w_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_w_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_w_V[this]=udg_si__ReimuMother_w_F
    set udg_si__ReimuMother_w_F=this
endfunction

function sc__ReimuMother_r_rSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_r_rSkill_Action)
endfunction

function s__ReimuMother_r__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_r_F
    if this!=0 then
        set udg_si__ReimuMother_r_F=udg_si__ReimuMother_r_V[this]
    else
        set udg_si__ReimuMother_r_I=udg_si__ReimuMother_r_I+1
        set this=udg_si__ReimuMother_r_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_r_V[this]=-1
    return this
endfunction

function s__ReimuMother_r_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_r_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_r_V[this]=udg_si__ReimuMother_r_F
    set udg_si__ReimuMother_r_F=this
endfunction

function sc__ReimuMother_f_fSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_f_fSkill_Action)
endfunction

function s__ReimuMother_f__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_f_F
    if this!=0 then
        set udg_si__ReimuMother_f_F=udg_si__ReimuMother_f_V[this]
    else
        set udg_si__ReimuMother_f_I=udg_si__ReimuMother_f_I+1
        set this=udg_si__ReimuMother_f_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_f_V[this]=-1
    return this
endfunction

function s__ReimuMother_f_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_f_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_f_V[this]=udg_si__ReimuMother_f_F
    set udg_si__ReimuMother_f_F=this
endfunction

function sc__ReimuMother_d_dSkill_Action takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_d_dSkill_Action)
endfunction

function s__ReimuMother_d__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_d_F
    if this!=0 then
        set udg_si__ReimuMother_d_F=udg_si__ReimuMother_d_V[this]
    else
        set udg_si__ReimuMother_d_I=udg_si__ReimuMother_d_I+1
        set this=udg_si__ReimuMother_d_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_d_V[this]=-1
    return this
endfunction

function s__ReimuMother_d_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_d_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_d_V[this]=udg_si__ReimuMother_d_F
    set udg_si__ReimuMother_d_F=this
endfunction

function sc__ReimuMother_e_eSkill_loop takes nothing returns nothing
    call TriggerEvaluate(udg_st__ReimuMother_e_eSkill_loop)
endfunction

function s__ReimuMother_e__allocate takes nothing returns integer
    local integer this=udg_si__ReimuMother_e_F
    if this!=0 then
        set udg_si__ReimuMother_e_F=udg_si__ReimuMother_e_V[this]
    else
        set udg_si__ReimuMother_e_I=udg_si__ReimuMother_e_I+1
        set this=udg_si__ReimuMother_e_I
    endif
    if this>8190 then
        return 0
    endif
    set udg_si__ReimuMother_e_V[this]=-1
    return this
endfunction

function s__ReimuMother_e_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif udg_si__ReimuMother_e_V[this]!=-1 then
        return
    endif
    set udg_si__ReimuMother_e_V[this]=udg_si__ReimuMother_e_F
    set udg_si__ReimuMother_e_F=this
endfunction

function GetTime takes nothing returns real
    return TimerGetElapsed(udg_TimeTimer)
endfunction

function I2S2 takes integer i returns string
    return SubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ",i,i+1)
endfunction

function Get takes integer i,string s returns integer
    return GetStoredInteger(udg_GC[i],"",s)
endfunction

function Set takes integer i,string s,integer j returns nothing
    call StoreInteger(udg_GC[i],"",s,j)
endfunction

function Save takes nothing returns boolean
    return SaveGameCache(udg_GC[99])
endfunction

function Test2 takes nothing returns boolean
    local unit u=GetTriggerUnit()
    call BJDebugMsg(" ")
    call BJDebugMsg("Unit Name: "+GetUnitName(u))
    call BJDebugMsg("Unit Coordinates("+R2S(GetUnitX(u))+","+R2S(GetUnitY(u))+")")
    call BJDebugMsg("Unit TypeID: "+I2S(GetUnitTypeId(u)))
    call BJDebugMsg("Unit HandleID: "+I2S(GetHandleId(u)))
    set u=null
    return false
endfunction

function Test3 takes nothing returns boolean
    local unit u=GetTriggerUnit()
    call BJDebugMsg(" ")
    call BJDebugMsg("Unit Name: "+GetUnitName(u))
    call BJDebugMsg("Ability Name: "+GetObjectName(GetSpellAbilityId()))
    call BJDebugMsg("AbilityID: >"+I2S(GetSpellAbilityId()))
    set u=null
    return false
endfunction

function Test41 takes nothing returns boolean
    call KillUnit(GetTriggerUnit())
    call DestroyTrigger(GetTriggeringTrigger())
    return false
endfunction

function Test4 takes nothing returns nothing
    local trigger trg=CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(trg,GetTriggerPlayer(),EVENT_PLAYER_UNIT_SELECTED,null)
    call TriggerAddCondition(trg,Condition(function Test41))
    set trg=null
endfunction

function Test takes nothing returns boolean
    local integer x=0
    local integer y=0
    local integer i=0
    local integer j=0
    local string s=GetEventPlayerChatString()
    local string s2=""
    local trigger trg
    if StringCase(s,false)==".save" then
        call SaveGameCache(udg_GC[99])
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,"Game Rank Saved")
    elseif StringCase(SubString(s,0,4),false)==".get" then
        set x=5
        loop
        exitwhen SubString(s,x,x+1)=="" or SubString(s,x,x+1)==" "
            set x=x+1
        endloop
        set i=S2I(SubString(s,5,x))
        set s2=SubString(s,x+1,StringLength(s))
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,"("+I2S(i)+","+s2+") →→ "+I2S(GetStoredInteger(udg_GC[i],"",s2)))
    elseif StringCase(SubString(s,0,4),false)==".set" then
        set x=5
        loop
        exitwhen SubString(s,x,x+1)=="" or SubString(s,x,x+1)==" "
            set x=x+1
        endloop
        set i=S2I(SubString(s,5,x))
        set y=x+1
        loop
        exitwhen SubString(s,y,y+1)=="" or SubString(s,y,y+1)==" "
            set y=y+1
        endloop
        set s2=SubString(s,x+1,y)
        set j=S2I(SubString(s,y+1,StringLength(s)))
        call StoreInteger(udg_GC[i],"",s2,j)
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,I2S(j)+" →→ ("+I2S(i)+","+s2+")")
    elseif StringCase(s,false)==".info" then
        set trg=CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(trg,GetTriggerPlayer(),EVENT_PLAYER_UNIT_SELECTED,null)
        call TriggerAddCondition(trg,Condition(function Test2))
        set trg=null
    elseif StringCase(s,false)==".skill" then
        set trg=CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(trg,GetTriggerPlayer(),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
        call TriggerAddCondition(trg,Condition(function Test3))
        set trg=null
    elseif StringCase(s,false)==".kill" then
        call Test4()
    elseif StringCase(s,false)==".record" then
        set udg_IsGameOver=false
        call ExecuteFunc("TGameOver")
    endif
    return false
endfunction

function InitTest takes nothing returns boolean
    local trigger trg=null
    if GetPlayerName(GetTriggerPlayer())=="FaiWei" or GetPlayerName(GetTriggerPlayer())=="Karolson" or GetPlayerName(GetTriggerPlayer())=="Skandod" then
        set trg=CreateTrigger()
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,"Game Test Mode")
        call TriggerRegisterPlayerChatEvent(trg,GetTriggerPlayer(),".get",false)
        call TriggerRegisterPlayerChatEvent(trg,GetTriggerPlayer(),".set",false)
        call TriggerRegisterPlayerChatEvent(trg,GetTriggerPlayer(),".save",true)
        call TriggerRegisterPlayerChatEvent(trg,GetTriggerPlayer(),".info",true)
        call TriggerRegisterPlayerChatEvent(trg,GetTriggerPlayer(),".skill",true)
        call TriggerRegisterPlayerChatEvent(trg,GetTriggerPlayer(),".kill",true)
        call TriggerRegisterPlayerChatEvent(trg,GetTriggerPlayer(),".record",true)
        call TriggerAddCondition(trg,Condition(function Test))
        set trg=null
    endif
    return false
endfunction

function runawayB2I takes nothing returns nothing
    local integer i=1
    local integer j=1
    local integer result=0
    local integer run=0
    local integer id=GetPlayerId(GetLocalPlayer())
    loop
    exitwhen i>25
        if udg_runaway[i] then
            set result=result+j
            set run=run+2
        endif
        set i=i+1
        set j=j*2
    endloop
    call StoreInteger(udg_GC[id],"","R1",result)
    set i=1
    set j=1
    set result=0
    loop
    exitwhen i>25
        if udg_runaway[i+25] then
            set result=result+j
            set run=run+2
        endif
        set i=i+1
        set j=j*2
    endloop
    call StoreInteger(udg_GC[id],"","R2",result)
    call StoreInteger(udg_GC[id],"","Out",run)
endfunction

function runawayI2B takes nothing returns nothing
    local integer i=1
    local integer j=1
    local integer id=GetPlayerId(GetLocalPlayer())
    local integer result=GetStoredInteger(udg_GC[id],"","R1")
    loop
    exitwhen i>25
        set j=result/2
        if result==j*2 then
            set udg_runaway[i]=false
        else
            set udg_runaway[i]=true
        endif
        set i=i+1
        set result=j
    endloop
    set i=1
    set j=1
    set result=GetStoredInteger(udg_GC[id],"","R2")
    loop
    exitwhen i>25
        set j=result/2
        if result==j*2 then
            set udg_runaway[i+25]=false
        else
            set udg_runaway[i+25]=true
        endif
        set i=i+1
        set result=j
    endloop
endfunction

function SetLevel takes nothing returns nothing
    local integer x=GetStoredInteger(udg_GC[99],"","th_game")
    local real y=0
    if GetStoredInteger(udg_GC[99],"","board_number")>0 then
        set y=x+1000*(.01*GetStoredInteger(udg_GC[99],"","winrate")*(.01*GetStoredInteger(udg_GC[99],"","board_number")+1))*(GetStoredInteger(udg_GC[99],"","udg_MVP")*.5/GetStoredInteger(udg_GC[99],"","board_number")+1)*(GetStoredInteger(udg_GC[99],"","mighty")*.5/GetStoredInteger(udg_GC[99],"","board_number")+1)
    endif
    call StoreInteger(udg_GC[99],"","combat_power",R2I(y))
    call StoreInteger(udg_GC[99],"","KD_ratio",R2I((GetStoredInteger(udg_GC[99],"","kills")+GetStoredInteger(udg_GC[99],"","assists"))/IMaxBJ(GetStoredInteger(udg_GC[99],"","deaths"),1)))
endfunction

function RunAway takes integer isrun returns nothing
    local integer i=GetPlayerId(GetLocalPlayer())
    if IsPlayerObserver(GetLocalPlayer()) or udg_IsGameOver then
        return
    endif
    if isrun==0 then
        if GetStoredInteger(udg_GC[i],"","R0")==50 then
            call StoreInteger(udg_GC[i],"","R0",1)
        else
            call StoreInteger(udg_GC[i],"","R0",1+GetStoredInteger(udg_GC[i],"","R0"))
        endif
        call runawayI2B()
        set udg_runaway[GetStoredInteger(udg_GC[i],"","R0")]=true
        call runawayB2I()
        set udg_Run=true
        call StoreInteger(udg_GC[99],"","th_game",GetStoredInteger(udg_GC[99],"","th_game")-50)
    elseif udg_Run then
        call runawayI2B()
        set udg_runaway[GetStoredInteger(udg_GC[i],"","R0")]=false
        call runawayB2I()
        if isrun==1 then
            call StoreInteger(udg_GC[99],"","th_game",GetStoredInteger(udg_GC[99],"","th_game")+25)
            set udg_Run2=true
        else
            set udg_Run=false
            if udg_Run2 then
                call StoreInteger(udg_GC[99],"","th_game",GetStoredInteger(udg_GC[99],"","th_game")+25)
            else
                call StoreInteger(udg_GC[99],"","th_game",GetStoredInteger(udg_GC[99],"","th_game")+50)
            endif
        endif
    endif
    call SetLevel()
    call SaveGameCache(udg_GC[99])
endfunction

function CountPlayer takes nothing returns boolean
    local integer i=0
    local boolean result=false
    set udg_TeamPlayer[0]=0
    set udg_TeamPlayer[1]=0
    loop
    exitwhen i>11
        if IsPlayerObserver(Player(i))==false and GetPlayerController(Player(i))==MAP_CONTROL_USER and GetPlayerSlotState(Player(i))==PLAYER_SLOT_STATE_PLAYING then
            if IsPlayerAlly(Player(i),GetOwningPlayer(udg_BaseUnit[0])) then
                set udg_TeamPlayer[0]=udg_TeamPlayer[0]+1
            else
                set udg_TeamPlayer[1]=udg_TeamPlayer[1]+1
            endif
        endif
        set i=i+1
    endloop
    set result=udg_TeamPlayer[0]>0 and udg_TeamPlayer[1]>0
    set udg_PlayerNumber=udg_TeamPlayer[0]+udg_TeamPlayer[1]
    if udg_PlayerNumber==10 then
        set udg_MVP=true
    endif
    return result
endfunction

function MinTimer takes nothing returns nothing
    if udg_IsGameOver then
        call DestroyTimer(GetExpiredTimer())
        return
    endif
    if IsPlayerObserver(GetLocalPlayer()) then
        return
    endif
    call StoreInteger(udg_GC[99],"","time",1+GetStoredInteger(udg_GC[99],"","time"))
    call SaveGameCache(udg_GC[99])
endfunction

function GameOver takes integer tid returns nothing
    local integer i=1
    local integer j=GetPlayerId(GetLocalPlayer())
    local real x
    if udg_IsGameOver or IsPlayerObserver(GetLocalPlayer()) then
        return
    endif
    call RunAway(2)
    set udg_IsGameOver=true
    if TimerGetElapsed(udg_TimeTimer)<600 or tid<0 then
        call StoreInteger(udg_GC[99],"","board_number",GetStoredInteger(udg_GC[99],"","board_number")-1)
        call StoreInteger(udg_GC[99],"","th_game",GetStoredInteger(udg_GC[99],"","th_game")-udg_LoseScore)
        call SetLevel()
        call SaveGameCache(udg_GC[99])
        call BJDebugMsg("|cff008800Game over is in less than 10 minutes, regardless of victory|r")
        return
    endif
    set x=0
    set i=0
    loop
    exitwhen i>11
        if (udg_MU_Kill[i]+udg_MU_Assist[i])/IMaxBJ(udg_MU_Die[i],1)>x and IsUnitAlly(udg_BaseUnit[tid],Player(i)) then
            set x=(udg_MU_Kill[i]+udg_MU_Assist[i])/IMaxBJ(udg_MU_Die[i],1)
        endif
        set i=i+1
    endloop
    if udg_MVP then
        set i=0
        loop
        exitwhen i>11
            if (udg_MU_Kill[i]+udg_MU_Assist[i])/IMaxBJ(udg_MU_Die[i],1)>x and IsUnitAlly(udg_BaseUnit[tid],Player(i)) then
                call StoreInteger(udg_GC[i],"","udg_MVP",1+GetStoredInteger(udg_GC[i],"","udg_MVP"))
                call DisplayTimedTextToPlayer(Player(i),0,0,60,"|cff008800You are: |cffffff00MVP|r")
            endif
            set i=i+1
        endloop
    endif
    set x=0
    set i=0
    loop
    exitwhen i>11
        if (udg_MU_Kill[i]+udg_MU_Assist[i])/IMaxBJ(udg_MU_Die[i],1)>x and IsUnitEnemy(udg_BaseUnit[tid],Player(i)) then
            set x=(udg_MU_Kill[i]+udg_MU_Assist[i])/IMaxBJ(udg_MU_Die[i],1)
        endif
        set i=i+1
    endloop
    if udg_MVP then
        set i=0
        loop
        exitwhen i>11
            if (udg_MU_Kill[i]+udg_MU_Assist[i])/IMaxBJ(udg_MU_Die[i],1)>x and IsUnitEnemy(udg_BaseUnit[tid],Player(i)) then
                call StoreInteger(udg_GC[i],"","mighty",1+GetStoredInteger(udg_GC[i],"","mighty"))
                call DisplayTimedTextToPlayer(Player(i),0,0,60,"|cff008800You are: |cffffff00Mighty|r")
            endif
            set i=i+1
        endloop
    endif
    set i=0
    loop
    exitwhen i>11
        if IsUnitAlly(udg_BaseUnit[tid],Player(i)) then
            call StoreInteger(udg_GC[i],"","win",GetStoredInteger(udg_GC[i],"","win")+1)
            set udg_Record[i]=udg_Record[i]+udg_WinScore
        else
            set udg_Record[i]=udg_Record[i]+udg_LoseScore
        endif
        call StoreInteger(udg_GC[99],"","winrate",100*GetStoredInteger(udg_GC[99],"","win")/GetStoredInteger(udg_GC[99],"","board_number"))
        set i=i+1
    endloop
    if udg_Record[j]>udg_MaxExp then
        set udg_Record[j]=udg_MaxExp
    endif
    if udg_Record[j]>=0 then
        call DisplayTimedTextToPlayer(Player(j),0,0,60,"|cff00ff00th_game+"+I2S(udg_Record[j])+"|r")
    else
        call DisplayTimedTextToPlayer(Player(j),0,0,60,"|cff00ff00th_game"+I2S(udg_Record[j])+"|r")
    endif
    call StoreInteger(udg_GC[99],"","th_game",udg_Record[j]-udg_LoseScore+GetStoredInteger(udg_GC[99],"","th_game"))
    call SetLevel()
    call SaveGameCache(udg_GC[99])
    call BJDebugMsg("|cffcc00ffGame Rank Saved|r")
endfunction

function TGameOver takes nothing returns nothing
    if udg_GameTime<300 then
        call BJDebugMsg("|cffcc00ffIf the game lasts less than 5 minutes, points will not be calculated|r")
    else
        call GameOver(GetPlayerTeam(GetTriggerPlayer()))
    endif
endfunction

function PlayerLeave takes nothing returns boolean
    if IsPlayerObserver(GetTriggerPlayer()) or udg_IsGameOver then
        return false
    endif
    set udg_KengDie=false
    set udg_TeamPlayer[GetPlayerTeam(GetTriggerPlayer())]=udg_TeamPlayer[GetPlayerTeam(GetTriggerPlayer())]-1
    set udg_PlayerNumber=udg_PlayerNumber-1
    if udg_TeamPlayer[0]==0 then
        call GameOver(1)
    elseif udg_TeamPlayer[1]==0 then
        call GameOver(0)
    endif
    call RunAway(2)
    return false
endfunction

function KillHero takes nothing returns boolean
    local integer id1
    local integer id2=GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    local unit u
    local integer i=0
    if IsPlayerObserver(Player(id2)) or GetPlayerController(Player(id2))!=MAP_CONTROL_USER or GetPlayerSlotState(Player(id2))!=PLAYER_SLOT_STATE_PLAYING then
        return false
    endif
    set udg_MU_Die[id2]=udg_MU_Die[id2]+1
    call StoreInteger(udg_GC[id2],"","deaths",GetStoredInteger(udg_GC[id2],"","deaths")+1)
    if GetKillingUnit()==null then
        call SetLevel()
        call SaveGameCache(udg_GC[99])
        return false
    endif
    set id1=GetPlayerId(GetOwningPlayer(GetKillingUnit()))
    set u=GetTriggerUnit()
    if IsUnitEnemy(u,Player(id1)) then
        set udg_MU_Kill[id1]=udg_MU_Kill[id1]+1
        set udg_MU_NKill[id1]=udg_MU_NKill[id1]+1
        if udg_MU_NKill[id1]>udg_MU_MKill[id1] then
            set udg_MU_MKill[id1]=udg_MU_NKill[id1]
        endif
        if udg_MU_MKill[id1]>GetStoredInteger(udg_GC[id1],"","MK") then
            call StoreInteger(udg_GC[id1],"","MK",udg_MU_MKill[id1])
        endif
        call StoreInteger(udg_GC[id1],"","kills",GetStoredInteger(udg_GC[id1],"","kills")+1)
        set udg_MU_NKill[id2]=0
        loop
        exitwhen i>11
            if i!=id1 and IsPlayerEnemy(Player(id2),Player(i)) and TimerGetElapsed(udg_TimeTimer)-udg_DamageTime[i*100+id2]<15 then
                set udg_MU_Assist[i]=udg_MU_Assist[i]+1
                call StoreInteger(udg_GC[i],"","assists",GetStoredInteger(udg_GC[i],"","assists")+1)
            endif
            set i=i+1
        endloop
    endif
    call SetLevel()
    call SaveGameCache(udg_GC[99])
    set u=null
    return false
endfunction

function DamageHero takes nothing returns boolean
    local integer id1=GetPlayerId(GetOwningPlayer(GetEventDamageSource()))
    local integer id2=GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    set udg_DamageTime[id1*100+id2]=TimerGetElapsed(udg_TimeTimer)
    return false
endfunction

function InitPlayerHero takes unit hero returns nothing
    local integer id=GetPlayerId(GetOwningPlayer(hero))
    if udg_IsGameOver then
        return
    endif
    set udg_Hero[id]=hero
    call DestroyTrigger(udg_MU_KillHero[id])
    set udg_MU_KillHero[id]=CreateTrigger()
    call TriggerRegisterUnitEvent(udg_MU_KillHero[id],hero,EVENT_UNIT_DEATH)
    call TriggerAddCondition(udg_MU_KillHero[id],Condition(function KillHero))
    call DestroyTrigger(udg_MU_DamageHero[id])
    set udg_MU_DamageHero[id]=CreateTrigger()
    call TriggerRegisterUnitEvent(udg_MU_DamageHero[id],hero,EVENT_UNIT_DAMAGED)
    call TriggerAddCondition(udg_MU_DamageHero[id],Condition(function DamageHero))
endfunction

function BaseDestroy takes nothing returns boolean
    if GetTriggerUnit()==udg_BaseUnit[0] then
        call GameOver(1)
    else
        call GameOver(0)
    endif
    return false
endfunction

function RunA takes nothing returns nothing
    call DestroyTimer(GetExpiredTimer())
    call RunAway(0)
    set udg_WinScore=100
    set udg_LoseScore=-50
    call StoreInteger(udg_GC[99],"","th_game",GetStoredInteger(udg_GC[99],"","th_game")+udg_LoseScore)
    call SetLevel()
    if not IsPlayerObserver(GetLocalPlayer()) then
        call StoreInteger(udg_GC[99],"","board_number",GetStoredInteger(udg_GC[99],"","board_number")+1)
    endif
    call SaveGameCache(udg_GC[99])
endfunction

function RunB takes nothing returns nothing
    call DestroyTimer(GetExpiredTimer())
    set udg_MaxExp=999999
    call RunAway(1)
endfunction

function InitRecord takes nothing returns nothing
    local integer i=0
    local trigger trg=CreateTrigger()
    call DestroyTimer(GetExpiredTimer())
    loop
    exitwhen i>15
        if IsPlayerObserver(Player(i)) then
            set udg_GC[i]=InitGameCache("Nothing")
        else
            set udg_GC[i]=InitGameCache("11SAV@"+I2S2(i))
        endif
        call TriggerRegisterPlayerChatEvent(trg,Player(i),"iknowhowtowinindots",true)
        set i=i+1
    endloop
    call TriggerAddCondition(trg,Condition(function InitTest))
    set udg_GC[99]=udg_GC[GetPlayerId(GetLocalPlayer())]
    call StoreString(udg_GC[99],"","Title@"+I2S2(0),"win")
    call StoreString(udg_GC[99],"","Title@"+I2S2(1),"th_game")
    call StoreString(udg_GC[99],"","Title@"+I2S2(2),"winrate")
    call StoreString(udg_GC[99],"","Title@"+I2S2(3),"KD_ratio")
    call StoreString(udg_GC[99],"","Title@"+I2S2(4),"udg_MVP")
    call StoreString(udg_GC[99],"","Title@"+I2S2(5),"mighty")
    call StoreString(udg_GC[99],"","Title@"+I2S2(6),"run_away")
    call StoreString(udg_GC[99],"","Title@"+I2S2(7),"combat_power")
    set udg_BaseUnit[0]=gg_unit_h00D_0013
    set udg_BaseUnit[1]=gg_unit_h00U_0019
    if not CountPlayer() then
        call SaveGameCache(udg_GC[99])
        return
    endif
    call BJDebugMsg("|cffcc00ffThe ranking system has been turned on, after the game is over, please display 'Game Rank Saved' on the screen before leaving the game")
    set udg_TimeTimer=CreateTimer()
    call TimerStart(udg_TimeTimer,99999,false,null)
    call TimerStart(CreateTimer(),60,true,function MinTimer)
    call TimerStart(CreateTimer(),60,false,function RunB)
    set trg=CreateTrigger()
    set i=0
    loop
    exitwhen i>11
        call TriggerRegisterPlayerEvent(trg,Player(i),EVENT_PLAYER_LEAVE)
        set i=i+1
    endloop
    call TriggerAddCondition(trg,Condition(function PlayerLeave))
    set trg=CreateTrigger()
    call TriggerRegisterUnitEvent(trg,udg_BaseUnit[0],EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(trg,udg_BaseUnit[1],EVENT_UNIT_DEATH)
    call TriggerAddCondition(trg,Condition(function BaseDestroy))
    set trg=null
    call RunA()
endfunction

function Record__Init takes nothing returns nothing
    call TimerStart(CreateTimer(),0,false,function InitRecord)
endfunction

function YDWEEnumDestructablesInCircleBJFilterNull takes nothing returns boolean
    local real dx=GetDestructableX(GetFilterDestructable())-GetLocationX(bj_enumDestructableCenter)
    local real dy=GetDestructableY(GetFilterDestructable())-GetLocationY(bj_enumDestructableCenter)
    return dx*dx+dy*dy<=bj_enumDestructableRadius*bj_enumDestructableRadius
endfunction

function YDWEGetCurrentCameraSetupNull takes nothing returns camerasetup
    local camerasetup theCam=CreateCameraSetup()
    local real duration=0
    call CameraSetupSetField(theCam,CAMERA_FIELD_TARGET_DISTANCE,GetCameraField(CAMERA_FIELD_TARGET_DISTANCE),duration)
    call CameraSetupSetField(theCam,CAMERA_FIELD_FARZ,GetCameraField(CAMERA_FIELD_FARZ),duration)
    call CameraSetupSetField(theCam,CAMERA_FIELD_ZOFFSET,GetCameraField(CAMERA_FIELD_ZOFFSET),duration)
    call CameraSetupSetField(theCam,CAMERA_FIELD_ANGLE_OF_ATTACK,bj_RADTODEG*GetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK),duration)
    call CameraSetupSetField(theCam,CAMERA_FIELD_FIELD_OF_VIEW,bj_RADTODEG*GetCameraField(CAMERA_FIELD_FIELD_OF_VIEW),duration)
    call CameraSetupSetField(theCam,CAMERA_FIELD_ROLL,bj_RADTODEG*GetCameraField(CAMERA_FIELD_ROLL),duration)
    call CameraSetupSetField(theCam,CAMERA_FIELD_ROTATION,bj_RADTODEG*GetCameraField(CAMERA_FIELD_ROTATION),duration)
    call CameraSetupSetDestPosition(theCam,GetCameraTargetPositionX(),GetCameraTargetPositionY(),duration)
    set udg_yd_NullTempCam=theCam
    set theCam=null
    return udg_yd_NullTempCam
endfunction

function YDWEGetInventoryIndexOfItemTypeBJNull takes unit whichUnit,integer itemId returns integer
    local integer index=0
    if itemId!=0 then
        loop
            if GetItemTypeId(UnitItemInSlot(whichUnit,index))==itemId then
                return index+1
            endif
            set index=index+1
        exitwhen index>=bj_MAX_INVENTORY
        endloop
    endif
    return 0
endfunction

function YDWEGetItemOfTypeFromUnitBJNull takes unit whichUnit,integer itemId returns item
    local integer index=0
    loop
        set udg_yd_NullTempItem=UnitItemInSlot(whichUnit,index)
        if GetItemTypeId(udg_yd_NullTempItem)==itemId then
            return udg_yd_NullTempItem
        endif
        set index=index+1
    exitwhen index>=bj_MAX_INVENTORY
    endloop
    return null
endfunction

function YDWEGetUnitsInRangeOfLocMatchingNull takes real radius,location whichLocation,boolexpr filter returns group
    local group g=CreateGroup()
    call GroupEnumUnitsInRangeOfLoc(g,whichLocation,radius,filter)
    call DestroyBoolExpr(filter)
    set udg_yd_NullTempGroup=g
    set g=null
    return udg_yd_NullTempGroup
endfunction

function YDWEGetUnitsInRectMatchingNull takes rect r,boolexpr filter returns group
    local group g=CreateGroup()
    call GroupEnumUnitsInRect(g,r,filter)
    call DestroyBoolExpr(filter)
    set udg_yd_NullTempGroup=g
    set g=null
    return udg_yd_NullTempGroup
endfunction

function YDWEPauseAllUnitsBJNull takes boolean pause returns nothing
    local integer index
    local player indexPlayer
    local group g
    set bj_pauseAllUnitsFlag=pause
    set g=CreateGroup()
    set index=0
    loop
        set indexPlayer=Player(index)
        if GetPlayerController(indexPlayer)==MAP_CONTROL_COMPUTER then
            call PauseCompAI(indexPlayer,pause)
        endif
        call GroupEnumUnitsOfPlayer(g,indexPlayer,null)
        call ForGroup(g,function PauseAllUnitsBJEnum)
        call GroupClear(g)
        set index=index+1
    exitwhen index==bj_MAX_PLAYER_SLOTS
    endloop
    call DestroyGroup(g)
    set g=null
endfunction

function YDWEPlaySoundNull takes string soundName returns nothing
    local sound soundHandle=CreateSound(soundName,false,false,true,12700,12700,"")
    call StartSound(soundHandle)
    call KillSoundWhenDone(soundHandle)
    set soundHandle=null
endfunction

function YDWEPolledWaitNull takes real duration returns nothing
    local timer t
    local real timeRemaining
    if duration>0 then
        set t=CreateTimer()
        call TimerStart(t,duration,false,null)
        loop
            set timeRemaining=TimerGetRemaining(t)
        exitwhen timeRemaining<=0
            if timeRemaining>bj_POLLED_WAIT_SKIP_THRESHOLD then
                call TriggerSleepAction(.1*timeRemaining)
            else
                call TriggerSleepAction(bj_POLLED_WAIT_INTERVAL)
            endif
        endloop
        call DestroyTimer(t)
    endif
    set t=null
endfunction

function YDWESetUnitFacingToFaceLocTimedNull takes unit whichUnit,location target,real duration returns nothing
    local location unitLoc=GetUnitLoc(whichUnit)
    call SetUnitFacingTimed(whichUnit,AngleBetweenPoints(unitLoc,target),duration)
    call RemoveLocation(unitLoc)
    set unitLoc=null
endfunction

function YDWETriggerRegisterEnterRectSimpleNull takes trigger trig,rect r returns event
    local region rectRegion=CreateRegion()
    call RegionAddRect(rectRegion,r)
    set udg_yd_NullTempRegion=rectRegion
    set rectRegion=null
    return TriggerRegisterEnterRegion(trig,udg_yd_NullTempRegion,null)
endfunction

function YDWEUnitHasItemOfTypeBJNull takes unit whichUnit,integer itemId returns boolean
    local integer index=0
    if itemId!=0 then
        loop
            if GetItemTypeId(UnitItemInSlot(whichUnit,index))==itemId then
                return true
            endif
            set index=index+1
        exitwhen index>=bj_MAX_INVENTORY
        endloop
    endif
    return false
endfunction

function bjf takes real x,real y,real x2,real y2 returns real
    return bj_RADTODEG*Atan2(y2-y,x2-x)
endfunction

function u2pf takes unit u,real x2,real y2 returns real
    return bjf(GetUnitX(u),GetUnitY(u),x2,y2)
endfunction

function u2uf takes unit u,unit tu returns real
    return bjf(GetUnitX(u),GetUnitY(u),GetUnitX(tu),GetUnitY(tu))
endfunction

function p2pd takes real x,real y,real x2,real y2 returns real
    return SquareRoot((y-y2)*(y-y2)+(x-x2)*(x-x2))
endfunction

function u2ud takes unit u,unit tu returns real
    return p2pd(GetUnitX(u),GetUnitY(u),GetUnitX(tu),GetUnitY(tu))
endfunction

function u2pd takes unit u,real x2,real y2 returns real
    return p2pd(GetUnitX(u),GetUnitY(u),x2,y2)
endfunction

function Near__GNG takes nothing returns nothing
    set udg_Near__D=u2pd(GetEnumUnit(),udg_Near__X,udg_Near__Y)
    if udg_Near__D<udg_Near__L then
        set udg_Near__L=udg_Near__D
        set udg_Near__U=GetEnumUnit()
    endif
endfunction

function Near_Get takes group g,real x,real y returns unit
    set udg_Near__X=x
    set udg_Near__Y=y
    set udg_Near__U=null
    set udg_Near__L=9999
    call ForGroup(g,function Near__GNG)
    return udg_Near__U
endfunction

function YDWEEnumDestructablesInCircleBJNull takes real radius,location loc,code actionFunc returns nothing
    local rect r
    local real centerX=GetLocationX(loc)
    local real centerY=GetLocationY(loc)
    if radius>=0 then
        set bj_enumDestructableCenter=loc
        set bj_enumDestructableRadius=radius
        set r=Rect(centerX-radius,centerY-radius,centerX+radius,centerY+radius)
        call EnumDestructablesInRect(r,Filter(function YDWEEnumDestructablesInCircleBJFilterNull),actionFunc)
        call RemoveRect(r)
        set r=null
    endif
endfunction

function YDWEGetUnitsInRangeOfLocAllNull takes real radius,location whichLocation returns group
    return YDWEGetUnitsInRangeOfLocMatchingNull(radius,whichLocation,null)
endfunction

function YDWESetUnitFacingToFaceUnitTimedNull takes unit whichUnit,unit target,real duration returns nothing
    local location unitLoc=GetUnitLoc(target)
    call YDWESetUnitFacingToFaceLocTimedNull(whichUnit,unitLoc,duration)
    call RemoveLocation(unitLoc)
    set unitLoc=null
endfunction

function Budu__spellaction takes nothing returns nothing
    local unit u=GetTriggerUnit()
    local unit tu=GetSpellTargetUnit()
    local real x=GetSpellTargetX()
    local real y=GetSpellTargetY()
    local integer id=GetSpellAbilityId()
    local integer a=GetUnitAbilityLevel(u,id)
    if id=='A1IO' then
        if tu!=null then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl",GetUnitX(u),GetUnitY(u)))
            call SetUnitX(u,GetUnitX(tu))
            call SetUnitY(u,GetUnitY(tu))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl",GetUnitX(u),GetUnitY(u)))
            call KillUnit(tu)
        else
        endif
    else
        set tu=CreateUnit(GetOwningPlayer(u),'o01E',GetUnitX(u),GetUnitY(u),GetUnitFacing(u))
        call UnitApplyTimedLife(tu,'BHwe',12)
    endif
    if id=='A000' then
        set udg_Budu__b=false
        call GroupEnumUnitsInRange(udg_Budu__g,GetUnitX(u),GetUnitY(u),275+32,null)
        loop
            set tu=FirstOfGroup(udg_Budu__g)
        exitwhen tu==null
            call GroupRemoveUnit(udg_Budu__g,tu)
            if IsUnitEnemy(tu,GetOwningPlayer(u)) and tu!=null and IsUnitType(tu,UNIT_TYPE_DEAD)==false then
            endif
            if GetUnitAbilityLevel(tu,'Aher')>0 then
                set udg_Budu__b=true
            endif
        endloop
        if udg_Budu__b then
            call UnitAddAbility(u,'A006')
            call UnitRemoveAbility(u,'A006')
        endif
    endif
    set u=null
    set tu=null
endfunction

function Budu__orderaction takes nothing returns nothing
    local unit u=GetTriggerUnit()
    local unit tu=GetOrderTargetUnit()
    if GetIssuedOrderId()==OrderId("smart") and GetOwningPlayer(tu)==GetOwningPlayer(u) and GetUnitTypeId(tu)=='osp1' then
        call IssueTargetOrder(u,"acidbomb",tu)
    endif
    set u=null
    set tu=null
endfunction

function Budu_reg takes unit u returns nothing
    set udg_Budu__tg=CreateTrigger()
    call TriggerRegisterUnitEvent(udg_Budu__tg,u,EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddAction(udg_Budu__tg,function Budu__spellaction)
    set udg_Budu__tg=CreateTrigger()
    call TriggerRegisterUnitEvent(udg_Budu__tg,u,EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddAction(udg_Budu__tg,function Budu__orderaction)
endfunction

function Trig_Command_Damage_Actions takes nothing returns nothing
    local player p=GetTriggerPlayer()
    local integer i=GetPlayerId(p)*udg_STATS_OFFSET
    local real dmg_taken=udg_Stats_Damage[i+udg_STATS_DT_ABS]+udg_Stats_Damage[i+udg_STATS_DT_MAGIC]+udg_Stats_Damage[i+udg_STATS_DT_PHYS]
    local real dmg_abs=udg_Stats_Damage[i+udg_STATS_DD_HERO_ABS]+udg_Stats_Damage[i+udg_STATS_DD_UNIT_ABS]+udg_Stats_Damage[i+udg_STATS_DD_BLD_ABS]
    local real dmg_magic=udg_Stats_Damage[i+udg_STATS_DD_HERO_MAGIC]+udg_Stats_Damage[i+udg_STATS_DD_UNIT_MAGIC]+udg_Stats_Damage[i+udg_STATS_DD_BLD_MAGIC]
    local real dmg_phys=udg_Stats_Damage[i+udg_STATS_DD_HERO_PHYS]+udg_Stats_Damage[i+udg_STATS_DD_UNIT_PHYS]+udg_Stats_Damage[i+udg_STATS_DD_BLD_PHYS]
    local real dmg_heroes=udg_Stats_Damage[i+udg_STATS_DD_HERO_ABS]+udg_Stats_Damage[i+udg_STATS_DD_HERO_MAGIC]+udg_Stats_Damage[i+udg_STATS_DD_HERO_PHYS]
    local real dmg_units=udg_Stats_Damage[i+udg_STATS_DD_UNIT_ABS]+udg_Stats_Damage[i+udg_STATS_DD_UNIT_MAGIC]+udg_Stats_Damage[i+udg_STATS_DD_UNIT_PHYS]
    local real dmg_builds=udg_Stats_Damage[i+udg_STATS_DD_BLD_ABS]+udg_Stats_Damage[i+udg_STATS_DD_BLD_MAGIC]+udg_Stats_Damage[i+udg_STATS_DD_BLD_PHYS]
    local real dmg_total=dmg_heroes+dmg_units+dmg_builds
    local string c_abs="|cffffff99"
    local string c_magic="|cff9999ff"
    local string c_phys="|cffff9999"
    call DisplayTextToPlayer(p,0,0,"Damage dealt: TRUE | MAGICAL | PHYSICAL | TOTAL")
    call DisplayTextToPlayer(p,0,0,"To heroes: "+c_abs+R2S(udg_Stats_Damage[i+udg_STATS_DD_HERO_ABS])+"|r | "+c_magic+R2S(udg_Stats_Damage[i+udg_STATS_DD_HERO_MAGIC])+"|r | "+c_phys+R2S(udg_Stats_Damage[i+udg_STATS_DD_HERO_PHYS])+"|r | "+R2S(dmg_heroes))
    call DisplayTextToPlayer(p,0,0,"To units: "+c_abs+R2S(udg_Stats_Damage[i+udg_STATS_DD_UNIT_ABS])+"|r | "+c_magic+R2S(udg_Stats_Damage[i+udg_STATS_DD_UNIT_MAGIC])+"|r | "+c_phys+R2S(udg_Stats_Damage[i+udg_STATS_DD_UNIT_PHYS])+"|r | "+R2S(dmg_units))
    call DisplayTextToPlayer(p,0,0,"To buildings: "+c_abs+R2S(udg_Stats_Damage[i+udg_STATS_DD_BLD_ABS])+"|r | "+c_magic+R2S(udg_Stats_Damage[i+udg_STATS_DD_BLD_MAGIC])+"|r | "+c_phys+R2S(udg_Stats_Damage[i+udg_STATS_DD_BLD_PHYS])+"|r | "+R2S(dmg_builds))
    call DisplayTextToPlayer(p,0,0,"Total damage: "+c_abs+R2S(dmg_abs)+"|r | "+c_magic+R2S(dmg_magic)+"|r | "+c_phys+R2S(dmg_phys)+"|r | "+R2S(dmg_total))
    call DisplayTextToPlayer(p,0,0,"------------")
    call DisplayTextToPlayer(p,0,0,"Damage taken: "+c_abs+R2S(udg_Stats_Damage[i+udg_STATS_DT_ABS])+"|r | "+c_magic+R2S(udg_Stats_Damage[i+udg_STATS_DT_MAGIC])+"|r | "+c_phys+R2S(udg_Stats_Damage[i+udg_STATS_DT_PHYS])+"|r | "+R2S(dmg_taken))
endfunction

function InitTrig_Command_Damage takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(tr,Player(0),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(1),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(2),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(3),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(4),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(6),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(7),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(8),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(9),"-dmg",true)
    call TriggerRegisterPlayerChatEvent(tr,Player(10),"-dmg",true)
    call TriggerAddAction(tr,function Trig_Command_Damage_Actions)
endfunction

function Stat_Init takes nothing returns nothing
    local integer i=0
    loop
        set udg_Stats_Damage[i]=0
        set i=i+1
    exitwhen i==udg_STATS_OFFSET*16
    endloop
    call InitTrig_Command_Damage()
    call DisplayTextToPlayer(GetLocalPlayer(),0,0,"Debug: use -dmg to show damage dealt/taken")
endfunction

function Stat_AddDamage takes unit caster,unit target,real damage,integer dmgtype returns nothing
    local integer player_c=GetPlayerId(GetOwningPlayer(caster))
    local integer player_t=GetPlayerId(GetOwningPlayer(target))
    local integer arrayid=0
    local integer arrayid2=0
    if damage==0. then
        return
    endif
    if player_c==5 or player_c==11 and player_t==5 or player_t==11 then
        return
    endif
    if dmgtype==udg_STATS_DTYPE_ABS then
        if IsUnitType(target,UNIT_TYPE_STRUCTURE) then
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_BLD_ABS
        elseif IsUnitType(target,UNIT_TYPE_HERO) then
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_HERO_ABS
        else
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_UNIT_ABS
        endif
        set arrayid2=player_t*udg_STATS_OFFSET+udg_STATS_DT_ABS
    elseif dmgtype==udg_STATS_DTYPE_MAGIC then
        if IsUnitType(target,UNIT_TYPE_STRUCTURE) then
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_BLD_MAGIC
        elseif IsUnitType(target,UNIT_TYPE_HERO) then
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_HERO_MAGIC
        else
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_UNIT_MAGIC
        endif
        set arrayid2=player_t*udg_STATS_OFFSET+udg_STATS_DT_MAGIC
    elseif dmgtype==udg_STATS_DTYPE_PHYS then
        if IsUnitType(target,UNIT_TYPE_STRUCTURE) then
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_BLD_PHYS
        elseif IsUnitType(target,UNIT_TYPE_HERO) then
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_HERO_PHYS
        else
            set arrayid=player_c*udg_STATS_OFFSET+udg_STATS_DD_UNIT_PHYS
        endif
        set arrayid2=player_t*udg_STATS_OFFSET+udg_STATS_DT_PHYS
    endif
    set udg_Stats_Damage[arrayid]=udg_Stats_Damage[arrayid]+damage
    set udg_Stats_Damage[arrayid2]=udg_Stats_Damage[arrayid2]+damage
endfunction

function Return_True takes nothing returns boolean
    return true
endfunction

function DebugMsg takes string msg returns nothing
    if udg_DebugMode then
        call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,5.,msg)
    endif
endfunction

function FirstAbilityInit takes integer abid returns nothing
    call UnitAddAbility(gg_unit_h00D_0013,abid)
    call UnitRemoveAbility(gg_unit_h00D_0013,abid)
endfunction

function CountOnlineTeam takes nothing returns nothing
    if GetPlayerSlotState(GetEnumPlayer())==PLAYER_SLOT_STATE_PLAYING then
        if IsPlayerInForce(GetEnumPlayer(),udg_TeamA) then
            set udg_GameSurrenderTeamValue[3]=udg_GameSurrenderTeamValue[3]+1
        elseif IsPlayerInForce(GetEnumPlayer(),udg_TeamB) then
            set udg_GameSurrenderTeamValue[4]=udg_GameSurrenderTeamValue[4]+1
        endif
    endif
endfunction

function CE_Input takes unit h,unit v,real amount returns nothing
    local integer A=GetPlayerId(GetOwningPlayer(h))
    local integer B=GetPlayerId(GetOwningPlayer(v))
    local integer offset=512+B*16+A
    set udg_CE_Response[offset]=udg_CE_Response[offset]+amount
endfunction

function CE_Set takes unit h,unit v,real amount returns nothing
    local integer A=GetPlayerId(GetOwningPlayer(h))
    local integer B=GetPlayerId(GetOwningPlayer(v))
    local integer offset=B*16+A
    set udg_CE_Response[offset]=udg_CE_Response[offset]+amount
endfunction

function IsDayTime takes nothing returns boolean
    return GetFloatGameState(GAME_STATE_TIME_OF_DAY)>=6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY)<18
endfunction

function InitSlight takes unit u returns nothing
    call UnitAddAbility(u,'A1F3')
    call UnitAddAbility(u,'A1F4')
    call SetUnitAbilityLevel(u,'A1F3',10)
    call SetUnitAbilityLevel(u,'A1F4',10)
endfunction

function GetUnitExtraSlight takes unit u returns integer
    local integer ret=0
    if GetUnitAbilityLevel(u,'A1F3')>0 then
        set ret=ret+(GetUnitAbilityLevel(u,'A1F3')-10)*10
    endif
    if GetUnitAbilityLevel(u,'A1F4')>0 then
        set ret=ret+(GetUnitAbilityLevel(u,'A1F4')-10)*100
    endif
    return ret
endfunction

function GetUnitSlight takes unit u returns integer
    local integer ret
    if GetFloatGameState(GAME_STATE_TIME_OF_DAY)>=6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY)<18 then
        set ret=1050
    else
        set ret=700
    endif
    if false and GetUnitAbilityLevel(u,'A0VW')>0 then
        set ret=ret-470
    endif
    set ret=ret+GetUnitExtraSlight(u)
    return ret
endfunction

function SetUnitExtraSlight takes unit u,integer value returns nothing
    local integer v=value
    local integer v2=value
    set v=v/100
    set v2=v2/10
    set v2=v2-v*10
    loop
    exitwhen v>-10 and v<10
        if v<-10 then
            set v=v+10
        else
            set v=v-10
        endif
    endloop
    if GetUnitAbilityLevel(u,'A1F4')==0 then
        call InitSlight(u)
    endif
    call SetUnitAbilityLevel(u,'A1F4',v+10)
    call SetUnitAbilityLevel(u,'A1F3',v2+10)
endfunction

function UnitAddSlight takes unit u,integer value returns nothing
    local integer s=GetUnitExtraSlight(u)
    set s=s+value
    call SetUnitExtraSlight(u,s)
endfunction

function GetTimerData takes timer t returns integer
    return LoadInteger(udg_TimerSys,GetHandleId(t),0)
endfunction

function SetTimerData takes timer t,integer i returns nothing
    call SaveInteger(udg_TimerSys,GetHandleId(t),0,i)
endfunction

function NewTimer takes nothing returns timer
    return CreateTimer()
endfunction

function ReleaseTimer takes timer t returns nothing
    call PauseTimer(t)
    call DestroyTimer(t)
endfunction

function GetGroupData takes group g returns integer
    return LoadInteger(udg_GroupSys,GetHandleId(g),0)
endfunction

function SetGroupData takes group g,integer i returns nothing
    call SaveInteger(udg_GroupSys,GetHandleId(g),0,i)
endfunction

function NewGroup takes nothing returns group
    return CreateGroup()
endfunction

function ReleaseGroup takes group g returns nothing
    call DestroyGroup(g)
endfunction

function NewDummy takes player p,real x,real y,real a returns unit
    local integer i=GetPlayerId(p)
    if FirstOfGroup(udg_DummyCastersLeft[i])==null then
        set bj_lastCreatedUnit=CreateUnit(p,'e02U',x,y,0)
        call GroupAddUnit(udg_DummyCastersAll[i],bj_lastCreatedUnit)
    else
        set bj_lastCreatedUnit=FirstOfGroup(udg_DummyCastersLeft[i])
        call GroupRemoveUnit(udg_DummyCastersLeft[i],bj_lastCreatedUnit)
        call SetUnitX(bj_lastCreatedUnit,x)
        call SetUnitY(bj_lastCreatedUnit,y)
    endif
    return bj_lastCreatedUnit
endfunction

function ReAddDummy takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit u=LoadUnitHandle(udg_ht,GetHandleId(t),0)
    call GroupAddUnit(udg_DummyCastersLeft[GetPlayerId(GetOwningPlayer(u))],u)
    call SetUnitX(u,-5344.)
    call SetUnitY(u,-3968.)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht,GetHandleId(t))
    set t=null
    set u=null
endfunction

function ReleaseDummy takes unit u returns nothing
    local timer t
    if IsUnitInGroup(u,udg_DummyCastersAll[GetPlayerId(GetOwningPlayer(u))]) then
        set t=CreateTimer()
        call SaveUnitHandle(udg_ht,GetHandleId(t),0,u)
        call TimerStart(t,5.,false,function ReAddDummy)
    else
        call ShowUnit(u,false)
        call SetUnitExploded(u,true)
        call KillUnit(u)
    endif
    set t=null
endfunction

function NewSpecialDummy takes player p,real x,real y,real a returns unit
    local integer i=GetPlayerId(p)
    if FirstOfGroup(udg_SpecialDummyCastersLeft[i])==null then
        set bj_lastCreatedUnit=CreateUnit(p,'e02X',x,y,0)
        call GroupAddUnit(udg_SpecialDummyCastersAll[i],bj_lastCreatedUnit)
    else
        set bj_lastCreatedUnit=FirstOfGroup(udg_SpecialDummyCastersLeft[i])
        call GroupRemoveUnit(udg_SpecialDummyCastersLeft[i],bj_lastCreatedUnit)
        call SetUnitX(bj_lastCreatedUnit,x)
        call SetUnitY(bj_lastCreatedUnit,y)
        call SetUnitFacing(bj_lastCreatedUnit,a)
    endif
    return bj_lastCreatedUnit
endfunction

function ReAddSpecialDummy takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit u=LoadUnitHandle(udg_ht,GetHandleId(t),0)
    call GroupAddUnit(udg_SpecialDummyCastersLeft[GetPlayerId(GetOwningPlayer(u))],u)
    call SetUnitX(u,-5344.)
    call SetUnitY(u,-3968.)
    call SetUnitFacing(u,0.)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht,GetHandleId(t))
    set t=null
    set u=null
endfunction

function ReleaseSpecialDummy takes unit u returns nothing
    local timer t
    if IsUnitInGroup(u,udg_SpecialDummyCastersAll[GetPlayerId(GetOwningPlayer(u))]) then
        set t=CreateTimer()
        call SaveUnitHandle(udg_ht,GetHandleId(t),0,u)
        call TimerStart(t,5.,false,function ReAddSpecialDummy)
    else
        call ShowUnit(u,false)
        call SetUnitExploded(u,true)
        call KillUnit(u)
    endif
    set t=null
endfunction

function NewVisionDummy takes player p,real x,real y,real a returns unit
    local integer i=GetPlayerId(p)
    if FirstOfGroup(udg_SpecialDummyCastersLeft[i])==null then
        set bj_lastCreatedUnit=CreateUnit(p,'e035',x,y,0)
        call GroupAddUnit(udg_DummyVisionCastersAll[i],bj_lastCreatedUnit)
    else
        set bj_lastCreatedUnit=FirstOfGroup(udg_DummyVisionCastersLeft[i])
        call GroupRemoveUnit(udg_DummyVisionCastersLeft[i],bj_lastCreatedUnit)
        call SetUnitX(bj_lastCreatedUnit,x)
        call SetUnitY(bj_lastCreatedUnit,y)
        call SetUnitFacing(bj_lastCreatedUnit,a)
    endif
    return bj_lastCreatedUnit
endfunction

function ReAddVisionDummy takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit u=LoadUnitHandle(udg_ht,GetHandleId(t),0)
    call GroupAddUnit(udg_DummyVisionCastersLeft[GetPlayerId(GetOwningPlayer(u))],u)
    call SetUnitX(u,-5344.)
    call SetUnitY(u,-3968.)
    call SetUnitFacing(u,0.)
    call UnitRemoveAbility(u,'Aloc')
    call ShowUnit(u,true)
    call UnitAddAbility(u,'Aloc')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht,GetHandleId(t))
    set t=null
    set u=null
endfunction

function ReleaseVisionDummy takes unit u returns nothing
    if IsUnitInGroup(u,udg_DummyVisionCastersAll[GetPlayerId(GetOwningPlayer(u))]) then
        call ShowUnit(u,false)
        call GroupAddUnit(udg_DummyVisionCastersLeft[GetPlayerId(GetOwningPlayer(u))],u)
        call SetUnitX(u,-5344.)
        call SetUnitY(u,-3968.)
        call SetUnitFacing(u,0.)
        call UnitRemoveAbility(u,'Aloc')
        call ShowUnit(u,true)
        call UnitAddAbility(u,'Aloc')
    else
        call ShowUnit(u,false)
        call SetUnitExploded(u,true)
        call KillUnit(u)
    endif
endfunction

function InitCasters takes nothing returns nothing
    local integer i=0
    loop
    exitwhen i>11
        set udg_Caster[i]=CreateUnit(Player(i),'e02U',-5344.,-3968.,0.)
        set i=i+1
    endloop
endfunction

function TimerSysInit takes nothing returns nothing
    local integer i=0
    loop
    exitwhen i>udg_TimerIndex
        call SaveInteger(udg_TimerSys,GetHandleId(udg_Timers[i]),0,31415927)
        set i=i+1
    endloop
endfunction

function GroupSysInit takes nothing returns nothing
    local integer i=0
    loop
    exitwhen i>udg_GroupIndex
        call SaveInteger(udg_GroupSys,GetHandleId(udg_Groups[i]),0,31415927)
        set i=i+1
    endloop
endfunction

function TimedLightningClear takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local lightning e=LoadLightningHandle(udg_ht,task,0)
    local real timeleft=LoadReal(udg_ht,task,0)
    local real fadetime=LoadReal(udg_ht,task,1)
    local real r=LoadReal(udg_ht,task,2)
    local real g=LoadReal(udg_ht,task,3)
    local real b=LoadReal(udg_ht,task,4)
    if timeleft>=0 then
        call SetLightningColor(e,r,g,b,timeleft/fadetime)
        set timeleft=timeleft-.05
        call SaveReal(udg_ht,task,0,timeleft)
    else
        call DestroyLightning(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht,task)
    endif
    set t=null
    set e=null
endfunction

function TimedLightning takes lightning e,real fadetime returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local real r=GetLightningColorR(e)
    local real g=GetLightningColorG(e)
    local real b=GetLightningColorB(e)
    call SaveLightningHandle(udg_ht,task,0,e)
    call SaveReal(udg_ht,task,0,fadetime)
    call SaveReal(udg_ht,task,1,fadetime)
    call SaveReal(udg_ht,task,2,r)
    call SaveReal(udg_ht,task,3,g)
    call SaveReal(udg_ht,task,4,b)
    call TimerStart(t,.05,true,function TimedLightningClear)
    set t=null
endfunction

function TimedEffectClear takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local effect e=LoadEffectHandle(udg_ht,task,0)
    call DestroyEffect(e)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht,task)
    set t=null
    set e=null
endfunction

function AddTimedEffectToUnit takes unit u,real duration,string fx,string pt returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local effect e=AddSpecialEffectTarget(fx,u,pt)
    call SaveEffectHandle(udg_ht,task,0,e)
    call TimerStart(t,duration,false,function TimedEffectClear)
    set t=null
    set e=null
endfunction

function AddTimedEffectToPoint takes real x,real y,real duration,string es returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local effect e=AddSpecialEffect(es,x,y)
    call SaveEffectHandle(udg_ht,task,0,e)
    call TimerStart(t,duration,false,function TimedEffectClear)
    set t=null
    set e=null
endfunction

function TimedAbilityClear takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit u=LoadUnitHandle(udg_ht,task,0)
    local integer abid=LoadInteger(udg_ht,task,0)
    call UnitRemoveAbility(u,abid)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht,task)
    call DebugMsg("Ability Cleared")
    set t=null
    set u=null
endfunction

function AddTimedAbilityToUnit takes unit u,integer abid,integer level,real duration returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    call UnitAddAbility(u,abid)
    if level>1 then
        call SetUnitAbilityLevel(u,abid,level)
    endif
    call UnitMakeAbilityPermanent(u,true,abid)
    call SaveUnitHandle(udg_ht,task,0,u)
    call SaveInteger(udg_ht,task,0,abid)
    call TimerStart(t,duration,false,function TimedAbilityClear)
    call DebugMsg("Ability Level Set To "+I2S(GetUnitAbilityLevel(u,abid)))
    set t=null
endfunction

function ClearUnitFromTarget takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local real timeleft=LoadReal(udg_ht,task,0)
    local unit u=LoadUnitHandle(udg_ht,task,0)
    local unit target=LoadUnitHandle(udg_ht,task,1)
    local boolean killondeath=LoadBoolean(udg_ht,task,2)
    local boolean killonexpire=LoadBoolean(udg_ht,task,3)
    local boolean playdeathanim=LoadBoolean(udg_ht,task,4)
    if timeleft>0 then
        set timeleft=timeleft-.02
        call SaveReal(udg_ht,task,0,timeleft)
        call SetUnitX(u,GetUnitX(target))
        call SetUnitY(u,GetUnitY(target))
        if GetWidgetLife(target)<.405 or IsUnitType(target,UNIT_TYPE_DEAD) and killondeath then
            if playdeathanim then
                call KillUnit(u)
            else
                call RemoveUnit(u)
            endif
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht,task)
        endif
    else
        call ReleaseTimer(t)
        if killonexpire then
            if playdeathanim then
                call KillUnit(u)
            else
                call RemoveUnit(u)
            endif
        endif
        call FlushChildHashtable(udg_ht,task)
    endif
    set t=null
    set u=null
    set target=null
endfunction

function AttachUnitToTarget takes unit u,unit target,real duration,boolean killondeath,boolean killonexpire,boolean playdeathanim returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    call SaveReal(udg_ht,task,0,duration-.02)
    call SaveUnitHandle(udg_ht,task,0,u)
    call SaveUnitHandle(udg_ht,task,1,target)
    call SaveBoolean(udg_ht,task,2,killondeath)
    call SaveBoolean(udg_ht,task,3,killonexpire)
    call SaveBoolean(udg_ht,task,4,playdeathanim)
    call SetUnitX(u,GetUnitX(target))
    call SetUnitY(u,GetUnitY(target))
    call TimerStart(t,.02,true,function ClearUnitFromTarget)
    set t=null
endfunction

function KB_TREE_DETECTION_RANGE takes nothing returns real
    return 84.
endfunction

function KB_UNIT_DETECTION_RANGE takes nothing returns real
    return 75.
endfunction

function Knockback_UnitFilter takes nothing returns boolean
    local unit u=GetFilterUnit()
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    if u!=LoadUnitHandle(udg_ht,task,0) and u!=LoadUnitHandle(udg_ht,task,1) then
        if GetWidgetLife(u)>.405 and GetUnitAbilityLevel(u,'Aloc')==0 and not IsUnitType(u,UNIT_TYPE_STRUCTURE) and not IsUnitType(u,UNIT_TYPE_ANCIENT) and not IsUnitType(u,UNIT_TYPE_DEAD) then
            set u=null
            set t=null
            return true
        endif
    endif
    set u=null
    set t=null
    return false
endfunction

function Knockback_KillTree takes nothing returns nothing
    local destructable d=GetEnumDestructable()
    call KillDestructable(d)
    set d=null
endfunction

function Knockback_TreeFilter takes nothing returns boolean
    local destructable d1=GetFilterDestructable()
    local integer d=GetDestructableTypeId(d1)
    if d=='ATtr' or d=='BTtw' or d=='KTtw' or d=='YTft' or d=='JTct' or d=='YTst' or d=='YTct' or d=='YTwt' or d=='JTwt' or d=='JTwt' or d=='FTtw' or d=='CTtr' or d=='ITtw' or d=='NTtw' or d=='OTtw' or d=='ZTtw' or d=='WTst' or d=='LTlt' or d=='GTsh' or d=='Xtlt' or d=='WTtw' or d=='Attc' or d=='BTtc' or d=='CTtc' or d=='ITtc' or d=='NTtc' or d=='ZTtc' then
        set d1=null
        return true
    endif
    set d1=null
    return false
endfunction

function Knockback_TreeCheck takes nothing returns nothing
    local timer t=GetExpiredTimer()
    call SaveBoolean(udg_ht,GetHandleId(t),20,false)
    set t=null
endfunction

function Knockback_UnitCheck takes nothing returns boolean
    local unit u=GetFilterUnit()
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    if GetWidgetLife(u)>.405 and u!=LoadUnitHandle(udg_ht,task,0) and u!=LoadUnitHandle(udg_ht,task,1) and not IsUnitType(u,UNIT_TYPE_DEAD) then
        call SaveBoolean(udg_ht,task,20,false)
    endif
    set u=null
    set t=null
    return false
endfunction

function Knockback_Loop takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit caster=LoadUnitHandle(udg_ht,task,0)
    local unit target=LoadUnitHandle(udg_ht,task,1)
    local real ox=LoadReal(udg_ht,task,2)
    local real oy=LoadReal(udg_ht,task,3)
    local real cx=LoadReal(udg_ht,task,4)
    local real cy=LoadReal(udg_ht,task,5)
    local real distance=LoadReal(udg_ht,task,6)
    local real speed=LoadReal(udg_ht,task,7)
    local real cos=LoadReal(udg_ht,task,8)
    local real sin=LoadReal(udg_ht,task,9)
    local effect e
    local boolean realistic=LoadBoolean(udg_ht,task,11)
    local boolean knockothers=LoadBoolean(udg_ht,task,12)
    local boolean knockfriendly=LoadBoolean(udg_ht,task,13)
    local boolean stopontrees=LoadBoolean(udg_ht,task,14)
    local group g=LoadGroupHandle(udg_ht,task,15)
    local rect r=LoadRectHandle(udg_ht,task,16)
    local boolexpr b=LoadBooleanExprHandle(udg_ht,task,17)
    local boolexpr b1=LoadBooleanExprHandle(udg_ht,task,18)
    local boolexpr b2=LoadBooleanExprHandle(udg_ht,task,19)
    local boolean continue
    local unit v
    local integer i
    if realistic then
        set speed=.94*speed
        call SaveReal(udg_ht,task,7,speed)
    endif
    if stopontrees then
        call EnumDestructablesInRect(r,b,function Knockback_TreeCheck)
    else
        call EnumDestructablesInRect(r,b,function Knockback_KillTree)
    endif
    if knockothers then
        set i=StringHash("Knockback_Secondary")
        call GroupEnumUnitsInRange(g,cx,cy,75.,b1)
        loop
            set v=FirstOfGroup(g)
        exitwhen v==null
            call GroupRemoveUnit(g,v)
            if v!=caster and not IsUnitInGroup(v,udg_KnockedBack) and (IsUnitAlly(v,GetOwningPlayer(caster)) and knockfriendly) or IsUnitEnemy(v,GetOwningPlayer(caster)) then
                call SaveUnitHandle(udg_ht,i,0,target)
                call SaveUnitHandle(udg_ht,i,1,v)
                call SaveReal(udg_ht,i,2,.75*(distance-SquareRoot((cx-ox)*(cx-ox)+(cy-oy)*(cy-oy))))
                call SaveReal(udg_ht,i,3,.5*speed)
                call SaveReal(udg_ht,i,4,Atan2(GetUnitY(v)-GetUnitY(target),GetUnitX(v)-GetUnitX(target)))
                call SaveStr(udg_ht,i,5,LoadStr(udg_ht,task,10))
                call SaveBoolean(udg_ht,i,6,realistic)
                call SaveBoolean(udg_ht,i,7,false)
                call SaveBoolean(udg_ht,i,8,false)
                call SaveBoolean(udg_ht,i,9,stopontrees)
                call ExecuteFunc("Knockback_Secondary")
            endif
        endloop
        call GroupClear(g)
    else
        call GroupEnumUnitsInRange(g,cx+32*75.*cos,cy+32*75.*sin,75.,b2)
        call GroupClear(g)
    endif
    set continue=LoadBoolean(udg_ht,task,20)
    if speed<50. then
        set continue=false
    endif
    if IsUnitInRangeXY(target,ox,oy,distance) then
        set cx=cx+speed*cos
        set cy=cy+speed*sin
        if IsTerrainPathable(cx,cy,PATHING_TYPE_WALKABILITY)==false and continue then
            call SetUnitX(target,cx)
            call SetUnitY(target,cy)
            call SaveReal(udg_ht,task,4,cx)
            call SaveReal(udg_ht,task,5,cy)
            call SetRect(r,cx+32*84.*cos-84.,cy+32*84.*sin-84.,cx+32*84.*cos+84.,cy+32*84.*sin+84.)
            call SaveRectHandle(udg_ht,task,16,r)
        else
            set e=LoadEffectHandle(udg_ht,task,10)
            call PauseUnit(target,false)
            call DestroyEffect(e)
            call SetUnitPathing(target,true)
            call DestroyBoolExpr(b)
            call DestroyBoolExpr(b1)
            call DestroyBoolExpr(b2)
            call RemoveRect(r)
            call GroupRemoveUnit(udg_KnockedBack,target)
            call DestroyGroup(g)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht,task)
        endif
    else
        set e=LoadEffectHandle(udg_ht,task,10)
        call PauseUnit(target,false)
        call DestroyEffect(e)
        call SetUnitPathing(target,true)
        call DestroyBoolExpr(b)
        call DestroyBoolExpr(b1)
        call DestroyBoolExpr(b2)
        call RemoveRect(r)
        call GroupRemoveUnit(udg_KnockedBack,target)
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht,task)
    endif
    set b=null
    set b1=null
    set b2=null
    set caster=null
    set target=null
    set e=null
    set g=null
    set v=null
    set r=null
    set t=null
endfunction

function Knockback takes unit caster,unit target,real distance,real speed,real angle,string e,boolean realistic,boolean knockothers,boolean knockfriendly,boolean stopontrees returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local real ox=GetUnitX(target)
    local real oy=GetUnitY(target)
    local group g=CreateGroup()
    local rect r=Rect(ox-84.,oy-84.,ox+84.,oy+84.)
    local boolexpr b=Filter(function Knockback_TreeFilter)
    local boolexpr b1=Filter(function Knockback_UnitFilter)
    local boolexpr b2=Filter(function Knockback_UnitCheck)
    local effect e1
    call SaveUnitHandle(udg_ht,task,0,caster)
    call SaveUnitHandle(udg_ht,task,1,target)
    call SaveReal(udg_ht,task,2,ox)
    call SaveReal(udg_ht,task,3,oy)
    call SaveReal(udg_ht,task,4,ox)
    call SaveReal(udg_ht,task,5,oy)
    call SaveReal(udg_ht,task,6,distance)
    if realistic then
        call SaveReal(udg_ht,task,7,2.75*speed)
    else
        call SaveReal(udg_ht,task,7,speed)
    endif
    call SaveReal(udg_ht,task,8,.03125*Cos(angle))
    call SaveReal(udg_ht,task,9,.03125*Sin(angle))
    call SaveStr(udg_ht,task,10,e)
    if e!="" then
        set e1=AddSpecialEffectTarget(e,target,"origin")
        call SaveEffectHandle(udg_ht,task,10,e1)
    endif
    call SaveBoolean(udg_ht,task,11,realistic)
    call SaveBoolean(udg_ht,task,12,knockothers)
    call SaveBoolean(udg_ht,task,13,knockfriendly)
    call SaveBoolean(udg_ht,task,14,stopontrees)
    call SaveGroupHandle(udg_ht,task,15,g)
    call SaveRectHandle(udg_ht,task,16,r)
    call SaveBooleanExprHandle(udg_ht,task,17,b)
    call SaveBooleanExprHandle(udg_ht,task,18,b1)
    call SaveBooleanExprHandle(udg_ht,task,19,b2)
    call SaveBoolean(udg_ht,task,20,true)
    call SetUnitPosition(target,ox,oy)
    call SetUnitPathing(target,false)
    call PauseUnit(target,true)
    call GroupAddUnit(udg_KnockedBack,target)
    call TimerStart(t,.03125,true,function Knockback_Loop)
    set t=null
    set g=null
    set b=null
    set b1=null
    set b2=null
    set r=null
    set e1=null
endfunction

function Knockback_Secondary takes nothing returns nothing
    local integer task=StringHash("Knockback_Secondary")
    local unit caster=LoadUnitHandle(udg_ht,task,0)
    local unit target=LoadUnitHandle(udg_ht,task,1)
    local real distance=LoadReal(udg_ht,task,2)
    local real speed=LoadReal(udg_ht,task,3)
    local real angle=LoadReal(udg_ht,task,4)
    local string e=LoadStr(udg_ht,task,5)
    local boolean realistic=LoadBoolean(udg_ht,task,6)
    local boolean knockothers=LoadBoolean(udg_ht,task,7)
    local boolean knockfriendly=LoadBoolean(udg_ht,task,8)
    local boolean stopontrees=LoadBoolean(udg_ht,task,9)
    call Knockback(caster,target,distance,speed,angle,e,realistic,knockothers,knockfriendly,stopontrees)
    call FlushChildHashtable(udg_ht,task)
    set caster=null
    set target=null
    set e=null
endfunction

function GroupEnumUnitsInSector takes group whichGroup,real xc,real yc,real f,real r,real a,boolexpr filter returns nothing
    local group g=CreateGroup()
    local unit u
    local real x
    local real y
    local real x1
    local real y1
    local real x2
    local real y2
    call GroupClear(whichGroup)
    call GroupEnumUnitsInRange(g,xc,yc,r,filter)
    set a=a*.008727
    set f=f*.017454
    set x1=Cos(f-a)
    set y1=Sin(f-a)
    set x2=Cos(f+a)
    set y2=Sin(f+a)
    loop
        set u=FirstOfGroup(g)
    exitwhen u==null
        call GroupRemoveUnit(g,u)
        set x=GetUnitX(u)-xc
        set y=GetUnitY(u)-yc
        if y*x1>=x*y1 and y*x2<=x*y2 then
            call GroupAddUnit(whichGroup,u)
        endif
    endloop
    call DestroyGroup(g)
    set g=null
endfunction

function GroupEnumUnitsInLine takes group g,real ox,real oy,real tx,real ty,real width,boolexpr f returns nothing
    local integer i=1
    local real a=Atan2(ty-oy,tx-ox)
    local real d=(tx-ox)*(tx-ox)+(ty-oy)*(ty-oy)
    local real r=.5*width
    local real dx=r*Cos(a)
    local real dy=r*Sin(a)
    local real x
    local real y
    local group tmpgrp=CreateGroup()
    local unit u
    call GroupClear(g)
    loop
        set x=ox+i*dx
        set y=oy+i*dy
        call GroupEnumUnitsInRange(tmpgrp,x,y,r,f)
        loop
            set u=FirstOfGroup(tmpgrp)
        exitwhen u==null
            call GroupRemoveUnit(tmpgrp,u)
            call GroupAddUnit(g,u)
        endloop
        set i=i+1
    exitwhen x*x+y*y>=d
    endloop
    call DestroyGroup(tmpgrp)
    set u=null
    set tmpgrp=null
endfunction

function GroupEnumUnitsInRectangle takes group g,real ox,real oy,real ux,real uy,real rx,real ry,boolexpr f returns nothing
    local real mx=.5*(ux+rx)
    local real my=.5*(uy+ry)
    local real r=SquareRoot((mx-ox)*(mx-ox)+(my-oy)*(my-oy))
    local group tmpgrp=CreateGroup()
    local unit u
    local real cx
    local real cy
    local real s1
    local real s2
    local real s3
    local real s4
    call GroupClear(g)
    call GroupEnumUnitsInRange(tmpgrp,mx,my,r,f)
    loop
        set u=FirstOfGroup(tmpgrp)
    exitwhen u==null
        call GroupRemoveUnit(tmpgrp,u)
        set cx=GetUnitX(u)
        set cy=GetUnitY(u)
        set s1=(cx-ox)*(ux-ox)+(cy-oy)*(uy-oy)
        set s2=(ux-ox)*(ux-ox)+(uy-oy)*(uy-oy)
        set s3=(cx-ox)*(rx-ox)+(cy-oy)*(ry-oy)
        set s4=(rx-ox)*(rx-ox)+(ry-oy)*(ry-oy)
        if s1>=0 and s1<=s2 and s3>=0 and s3<=s4 then
            call GroupAddUnit(g,u)
        endif
    endloop
    call DestroyGroup(tmpgrp)
    set u=null
    set tmpgrp=null
endfunction

function ProjectileMoveToTarget takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit source
    local unit projectile=LoadUnitHandle(udg_ht,task,1)
    local unit target=LoadUnitHandle(udg_ht,task,2)
    local effect e
    local real d=LoadReal(udg_ht,task,4)
    local real cx=LoadReal(udg_ht,task,5)
    local real cy=LoadReal(udg_ht,task,6)
    local real tx=GetUnitX(target)
    local real ty=GetUnitY(target)
    local real a=Atan2(ty-cy,tx-cx)
    local real dx=d*Cos(a)
    local real dy=d*Sin(a)
    local string func=LoadStr(udg_ht,task,7)
    if IsUnitInRange(projectile,target,d) or GetWidgetLife(target)<.405 then
        set e=LoadEffectHandle(udg_ht,task,3)
        set source=LoadUnitHandle(udg_ht,task,0)
        call DestroyEffect(e)
        call SetUnitScale(projectile,1.,1.,1.)
        call ReleaseDummy(projectile)
        set udg_PS_Source=source
        set udg_PS_Target=target
        if GetWidgetLife(target)>.405 then
            call ExecuteFunc(func)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht,task)
    else
        set cx=cx+dx
        set cy=cy+dy
        call SetUnitFacing(projectile,bj_RADTODEG*a)
        call SetUnitX(projectile,cx)
        call SetUnitY(projectile,cy)
        call SaveReal(udg_ht,task,5,cx)
        call SaveReal(udg_ht,task,6,cy)
    endif
    set t=null
    set func=""
    set e=null
    set source=null
    set projectile=null
    set target=null
endfunction

function LaunchProjectileToUnit takes string model,real scale,unit source,real speed,unit target,string func returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local real ox=GetUnitX(source)
    local real oy=GetUnitY(source)
    local unit u=NewSpecialDummy(GetOwningPlayer(source),ox,oy,GetUnitFacing(source))
    local effect e=AddSpecialEffectTarget(model,u,"origin")
    local real d=speed*.03125
    call SetUnitScale(u,scale,scale,scale)
    call SaveUnitHandle(udg_ht,task,0,source)
    call SaveUnitHandle(udg_ht,task,1,u)
    call SaveUnitHandle(udg_ht,task,2,target)
    call SaveEffectHandle(udg_ht,task,3,e)
    call SaveReal(udg_ht,task,4,d)
    call SaveReal(udg_ht,task,5,ox)
    call SaveReal(udg_ht,task,6,oy)
    call SaveStr(udg_ht,task,7,func)
    call TimerStart(t,.03125,true,function ProjectileMoveToTarget)
    set u=null
    set t=null
    set e=null
endfunction

function LaunchProjectileToUnitEx takes string model,real scale,unit source,real x,real y,real speed,unit target,string func returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local real ox=GetUnitX(source)
    local real oy=GetUnitY(source)
    local unit u=NewSpecialDummy(GetOwningPlayer(source),x,y,GetUnitFacing(source))
    local effect e=AddSpecialEffectTarget(model,u,"origin")
    local real d=speed*.03125
    call SetUnitScale(u,scale,scale,scale)
    call SaveUnitHandle(udg_ht,task,0,source)
    call SaveUnitHandle(udg_ht,task,1,u)
    call SaveUnitHandle(udg_ht,task,2,target)
    call SaveEffectHandle(udg_ht,task,3,e)
    call SaveReal(udg_ht,task,4,d)
    call SaveReal(udg_ht,task,5,x)
    call SaveReal(udg_ht,task,6,y)
    call SaveStr(udg_ht,task,7,func)
    call TimerStart(t,.03125,true,function ProjectileMoveToTarget)
    set u=null
    set t=null
    set e=null
endfunction

function ProjectileMoveToPoint takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit source=LoadUnitHandle(udg_ht,task,0)
    local unit u=LoadUnitHandle(udg_ht,task,1)
    local effect e=LoadEffectHandle(udg_ht,task,2)
    local player sourceplayer=LoadPlayerHandle(udg_ht,task,3)
    local real ox=LoadReal(udg_ht,task,0)
    local real oy=LoadReal(udg_ht,task,1)
    local real d=LoadReal(udg_ht,task,2)
    local real tx=LoadReal(udg_ht,task,3)
    local real ty=LoadReal(udg_ht,task,4)
    local real collisionsize=LoadReal(udg_ht,task,5)
    local string onhitfunc=LoadStr(udg_ht,task,6)
    local string onendfunc=LoadStr(udg_ht,task,7)
    local group g=LoadGroupHandle(udg_ht,task,8)
    local group tmpgrp=LoadGroupHandle(udg_ht,task,9)
    local group controlgrp=LoadGroupHandle(udg_ht,task,10)
    local boolean stoponally=LoadBoolean(udg_ht,task,11)
    local boolean stoponenemy=LoadBoolean(udg_ht,task,12)
    local boolean stoponhero=LoadBoolean(udg_ht,task,13)
    local unit v
    local real a=Atan2(ty-oy,tx-ox)
    local real dx=d*Cos(a)
    local real dy=d*Sin(a)
    local boolean stop=false
    local boolean hasenemy=false
    local boolean hasally=false
    local boolean hashero=false
    local boolean hasallyhero=false
    set ox=ox+dx
    set oy=oy+dy
    call GroupClear(g)
    call GroupEnumUnitsInRange(tmpgrp,ox,oy,collisionsize,null)
    loop
        set v=FirstOfGroup(tmpgrp)
    exitwhen v==null
        call GroupRemoveUnit(tmpgrp,v)
        if v!=source and GetWidgetLife(v)>.405 and not IsUnitInGroup(v,controlgrp) and IsUnitType(v,UNIT_TYPE_STRUCTURE)==false and GetUnitAbilityLevel(v,'Avul')==0 then
            call GroupAddUnit(g,v)
            call GroupAddUnit(controlgrp,v)
            if IsUnitAlly(v,sourceplayer) then
                set hasally=true
            else
                set hasenemy=true
            endif
            if IsUnitType(v,UNIT_TYPE_HERO) then
                if IsUnitAlly(v,sourceplayer) then
                    set hasallyhero=true
                else
                    set hashero=true
                endif
            endif
        endif
    endloop
    if stoponenemy and hasenemy then
        set stop=true
    endif
    if stoponally and hasally then
        set stop=true
    endif
    if stoponhero and (hashero and stoponenemy) or (hasallyhero and stoponally) then
        set stop=true
    endif
    if GetRectMinX(bj_mapInitialPlayableArea)<=ox and ox<=GetRectMaxX(bj_mapInitialPlayableArea) then
        call SetUnitX(u,ox)
    else
        set stop=true
    endif
    if GetRectMinY(bj_mapInitialPlayableArea)<=oy and oy<=GetRectMaxY(bj_mapInitialPlayableArea) then
        call SetUnitY(u,oy)
    else
        set stop=true
    endif
    if IsUnitInRangeXY(u,tx,ty,collisionsize) then
        set stop=true
    endif
    set v=FirstOfGroup(g)
    call SetUnitFacing(u,a)
    if onhitfunc!="" and v!=null then
        set udg_PS_CurrentX=ox
        set udg_PS_CurrentY=oy
        set udg_PS_OnHit_Group=g
        set udg_PS_Source=source
        set udg_PS_Source_Player=sourceplayer
        call ExecuteFunc(onhitfunc)
    endif
    if stop then
        if onendfunc!="" then
            set udg_PS_CurrentX=ox
            set udg_PS_CurrentY=oy
            set udg_PS_OnHit_Group=g
            set udg_PS_Source=source
            set udg_PS_Source_Player=sourceplayer
            call ExecuteFunc(onendfunc)
        endif
        call DestroyEffect(e)
        call SetUnitScale(u,1.,1.,1.)
        call ReleaseSpecialDummy(u)
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call DestroyGroup(tmpgrp)
        call DestroyGroup(controlgrp)
        call FlushChildHashtable(udg_ht,task)
    else
        call SaveReal(udg_ht,task,0,ox)
        call SaveReal(udg_ht,task,1,oy)
    endif
    set u=null
    set g=null
    set tmpgrp=null
    set controlgrp=null
    set t=null
    set e=null
    set source=null
    set sourceplayer=null
    set v=null
    set onhitfunc=""
    set onendfunc=""
endfunction

function LaunchProjectileFromUnitToPoint takes string model,real scale,unit source,real tx,real ty,real speed,real collisionsize,string onhitfunc,string onendfunc,boolean stoponally,boolean stoponenemy,boolean stoponhero returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local real ox=GetUnitX(source)
    local real oy=GetUnitY(source)
    local real a=GetUnitFacing(source)
    local player sourceplayer=GetOwningPlayer(source)
    local unit u=NewSpecialDummy(sourceplayer,ox,oy,a)
    local effect e=AddSpecialEffectTarget(model,u,"origin")
    local real d=speed*.03125
    local group g=CreateGroup()
    local group tmpgrp=CreateGroup()
    local group controlgrp=CreateGroup()
    call SetUnitScale(u,scale,scale,scale)
    call SaveUnitHandle(udg_ht,task,0,source)
    call SaveUnitHandle(udg_ht,task,1,u)
    call SaveEffectHandle(udg_ht,task,2,e)
    call SavePlayerHandle(udg_ht,task,3,sourceplayer)
    call SaveReal(udg_ht,task,0,ox)
    call SaveReal(udg_ht,task,1,oy)
    call SaveReal(udg_ht,task,2,d)
    call SaveReal(udg_ht,task,3,tx)
    call SaveReal(udg_ht,task,4,ty)
    call SaveReal(udg_ht,task,5,collisionsize)
    call SaveStr(udg_ht,task,6,onhitfunc)
    call SaveStr(udg_ht,task,7,onendfunc)
    call SaveGroupHandle(udg_ht,task,8,g)
    call SaveGroupHandle(udg_ht,task,9,tmpgrp)
    call SaveGroupHandle(udg_ht,task,10,controlgrp)
    call SaveBoolean(udg_ht,task,11,stoponally)
    call SaveBoolean(udg_ht,task,12,stoponenemy)
    call SaveBoolean(udg_ht,task,13,stoponhero)
    call TimerStart(t,.03125,true,function ProjectileMoveToPoint)
    set t=null
    set u=null
    set e=null
    set g=null
    set tmpgrp=null
    set controlgrp=null
    set sourceplayer=null
endfunction

function LaunchProjectileFromPointToPoint takes string model,real scale,player sourceplayer,real ox,real oy,real tx,real ty,real speed,real collisionsize,string onhitfunc,string onendfunc,boolean stoponally,boolean stoponenemy,boolean stoponhero returns nothing
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    local real a=57.29578*Atan2(ty-oy,tx-ox)
    local unit u=NewSpecialDummy(sourceplayer,ox,oy,a)
    local effect e=AddSpecialEffectTarget(model,u,"origin")
    local real d=speed*.03125
    local group g=CreateGroup()
    local group tmpgrp=CreateGroup()
    local group controlgrp=CreateGroup()
    call SetUnitScale(u,scale,scale,scale)
    call SaveUnitHandle(udg_ht,task,0,null)
    call SaveUnitHandle(udg_ht,task,1,u)
    call SaveEffectHandle(udg_ht,task,2,e)
    call SavePlayerHandle(udg_ht,task,3,sourceplayer)
    call SaveReal(udg_ht,task,0,ox)
    call SaveReal(udg_ht,task,1,oy)
    call SaveReal(udg_ht,task,2,d)
    call SaveReal(udg_ht,task,3,tx)
    call SaveReal(udg_ht,task,4,ty)
    call SaveReal(udg_ht,task,5,collisionsize)
    call SaveStr(udg_ht,task,6,onhitfunc)
    call SaveStr(udg_ht,task,7,onendfunc)
    call SaveGroupHandle(udg_ht,task,8,g)
    call SaveGroupHandle(udg_ht,task,9,tmpgrp)
    call SaveGroupHandle(udg_ht,task,10,controlgrp)
    call SaveBoolean(udg_ht,task,11,stoponally)
    call SaveBoolean(udg_ht,task,12,stoponenemy)
    call SaveBoolean(udg_ht,task,13,stoponhero)
    call TimerStart(t,.03125,true,function ProjectileMoveToPoint)
    set u=null
    set t=null
    set e=null
    set g=null
    set tmpgrp=null
    set controlgrp=null
endfunction

function Initialize_Bonus takes nothing returns nothing
    local integer i=0
    set udg_BonusStr[0]='A0K2'
    set udg_BonusStr[1]='A0K9'
    set udg_BonusStr[2]='A0K4'
    set udg_BonusStr[3]='A0JZ'
    set udg_BonusStr[4]='A0JY'
    set udg_BonusStr[5]='A0KB'
    set udg_BonusStr[6]='A0K8'
    set udg_BonusStr[7]='A0K5'
    set udg_BonusStr[8]='A0K3'
    set udg_BonusStr[9]='A0KA'
    set udg_BonusStr[10]='A0K6'
    set udg_BonusStr[11]='A0L2'
    set udg_BonusStr[12]='A0K7'
    set udg_BonusAgi[0]='A0L0'
    set udg_BonusAgi[1]='A0KZ'
    set udg_BonusAgi[2]='A0KY'
    set udg_BonusAgi[3]='A0KX'
    set udg_BonusAgi[4]='A0KW'
    set udg_BonusAgi[5]='A0KP'
    set udg_BonusAgi[6]='A0KV'
    set udg_BonusAgi[7]='A0KU'
    set udg_BonusAgi[8]='A0KT'
    set udg_BonusAgi[9]='A0KS'
    set udg_BonusAgi[10]='A0KR'
    set udg_BonusAgi[11]='A0KQ'
    set udg_BonusAgi[12]='A0KO'
    set udg_BonusInt[0]='A0KC'
    set udg_BonusInt[1]='A0KN'
    set udg_BonusInt[2]='A0KM'
    set udg_BonusInt[3]='A0KL'
    set udg_BonusInt[4]='A0KK'
    set udg_BonusInt[5]='A0KJ'
    set udg_BonusInt[6]='A0KD'
    set udg_BonusInt[7]='A0KI'
    set udg_BonusInt[8]='A0KH'
    set udg_BonusInt[9]='A0KG'
    set udg_BonusInt[10]='A0KF'
    set udg_BonusInt[11]='A0KE'
    set udg_BonusInt[12]='A0L1'
    set udg_BonusArm[0]='A0L5'
    set udg_BonusArm[1]='A0L6'
    set udg_BonusArm[2]='A0L4'
    set udg_BonusArm[3]='A0ML'
    set udg_BonusArm[4]='A0LY'
    set udg_BonusArm[5]='A0L7'
    set udg_BonusArm[6]='A0L3'
    set udg_BonusArm[7]='A0LO'
    set udg_BonusArm[8]='A0LB'
    set udg_BonusArm[9]='A0MD'
    set udg_BonusArm[10]='A0ME'
    set udg_BonusArm[11]='A0LA'
    set udg_BonusArm[12]='A0M0'
    set udg_BonusDmg[0]='A0N1'
    set udg_BonusDmg[1]='A0N6'
    set udg_BonusDmg[2]='A0N7'
    set udg_BonusDmg[3]='A0N8'
    set udg_BonusDmg[4]='A0NA'
    set udg_BonusDmg[5]='A0NC'
    set udg_BonusDmg[6]='A0NK'
    set udg_BonusDmg[7]='A0NT'
    set udg_BonusDmg[8]='A0NL'
    set udg_BonusDmg[9]='A0NM'
    set udg_BonusDmg[10]='A0NN'
    set udg_BonusDmg[11]='A0NS'
    set udg_BonusDmg[12]='A0N3'
    set udg_BonusAspd[0]='A0NV'
    set udg_BonusAspd[1]='A0NU'
    set udg_BonusAspd[2]='A0NX'
    set udg_BonusAspd[3]='A0NY'
    set udg_BonusAspd[4]='A0OJ'
    set udg_BonusAspd[5]='A0O1'
    set udg_BonusAspd[6]='A0O4'
    set udg_BonusAspd[7]='A0OF'
    set udg_BonusAspd[8]='A0OI'
    set udg_BonusAspd[9]='A0OL'
    set udg_BinarySys[0]=1
    set udg_BinarySys[1]=2
    set udg_BinarySys[2]=4
    set udg_BinarySys[3]=8
    set udg_BinarySys[4]=16
    set udg_BinarySys[5]=32
    set udg_BinarySys[6]=64
    set udg_BinarySys[7]=128
    set udg_BinarySys[8]=256
    set udg_BinarySys[9]=512
    set udg_BinarySys[10]=1024
    set udg_BinarySys[11]=2048
    set udg_BinarySys[12]=-4096
    loop
    exitwhen i>12
        call UnitAddAbility(gg_unit_h00D_0013,udg_BonusStr[i])
        call UnitAddAbility(gg_unit_h00D_0013,udg_BonusAgi[i])
        call UnitAddAbility(gg_unit_h00D_0013,udg_BonusInt[i])
        call UnitAddAbility(gg_unit_h00D_0013,udg_BonusArm[i])
        call UnitAddAbility(gg_unit_h00D_0013,udg_BonusDmg[i])
        call UnitRemoveAbility(gg_unit_h00D_0013,udg_BonusStr[i])
        call UnitRemoveAbility(gg_unit_h00D_0013,udg_BonusAgi[i])
        call UnitRemoveAbility(gg_unit_h00D_0013,udg_BonusInt[i])
        call UnitRemoveAbility(gg_unit_h00D_0013,udg_BonusArm[i])
        call UnitRemoveAbility(gg_unit_h00D_0013,udg_BonusDmg[i])
        if i<10 then
            call UnitAddAbility(gg_unit_h00D_0013,udg_BonusAspd[i])
            call UnitRemoveAbility(gg_unit_h00D_0013,udg_BonusAspd[i])
        endif
        set i=i+1
    endloop
    call UnitAddAbility(gg_unit_h00D_0013,'A07D')
    call UnitAddAbility(gg_unit_h00D_0013,'A0CX')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A07D')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A0CX')
endfunction

function UnitGetBonusStr takes unit u returns integer
    local integer i=0
    local integer j=0
    loop
    exitwhen i>12
        if GetUnitAbilityLevel(u,udg_BonusStr[i])==1 then
            set j=j+udg_BinarySys[i]
        endif
        set i=i+1
    endloop
    return j
endfunction

function UnitGetBonusAgi takes unit u returns integer
    local integer i=0
    local integer j=0
    loop
    exitwhen i>12
        if GetUnitAbilityLevel(u,udg_BonusAgi[i])==1 then
            set j=j+udg_BinarySys[i]
        endif
        set i=i+1
    endloop
    return j
endfunction

function UnitGetBonusInt takes unit u returns integer
    local integer i=0
    local integer j=0
    loop
    exitwhen i>12
        if GetUnitAbilityLevel(u,udg_BonusInt[i])==1 then
            set j=j+udg_BinarySys[i]
        endif
        set i=i+1
    endloop
    return j
endfunction

function UnitGetBonusArm takes unit u returns integer
    local integer i=0
    local integer j=0
    loop
    exitwhen i>12
        if GetUnitAbilityLevel(u,udg_BonusArm[i])==1 then
            set j=j+udg_BinarySys[i]
        endif
        set i=i+1
    endloop
    return j
endfunction

function UnitGetBonusDmg takes unit u returns integer
    local integer i=0
    local integer j=0
    loop
    exitwhen i>12
        if GetUnitAbilityLevel(u,udg_BonusDmg[i])==1 then
            set j=j+udg_BinarySys[i]
        endif
        set i=i+1
    endloop
    return j
endfunction

function UnitGetBonusAspd takes unit u returns integer
    local integer i=0
    local integer j=0
    loop
    exitwhen i>8
        if GetUnitAbilityLevel(u,udg_BonusAspd[i])==1 then
            set j=j+udg_BinarySys[i]
        endif
        set i=i+1
    endloop
    if GetUnitAbilityLevel(u,udg_BonusAspd[9])==1 then
        set j=j-512
    endif
    return j
endfunction

function UnitSetBonusStr takes unit u,integer str returns nothing
    local integer i=11
    if str<-4096 or str>4095 then
        call BJDebugMsg("Bonus Out Of Range")
        return
    endif
    if str<0 then
        set str=4096+str
        call UnitAddAbility(u,udg_BonusStr[12])
        call UnitMakeAbilityPermanent(u,true,udg_BonusStr[12])
    else
        call UnitRemoveAbility(u,udg_BonusStr[12])
    endif
    loop
    exitwhen i<0
        if str>=udg_BinarySys[i] then
            call UnitAddAbility(u,udg_BonusStr[i])
            call UnitMakeAbilityPermanent(u,true,udg_BonusStr[i])
            set str=str-udg_BinarySys[i]
        else
            call UnitRemoveAbility(u,udg_BonusStr[i])
        endif
        set i=i-1
    endloop
endfunction

function UnitSetBonusAgi takes unit u,integer agi returns nothing
    local integer i=11
    if agi<-4096 or agi>4095 then
        call BJDebugMsg("Bonus Out Of Range")
        return
    endif
    if agi<0 then
        set agi=4096+agi
        call UnitAddAbility(u,udg_BonusAgi[12])
        call UnitMakeAbilityPermanent(u,true,udg_BonusAgi[12])
    else
        call UnitRemoveAbility(u,udg_BonusAgi[12])
    endif
    loop
    exitwhen i<0
        if agi>=udg_BinarySys[i] then
            call UnitAddAbility(u,udg_BonusAgi[i])
            call UnitMakeAbilityPermanent(u,true,udg_BonusAgi[i])
            set agi=agi-udg_BinarySys[i]
        else
            call UnitRemoveAbility(u,udg_BonusAgi[i])
        endif
        set i=i-1
    endloop
endfunction

function UnitSetBonusInt takes unit u,integer int returns nothing
    local integer i=11
    if int<-4096 or int>4095 then
        call BJDebugMsg("Bonus Out Of Range")
        return
    endif
    if int<0 then
        set int=4096+int
        call UnitAddAbility(u,udg_BonusInt[12])
        call UnitMakeAbilityPermanent(u,true,udg_BonusInt[12])
    else
        call UnitRemoveAbility(u,udg_BonusInt[12])
    endif
    loop
    exitwhen i<0
        if int>=udg_BinarySys[i] then
            call UnitAddAbility(u,udg_BonusInt[i])
            call UnitMakeAbilityPermanent(u,true,udg_BonusInt[i])
            set int=int-udg_BinarySys[i]
        else
            call UnitRemoveAbility(u,udg_BonusInt[i])
        endif
        set i=i-1
    endloop
endfunction

function UnitSetBonusArm takes unit u,integer arm returns nothing
    local integer i=11
    if arm<-4096 or arm>4095 then
        call BJDebugMsg("Bonus Out Of Range")
        return
    endif
    if arm<0 then
        set arm=4096+arm
        call UnitAddAbility(u,udg_BonusArm[12])
        call UnitMakeAbilityPermanent(u,true,udg_BonusArm[12])
    else
        call UnitRemoveAbility(u,udg_BonusArm[12])
    endif
    loop
    exitwhen i<0
        if arm>=udg_BinarySys[i] then
            call UnitAddAbility(u,udg_BonusArm[i])
            call UnitMakeAbilityPermanent(u,true,udg_BonusArm[i])
            set arm=arm-udg_BinarySys[i]
        else
            call UnitRemoveAbility(u,udg_BonusArm[i])
        endif
        set i=i-1
    endloop
endfunction

function UnitSetBonusDmg takes unit u,integer dmg returns nothing
    local integer i=11
    if dmg<-4096 or dmg>4095 then
        call BJDebugMsg("Bonus Out Of Range")
        return
    endif
    if dmg<0 then
        set dmg=4096+dmg
        call UnitAddAbility(u,udg_BonusDmg[12])
        call UnitMakeAbilityPermanent(u,true,udg_BonusDmg[12])
    else
        call UnitRemoveAbility(u,udg_BonusDmg[12])
    endif
    loop
    exitwhen i<0
        if dmg>=udg_BinarySys[i] then
            call UnitAddAbility(u,udg_BonusDmg[i])
            call UnitMakeAbilityPermanent(u,true,udg_BonusDmg[i])
            set dmg=dmg-udg_BinarySys[i]
        else
            call UnitRemoveAbility(u,udg_BonusDmg[i])
        endif
        set i=i-1
    endloop
endfunction

function UnitSetBonusAspd takes unit u,integer aspd returns nothing
    local integer i=8
    if aspd<-512 or aspd>511 then
        call BJDebugMsg("Bonus Out Of Range")
        return
    endif
    if aspd<0 then
        set aspd=512+aspd
        call UnitAddAbility(u,udg_BonusAspd[9])
        call UnitMakeAbilityPermanent(u,true,udg_BonusAspd[9])
    else
        call UnitRemoveAbility(u,udg_BonusAspd[9])
    endif
    loop
    exitwhen i<0
        if aspd>=udg_BinarySys[i] then
            call UnitAddAbility(u,udg_BonusAspd[i])
            call UnitMakeAbilityPermanent(u,true,udg_BonusAspd[i])
            set aspd=aspd-udg_BinarySys[i]
        else
            call UnitRemoveAbility(u,udg_BonusAspd[i])
        endif
        set i=i-1
    endloop
endfunction

function UnitAddBonusStr takes unit u,integer str returns nothing
    call UnitSetBonusStr(u,UnitGetBonusStr(u)+str)
endfunction

function UnitAddBonusAgi takes unit u,integer agi returns nothing
    call UnitSetBonusAgi(u,UnitGetBonusAgi(u)+agi)
endfunction

function UnitAddBonusInt takes unit u,integer int returns nothing
    call UnitSetBonusInt(u,UnitGetBonusInt(u)+int)
endfunction

function UnitAddBonusArm takes unit u,integer arm returns nothing
    call UnitSetBonusArm(u,UnitGetBonusArm(u)+arm)
endfunction

function UnitAddBonusDmg takes unit u,integer dmg returns nothing
    call UnitSetBonusDmg(u,UnitGetBonusDmg(u)+dmg)
endfunction

function UnitAddBonusAspd takes unit u,integer aspd returns nothing
    call UnitSetBonusAspd(u,UnitGetBonusAspd(u)+aspd)
endfunction

function UnitAddMaxLife takes unit u,integer life returns nothing
    local integer a
    local integer b=2
    local integer l
    if life>0 then
        loop
        exitwhen life==0
            set a=life-life/10*10
            loop
            exitwhen a==0
                set a=a-1
                call UnitAddAbility(u,'A07D')
                call SetUnitAbilityLevel(u,'A07D',b)
                call UnitRemoveAbility(u,'A07D')
            endloop
            set life=life/10
            set b=b+1
        endloop
    elseif life<0 then
        set l=-life
        loop
        exitwhen l==0
            set a=l-l/10*10
            loop
            exitwhen a==0
                set a=a-1
                call UnitAddAbility(u,'A0CX')
                call SetUnitAbilityLevel(u,'A0CX',b)
                call UnitRemoveAbility(u,'A0CX')
            endloop
            set l=l/10
            set b=b+1
        endloop
    endif
endfunction

function Initialize_Buff_System takes nothing returns nothing
    call UnitAddAbility(gg_unit_h00D_0013,'A0QV')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A0QV')
    set udg_LBuff_Max=udg_LBuff_Max+1
    set udg_LBuff_bookid[udg_LBuff_Max]=0
    set udg_LBuff_abilityid[udg_LBuff_Max]=0
    set udg_LBuff_buffid[udg_LBuff_Max]='BPSE'
    call UnitAddAbility(gg_unit_h00D_0013,'A0QW')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A0QW')
    set udg_LBuff_Max=udg_LBuff_Max+1
    set udg_LBuff_bookid[udg_LBuff_Max]=0
    set udg_LBuff_abilityid[udg_LBuff_Max]=0
    set udg_LBuff_buffid[udg_LBuff_Max]='B07X'
    call UnitAddAbility(gg_unit_h00D_0013,'A0QI')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A0QI')
    set udg_LBuff_Max=udg_LBuff_Max+1
    set udg_LBuff_bookid[udg_LBuff_Max]=0
    set udg_LBuff_abilityid[udg_LBuff_Max]=0
    set udg_LBuff_buffid[udg_LBuff_Max]='B07T'
    call UnitAddAbility(gg_unit_h00D_0013,'A03C')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A03C')
    set udg_LBuff_Max=udg_LBuff_Max+1
    set udg_LBuff_bookid[udg_LBuff_Max]=0
    set udg_LBuff_abilityid[udg_LBuff_Max]=0
    set udg_LBuff_buffid[udg_LBuff_Max]='B07Z'
    call UnitAddAbility(gg_unit_h00D_0013,'A006')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A006')
    set udg_LBuff_Max=udg_LBuff_Max+1
    set udg_LBuff_bookid[udg_LBuff_Max]=0
    set udg_LBuff_abilityid[udg_LBuff_Max]=0
    set udg_LBuff_buffid[udg_LBuff_Max]='B07Y'
    call UnitAddAbility(gg_unit_h00D_0013,'A03E')
    call UnitRemoveAbility(gg_unit_h00D_0013,'A03E')
    set udg_LBuff_Max=udg_LBuff_Max+1
    set udg_LBuff_bookid[udg_LBuff_Max]=0
    set udg_LBuff_abilityid[udg_LBuff_Max]=0
    set udg_LBuff_buffid[udg_LBuff_Max]='B080'
endfunction

function IsUnitDead takes unit u returns boolean
    return GetWidgetLife(u)<.405 or IsUnitType(u,UNIT_TYPE_DEAD) or GetUnitTypeId(u)==0
endfunction

function IsUnitAlive takes unit u returns boolean
    return GetWidgetLife(u)>=.405
endfunction

function IsUnitInvulnerable takes unit u returns boolean
    local real CurrentHealth=GetWidgetLife(u)
    local real CurrentMana=GetUnitState(u,UNIT_STATE_MANA)
    local boolean k
    if GetUnitAbilityLevel(u,'Avul')>0 or GetUnitAbilityLevel(u,'Bvul')>0 then
        return true
    endif
    call SetWidgetLife(u,CurrentHealth+.001)
    if CurrentHealth!=GetWidgetLife(u) then
        call UnitDamageTarget(u,u,.001,false,true,null,null,null)
        set k=GetWidgetLife(u)==CurrentHealth+.001
    else
        call UnitDamageTarget(u,u,.001,false,true,null,null,null)
        set k=GetWidgetLife(u)==CurrentHealth
        call SetWidgetLife(u,CurrentHealth)
    endif
    if k then
        return not (GetUnitState(u,UNIT_STATE_MANA)!=CurrentMana)
    endif
    return k
endfunction

function H2I takes agent h returns integer
    call SaveAgentHandle(udg_Hashtable,GetHandleId(h),0,h)
    return GetHandleId(h)
endfunction

function H2S takes handle h returns string
    return I2S(GetHandleId(h))
endfunction

function I2U takes integer i returns unit
    return LoadUnitHandle(udg_Hashtable,i,0)
endfunction

function I2L takes integer i returns location
    return LoadLocationHandle(udg_Hashtable,i,0)
endfunction

function I2G takes integer i returns group
    return LoadGroupHandle(udg_Hashtable,i,0)
endfunction

function I2T takes integer i returns timer
    return LoadTimerHandle(udg_Hashtable,i,0)
endfunction

function I2E takes integer i returns effect
    return LoadEffectHandle(udg_Hashtable,i,0)
endfunction

function I2B takes integer i returns boolexpr
    return LoadBooleanExprHandle(udg_Hashtable,i,0)
endfunction

function I2BE takes integer i returns boolexpr
    return LoadBooleanExprHandle(udg_Hashtable,i,0)
endfunction

function I2LT takes integer i returns lightning
    return LoadLightningHandle(udg_Hashtable,i,0)
endfunction

function I2TD takes integer i returns timerdialog
    return LoadTimerDialogHandle(udg_Hashtable,i,0)
endfunction

function I2TR takes integer i returns trigger
    return LoadTriggerHandle(udg_Hashtable,i,0)
endfunction

function I2TA takes integer i returns triggeraction
    return LoadTriggerActionHandle(udg_Hashtable,i,0)
endfunction

function I2W takes integer i returns rect
    return LoadRectHandle(udg_Hashtable,i,0)
endfunction

function I2RT takes integer i returns rect
    return LoadRectHandle(udg_Hashtable,i,0)
endfunction

function I2D takes integer i returns destructable
    return LoadDestructableHandle(udg_Hashtable,i,0)
endfunction

function I2WE takes integer i returns nothing
    return
endfunction

function I2SND takes integer i returns sound
    return LoadSoundHandle(udg_Hashtable,i,0)
endfunction

function I2MB takes integer i returns multiboard
    return LoadMultiboardHandle(udg_Hashtable,i,0)
endfunction

function I2MBI takes integer i returns multiboarditem
    return LoadMultiboardItemHandle(udg_Hashtable,i,0)
endfunction

function I2FM takes integer i returns fogmodifier
    return LoadFogModifierHandle(udg_Hashtable,i,0)
endfunction

function I2P takes integer i returns player
    return LoadPlayerHandle(udg_Hashtable,i,0)
endfunction

function I2IT takes integer i returns item
    return LoadItemHandle(udg_Hashtable,i,0)
endfunction

function Coin takes integer a,integer b returns integer
    if GetRandomInt(0,1)==0 then
        return a
    endif
    return b
endfunction

function Integer takes boolean b returns integer
    if b then
        return 1
    else
        return 0
    endif
endfunction

function Boolean takes integer b returns boolean
    return b!=0
endfunction

function Bit takes integer b returns integer
    return R2I(Pow(2,b))
endfunction

function GetBitBoolean takes integer a,integer b returns boolean
    set a=a/R2I(Pow(2,b))
    if a==a/2*2 then
        return false
    else
        return true
    endif
endfunction

function EnableHeight takes unit u returns nothing
    call UnitAddAbility(u,'Arav')
    call UnitRemoveAbility(u,'Arav')
endfunction

function DistanceBetweenUnits takes unit A,unit B returns real
    local real dx=GetUnitX(B)-GetUnitX(A)
    local real dy=GetUnitY(B)-GetUnitY(A)
    return SquareRoot(dx*dx+dy*dy)
endfunction

function AngleBetweenUnits takes unit A,unit B returns real
    return bj_RADTODEG*Atan2(GetUnitY(B)-GetUnitY(A),GetUnitX(B)-GetUnitX(A))
endfunction

function GetRandomLocInRange takes location o,real r returns location
    local real px
    local real py
    if r<4. then
        set r=4.
    endif
    loop
        set px=GetRandomReal(-r,r)
        set py=GetRandomReal(-r,r)
    exitwhen Pow(px,2)+Pow(py,2)<=Pow(r,2)
    endloop
    return Location(GetLocationX(o)+px,GetLocationY(o)+py)
endfunction

function GetPlayerFilter takes player q returns boolexpr
    return udg_FLIFF[GetPlayerId(q)]
endfunction

function FLIFF01 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(0)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF02 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(1)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF03 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(2)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF04 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(3)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF05 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(4)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF06 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(5)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF07 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(6)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF08 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(7)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF09 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(8)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF10 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(9)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF11 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(10)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF12 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(11)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF13 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(12)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF14 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(13)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function FLIFF15 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(),Player(14)) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(),'Aloc')!=0 then
        return false
    endif
    return true
endfunction

function CostItem takes item w,integer n returns nothing
    local integer m=GetItemCharges(w)
    if n<=0 then
        return
    endif
    if m<=n then
        call RemoveItem(w)
    else
        call SetItemCharges(w,m-n)
    endif
endfunction

function GPSU takes nothing returns integer
    return 'o000'
endfunction

function YawError takes real current,real reference returns real
    local real e=reference-current
    if e<-180. then
        return e+360.
    endif
    if e>=180. then
        return e-360.
    endif
    return e
endfunction

function GetPositionZ takes real x,real y returns real
    local location p=Location(x,y)
    local real z=GetLocationZ(p)
    call RemoveLocation(p)
    set p=null
    return z
endfunction

function SetUnitXY takes unit u,real x,real y returns nothing
    if GetRectMinX(bj_mapInitialPlayableArea)<=x and x<=GetRectMaxX(bj_mapInitialPlayableArea) then
        call SetUnitX(u,x)
    endif
    if GetRectMinY(bj_mapInitialPlayableArea)<=y and y<=GetRectMaxY(bj_mapInitialPlayableArea) then
        call SetUnitY(u,y)
    endif
endfunction

function SetUnitXYFly takes unit u,real x,real y returns boolean
    if IsTerrainPathable(x,y,PATHING_TYPE_FLYABILITY) then
        return false
    endif
    call SetUnitX(u,x)
    call SetUnitY(u,y)
    return true
endfunction

function SetUnitXYGround takes unit u,real x,real y returns boolean
    if IsTerrainPathable(x,y,PATHING_TYPE_WALKABILITY) then
        return false
    endif
    call SetUnitX(u,x)
    call SetUnitY(u,y)
    return true
endfunction

function SetUnitXYRepel takes unit u,real x,real y returns boolean
    if IsTerrainPathable(x,y,PATHING_TYPE_WALKABILITY) then
        return false
    endif
    call SetUnitPosition(u,x,y)
    return true
endfunction

function TSU_RemoveUnit_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    call RemoveUnit(LoadUnitHandle(udg_ht,task,0))
    call FlushChildHashtable(udg_ht,task)
    call ReleaseTimer(t)
    set t=null
endfunction

function TSU_RemoveUnit takes real delay,unit u returns timer
    local timer t
    if u==null then
        set t=null
        return null
    endif
    set t=CreateTimer()
    call SaveUnitHandle(udg_ht,GetHandleId(t),0,u)
    call TimerStart(t,delay,false,function TSU_RemoveUnit_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_DestroyEffect_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    call DestroyEffect(LoadEffectHandle(udg_ht,task,0))
    call FlushChildHashtable(udg_ht,task)
    call ReleaseTimer(t)
    set t=null
endfunction

function TSU_DestroyEffect takes real delay,effect e returns timer
    local timer t
    if e==null then
        set t=null
        return null
    endif
    set t=CreateTimer()
    call SaveEffectHandle(udg_ht,GetHandleId(t),0,e)
    call TimerStart(t,delay,false,function TSU_DestroyEffect_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_DestroyLightning_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local lightning e=LoadLightningHandle(udg_ht,task,0)
    local integer i=LoadInteger(udg_ht,task,1)
    if i==10 then
        call SaveInteger(udg_ht,task,1,9)
        call TimerStart(t,.04,true,function TSU_DestroyLightning_Main)
    elseif i>0 then
        call SetLightningColor(e,1.,1.,1.,i/10.)
        call SaveInteger(udg_ht,task,1,i-1)
    else
        call DestroyLightning(e)
        call FlushChildHashtable(udg_ht,task)
        call ReleaseTimer(t)
    endif
    set t=null
    set e=null
endfunction

function TSU_DestroyLightning takes real delay,lightning e returns timer
    local timer t
    if e==null then
        set t=null
        return null
    endif
    set t=CreateTimer()
    call SaveLightningHandle(udg_ht,GetHandleId(t),0,e)
    call SaveInteger(udg_ht,GetHandleId(t),1,10)
    call TimerStart(t,delay,false,function TSU_DestroyLightning_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_RemoveDestructable_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    call RemoveDestructable(LoadDestructableHandle(udg_ht,GetHandleId(t),0))
    call FlushChildHashtable(udg_ht,task)
    call ReleaseTimer(t)
    set t=null
endfunction

function TSU_RemoveDestructable takes real delay,destructable d returns timer
    local timer t
    if d==null then
        set t=null
        return null
    endif
    set t=CreateTimer()
    call SaveDestructableHandle(udg_ht,GetHandleId(t),0,d)
    call TimerStart(t,delay,false,function TSU_RemoveDestructable_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_AddSpecialEffect_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit target=LoadUnitHandle(udg_ht,task,0)
    local integer i=LoadInteger(udg_ht,task,1)
    if i>0 and GetUnitState(target,UNIT_STATE_LIFE)>0 then
        call SaveInteger(udg_ht,task,1,i-1)
    else
        call DestroyEffect(LoadEffectHandle(udg_ht,task,1))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht,task)
    endif
    set t=null
    set target=null
endfunction

function TSU_AddSpecialEffectTarget takes string modelName,unit target,string attachPointName,real time returns timer
    local timer t
    local effect e
    if target==null then
        set t=null
        set e=null
        return null
    endif
    set t=CreateTimer()
    set e=AddSpecialEffectTarget(modelName,target,attachPointName)
    call SaveUnitHandle(udg_ht,GetHandleId(t),0,target)
    call SaveEffectHandle(udg_ht,GetHandleId(t),1,e)
    call SaveInteger(udg_ht,GetHandleId(t),1,R2I(time/.1))
    call TimerStart(t,.1,true,function TSU_AddSpecialEffect_Main)
    set bj_lastStartedTimer=t
    set t=null
    set e=null
    return bj_lastStartedTimer
endfunction

function TSU_SetUnitInvulnerable_End takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit u=LoadUnitHandle(udg_ht,task,0)
    call SetUnitInvulnerable(u,false)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht,task)
    set t=null
    set u=null
endfunction

function TSU_SetUnitInvulnerable takes unit u,real period returns timer
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    call SetUnitInvulnerable(u,true)
    call SaveUnitHandle(udg_ht,task,0,u)
    call TimerStart(t,period,false,function TSU_SetUnitInvulnerable_End)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_SetUnitTimeScale_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit u=LoadUnitHandle(udg_ht,task,0)
    call SetUnitTimeScale(u,LoadReal(udg_ht,task,0))
    call FlushChildHashtable(udg_ht,task)
    call ReleaseTimer(t)
    set t=null
    set u=null
endfunction

function TSU_SetUnitTimeScale takes real delay,unit u,real rate returns timer
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    call SaveUnitHandle(udg_ht,task,0,u)
    call SaveReal(udg_ht,task,0,rate)
    call TimerStart(t,delay,false,function TSU_SetUnitTimeScale_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_SetUnitMoveSpeed_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit u=LoadUnitHandle(udg_ht,task,0)
    local real s=LoadReal(udg_ht,task,0)
    call SetUnitMoveSpeed(u,s)
    call FlushChildHashtable(udg_ht,task)
    call ReleaseTimer(t)
    set t=null
    set u=null
endfunction

function TSU_SetUnitMoveSpeed takes real delay,unit u,real speed returns timer
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    call SaveUnitHandle(udg_ht,task,0,u)
    call SaveReal(udg_ht,task,0,speed)
    call TimerStart(t,delay,false,function TSU_SetUnitMoveSpeed_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_UnitRemoveAbility_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit u=LoadUnitHandle(udg_ht,task,0)
    local integer aID=LoadInteger(udg_ht,task,0)
    call UnitRemoveAbility(u,aID)
    call FlushChildHashtable(udg_ht,task)
    call ReleaseTimer(t)
    set t=null
    set u=null
endfunction

function TSU_UnitRemoveAbility takes real delay,unit u,integer aID returns timer
    local timer t=CreateTimer()
    local integer task=GetHandleId(t)
    call SaveUnitHandle(udg_ht,task,0,u)
    call SaveInteger(udg_ht,task,0,aID)
    call TimerStart(t,delay,false,function TSU_UnitRemoveAbility_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function TSU_UnitAddItem_Main takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer task=GetHandleId(t)
    local unit u=LoadUnitHandle(udg_ht,task,0)
    local item w=LoadItemHandle(udg_ht,task,1)
    local integer i=LoadInteger(udg_ht,task,1)
    if GetWidgetLife(u)>=.405 or i<=0 then
        call SetItemVisible(w,true)
        call SetItemPosition(w,GetUnitX(u),GetUnitY(u))
        call UnitAddItem(u,w)
        call FlushChildHashtable(udg_ht,task)
        call ReleaseTimer(t)
    else
        call SaveInteger(udg_ht,task,1,i-1)
    endif
    set t=null
    set u=null
    set w=null
endfunction

function TSU_UnitAddItem takes unit u,item w returns timer
    local timer t
    if u==null or w==null then
        set t=null
        return null
    endif
    if GetWidgetLife(u)>=.405 then
        call UnitAddItem(u,w)
        set t=null
        return null
    endif
    set t=CreateTimer()
    call SetItemVisible(w,false)
    call SaveUnitHandle(udg_ht,GetHandleId(t),0,u)
    call SaveItemHandle(udg_ht,GetHandleId(t),1,w)
    call SaveInteger(udg_ht,GetHandleId(t),1,800)
    call TimerStart(t,.25,true,function TSU_UnitAddItem_Main)
    set bj_lastStartedTimer=t
    set t=null
    return bj_lastStartedTimer
endfunction

function UnitDamageArea takes unit h,real x,real y,real r,boolexpr f,real amount,boolean attack,boolean ranged,attacktype attackType,damagetype damageType,weapontype weaponType returns integer
    local integer n=0
    local unit v
    local group g=CreateGroup()
    call GroupEnumUnitsInRange(g,x,y,r+128.,f)
    loop
        set v=FirstOfGroup(g)
    exitwhen v==null
        call GroupRemoveUnit(g,v)
        if IsUnitInRangeXY(v,x,y,r) then
            call UnitDamageTarget(h,v,amount,attack,ranged,attackType,damageType,weaponType)
        endif
        set n=n+1
    endloop
    call DestroyGroup(g)
    set v=null
    set g=null
    return n
endfunction

function CameraRemovePlayer_function takes nothing returns nothing
    if GetOwningPlayer(GetEnumUnit())==bj_forceRandomCurrentPick then
        call GroupRemoveUnit(udg_CameraUnitsStart,GetEnumUnit())
        call GroupRemoveUnit(udg_CameraUnits,GetEnumUnit())
    endif
endfunction

function CameraRemovePlayer takes player p returns nothing
    set bj_forceRandomCurrentPick=p
    call ForGroup(udg_CameraUnits,function CameraRemovePlayer_function)
    call ForGroup(udg_CameraUnitsStart,function CameraRemovePlayer_function)
    if GetLocalPlayer()==p then
        call ResetToGameCamera(1.5)
    endif
endfunction

function CameraAdd takes unit u returns nothing
    local player p=GetOwningPlayer(u)
    local integer i=GetPlayerId(p)
    call CameraRemovePlayer(p)
    call GroupAddUnit(udg_CameraUnitsStart,u)
    call GroupAddUnit(udg_CameraUnits,u)
    set p=null
endfunction

function CameraRemove takes unit u returns nothing
    call GroupRemoveUnit(udg_CameraUnitsStart,u)
    call GroupRemoveUnit(udg_CameraUnits,u)
    if GetLocalPlayer()==GetOwningPlayer(u) then
        call ResetToGameCamera(0)
    endif
endfunction

function CameraRemoveAll takes nothing returns nothing
    call GroupClear(udg_CameraUnits)
    call GroupClear(udg_CameraUnitsStart)
endfunction

function CameraDeath takes nothing returns nothing
    if IsUnitInGroup(GetTriggerUnit(),udg_CameraUnitsStart) or IsUnitInGroup(GetTriggerUnit(),udg_CameraUnits) then
        call CameraRemove(GetTriggerUnit())
    endif
endfunction

function CameraMovement takes nothing returns nothing
    local unit u=GetEnumUnit()
    if GetLocalPlayer()==GetOwningPlayer(u) then
        call PanCameraToTimed(GetUnitX(u),GetUnitY(u),.1)
        call SetCameraField(CAMERA_FIELD_ZOFFSET,0.,0.)
        call SetCameraField(CAMERA_FIELD_ROTATION,90.,0.)
        call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK,304.,0.)
        call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW,70.,0)
        call SetCameraField(CAMERA_FIELD_FARZ,5000,0.)
    endif
    set u=null
endfunction

function CameraActions takes nothing returns nothing
    call ForGroup(udg_CameraUnits,function CameraMovement)
endfunction

function CameraUse takes nothing returns nothing
    if GetOwningPlayer(GetEnumUnit())==GetTriggerPlayer() then
        set bj_isUnitGroupDeadResult=false
    endif
endfunction

function CameraOn takes nothing returns nothing
    local integer i=GetPlayerId(GetTriggerPlayer())
    if GetOwningPlayer(GetEnumUnit())==GetTriggerPlayer() then
        call GroupAddUnit(udg_CameraUnits,GetEnumUnit())
    endif
endfunction

function CameraOff takes nothing returns nothing
    if GetOwningPlayer(GetEnumUnit())==GetTriggerPlayer() then
        call GroupRemoveUnit(udg_CameraUnits,GetEnumUnit())
    endif
endfunction

function CameraInitialOff takes nothing returns nothing
    call GroupRemoveUnit(udg_CameraUnits,GetEnumUnit())
endfunction

function CameraChatActions takes nothing returns nothing
    set bj_isUnitGroupDeadResult=true
    call ForGroup(udg_CameraUnits,function CameraUse)
    if bj_isUnitGroupDeadResult and GetEventPlayerChatString()=="-fol" then
        call CameraAdd(udg_PlayerHeroes[GetPlayerId(GetTriggerPlayer())])
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0.,0.,2.,"Entered camera following mode, press Esc to temporarily stop the effect for 10 seconds or enter '-foloff' to cancel")
        set udg_CameraState[GetPlayerId(GetTriggerPlayer())]=1
        call ForGroup(udg_CameraUnitsStart,function CameraOn)
    elseif GetEventPlayerChatString()=="-foloff" then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0.,0.,2.,"Camera following mode turned off")
        set udg_CameraState[GetPlayerId(GetTriggerPlayer())]=0
        call ForGroup(udg_CameraUnits,function CameraOff)
        if GetLocalPlayer()==GetTriggerPlayer() then
            call ResetToGameCamera(1.5)
        endif
    endif
endfunction

function CameraEscape takes nothing returns nothing
    local integer i=GetPlayerId(GetTriggerPlayer())
    if IsUnitInGroup(udg_PlayerHeroes[i],udg_CameraUnits) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0.,0.,2.,"Camera following mode temporarily suspended for 10 seconds")
        call CameraRemove(udg_PlayerHeroes[i])
    else
        return
    endif
    call TriggerSleepAction(10.)
    if GetWidgetLife(udg_PlayerHeroes[i])>.405 then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0.,0.,2.,"Camera following mode turned on")
        call CameraAdd(udg_PlayerHeroes[i])
    endif
endfunction

function CameraInit takes nothing returns nothing
    local integer i
    local trigger t=CreateTrigger()
    local player p
    call CameraRemoveAll()
    call TriggerRegisterTimerEvent(t,.1,true)
    call TriggerAddAction(t,function CameraActions)
    set t=CreateTrigger()
    call TriggerAddAction(t,function CameraChatActions)
    set i=0
    loop
        call TriggerRegisterPlayerChatEvent(t,Player(i),"-fol",true)
        call TriggerRegisterPlayerChatEvent(t,Player(i),"-foloff",true)
        set i=i+1
    exitwhen i>=12
    endloop
    set t=CreateTrigger()
    call TriggerAddAction(t,function CameraDeath)
    set i=0
    loop
        call TriggerRegisterPlayerUnitEvent(t,Player(i),EVENT_PLAYER_UNIT_DEATH,null)
        set i=i+1
    exitwhen i>=12
    endloop
    set t=CreateTrigger()
    call TriggerAddAction(t,function CameraEscape)
    set i=0
    loop
        call TriggerRegisterPlayerEvent(t,Player(i),EVENT_PLAYER_END_CINEMATIC)
        set i=i+1
    exitwhen i>=12
    endloop
    set t=null
    set p=null
endfunction

function GetTrackableX takes trackable tr returns real
    return LoadReal(udg_cssht,GetHandleId(tr),3)
endfunction

function GetTrackableY takes trackable tr returns real
    return LoadReal(udg_cssht,GetHandleId(tr),4)
endfunction

function GetTrackablePlayerId takes trackable tr returns integer
    return LoadInteger(udg_cssht,GetHandleId(tr),2)
endfunction

function GetTrackableIndex takes trackable tr returns integer
    return LoadInteger(udg_cssht,GetHandleId(tr),5)
endfunction

function CreateTrackableForPlayerId takes string path,real x,real y,real facing,integer pid,integer index returns trackable
    local trackable tr
    local integer tid
    if GetLocalPlayer()!=Player(pid) then
        set path=""
    endif
    set tr=CreateTrackable(path,x,y,facing)
    set tid=GetHandleId(tr)
    call SaveInteger(udg_cssht,tid,2,pid)
    call SaveReal(udg_cssht,tid,3,x)
    call SaveReal(udg_cssht,tid,4,y)
    call SaveInteger(udg_cssht,tid,5,index)
    call SaveReal(udg_cssht,index,0,x)
    call SaveReal(udg_cssht,index,1,y)
    return tr
endfunction

function ItemRegisterDataDefence takes integer id,integer cost,integer hp,integer mp,real hpregen,real mpregen,real armor,real magres,real eva returns nothing
    call SaveInteger(udg_ItemDatabase,id,0,cost)
    call SaveInteger(udg_ItemDatabase,id,5,hp)
    call SaveInteger(udg_ItemDatabase,id,6,mp)
    call SaveReal(udg_ItemDatabase,id,9,hpregen)
    call SaveReal(udg_ItemDatabase,id,10,mpregen)
    call SaveReal(udg_ItemDatabase,id,4,armor)
    call SaveReal(udg_ItemDatabase,id,11,magres)
    call SaveReal(udg_ItemDatabase,id,16,eva)
endfunction

function ItemRegisterDataAttack takes integer id,integer atk,real aspd,real critchance,real physvamp,real cdreduce,real mspercent returns nothing
    call SaveInteger(udg_ItemDatabase,id,7,atk)
    call SaveReal(udg_ItemDatabase,id,8,aspd)
    call SaveReal(udg_ItemDatabase,id,12,critchance)
    call SaveReal(udg_ItemDatabase,id,13,physvamp)
    call SaveReal(udg_ItemDatabase,id,15,cdreduce)
    call SaveReal(udg_ItemDatabase,id,14,mspercent)
endfunction

function ItemRegisterDataStat takes integer id,integer str,integer agi,integer int returns nothing
    call SaveInteger(udg_ItemDatabase,id,1,str)
    call SaveInteger(udg_ItemDatabase,id,2,agi)
    call SaveInteger(udg_ItemDatabase,id,3,int)
endfunction

function GetItemCost takes integer id returns integer
    return LoadInteger(udg_ItemDatabase,id,0)
endfunction

function GetItemHealth takes integer id returns integer
    return LoadInteger(udg_ItemDatabase,id,5)
endfunction

function GetItemMana takes integer id returns integer
    return LoadInteger(udg_ItemDatabase,id,6)
endfunction

function GetItemStr takes integer id returns integer
    return LoadInteger(udg_ItemDatabase,id,1)
endfunction

function GetItemAgi takes integer id returns integer
    return LoadInteger(udg_ItemDatabase,id,2)
endfunction

function GetItemInt takes integer id returns integer
    return LoadInteger(udg_ItemDatabase,id,3)
endfunction

function GetItemArmor takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,4)
endfunction

function GetItemMagRes takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,11)
endfunction

function GetItemAttack takes integer id returns integer
    return LoadInteger(udg_ItemDatabase,id,7)
endfunction

function GetItemAttackSpeed takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,8)
endfunction

function GetItemMovementSpeed takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,14)
endfunction

function GetItemLifeRegen takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,9)
endfunction

function GetItemManaRegen takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,10)
endfunction

function GetItemCooldownReduction takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,15)
endfunction

function GetItemPhysicalDrain takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,13)
endfunction

function GetItemEvasion takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,16)
endfunction

function GetItemCritChance takes integer id returns real
    return LoadReal(udg_ItemDatabase,id,12)
endfunction

function AngleBetween takes unit u1,unit u2 returns real
    return bj_RADTODEG*Atan2(GetUnitY(u2)-GetUnitY(u1),GetUnitX(u2)-GetUnitX(u1))
endfunction

function AngleBetween2 takes unit u1,unit u2 returns real
    return Atan2(GetUnitY(u2)-GetUnitY(u1),GetUnitX(u2)-GetUnitX(u1))
endfunction

function AngleBetweenUnitXY takes unit u1,real x,real y returns real
    return Atan2(y-GetUnitY(u1),x-GetUnitX(u1))
endfunction

function DistanceBetween takes unit u,real x,real y returns real
    local real dx=GetUnitX(u)-x
    local real dy=GetUnitY(u)-y
    return SquareRoot(dx*dx+dy*dy)
endfunction

function DistanceBetween2 takes unit u,real x,real y returns real
    local real dx=GetUnitX(u)-x
    local real dy=GetUnitY(u)-y
    return SquareRoot(dx*dx+dy*dy)
endfunction

function PolarProjection takes unit u,real dist,real angle,boolean f returns real
    local real x=GetUnitX(u)+dist*Cos(angle*bj_DEGTORAD)
    if f then
        return x
    endif
    set x=GetUnitY(u)+dist*Sin(angle*bj_DEGTORAD)
    return x
endfunction

function GCU_Enum takes nothing returns nothing
    local unit u = GetEnumUnit()
    local real dx = GetUnitX(u) - udg_GCU_CurrentX
    local real dy = GetUnitY(u) - udg_GCU_CurrentY
    local real d = (dx*dx + dy*dy) / 10000.
    if d < udg_GCU_CurrentDistance then
        set udg_GCU_CurrentDistance = d
        set udg_GCU_CurrentPick = u
    endif
    set u = null
endfunction

function GetClosestUnitInGroup takes real x, real y, group whichGroup returns unit
    set udg_GCU_CurrentPick = null
    set udg_GCU_CurrentX = x
    set udg_GCU_CurrentY = y
    set udg_GCU_CurrentDistance = 100000
    call ForGroup(whichGroup, function GCU_Enum)
    return udg_GCU_CurrentPick
endfunction