unit Service.Financiamento.PagamentoAmericano;

interface

uses
  Service.Financiamento;
type
  TServiceFinanciamentoPagamentoAmericano = class(TServiceFinanciamento)
    procedure CalcularFinanciamento();override;
  end;

implementation

{ TServiceFinanciamentoPagamentoAmericano }

procedure TServiceFinanciamentoPagamentoAmericano.CalcularFinanciamento;
var
  I: Integer;
  LSaldoDevedor: Currency;
begin
  inherited;
  FMes := 0;
  LSaldoDevedor := FCapital;
  for I := 0 to Pred(FMesses) do
  begin
    FDataSet.Append;
    FMes := FMes + 1;
    FDataSet.FieldByName('mes').AsInteger := FMes;
    FDataSet.FieldByName('juros').AsCurrency := (FTaxa / 100) * FCapital;
    LSaldoDevedor := LSaldoDevedor + FDataSet.FieldByName('juros').AsCurrency;
    FDataSet.FieldByName('SaldoDevedor').AsCurrency := FCapital;
    FDataSet.FieldByName('amortizacao').AsCurrency := 0;
    FDataSet.FieldByName('pagamento').AsCurrency := FDataSet.FieldByName('juros').AsCurrency;
    if I = Pred(FMesses) then
    begin
      FDataSet.FieldByName('amortizacao').AsCurrency := FCapital;
      FDataSet.FieldByName('pagamento').AsCurrency := FCapital + FDataSet.FieldByName('juros').AsCurrency;
      FDataSet.FieldByName('SaldoDevedor').AsCurrency := 0;
    end;
    FDataSet.Post;
  end;
  CalcularTotais;
  FDataSet.First;
end;

end.
