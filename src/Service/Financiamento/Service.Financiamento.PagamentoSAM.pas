unit Service.Financiamento.PagamentoSAM;

interface

uses
  Math,
  Service.Financiamento;
  type
  TServiceFinanciamentoPagamentoSAM = class(TServiceFinanciamento)
  private
  FSaldoDevedorSac:Currency;
  function CalcularPrice:Double;
  function CalcularSAC(ASaldoDevedor:Currency): double;
  function CacularSAM(ASaldoDevedor:Currency): Double;
  public
  procedure CalcularFinanciamento();override;
  end;
implementation


{ TServiceFinanciamentoPagamentoSAM }

function TServiceFinanciamentoPagamentoSAM.CacularSAM(ASaldoDevedor:Currency): Double;
var
  LSAc,LPrice:Double;
begin
  LSAc   := CalcularSAC(ASaldoDevedor);
  LPrice := CalcularPrice;
  Result := ((LSAc + LPrice )/2);
end;

procedure TServiceFinanciamentoPagamentoSAM.CalcularFinanciamento;
var
  I: Integer;
  LSaldoDevedor: Currency;
begin
  inherited;
  FMes := 0;
  LSaldoDevedor := FCapital;
  FSaldoDevedorSac := FCapital;
  for I := 0 to Pred(FMesses) do
  begin
    FDataSet.Append;
    FMes := FMes + 1;
    FDataSet.FieldByName('mes').AsInteger := FMes;
    FDataSet.FieldByName('juros').AsCurrency := ((FTaxa / 100) * LSaldoDevedor);
    FDataSet.FieldByName('pagamento').AsCurrency := CacularSAM(LSaldoDevedor);
    FDataSet.FieldByName('amortizacao').AsCurrency := FDataSet.FieldByName('pagamento').AsCurrency - FDataSet.FieldByName('juros').AsCurrency;
    LSaldoDevedor := LSaldoDevedor - FDataSet.FieldByName('amortizacao').AsCurrency;
    FDataSet.FieldByName('SaldoDevedor').AsCurrency := LSaldoDevedor;
    FDataSet.Post;
  end;
  CalcularTotais;
  FDataSet.First;
end;

function TServiceFinanciamentoPagamentoSAM.CalcularPrice: Double;
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

function TServiceFinanciamentoPagamentoSAM.CalcularSAC(ASaldoDevedor:Currency): double;
var
  LAmortizacao:Currency;
  LJuros:Currency;
begin
  LJuros := (FTaxa/100) * FSaldoDevedorSac;
  LAmortizacao := (FCapital/FMesses);
  FSaldoDevedorSac := FSaldoDevedorSac - LAmortizacao;
  Result := LJuros + LAmortizacao;
end;

end.
