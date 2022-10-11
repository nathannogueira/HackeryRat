unit UCriarServidor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sLabel, sButton, sEdit, EDITSERVER, shellapi;

type
  TFrmCriarServidor = class(TForm)
    EdtIP: TsEdit;
    sButton2: TsButton;
    sButton3: TsButton;
    SaveDialog1: TSaveDialog;
    EdtApelido: TsEdit;
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCriarServidor: TFrmCriarServidor;

implementation

{$R *.dfm}

procedure TFrmCriarServidor.sButton2Click(Sender: TObject);
var
Origem: string;
begin
If SaveDialog1.Execute then
begin
Origem:= ExtractFilePath(ParamStr(0)) + 'server.dll';
CopyFile(PChar(Origem), PChar(SaveDialog1.FileName), true);
InsOrReplaceInFile('IP',SaveDialog1.FileName,EdtIP.Text);
InsOrReplaceInFile('APELIDO',SaveDialog1.FileName,EdtApelido.Text);
ShowMessage('SERVIDOR CRIADO COM SUCESSO!');
end;
end;

procedure TFrmCriarServidor.sButton3Click(Sender: TObject);
begin
Close;
end;

procedure TFrmCriarServidor.FormCreate(Sender: TObject);
begin
 FrmCriarServidor.Left := (Screen.Width  div 2) - ( FrmCriarServidor.Width div 2);
 FrmCriarServidor.Top := (Screen.Height div 2) - ( FrmCriarServidor.Height div 2);
end;

end.
