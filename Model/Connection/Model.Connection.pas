unit Model.Connection;

interface

uses
  Data.DB,
  System.JSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,
  FireDAC.Phys.MySQL,
  FireDAC.Comp.Client,
  System.Generics.Collections;

var
  FDriver : TFDPhysMySQLDriverLink;
  FConnList : TObjectList<TFDConnection>;

function Connected : Integer;
procedure Disconnected(Index : Integer);

implementation

function Connected : Integer;
begin
  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  Result := Pred(FConnList.Count);

  FConnList.Items[Result].Params.DriverID := '';
  FConnList.Items[Result].Params.Database := '';
  FConnList.Items[Result].Params.UserName := '';
  FConnList.Items[Result].Params.Password := '';
  FConnList.Items[Result].Params.Add('Port=3306');
  FConnList.Items[Result].Params.Add('CharacterSet=utf8');
  FConnList.Items[Result].Params.Add('Server=...');
  FConnList.Items[Result].Connected;

end;

procedure Disconnected(Index : Integer);
begin
  FConnList.Items[Index].Connected := False;
  FConnList.Items[Index].Free;
  FConnList.TrimExcess;
end;

end.
