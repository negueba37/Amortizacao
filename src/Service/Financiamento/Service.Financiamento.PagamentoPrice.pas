unit Service.Financiamento.PagamentoPrice;

interface
uses
  Math,
  Service.Financiamento;
  type
  TServiceFinanciamentoPagamentoPrice = class(TServiceFinanciamento)
  private
  function CalcularValorParcela:double;
  public
    procedure CalcularFinanciamento(); override;
  end;

implementation

{ TServiceFinanciamentoPagamentoPrice }

procedure TServiceFinanciamentoPagamentoPrice.CalcularFinanciamento;
var
  I: Integer;
  LSaldoDevedor: Currency;
  LPagamento:Currency;
begin
  inherited;
  FMes := 0;
  LPagamento := CalcularValorParcela;
  LSaldoDevedor := FCapital;
  for I := 0 to Pred(FMesses) do
  begin
    FDataSet.Append;
    FMes := FMes + 1;
    FDataSet.FieldByName('mes').AsInteger := FMes;
    FDataSet.FieldByName('juros').AsCurrency := ((FTaxa / 100) * LSaldoDevedor);
    FDataSet.FieldByName('pagamento').AsCurrency := LPagamento;
    FDataSet.FieldByName('amortizacao').AsCurrency := LPagamento -FDataSet.FieldByName('juros').AsCurrency;
    LSaldoDevedor := LSaldoDevedor - FDataSet.FieldByName('amortizacao').AsCurrency;
    FDataSet.FieldByName('SaldoDevedor').AsCurrency := LSaldoDevedor;
    FDataSet.Post;
  end;
  CalcularTotais;
  FDataSet.First;
end;

function TServiceFinanciamentoPagamentoPrice.CalcularValorParcela: double;
var
  Divi,Y,Z,I:Double;
  IElevado:Double;
begin
  I := (FTaxa/100);
  IElevado := I + 1;
  IElevado := Power(IElevado,FMesses);
  Y := IElevado - 1;
  Z := IElevado * I;
  Divi := (y/z);
  Result := FCapital / Divi;
end;

end.
