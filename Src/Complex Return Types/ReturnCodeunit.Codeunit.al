// #define ComplexReturnTypes

#if ComplexReturnTypes
codeunit 50101 "Return Codeunit"
{
    procedure TeslaObject() Car: Codeunit "Car Class"
    begin
        Car.SetName('Tesla');
        Car.SetContents('batteries');
    end;

    procedure BMWObject() Car: Codeunit "Car Class"
    begin
        Car.SetName('BMW');
        Car.SetContents('dinosaurs');
    end;

    [EventSubscriber(ObjectType::Page, page::"Customer List", 'OnOpenPageEvent', '', false, false)]
    local procedure ShowObjects()
    begin
        message(TeslaObject().ToString());
        message(BMWObject().ToString());
    end;
}

Codeunit 50102 "Car Class"
{
    var
        MainObject: JsonObject;

    procedure GetObject(): JsonObject
    begin
        exit(MainObject);
    end;

    procedure SetName(name: Text)
    begin
        if MainObject.Contains('name') then
            MainObject.Replace('name', name)
        else
            MainObject.Add('name', name);
    end;

    procedure GetName(): Text
    var
        Tok: JsonToken;
    begin
        MainObject.get('name', Tok);
        exit(Tok.AsValue().AsText());
    end;

    procedure SetContents(contents: Text)
    begin
        if MainObject.Contains('contents') then
            MainObject.Replace('contents', contents)
        else
            MainObject.Add('contents', contents);
    end;

    procedure GetContents(): Text
    var
        Tok: JsonToken;
    begin
        MainObject.get('contents', Tok);
        exit(Tok.AsValue().AsText());
    end;

    procedure ToString(): Text
    begin
        exit(strsubstno('A %1 contains %2', GetName(), GetContents()));
    end;

}
#endif