unit Service.Financiamento.Factory;

interface

uses
  Service.Financiamento.PagamentoAmericano,
  Service.Financiamento.PagamentoUnico,
  Service.Financiamento.PagamentoSAC,
  Service.Financiamento.PagamentoPrice,
  Service.Financiamento.PagamentoSAM,
  Service.Financiamento.PagamentoAlemao,
  Service.Financiamento.PagamentoVariavel;
  type
  TServiceFinanciamentoFactory = class
    function PagamentoAmericano:TServiceFinanciamentoPagamentoAmericano;
    function PagamentoVariavel:TServiceFinanciamentoPagamentoVarialvel;
    function PagamentoSAC:TServiceFinanciamentoSAC;
    function PagamentoUnico:TServiceFinanciamentoPagamentoUnico;
    function PagamentoPrice:TServiceFinanciamentoPagamentoPrice;
    function PagamentoSAM:TServiceFinanciamentoPagamentoSAM;
    function PagamentoAlemao:ServiceFinanciamentoPagamentoAlemao;
  end;
implementation

{ TServiceFinanciamentoFactory }

function TServiceFinanciamentoFactory.PagamentoPrice: TServiceFinanciamentoPagamentoPrice;
begin
  Result := TServiceFinanciamentoPagamentoPrice.Create;
end;

function TServiceFinanciamentoFactory.PagamentoSAC: TServiceFinanciamentoSAC;
begin
  Result := TServiceFinanciamentoSAC.Create;
end;

function TServiceFinanciamentoFactory.PagamentoSAM: TServiceFinanciamentoPagamentoSAM;
begin
  Result := TServiceFinanciamentoPagamentoSAM.Create;
end;

function TServiceFinanciamentoFactory.PagamentoAlemao: ServiceFinanciamentoPagamentoAlemao;
begin
  Result := ServiceFinanciamentoPagamentoAlemao.Create;
end;

function TServiceFinanciamentoFactory.PagamentoAmericano: TServiceFinanciamentoPagamentoAmericano;
begin
  Result := TServiceFinanciamentoPagamentoAmericano.Create;
end;

function TServiceFinanciamentoFactory.PagamentoUnico: TServiceFinanciamentoPagamentoUnico;
begin
  Result := TServiceFinanciamentoPagamentoUnico.Create;
end;

function TServiceFinanciamentoFactory.PagamentoVariavel: TServiceFinanciamentoPagamentoVarialvel;
begin
  Result := TServiceFinanciamentoPagamentoVarialvel.Create;
end;

end.
