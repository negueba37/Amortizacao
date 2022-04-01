unit View.Financiamento;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Imaging.pngimage,
  Model.Helpers.DbGrid,
  Service.Financiamento,
  Service.Financiamento.Factory,
  Model.TThreads.OnShow,
  Model.Helpers.Edit;
type
  TFrameFinanciamento = class(TFrame)
    pnlTop: TPanel;
    Panel2: TPanel;
    cmbSistemaPagamento: TComboBox;
    pnlFields: TPanel;
    edtCapital: TEdit;
    lblCapital: TLabel;
    edtTaxaJuros: TEdit;
    Label1: TLabel;
    edtQtMesses: TEdit;
    Label2: TLabel;
    dbgSimulador: TDBGrid;
    dsFinanciamento: TDataSource;
    Panel3: TPanel;
    Label3: TLabel;
    lblJuros: TLabel;
    lblCaptionJuros: TLabel;
    imgFechar: TImage;
    Label6: TLabel;
    pnlCalcular: TPanel;
    imgCalcular: TImage;
    lblCalcular: TLabel;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    lblCaptionAmortizacao: TLabel;
    lblAmortizacao: TLabel;
    lblCaptionPagamento: TLabel;
    lblPagamento: TLabel;
    procedure imgFecharClick(Sender: TObject);
    procedure lblCalcularClick(Sender: TObject);
    procedure edtCapitalChange(Sender: TObject);
    procedure edtTaxaJurosChange(Sender: TObject);
    procedure cmbSistemaPagamentoChange(Sender: TObject);
  private
    FClose: TProc;
    FFinanciamento:TServiceFinanciamento;
    FFinanciamentoFactory:TServiceFinanciamentoFactory;
    FThreadShow:TThreadShow;
    procedure SetClose(const Value: TProc);
    procedure AjustarGrid();
    procedure Calcular();
    procedure CelarValues();
  public
    procedure OnShow();
    procedure AfterConstruction();override;
    procedure BeforeDestruction();override;
    property Close:TProc read FClose write SetClose;
  end;

implementation

{$R *.dfm}

{ TFrameResultado }

procedure TFrameFinanciamento.AfterConstruction;
begin
  inherited;
  FFinanciamentoFactory := TServiceFinanciamentoFactory.Create;
  Self.Align := alClient;
  cmbSistemaPagamento.ItemIndex := 0;
  FThreadShow := TThreadShow.Create(True);
  FThreadShow.FreeOnTerminate := True;
  FThreadShow.OnShow := OnShow;
  FThreadShow.Start;
end;

procedure TFrameFinanciamento.AjustarGrid;
begin
  dbgSimulador.SetPosition(0,10);
  dbgSimulador.SetPosition(1,15);
  dbgSimulador.SetPosition(2,15);
  dbgSimulador.SetPosition(3,30);
  dbgSimulador.SetPosition(4,30);
end;

procedure TFrameFinanciamento.BeforeDestruction;
begin
  if Assigned(FFinanciamento) then
    FFinanciamento.Free;

  if Assigned(FFinanciamentoFactory) then
    FFinanciamentoFactory.Free;
  inherited;
end;

procedure TFrameFinanciamento.imgFecharClick(Sender: TObject);
begin
  if Assigned(FClose) then
    FClose();
end;

procedure TFrameFinanciamento.lblCalcularClick(Sender: TObject);
begin
  Calcular;
end;

procedure TFrameFinanciamento.Calcular;
begin
  if Assigned(FFinanciamento) then
    FreeAndNil(FFinanciamento);

  case cmbSistemaPagamento.ItemIndex of
    0:FFinanciamento := FFinanciamentoFactory.PagamentoUnico;
    1:FFinanciamento := FFinanciamentoFactory.PagamentoAmericano;
    2:FFinanciamento := FFinanciamentoFactory.PagamentoSAC;
    3:FFinanciamento := FFinanciamentoFactory.PagamentoPrice;
    4:FFinanciamento := FFinanciamentoFactory.PagamentoSAM;
    5:FFinanciamento := FFinanciamentoFactory.PagamentoAlemao;
    else
    begin
      cmbSistemaPagamento.SetFocus;
      raise Exception.Create('Nenhum sistema de amortização selecionado');
    end;

  end;

  if not Assigned(FFinanciamento)then Exit;

  FFinanciamento.DataSource(dsFinanciamento)
                .Capital(edtCapital.ToCurrency)
                .Taxa(edtTaxaJuros.ToCurrency)
                .Messes(edtQtMesses.ToInteger)
                .CalcularFinanciamento;

  lblJuros.Caption := FFinanciamento.Totais.Juros.ToString();
  lblAmortizacao.Caption := FFinanciamento.Totais.Amortizacao.ToString();
  lblPagamento.Caption := FFinanciamento.Totais.Pagamento.ToString();
end;

procedure TFrameFinanciamento.CelarValues;
begin
  lblJuros.Caption := 'R$ 0,00';
  lblAmortizacao.Caption := 'R$ 0,00';
  lblPagamento.Caption := 'R$ 0,00';
  if Assigned(FFinanciamento)then
    FFinanciamento.ClearFields;
end;

procedure TFrameFinanciamento.cmbSistemaPagamentoChange(Sender: TObject);
begin
  CelarValues();
end;

procedure TFrameFinanciamento.edtCapitalChange(Sender: TObject);
begin
  TEdit(Sender).FormatCurrency;
end;

procedure TFrameFinanciamento.edtTaxaJurosChange(Sender: TObject);
begin
  TEdit(Sender).FormatCurrency;
end;

procedure TFrameFinanciamento.OnShow;
begin
  AjustarGrid;
  edtCapital.SetFocus;
end;

procedure TFrameFinanciamento.SetClose(const Value: TProc);
begin
  FClose := Value;
end;
  {
  0-Pagamento Unico
  1-Pagamento Americano
  2-SAC
  3-PRIECE
  4-SAM
  5-Sistema Alemão
  1-Pagamento Variáveis
  }

end.
