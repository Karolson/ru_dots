function Trig_Shanghai04_Issue_Conditions takes nothing returns boolean
    return GetIssuedOrderId() == OrderId("impale")
endfunction

function Trig_Shanghai04_Issue_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local unit h = LoadUnitHandle(udg_sht, GetHandleId(u), 0)
    local real tx = GetOrderPointX()
    local real ty = GetOrderPointY()
    call IssuePointOrder(h, "impale", tx, ty)
    set u = null
    set h = null
endfunction

function InitTrig_Shanghai04_Issue takes nothing returns nothing
endfunction