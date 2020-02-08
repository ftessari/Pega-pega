unit UJoguin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxGDIPlusClasses, jpeg, ExtCtrls, StdCtrls, MMSystem;

type
  TFjoguin = class(TForm)
    Fundo: TImage;
    P: TImage;
    A: TImage;
    PE: TImage;
    PB: TImage;
    PC: TImage;
    PD: TImage;
    AE: TImage;
    AD: TImage;
    TimerP: TTimer;
    TimerA: TTimer;
    Chave: TImage;
    Pontos: TLabel;
    TimerHit: TTimer;
    Label2: TLabel;
    procedure TimerPTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerATimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerHitTimer(Sender: TObject);
    procedure novoJogo();
  private
    { Private declarations }
  public
  var
  SomKey: String;
    { Public declarations }
  end;

var
  Fjoguin: TFjoguin;
  VarPontos: Integer;
  Dir: String;

implementation

function Hit(obj1: TImage; obj2: TImage): boolean;
begin
  Result := true;

  if (obj1.Left + obj1.Width < obj2.Left) or
    (obj1.Left > obj2.Width + obj2.Left) or (obj1.Top + obj1.Height < obj2.Top)
    or (obj1.Top > obj2.Top + obj2.Height) then
    Result := false;
end;
{$R *.dfm}

procedure TFjoguin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TFjoguin.FormCreate(Sender: TObject);
begin
SomKey := Dir + 'item.wav';
  DoubleBuffered := true; // Corrigi efeito psica-pisca
  Dir := extractfilepath(Application.exename);
  novoJogo;
end;

procedure TFjoguin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TFjoguin.TimerATimer(Sender: TObject);
begin
  if (P.Left + P.Width < A.Left) then
  begin
    A.Left := A.Left - 5;
    A.Picture := AE.Picture;
  end;

  if (P.Left > A.Width + A.Left) then
  begin
    A.Left := A.Left + 5;
    A.Picture := AD.Picture;
  end;

  if (P.Top + P.Height < A.Top) then
    A.Top := A.Top - 5;

  if (P.Top > A.Top + A.Height) then
    A.Top := A.Top + 5;
end;

procedure TFjoguin.TimerHitTimer(Sender: TObject);

begin
  if Hit(P, Chave) then
  begin
    randomize;
    Chave.Left := random(800);
    Chave.Top := random(400);
    VarPontos := VarPontos + 1;
    Pontos.Caption := IntToStr(VarPontos);
    randomize;
    A.Left := random(800);
    A.Top := random(400);
    sndPlaySound(PWideChar(SomKey), 0);
  end;

  if Hit(P, A) then
  begin
    TimerP.Enabled := false;
    TimerA.Enabled := false;
    TimerHit.Enabled := false;

    if MessageBox(Handle, PChar('Você foi pego, deseja jogar novamente?'),
      'Fim de Jogo!', MB_YESNO) = mryes then
    begin
      novoJogo;
    end
    else
    begin
      Application.Terminate;
    end;
  end;
end;

procedure TFjoguin.novoJogo();
begin
  Fjoguin.TimerP.Enabled := true;
  Fjoguin.TimerA.Enabled := true;
  Fjoguin.TimerHit.Enabled := true;

  Fjoguin.Chave.Left := random(800);
  Fjoguin.Chave.Top := random(400);

  Fjoguin.A.Left := 780;
  Fjoguin.A.Top := 180;

  Fjoguin.P.Left := 60;
  Fjoguin.P.Top := 200;

  Fjoguin.Pontos.Caption := '0';
  VarPontos := 0;
end;

procedure TFjoguin.TimerPTimer(Sender: TObject);
begin
  if (getkeystate(vk_left) < 0) then
  begin
    P.Left := P.Left - 5;
    P.Picture := PE.Picture;
  end
  else if (getkeystate(vk_Right) < 0) then
  begin
    P.Left := P.Left + 5;
    P.Picture := PD.Picture;
  end
  else if (getkeystate(vk_up) < 0) then
  begin
    P.Top := P.Top - 5;
    P.Picture := PC.Picture;
  end
  else if (getkeystate(vk_down) < 0) then
  begin
    P.Top := P.Top + 5;
    P.Picture := PB.Picture;
  end;

end;

end.
