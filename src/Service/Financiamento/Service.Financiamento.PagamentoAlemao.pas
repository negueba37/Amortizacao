unit Service.Financiamento.PagamentoAlemao;

interface

uses
Math,
Service.Financiamento;
  type
  ServiceFinanciamentoPagamentoAlemao = class(TServiceFinanciamento)
  private
  function Parcela(ASaldoDevedor:Currency): Double;
  function Amortizacao(AParcela:Double;A1:Boolean): Double;overload;
  function Amortizacao(AParcela:Double): Double;overload;
  public
  procedure CalcularFinanciamento();override;
  end;
implementation

{ ServiceFinanciamentoPagamentoAlemao }

function ServiceFinanciamentoPagamentoAlemao.Amortizacao(AParcela:Double;A1:Boolean): Double;
var
  LJuros:Currency;
begin
  LJuros := (FTaxa/100);
  Result := (AParcela*Power((1-LJuros),(FMesses-1)));
end;

function ServiceFinanciamentoPagamentoAlemao.Amortizacao(AParcela: Double): Double;
var
  LJuros:Currency;
begin
  LJuros := (FTaxa/100);
  Result := (AParcela/(1-LJuros));
end;

procedure ServiceFinanciamentoPagamentoAlemao.CalcularFinanciamento;
var
  I: Integer;
  LSaldoDevedor: Currency;
  LAmortizacao:Currency;
begin
  inherited;
  If not(FDataSet.Active) then
    FDataSet.Active := True;
  FDataSet.EmptyDataSet;

  FMes := 0;
  LSaldoDevedor := FCapital;
  LAmortizacao := 0;
  for I := 0 to (FMesses) do
  begin
    FDataSet.Append;
    FDataSet.FieldByName('mes').AsInteger := FMes;

    if FMes = 0 then
    begin
      LAmortizacao := 0;
      FDataSet.FieldByName('pagamento').AsCurrency := FDataSet.FieldByName('juros').AsCurrency;
      FDataSet.FieldByName('amortizacao').AsCurrency := 0;
      FDataSet.FieldByName('juros').AsCurrency := ((FTaxa / 100) * LSaldoDevedor);
    end
    else
    begin
      FDataSet.FieldByName('pagamento').AsCurrency := Parcela(FCapital);

      if FMes = 1 then
        FDataSet.FieldByName('amortizacao').AsCurrency := Amortizacao(FDataSet.FieldByName('pagamento').AsCurrency,True)
      else
        FDataSet.FieldByName('amortizacao').AsCurrency := Amortizacao(LAmortizacao);

      LAmortizacao := FDataSet.FieldByName('amortizacao').AsCurrency;
      FDataSet.FieldByName('juros').AsCurrency := FDataSet.FieldByName('pagamento').AsCurrency- LAmortizacao;
    end;
    LSaldoDevedor := LSaldoDevedor - FDataSet.FieldByName('amortizacao').AsCurrency;
    FDataSet.FieldByName('SaldoDevedor').AsCurrency := LSaldoDevedor;
    FDataSet.Post;
    FMes := FMes + 1;
  end;
  CalcularTotais;
  FDataSet.First;
end;

function ServiceFinanciamentoPagamentoAlemao.Parcela(ASaldoDevedor:Currency): Double;
var
  LJuros:Currency;
  IElevado:Double;
begin
  LJuros := (FTaxa/100);
  IElevado := (1-Power((1-LJuros),FMesses));
  Result := (ASaldoDevedor*LJuros)/IElevado;
end;

end.
