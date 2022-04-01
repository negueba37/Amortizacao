unit Service.Financiamento.PagamentoSAC;

interface

uses Service.Financiamento;
  type
  TServiceFinanciamentoSAC = class(TServiceFinanciamento)
    public
    procedure CalcularFinanciamento();override;
  end;
implementation

{ TServiceFinanciamentoSAC }

procedure TServiceFinanciamentoSAC.CalcularFinanciamento;
var
  I: Integer;
  LSaldoDevedor: Currency;
  LAmortizacao:Currency;
begin
  inherited;
  FMes := 0;
  LSaldoDevedor := FCapital;
  LAmortizacao := (FCapital / FMesses);
  for I := 0 to Pred(FMesses) do
  begin
    FDataSet.Append;
    FMes := FMes + 1;
    FDataSet.FieldByName('mes').AsInteger := FMes;
    FDataSet.FieldByName('juros').AsCurrency := ((FTaxa / 100) * LSaldoDevedor);
    FDataSet.FieldByName('amortizacao').AsCurrency := LAmortizacao;
    FDataSet.FieldByName('pagamento').AsCurrency := (FDataSet.FieldByName('juros').AsCurrency + FDataSet.FieldByName('amortizacao').AsCurrency);
    LSaldoDevedor := LSaldoDevedor - LAmortizacao;
    FDataSet.FieldByName('SaldoDevedor').AsCurrency := LSaldoDevedor;
    FDataSet.Post;
  end;
  CalcularTotais;
  FDataSet.First;
end;


end.
