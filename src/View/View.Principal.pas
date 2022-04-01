unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  View.Pagamento, Vcl.ComCtrls, View.NovoCliente, Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    pnlNav: TPanel;
    pnlMain: TPanel;
    PagePrincipal: TPageControl;
    pnlSimulacao: TPanel;
    imgNovaSimulacao: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnNovaSimulacaoClick(Sender: TObject);
    procedure PosicionarFrameCliente();
    procedure FormShow(Sender: TObject);
    procedure pnlSimulacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    var
      FFrameCliente:TFrameNovoCliente;
    procedure CreateFramePagamento(AOwner:TTabSheet);
    procedure CreateTab(ACliente:string);
    procedure OnCloseCliente();
    procedure NovaSimulacao();
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnNovaSimulacaoClick(Sender: TObject);
begin
  PosicionarFrameCliente;
  FFrameCliente.BringToFront;
  FFrameCliente.Show;
  FFrameCliente.edtNomeCliente.SetFocus;
end;

procedure TfrmPrincipal.CreateFramePagamento(AOwner:TTabSheet);
var
  LFrame:TFramePagamento;
begin
  if not(AOwner is TTabSheet) then
    raise Exception.Create('Owner deve ser do tipo TTabShet');
  LFrame := TFramePagamento.Create(AOwner);
  LFrame.Parent := TTabSheet(AOwner);
  LFrame.Close := procedure ()
                  begin
                    if Assigned(LFrame.Parent) then
                       LFrame.Parent.Free;
                     //OnCloseCliente;
                  end;
end;

procedure TfrmPrincipal.CreateTab(ACliente:string);
var
  LNewTab:TTabSheet;
  LUid: TGuid;
begin
  LNewTab := TTabSheet.Create(PagePrincipal);
  LNewTab.PageControl := PagePrincipal;
  CreateGUID(LUid);
  LNewTab.Name := 'Tab'+GUIDToString(LUid)
                        .Replace('-','',[rfReplaceAll])
                        .Replace('{','',[rfReplaceAll])
                        .Replace('}','',[rfReplaceAll]);
  LNewTab.Caption := ACliente;
  CreateFramePagamento(LNewTab);
  PagePrincipal.TabIndex := LNewTab.TabIndex;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FFrameCliente := TFrameNovoCliente.Create(Self);
  FFrameCliente.Parent := Self;
  FFrameCliente.CloseFrame := OnCloseCliente;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    NovaSimulacao;
    Key := 0;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  FFrameCliente.Hide;
end;

procedure TfrmPrincipal.NovaSimulacao;
begin
  PosicionarFrameCliente;
  FFrameCliente.BringToFront;
  FFrameCliente.Show;
  FFrameCliente.edtNomeCliente.SetFocus;
end;

procedure TfrmPrincipal.OnCloseCliente;
begin
  if FFrameCliente.InNewClitente then
    CreateTab(FFrameCliente.edtNomeCliente.Text);
  FFrameCliente.ClearFields;
  FFrameCliente.Hide;
end;

procedure TfrmPrincipal.pnlSimulacaoClick(Sender: TObject);
begin
  NovaSimulacao();
end;

procedure TfrmPrincipal.PosicionarFrameCliente;
begin
  FFrameCliente.Top := Trunc((Self.Height / 2) - (FFrameCliente.Height/2));
  FFrameCliente.Left := Trunc((Self.Width / 2) - (FFrameCliente.Width/2));
end;

end.
