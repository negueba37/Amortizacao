unit Service.Financiamento.PagamentoUnico;

interface

uses
  Service.Financiamento;

type
  TServiceFinanciamentoPagamentoUnico = class(TServiceFinanciamento)
  public
    procedure CalcularFinanciamento(); override;
  end;

implementation

{ TServiceFinanciamentoPagamentoUnico }

procedure TServiceFinanciamentoPagamentoUnico.CalcularFinanciamento;
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
    FDataSet.FieldByName('juros').AsCurrency := (FTaxa / 100) * LSaldoDevedor;
    LSaldoDevedor := LSaldoDevedor + FDataSet.FieldByName('juros').AsCurrency;
    FDataSet.FieldByName('SaldoDevedor').AsCurrency := LSaldoDevedor;
    FDataSet.FieldByName('amortizacao').AsCurrency := 0;
    FDataSet.FieldByName('pagamento').AsCurrency := 0;
    if I = Pred(FMesses) then
    begin
      FDataSet.FieldByName('amortizacao').AsCurrency := FCapital;
      FDataSet.FieldByName('pagamento').AsCurrency := LSaldoDevedor;
      FDataSet.FieldByName('SaldoDevedor').AsCurrency := 0;
    end;
    FDataSet.Post;
  end;
  CalcularTotais;
  FDataSet.First;
end;


end.
