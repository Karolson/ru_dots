function IsUnitSpawn takes unit u returns boolean
    return GetUnitAbilityLevel(u, 'A008') > 0 and GetUnitTypeId(u) != 'h015' and GetUnitTypeId(u) != 'h01O'
endfunction

function IsUnitWard takes unit u returns boolean
    return GetUnitAbilityLevel(u, 'A0IL') > 0
endfunction

function IsUnitSummoned takes unit u returns boolean
    return GetUnitAbilityLevel(u, 'A0ZU') > 0
endfunction

function IsUnitGiant takes unit u returns boolean
    return IsUnitType(u, UNIT_TYPE_GIANT)
endfunction

function IsUnitShanghai takes unit u returns boolean
    return GetUnitTypeId(u) == 'n006'
endfunction

function IsUnitUUZ takes unit u returns boolean
    return GetUnitTypeId(u) == 'o001' or GetUnitTypeId(u) == 'o00K'
endfunction

function IsUnitUngoldable takes unit u returns boolean
    if GetUnitTypeId(u) == 'n01S' or GetUnitTypeId(u) == 'n01U' or GetUnitTypeId(u) == 'n01V' then
        return true
    endif
    return GetUnitTypeId(u) == 'h01O' or GetUnitTypeId(u) == 'h015'
endfunction

function IsMobileUnit takes unit u returns boolean
    local integer id
    if GetUnitAbilityLevel(u, 'A0IL') > 0 then
        return false
    endif
    if IsUnitType(u, UNIT_TYPE_GIANT) then
        return false
    endif
    set id = GetUnitTypeId(u)
    if id == 'U00M' then
        return false
    endif
    if id == 'n01M' then
        return false
    endif
    return true
endfunction

function IsUnitSlowable takes unit u returns boolean
    if GetUnitAbilityLevel(u, 'Avul') >= 1 then
        return false
    endif
    if GetUnitAbilityLevel(u, 'A0AN') >= 1 then
        return false
    endif
    return true
endfunction

function SetCustomState takes unit u, integer index, integer x returns nothing
    local integer d = GetUnitUserData(u)
    local integer n = R2I(Pow(10, index - 1))
    local integer m = 10 * n
    call SetUnitUserData(u, d / m * m + x * n + (d - d / n * n))
endfunction

function GetCustomState takes unit u, integer index returns integer
    local integer d = GetUnitUserData(u)
    local integer n = R2I(Pow(10, index - 1))
    local integer m = 10 * n
    return d / n - d / m * 10
endfunction

function IsUnitFree takes unit u returns boolean
    local integer d = GetUnitUserData(u)
    return d - d / 10000 * 10000 == 0
endfunction

function CS_LOST takes nothing returns integer
    return 1
endfunction

function CS_DRAW takes nothing returns integer
    return 2
endfunction

function CS_DRAG takes nothing returns integer
    return 3
endfunction

function CS_REPEL takes nothing returns integer
    return 4
endfunction

function CS_DASHING takes nothing returns integer
    return 5
endfunction

function CS_FROZEN takes nothing returns integer
    return 6
endfunction

function CS_YUUGI takes nothing returns integer
    return 7
endfunction

function SetUnitFlag takes unit u, integer which, boolean flag returns nothing
    if flag then
        call SetCustomState(u, which, 4)
    else
        call SetCustomState(u, which, 0)
    endif
endfunction

function GetUnitFlag takes unit u, integer which returns boolean
    return GetCustomState(u, which) != 0
endfunction

function ClearUnitFlag takes unit u returns nothing
    call SetUnitUserData(u, 0)
endfunction

function IsUnitAntiDebuff takes unit u returns boolean
    if GetUnitAbilityLevel(u, 'A0AN') > 0 then
        return true
    endif
    return IsUnitType(u, UNIT_TYPE_RESISTANT)
endfunction

function IsUnitAntiMagic takes unit u returns boolean
    if GetUnitAbilityLevel(u, 'ACmi') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'ACm2') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'ACm3') > 0 then
        return true
    endif
    return IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE)
endfunction

function IsUnitSlient takes unit u returns boolean
    if GetUnitAbilityLevel(u, 'B019') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'B035') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'B00Q') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'B032') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'BNsi') > 0 then
        return true
    endif
    return false
endfunction

function IsUnitMorphed takes unit u returns boolean
    if GetUnitAbilityLevel(u, 'B00N') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'B03S') > 0 then
        return true
    endif
    return IsUnitType(u, UNIT_TYPE_POLYMORPHED)
endfunction

function IsUnitLimited takes unit u returns boolean
    if GetUnitAbilityLevel(u, 'B00N') > 0 then
        return true
    endif
    if GetUnitAbilityLevel(u, 'B03S') > 0 then
        return true
    endif
    if GetCustomState(u, 1) != 0 then
        return true
    endif
    if GetCustomState(u, 2) != 0 then
        return true
    endif
    if GetCustomState(u, 4) != 0 then
        return true
    endif
    if GetCustomState(u, 6) != 0 then
        return true
    endif
    if GetUnitCurrentOrder(u) == 851973 then
        return true
    endif
    if IsUnitType(u, UNIT_TYPE_SNARED) then
        return true
    endif
    return false
endfunction

function InitTrig_Override_Systems takes nothing returns nothing
endfunction