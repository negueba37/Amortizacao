unit View.NovoCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TFrameNovoCliente = class(TFrame)
    pnlClient: TPanel;
    edtNomeCliente: TEdit;
    btnSalvar: TButton;
    pnlTop: TPanel;
    imgFechar: TImage;
    Panel1: TPanel;
    procedure btnSalvarClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure edtNomeClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FCloseFrame: TProc;
    FNewCliente:Boolean;
    procedure SetCloseFrame(const Value: TProc);
  public
    function InNewClitente:Boolean;
    procedure ClearFields();
    property CloseFrame:TProc read FCloseFrame write SetCloseFrame;
  end;

implementation

{$R *.dfm}

procedure TFrameNovoCliente.btnSalvarClick(Sender: TObject);
begin
  FNewCliente := False;
  if edtNomeCliente.Text = EmptyStr then
    raise Exception.Create('Nome do clinete não informado!');
  FNewCliente := True;
  if Assigned(FCloseFrame) then
    FCloseFrame();
end;

procedure TFrameNovoCliente.ClearFields;
begin
  edtNomeCliente.Clear;
end;

procedure TFrameNovoCliente.edtNomeClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnSalvarClick(Sender);
end;

procedure TFrameNovoCliente.imgFecharClick(Sender: TObject);
begin
  FNewCliente := False;
  if Assigned(FCloseFrame) then
    FCloseFrame();
end;

function TFrameNovoCliente.InNewClitente: Boolean;
begin
  Result := FNewCliente;
end;

procedure TFrameNovoCliente.SetCloseFrame(const Value: TProc);
begin
  FCloseFrame := Value;
end;

end.
