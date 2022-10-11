unit EditServer;

interface

Uses
Windows, SysUtils, Classes, Forms, ShellAPI, Dialogs;

var Exe: string;

procedure ReadExe;
procedure String2File(String2BeSaved, FileName: string);
procedure ExtractFromFile(DemarcStr: string; DataFile: string; var ExtractedStr: string);
procedure ExtractFromExe(DemarcStr: string; var ExtractedStr: string);
procedure InsOrReplaceInFile(DemarcStr,FileName, ReplacementString: string);
procedure DelFromString(DemarcStr: string; var String2Change: string);
procedure Add2String(DemarcStr, String2Add: string; var String2Alter: string);
function  File2String(FileName: string): string;

implementation

procedure ReadExe;
var
 ExeStream: TFileStream;
begin
 ExeStream := TFileStream.Create(Application.ExeName, fmOpenRead
   or fmShareDenyNone);
 try
   SetLength(Exe, ExeStream.Size);
   ExeStream.ReadBuffer(Pointer(Exe)^, ExeStream.Size);
 finally
   ExeStream.Free;
 end;
end;
//===================================================
procedure String2File(String2BeSaved, FileName: string);
var
 MyStream: TMemoryStream;
begin
 if String2BeSaved = '' then exit;
 SetCurrentDir(ExtractFilePath(Application.ExeName));
 MyStream := TMemoryStream.Create;
 try
   MyStream.WriteBuffer(Pointer(String2BeSaved)^, Length(String2BeSaved));
   MyStream.SaveToFile(FileName);
 finally
   MyStream.Free;
 end;
end;
//===================================================
procedure ExtractFromFile(DemarcStr: string; DataFile: string; var ExtractedStr: string);
var
 d, e: integer;
 Temp: String;
begin
 Temp := File2String(DataFile);
 if Pos(uppercase('so!#' + DemarcStr + chr(182)), Temp) > 0 then
 begin
   d := Pos(uppercase('so!#' + DemarcStr + chr(182)), Temp)
     + length(uppercase('so!#' + DemarcStr + chr(182)));
   e := Pos(uppercase('eo!#' + DemarcStr), Temp);
   ExtractedStr := Copy(Temp, d, e - d);
 end;
end;
//===================================================
procedure ExtractFromExe(DemarcStr: string; var ExtractedStr: string);
var
 d, e: integer;
begin
 if Length(Exe) = 0 then ReadExe;
 if Pos(uppercase('so!#' + DemarcStr + chr(182)), Exe) > 0 then
 begin
   d := Pos(uppercase('so!#' + DemarcStr + chr(182)), Exe)
     + length(uppercase('so!#' + DemarcStr + chr(182)));
   e := Pos(uppercase('eo!#' + DemarcStr), Exe);
   ExtractedStr := Copy(Exe, d, e - d);
 end;
end;
//===================================================
procedure InsOrReplaceInfile(DemarcStr, FileName, ReplacementString: string);
var
Temp: String;
begin
 If DemarcStr = '' then Exit;
 Temp := File2String(FileName);
 DelFromString(DemarcStr, Temp);
 Add2String(DemarcStr, ReplacementString, Temp);
 String2File(Temp, FileName);
end;
//===================================================
procedure DelFromString(DemarcStr: string; var String2Change: string);
var
 a, b: string;
begin
 a := UpperCase('so!#' + DemarcStr + chr(182));
 b := UpperCase('eo!#' + DemarcStr);
 delete(String2Change, pos(a, String2Change), (pos(b, String2Change)
   + length(b) - pos(a, String2Change)));
end;
//====================================================
procedure Add2String(DemarcStr, String2Add: string; var String2Alter: string);
begin
 If DemarcStr = '' then Exit;
 String2Alter := String2Alter + uppercase('so!#' + DemarcStr + chr(182))
   + String2Add + uppercase('eo!#' + DemarcStr);
end;
//====================================================
function File2String(FileName: string): string;
var
 MyStream: TFileStream;
 MyString: string;
begin
 MyStream := TFileStream.Create(FileName, fmOpenRead
   or fmShareDenyNone);
 try
   MyStream.Position := 0;
   SetLength(MyString, MyStream.Size);
   MyStream.ReadBuffer(Pointer(MyString)^, MyStream.Size);
 finally
   MyStream.Free;
 end;
 Result := MyString;
end;
//===================================================

end.
 