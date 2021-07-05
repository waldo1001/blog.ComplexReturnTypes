
codeunit 50106 "TestSalesLines"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header");
    begin
        if SalesHeader.SalesLines().IsEmpty() then
            error('Dude .. this document is empty...');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc2(var SalesHeader: Record "Sales Header");
    begin
        ShowMessageForeachLine(SalesHeader.SalesLines());
    end;

    local procedure ShowMessageForeachLine(SalesLine: record "Sales Line")
    begin
        if SalesLine.FindSet() then
            repeat
                Message('Much better...');
            until SalesLine.Next() < 1;
    end;

}

tableextension 50100 "Sales header Ext" extends "Sales Header"
{
    procedure SalesLines() SL: Record "Sales Line"
    begin
        SL.SetRange("Document Type", Rec."Document Type");
        SL.SetRange("Document No.", Rec."No.");
    end;

    procedure SalesLines(TypeFilter: Text) SL: Record "Sales Line"
    begin
        SL := SalesLines();
        SL.SetFilter("Type", TypeFilter);
    end;

}