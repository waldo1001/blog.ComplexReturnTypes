// #define ComplexReturnTypes

#if ComplexReturnTypes
codeunit 50100 "Return Record"
{
    local procedure FirstCustomer(CountryCode: Code[10]) Cust: record Customer
    begin
        Cust.Setrange("Country/Region Code", CountryCode);
        If not cust.FindFirst() then
            cust.Init();
    end;

    [EventSubscriber(ObjectType::Page, page::"Customer List", 'OnOpenPageEvent', '', false, false)]
    local procedure ShowFirstUSCustomer()
    begin
        Message(FirstCustomer('US').Name);
    end;

}
#endif