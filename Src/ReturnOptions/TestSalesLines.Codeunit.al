
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

    procedure SalesLines2(): Record "Sales Line"
    var
        SL: Record "Sales Line";
    begin
        SL.SetRange("Document Type", Rec."Document Type");
        SL.SetRange("Document No.", Rec."No.");
        exit(SL);
    end;

}

pageextension 50100 "Sales Order Ext" extends "Sales Order"
{
    actions
    {
        addfirst(navigation)
        {
            action(MessageSalesLinesCount)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                image = NumberGroup;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Salesline: record "Sales Line";
                begin
                    SalesLine.Copy(Rec.SalesLines());
                    if SalesLine.FindSet() then
                        repeat
                        // Do your thing..
                        until SalesLine.Next() < 1;



                    // Foreach Rec in SalesHeader.SalesLines() do begin
                    //     Rec.DoSomething();
                    // end;


                    // Message('Count: %1', Rec.SalesLines2().Count());
                end;
            }
        }
    }
}