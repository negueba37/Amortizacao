unit Service.Financiamento;

interface

uses
  Data.DB,
  FireDAC.Comp.Client, System.SysUtils;
  type
  TTotais = record
    Amortizacao:Currency;
    Juros:Currency;
    Pagamento:Currency;
  end;
  type
  TServiceFinanciamento = class
    private
    var
    FTotais:TTotais;
    procedure CalcField(DataSet: TDataSet);
    protected
    FMes:Integer;
    FDataSource:TDataSource;
    FDataSet:TFDMEmTable;
    FCapital:Currency;
    FMesses:Integer;
    FTaxa:Currency;
    procedure CalcularTotais;virtual;final;
    public
    constructor Create();virtual;
    destructor Destroy();override;
    function Capital(AValue:Currency):TServiceFinanciamento;virtual;final;
    function Taxa(AValue:Currency):TServiceFinanciamento;virtual;final;
    function Messes(AValue:Integer):TServiceFinanciamento;virtual;final;
    function DataSource(AValue:TDataSource):TServiceFinanciamento;virtual;final;
    procedure ClearFields;virtual;final;
    function Totais:TTotais;
    procedure CalcularFinanciamento();virtual;

  end;
implementation

{ TServiceFinanciamento }

procedure TServiceFinanciamento.CalcField(DataSet: TDataSet);
begin
  FMes := FMes + 1;
  FDataSet.FieldByName('mes').AsInteger := FMes;
end;

procedure TServiceFinanciamento.CalcularFinanciamento;
begin
  ClearFields;
  FDataSet.Append;
  FDataSet.FieldByName('mes').AsInteger := 0;
  FDataSet.FieldByName('juros').AsCurrency := 0;
  FDataSet.FieldByName('pagamento').AsCurrency := 0;
  FDataSet.FieldByName('amortizacao').AsCurrency := 0;
  FDataSet.FieldByName('SaldoDevedor').AsCurrency := FCapital;
  FDataSet.Post;
end;

procedure TServiceFinanciamento.CalcularTotais;
begin
  if not Assigned(FDataSet) then Exit;
  FTotais.Amortizacao := 0;
  FTotais.Juros := 0;
  FTotais.Pagamento := 0;
  FDataSet.First;
  while not(FDataSet.Eof) do
  begin
    FTotais.Amortizacao := FTotais.Amortizacao + FDataSet.FieldByName('amortizacao').AsCurrency;
    FTotais.Juros := FTotais.Juros + FDataSet.FieldByName('juros').AsCurrency;
    FTotais.Pagamento := FTotais.Pagamento + FDataSet.FieldByName('pagamento').AsCurrency;
    FDataSet.Next;
  end;
end;

function TServiceFinanciamento.Capital(AValue: Currency): TServiceFinanciamento;
begin
  if AValue <= 0 then
    raise Exception.Create('Valor do capital não pode ser menor ou igual a ZERO !');
  Result := Self;
  FCapital := AValue;
end;

procedure TServiceFinanciamento.ClearFields;
begin
  if (FDataSet.Active) then
    FDataSet.EmptyDataSet;
  FTotais.Amortizacao := 0;
  FTotais.Juros := 0;
  FTotais.Pagamento := 0;
  FDataSet.Active := True;
end;

constructor TServiceFinanciamento.Create;
begin
  FMes := 0;
  FDataSet := TFDMemTable.Create(nil);
  FDataSet.FieldDefs.Add('mes',ftInteger);
  FDataSet.FieldDefs.Add('juros',ftCurrency);
  FDataSet.FieldDefs.Add('amortizacao',ftCurrency);
  FDataSet.FieldDefs.Add('pagamento',ftCurrency);
  FDataSet.FieldDefs.Add('saldoDevedor',ftCurrency);
  FDataSet.CreateDataSet;
  FDataSet.OnCalcFields := CalcField;
end;

function TServiceFinanciamento.DataSource(AValue: TDataSource): TServiceFinanciamento;
begin
  Result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := FDataSet;
end;

destructor TServiceFinanciamento.Destroy();
begin
  FDataSet.Free;
  inherited;
end;

function TServiceFinanciamento.Messes(AValue: Integer): TServiceFinanciamento;
begin
  if AValue <= 0 then
    raise Exception.Create('Quantidade de messes não pode ser menor ou igual a ZERO !');
  Result := Self;
  FMesses := AValue;
end;

function TServiceFinanciamento.Taxa(AValue: Currency): TServiceFinanciamento;
begin
  if AValue < 0 then
    raise Exception.Create('Taxa não pode ser menor que ZERO !');
  Result := Self;
  FTaxa := AValue;
end;

function TServiceFinanciamento.Totais: TTotais;
begin
  Result := FTotais;
end;

end.
