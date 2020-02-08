program Joguin;

uses
  Forms,
  UJoguin in 'UJoguin.pas' {Fjoguin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Joguin';
  Application.CreateForm(TFjoguin, Fjoguin);
  Application.Run;
end.
