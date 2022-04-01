unit Service.Financiamento.PagamentoVariavel;

interface

uses Service.Financiamento;
  type
  TServiceFinanciamentoPagamentoVarialvel = class(TServiceFinanciamento)
    procedure CalcularFinanciamento();override;

  end;
implementation

{ TServiceFinanciamentoPagamentoVarialvel }

procedure TServiceFinanciamentoPagamentoVarialvel.CalcularFinanciamento;
begin
  inherited;

end;

end.
