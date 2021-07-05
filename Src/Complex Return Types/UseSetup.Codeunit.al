
// #define ComplexReturnTypes

#if ComplexReturnTypes
codeunit 50104 "UseSetup"
{
    [EventSubscriber(ObjectType::Page, page::"Customer List", 'OnOpenPageEvent', '', false, false)]
    local procedure ShowDifferentSetups()
    var
        Configs: Codeunit Configs;
    begin
        Message('Setup for Sales Order Nos: %1', Configs.SalesSetup()."Order Nos.");
        Message('Setup for Purchase Order Nos: %1', Configs.PurchaseSetup()."Order Nos.");
    end;
}
#endif

codeunit 50103 "Configs"
{
    procedure SalesSetup(): record "Sales & Receivables Setup"
    begin
        GetSalesSetupIfNecessary();
        exit(SalesSetupRec);
    end;

    procedure PurchaseSetup(): record "Purchases & Payables Setup"
    begin
        GetPurchaseSetupIfNecessary();
        exit(PurchaseSetupRec);
    end;

    local procedure GetSalesSetupIfNecessary()
    begin
        if not SalesSetupLoaded then
            SalesSetupRec.Get();

        SalesSetupLoaded := true;
    end;

    local procedure GetPurchaseSetupIfNecessary()
    begin
        if not PurchaseSetupLoaded then
            PurchaseSetupRec.Get();

        PurchaseSetupLoaded := true;
    end;

    var
        SalesSetupRec: record "Sales & Receivables Setup";
        PurchaseSetupRec: Record "Purchases & Payables Setup";
        SalesSetupLoaded: Boolean;
        PurchaseSetupLoaded: Boolean;
}