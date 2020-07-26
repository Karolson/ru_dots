function sc__MMD__QueueNode_onDestroy takes integer this returns nothing
    call FlushStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_VAL + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_msg[this])
    call FlushStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_key[this])
    set udg_s__MMD__QueueNode_msg[this] = null
    set udg_s__MMD__QueueNode_key[this] = null
    set udg_s__MMD__QueueNode_next[this] = 0
endfunction

function s__MMD__QueueNode__allocate takes nothing returns integer
    local integer this = udg_si__MMD__QueueNode_F
    if this != 0 then
        set udg_si__MMD__QueueNode_F = udg_si__MMD__QueueNode_V[this]
    else
        set udg_si__MMD__QueueNode_I = udg_si__MMD__QueueNode_I + 1
        set this = udg_si__MMD__QueueNode_I
    endif
    if this > 8190 then
        return 0
    endif
    set udg_s__MMD__QueueNode_next[this] = 0
    set udg_si__MMD__QueueNode_V[this] = -1
    return this
endfunction

function sc__MMD__QueueNode_deallocate takes integer this returns nothing
    if this == null then
        return
    elseif udg_si__MMD__QueueNode_V[this] != -1 then
        return
    endif
    set udg_f__arg_this = this
    call TriggerEvaluate(udg_st__MMD__QueueNode_onDestroy)
    set udg_si__MMD__QueueNode_V[this] = udg_si__MMD__QueueNode_F
    set udg_si__MMD__QueueNode_F = this
endfunction

function MMD_RaiseGuard takes string reason returns nothing
    set udg_MMD__num_senders = udg_MMD__NUM_SENDERS_SAFE
endfunction

function MMD__time takes nothing returns real
    return TimerGetElapsed(udg_MMD__clock)
endfunction

function MMD__prepC2I takes nothing returns nothing
    local integer i = 0
    local string id
    loop
    exitwhen i >= udg_MMD__num_chars
        set id = SubString(udg_MMD__chars, i, i + 1)
        if id == StringCase(id, true) then
            set id = id + "U"
        endif
        call StoreInteger(udg_MMD__gc, "c2i", id, i)
        set i = i + 1
    endloop
endfunction

function MMD__C2I takes string c returns integer
    local integer i
    local string id = c
    if id == StringCase(id, true) then
        set id = id + "U"
    endif
    set i = GetStoredInteger(udg_MMD__gc, "c2i", id)
    if i < 0 or i >= udg_MMD__num_chars or SubString(udg_MMD__chars, i, i + 1) != c and HaveStoredInteger(udg_MMD__gc, "c2i", id) then
        set i = 0
        loop
        exitwhen i >= udg_MMD__num_chars
            if c == SubString(udg_MMD__chars, i, i + 1) then
                call MMD_RaiseGuard("c2i poisoned")
                call StoreInteger(udg_MMD__gc, "c2i", id, i)
            exitwhen true
            endif
            set i = i + 1
        endloop
    endif
    return i
endfunction

function MMD__poor_hash takes string s, integer seed returns integer
    local integer n = StringLength(s)
    local integer m = n + seed
    local integer i = 0
    loop
    exitwhen i >= n
        set m = m * 41 + MMD__C2I(SubString(s, i, i + 1))
        set i = i + 1
    endloop
    return m
endfunction

function s__MMD__QueueNode_create takes integer id, string msg returns integer
    local integer this = s__MMD__QueueNode__allocate()
    set udg_s__MMD__QueueNode_timeout[this] = TimerGetElapsed(udg_MMD__clock) + 7.0 + GetRandomReal(0, 2 + 0.1 * GetPlayerId(GetLocalPlayer()))
    set udg_s__MMD__QueueNode_msg[this] = msg
    set udg_s__MMD__QueueNode_checksum[this] = MMD__poor_hash(udg_s__MMD__QueueNode_msg[this], id)
    set udg_s__MMD__QueueNode_key[this] = I2S(id)
    return this
endfunction

function s__MMD__QueueNode_onDestroy takes integer this returns nothing
    call FlushStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_VAL + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_msg[this])
    call FlushStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_key[this])
    set udg_s__MMD__QueueNode_msg[this] = null
    set udg_s__MMD__QueueNode_key[this] = null
    set udg_s__MMD__QueueNode_next[this] = 0
endfunction

function s__MMD__QueueNode_deallocate takes integer this returns nothing
    if this == null then
        return
    elseif udg_si__MMD__QueueNode_V[this] != -1 then
        return
    endif
    call s__MMD__QueueNode_onDestroy(this)
    set udg_si__MMD__QueueNode_V[this] = udg_si__MMD__QueueNode_F
    set udg_si__MMD__QueueNode_F = this
endfunction

function s__MMD__QueueNode_send takes integer this returns nothing
    call StoreInteger(udg_MMD__gc, udg_MMD__M_KEY_VAL + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_msg[this], udg_s__MMD__QueueNode_checksum[this])
    call StoreInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_checksum[this])
    call SyncStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_VAL + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_msg[this])
    call SyncStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_key[this])
endfunction

function MMD__isEmitter takes nothing returns boolean
    local integer i = 0
    local integer n = 0
    local integer r
    local integer array picks
    local boolean array pick_flags
    loop
    exitwhen i >= 12
        if GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            if n < udg_MMD__num_senders then
                set picks[n] = i
                set pick_flags[i] = true
            else
                set r = GetRandomInt(0, n)
                if r < udg_MMD__num_senders then
                    set pick_flags[picks[r]] = false
                    set picks[r] = i
                    set pick_flags[i] = true
                endif
            endif
            set n = n + 1
        endif
        set i = i + 1
    endloop
    return pick_flags[GetPlayerId(GetLocalPlayer())]
endfunction

function MMD__emit takes string message returns nothing
    local integer q
    if not udg_MMD__initialized then
        call BJDebugMsg("MMD Emit Error: Library not initialized yet.")
        return
    endif
    set q = s__MMD__QueueNode_create(udg_MMD__num_msg, message)
    if udg_MMD__q_head == 0 then
        set udg_MMD__q_head = q
    else
        set udg_s__MMD__QueueNode_next[udg_MMD__q_tail] = q
    endif
    set udg_MMD__q_tail = q
    set udg_MMD__num_msg = udg_MMD__num_msg + 1
    if MMD__isEmitter() then
        call s__MMD__QueueNode_send(q)
    endif
endfunction

function MMD__tick takes nothing returns nothing
    local integer q
    local integer i
    set q = udg_MMD__q_head
    loop
    exitwhen q == 0 or udg_s__MMD__QueueNode_timeout[q] >= TimerGetElapsed(udg_MMD__clock)
        if not HaveStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_VAL + udg_s__MMD__QueueNode_key[q], udg_s__MMD__QueueNode_msg[q]) then
            call MMD_RaiseGuard("message skipping")
            call s__MMD__QueueNode_send(q)
        elseif not HaveStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + udg_s__MMD__QueueNode_key[q], udg_s__MMD__QueueNode_key[q]) then
            call MMD_RaiseGuard("checksum skipping")
            call s__MMD__QueueNode_send(q)
        elseif GetStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_VAL + udg_s__MMD__QueueNode_key[q], udg_s__MMD__QueueNode_msg[q]) != udg_s__MMD__QueueNode_checksum[q] then
            call MMD_RaiseGuard("message tampering")
            call s__MMD__QueueNode_send(q)
        elseif GetStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + udg_s__MMD__QueueNode_key[q], udg_s__MMD__QueueNode_key[q]) != udg_s__MMD__QueueNode_checksum[q] then
            call MMD_RaiseGuard("checksum tampering")
            call s__MMD__QueueNode_send(q)
        endif
        set udg_MMD__q_head = udg_s__MMD__QueueNode_next[q]
        call s__MMD__QueueNode_deallocate(q)
        set q = udg_MMD__q_head
    endloop
    if udg_MMD__q_head == 0 then
        set udg_MMD__q_tail = 0
    endif
    set i = 0
    loop
    exitwhen not HaveStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + I2S(udg_MMD__num_msg), I2S(udg_MMD__num_msg))
        call MMD_RaiseGuard("message insertion")
        call MMD__emit("Blank")
        set i = i + 1
    exitwhen i >= 10
    endloop
endfunction

function MMD__pack takes string value returns string
    local integer j
    local integer i = 0
    local string result = ""
    local string c
    loop
    exitwhen i >= StringLength(value)
        set c = SubString(value, i, i + 1)
        set j = 0
        loop
        exitwhen j >= StringLength(udg_MMD__ESCAPED_CHARS)
            if c == SubString(udg_MMD__ESCAPED_CHARS, j, j + 1) then
                set c = "\\"+c
            exitwhen true
            endif
            set j = j + 1
        endloop
        set result = result + c
        set i = i + 1
    endloop
    return result
endfunction

function MMD__update_value takes string name, player p, string op, string value, integer val_type returns nothing
    local integer id = GetPlayerId(p)
    if p == null or id < 0 or id >= 12 then
        call BJDebugMsg("MMD Set Error: Invalid player. Must be P1 to P12.")
    elseif val_type != GetStoredInteger(udg_MMD__gc, "types", name) then
        call BJDebugMsg("MMD Set Error: Updated value of undefined variable or used value of incorrect type.")
    elseif StringLength(op) == 0 then
        call BJDebugMsg("MMD Set Error: Unrecognized operation type.")
    elseif StringLength(name) > 50 then
        call BJDebugMsg("MMD Set Error: Variable name is too long.")
    elseif StringLength(name) == 0 then
        call BJDebugMsg("MMD Set Error: Variable name is empty.")
    else
        call MMD__emit("VarP " + I2S(id) + " " + MMD__pack(name) + " " + op + " " + value)
    endif
endfunction

function MMD__DefineEvent takes string name, integer num_args, string format, string arg_data returns nothing
    if GetStoredInteger(udg_MMD__gc, "events", name) != 0 then
        call BJDebugMsg("MMD DefEvent Error: Event redefined.")
    else
        call StoreInteger(udg_MMD__gc, "events", name, num_args + 1)
        call MMD__emit("DefEvent " + MMD__pack(name) + " " + I2S(num_args) + " " + arg_data + MMD__pack(format))
    endif
endfunction

function MMD__LogEvent takes string name, integer num_args, string data returns nothing
    if GetStoredInteger(udg_MMD__gc, "events", name) != num_args + 1 then
        call BJDebugMsg("MMD LogEvent Error: Event not defined or defined with different # of args.")
    else
        call MMD__emit("Event " + MMD__pack(name) + data)
    endif
endfunction

function MMD_FlagPlayer takes player p, integer flag_type returns nothing
    local string flag = udg_MMD__flags[flag_type]
    local integer id = GetPlayerId(p)
    if p == null or id < 0 or id >= 12 then
        call BJDebugMsg("MMD Flag Error: Invalid player. Must be P1 to P12.")
    elseif StringLength(flag) == 0 then
        call BJDebugMsg("MMD Flag Error: Unrecognized flag type.")
    elseif GetPlayerController(Player(id)) == MAP_CONTROL_USER then
        call MMD__emit("FlagP " + I2S(id) + " " + flag)
    endif
endfunction

function MMD_DefineValue takes string name, integer value_type, integer goal_type, integer suggestion_type returns nothing
    local string goal = udg_MMD__goals[goal_type]
    local string vtype = udg_MMD__types[value_type]
    local string stype = udg_MMD__suggestions[suggestion_type]
    if goal == null then
        call BJDebugMsg("MMD Def Error: Unrecognized goal type.")
    elseif vtype == null then
        call BJDebugMsg("MMD Def Error: Unrecognized value type.")
    elseif stype == null then
        call BJDebugMsg("Stats Def Error: Unrecognized suggestion type.")
    elseif StringLength(name) > 32 then
        call BJDebugMsg("MMD Def Error: Variable name is too long.")
    elseif StringLength(name) == 0 then
        call BJDebugMsg("MMD Def Error: Variable name is empty.")
    elseif value_type == udg_MMD_TYPE_STRING and goal_type != udg_MMD_GOAL_NONE then
        call BJDebugMsg("MMD Def Error: Strings must have goal type of none.")
    elseif GetStoredInteger(udg_MMD__gc, "types", name) != 0 then
        call BJDebugMsg("MMD Def Error: Value redefined.")
    else
        call StoreInteger(udg_MMD__gc, "types", name, value_type)
        call MMD__emit("DefVarP " + MMD__pack(name) + " " + vtype + " " + goal + " " + stype)
    endif
endfunction

function MMD_UpdateValueInt takes string name, player p, integer op, integer value returns nothing
    call MMD__update_value(name, p, udg_MMD__ops[op], I2S(value), udg_MMD_TYPE_INT)
endfunction

function MMD_UpdateValueReal takes string name, player p, integer op, real value returns nothing
    call MMD__update_value(name, p, udg_MMD__ops[op], R2S(value), udg_MMD_TYPE_REAL)
endfunction

function MMD_UpdateValueString takes string name, player p, string value returns nothing
    local string q = "\""
    call MMD__update_value(name, p, udg_MMD__ops[udg_MMD_OP_SET], q + MMD__pack(value) + q, udg_MMD_TYPE_STRING)
endfunction

function MMD_DefineEvent0 takes string name, string format returns nothing
    call MMD__DefineEvent(name, 0, format, "")
endfunction

function MMD_DefineEvent1 takes string name, string format, string argName0 returns nothing
    call MMD__DefineEvent(name, 1, format, MMD__pack(argName0) + " ")
endfunction

function MMD_DefineEvent2 takes string name, string format, string argName0, string argName1 returns nothing
    call MMD__DefineEvent(name, 2, format, MMD__pack(argName0) + " " + MMD__pack(argName1) + " ")
endfunction

function MMD_DefineEvent3 takes string name, string format, string argName0, string argName1, string argName2 returns nothing
    call MMD__DefineEvent(name, 3, format, MMD__pack(argName0) + " " + MMD__pack(argName1) + " " + MMD__pack(argName2) + " ")
endfunction

function MMD_LogEvent0 takes string name returns nothing
    call MMD__LogEvent(name, 0, "")
endfunction

function MMD_LogEvent1 takes string name, string arg0 returns nothing
    call MMD__LogEvent(name, 1, " " + MMD__pack(arg0))
endfunction

function MMD_LogEvent2 takes string name, string arg0, string arg1 returns nothing
    call MMD__LogEvent(name, 2, " " + MMD__pack(arg0) + " " + MMD__pack(arg1))
endfunction

function MMD_LogEvent3 takes string name, string arg0, string arg1, string arg2 returns nothing
    call MMD__LogEvent(name, 3, " " + MMD__pack(arg0) + " " + MMD__pack(arg1) + " " + MMD__pack(arg2))
endfunction

function MMD_LogCustom takes string unique_identifier, string data returns nothing
    call MMD__emit("custom " + MMD__pack(unique_identifier) + " " + MMD__pack(data))
endfunction

function MMD__init2 takes nothing returns nothing
    local integer i
    local trigger t
    set udg_MMD__initialized = true
    call MMD__emit("init version " + I2S(udg_MMD__MINIMUM_PARSER_VERSION) + " " + I2S(udg_MMD__CURRENT_VERSION))
    set i = 0
    loop
    exitwhen i >= 12
        if GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            call MMD__emit("init pid " + I2S(i) + " " + MMD__pack(GetPlayerName(Player(i))))
        endif
        set i = i + 1
    endloop
    set t = CreateTrigger()
    call TriggerAddAction(t, function MMD__tick)
    call TriggerRegisterTimerEvent(t, 0.37, true)
endfunction

function sa__MMD__QueueNode_onDestroy takes nothing returns boolean
    local integer this = udg_f__arg_this
    call FlushStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_VAL + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_msg[this])
    call FlushStoredInteger(udg_MMD__gc, udg_MMD__M_KEY_CHK + udg_s__MMD__QueueNode_key[this], udg_s__MMD__QueueNode_key[this])
    set udg_s__MMD__QueueNode_msg[this] = null
    set udg_s__MMD__QueueNode_key[this] = null
    set udg_s__MMD__QueueNode_next[this] = 0
    return true
endfunction

function InitTrig_MMD takes nothing returns nothing
    local trigger t = CreateTrigger()
    set udg_st__MMD__QueueNode_onDestroy = CreateTrigger()
    call TriggerAddCondition(udg_st__MMD__QueueNode_onDestroy, Condition(function sa__MMD__QueueNode_onDestroy))
    call TriggerRegisterTimerEvent(t, 0, false)
    call TriggerAddAction(t, function MMD__init2)
    set udg_MMD__goals[udg_MMD_GOAL_NONE] = "none"
    set udg_MMD__goals[udg_MMD_GOAL_HIGH] = "high"
    set udg_MMD__goals[udg_MMD_GOAL_LOW] = "low"
    set udg_MMD__types[udg_MMD_TYPE_INT] = "int"
    set udg_MMD__types[udg_MMD_TYPE_REAL] = "real"
    set udg_MMD__types[udg_MMD_TYPE_STRING] = "string"
    set udg_MMD__suggestions[udg_MMD_SUGGEST_NONE] = "none"
    set udg_MMD__suggestions[udg_MMD_SUGGEST_TRACK] = "track"
    set udg_MMD__suggestions[udg_MMD_SUGGEST_LEADERBOARD] = "leaderboard"
    set udg_MMD__ops[udg_MMD_OP_ADD] = "+="
    set udg_MMD__ops[udg_MMD_OP_SUB] = "-="
    set udg_MMD__ops[udg_MMD_OP_SET] = "="
    set udg_MMD__flags[udg_MMD_FLAG_DRAWER] = "drawer"
    set udg_MMD__flags[udg_MMD_FLAG_LOSER] = "loser"
    set udg_MMD__flags[udg_MMD_FLAG_WINNER] = "winner"
    set udg_MMD__flags[udg_MMD_FLAG_LEAVER] = "leaver"
    set udg_MMD__flags[udg_MMD_FLAG_PRACTICING] = "practicing"
    call FlushGameCache(InitGameCache(udg_MMD__FILENAME))
    set udg_MMD__gc = InitGameCache(udg_MMD__FILENAME)
    call TimerStart(udg_MMD__clock, 999999999, false, null)
    call MMD__prepC2I()
endfunction