unit Model.TThreads.OnShow;

interface

uses
  System.Classes, System.SysUtils;

type
  TThreadShow = class(TThread)
  private
    FOnShow: TProc;
    FInterval: Integer;
    procedure SetInterval(const Value: Integer);
    procedure SetOnShow(const Value: TProc);
    { Private declarations }
  protected
    procedure Execute; override;
  public
    property Interval:Integer read FInterval write SetInterval;
    property OnShow:TProc read FOnShow write SetOnShow;
    procedure AfterConstruction();override;
  end;

implementation

procedure TThreadShow.AfterConstruction;
begin
  inherited;
  FInterval := 120;
end;

procedure TThreadShow.Execute;
begin
  Sleep(Interval);
  if Assigned(FOnShow) then
    FOnShow();
end;

procedure TThreadShow.SetInterval(const Value: Integer);
begin
  FInterval := Value;
end;

procedure TThreadShow.SetOnShow(const Value: TProc);
begin
  FOnShow := Value;
end;

end.
