program Financiamento;

uses
  Vcl.Forms,
  Model.Helpers.DbGrid in 'src\Model\Helpers\Model.Helpers.DbGrid.pas',
  Model.Helpers.Edit in 'src\Model\Helpers\Model.Helpers.Edit.pas',
  Model.TThreads.OnShow in 'src\Model\Threads\Model.TThreads.OnShow.pas',
  Service.Financiamento.Factory in 'src\Service\Financiamento\Service.Financiamento.Factory.pas',
  Service.Financiamento.PagamentoAlemao in 'src\Service\Financiamento\Service.Financiamento.PagamentoAlemao.pas',
  Service.Financiamento.PagamentoAmericano in 'src\Service\Financiamento\Service.Financiamento.PagamentoAmericano.pas',
  Service.Financiamento.PagamentoPrice in 'src\Service\Financiamento\Service.Financiamento.PagamentoPrice.pas',
  Service.Financiamento.PagamentoSAC in 'src\Service\Financiamento\Service.Financiamento.PagamentoSAC.pas',
  Service.Financiamento.PagamentoSAM in 'src\Service\Financiamento\Service.Financiamento.PagamentoSAM.pas',
  Service.Financiamento.PagamentoUnico in 'src\Service\Financiamento\Service.Financiamento.PagamentoUnico.pas',
  Service.Financiamento.PagamentoVariavel in 'src\Service\Financiamento\Service.Financiamento.PagamentoVariavel.pas',
  Service.Financiamento in 'src\Service\Financiamento\Service.Financiamento.pas',
  View.NovoCliente in 'src\View\View.NovoCliente.pas' {FrameNovoCliente: TFrame},
  View.Pagamento in 'src\View\View.Pagamento.pas' {FramePagamento: TFrame},
  View.Principal in 'src\View\View.Principal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
