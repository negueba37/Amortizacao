unit Model.Helpers.DbGrid;

interface
uses
  Vcl.DBGrids;
  type
  TDbGridHelper = class helper for TDBGrid
  procedure SetPosition(Index,Porcentagem:Integer);
  end;

implementation

{ TDbGridHelper }

procedure TDbGridHelper.SetPosition(Index,Porcentagem:Integer);
begin
  Self.Columns[Index].Width := Trunc((Porcentagem / 100) * (Self.Width-36));
end;

end.
