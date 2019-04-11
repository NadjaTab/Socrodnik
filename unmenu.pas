unit unmenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, process, FileUtil, LResources, Forms, Controls,
  Graphics, Dialogs, Menus, StdCtrls;

type

  { TFrmMenuosn }

  TFrmMenuosn = class(TForm)
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    mnuspawgr: TMenuItem;
    mnusprawob: TMenuItem;
    mnast: TMenuItem;
    mruch: TMenuItem;
    MenuOsn: TMainMenu;
    priem: TMenuItem;
    mu: TMenuItem;
    mstat: TMenuItem;
    mnugser: TMenuItem;
    muchet: TMenuItem;
    Process1: TProcess;
    SQLQuery1: TSQLQuery;
    Dzap: TSQLQuery;
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure mnuspawgrClick(Sender: TObject);
    procedure mnusprawobClick(Sender: TObject);
    procedure mruchClick(Sender: TObject);
    procedure muchetClick(Sender: TObject);
    procedure priemClick(Sender: TObject);
    procedure mstatClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FrmMenuosn: TFrmMenuosn;

implementation
uses unlogin, frmsvu, FPY, shelp, kuch, udatv, uspraw, sprawm;
{ TFrmMenuosn }

procedure TFrmMenuosn.priemClick(Sender: TObject);
begin

end;

procedure TFrmMenuosn.muchetClick(Sender: TObject);
begin
  FrmSplash.memFl:='PROSM';
  FSVU.SQLQuery1.Close;
  FSVU.SQLQuery1.SQL.Text:='SELECT DISTINCT *  FROM "F2" WHERE "PAR"=FALSE AND "PSY" IS NULL AND "NKAR" LIKE ''_______00'' ORDER BY "FAMIL"';
  FSVU.SQLQuery1.Open;
  FSVU.SQLQuery1.Active:=True;
  FSVU.SQLQuery1.Last;
  FSVU.SQLQuery1.First;
  FSVU.Grid_nastr();
  FSVU.Caption:='Сведения о гражданах, стоящих на учете ('+IntToStr(fsvu.SQLQuery1.RecordCount)+' семей)';
  frmsvu.FSVU.Show;
end;

procedure TFrmMenuosn.mnusprawobClick(Sender: TObject);
begin
   FrmSplash.memFl:='KAT';
   FrmSprav.Show;
end;

procedure TFrmMenuosn.MenuItem1Click(Sender: TObject);
begin
  FrmSplash.memFl:='NOUCH';
  FSVU.SQLQuery1.Close;
  FSVU.SQLQuery1.SQL.Text:='SELECT DISTINCT *  FROM "F2" WHERE "PAR"=FALSE AND "PSY"<>0 AND "NKAR" LIKE ''_______00'' ORDER BY "FAMIL"';
  FSVU.SQLQuery1.Open;
  FSVU.SQLQuery1.Active:=True;
  FSVU.SQLQuery1.Last;
  FSVU.SQLQuery1.First;
  FSVU.Grid_nastr();
  FSVU.Caption:='Сведения о гражданах, снятых с учета ('+IntToStr(fsvu.SQLQuery1.RecordCount)+' семей)';
  frmsvu.FSVU.Show;
end;

procedure TFrmMenuosn.MenuItem10Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath, sSQL, msdat, mpy, mnkar: String;
    X,pn, mm1, mm2, yy1, yy2, mdy, mk: LongInt;
begin
  FrmSplash.memFl:='STAT';
  FPY.FrmPY.ShowModal;
  if SQLQuery1.Active then SQLQuery1.Close;
  if FrmSplash.memPY<>'' then FrmSplash.memFl:='SPEC';
  Fdatv.ShowModal;

 // SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\otplat.txt');
// ShowMessage(GetEnvironmentVariableUTF8('USERPROFILE'));
  // ShowMessage(CurUser);
 // APath:=GetEnvironmentVariableUTF8('USERPROFILE');
  //AssignFile(f,APath+'\Local Settings\Temp\otplat.txt');
  Rewrite(f);
  pn:=0;
  msdat:=Fdatv.DateEdit1.Text;
  mm1:=StrToInt(Copy(msdat,4,2));
  yy1:=StrToInt(Copy(msdat,7,4));
  mm2:=StrToInt(Copy(Fdatv.DateEdit2.Text,4,2));
  yy2:=StrToInt(Copy(Fdatv.DateEdit2.Text,7,4));

       if SQLQuery1.Active then SQLQuery1.Close;
       sSQL:= 'SELECT "F2"."FAMIL","F2"."IMJA","F2"."OTCH","F2"."POL","F2"."DROG","MEROP"."DATA","MEROP"."KVD","MEROP"."NKAR","MEROP"."PY"';
       sSQL:= sSQL +' FROM "F2","MEROP" WHERE "F2"."PY"="MEROP"."PY" AND "F2"."NKAR"="MEROP"."NKAR" AND "F2"."PLATA"=''П''';
        sSQL:=sSQL+' AND "MEROP"."DATA" BETWEEN '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+'''';
       if FrmSplash.memPY<>'024' then sSQL:=sSQL+' AND "F2"."PY"='''+FrmSplash.memPY+'''';
       if Fdatv.ComboBox1.Text<>'' Then begin
         if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+Fdatv.ComboBox1.Text+'''';
         SQLQuery1.Open;
         sSQL:=sSQL+' AND "MEROP"."KISP"='+SQLQuery1.FieldByName('KISP').Text ;
         SQLQuery1.Close;
        end;
        sSQL:=sSQL+' ORDER BY "FAMIL","IMJA","OTCH","MEROP"."KVD"';
        SQLQuery1.SQL.Text:=sSQL;
        SQLQuery1.Open;
        SQLQuery1.First;
       // writeln(f,UTF8ToAnsi(sSQL));
        while Not SQLQuery1.EOF do begin
              pn:= pn + 1;
              s:= 'N:'+IntToStr(pn);
              writeln(f,UTF8ToAnsi(s));
              if Copy(SQLQuery1.FieldByName('NKAR').Text,8,2)='00' then
               begin
                 ms:=SQLQuery1.FieldByName('IMJA').Text;
                 s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                 ms:=SQLQuery1.FieldByName('OTCH').Text;
                 s:=s+Copy(ms,1,2)+'.';

               end
              else begin
                   if Dzap.Active then Dzap.Close;
                   Dzap.SQL.Text:='SELECT "FAMIL","IMJA","OTCH" FROM "F2" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
                   Dzap.Open;
                   ms:=Dzap.FieldByName('IMJA').Text;
                   s:= 'ФИО:'+ Dzap.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:= Dzap.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'. реб.(';
                   ms:=SQLQuery1.FieldByName('IMJA').Text;
                   s:= s+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:=SQLQuery1.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'.)';
              end;
              writeln(f,UTF8ToAnsi(s));
              mpy:= SQLQuery1.FieldByName('PY').Text;
              mnkar:=SQLQuery1.FieldByName('NKAR').Text;
              s:='ПОЛВОЗРАСТ:';
              if Trim(SQLQuery1.FieldByName('POL').Text)='2' then
               s:=s+'муж., '
               else s:=s+'жен., ';
              mdy:=StrToInt(Copy(SQLQuery1.FieldByName('DROG').Text,7,4));
              s:=s+IntToStr(yy2-mdy);
              writeln(f,UTF8ToAnsi(s));
              if Dzap.Active then Dzap.Close;
              Dzap.SQL.Text:='SELECT "NKOD" FROM "S1","F1" WHERE "S1"."KOD"="F1"."KOD" AND "F1"."PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "F1"."NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
              Dzap.Open;
              s:='Статус:'+Dzap.FieldByName('NKOD').Text;
              writeln(f,UTF8ToAnsi(s));
              if Dzap.Active then Dzap.Close;
              Dzap.SQL.Text:='SELECT "NAIM" FROM "OTDEL" WHERE "OTD"='''+SQLQuery1.FieldByName('PY').Text+'''';
              Dzap.Open;
              s:='Отдел:'+Dzap.FieldByName('NAIM').Text;
              writeln(f,UTF8ToAnsi(s));
              mk:=0;
              while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) do begin
                    if mk>0 then begin
                      s:='%ТАБЛИЦА';
                      writeln(f,UTF8ToAnsi(s));
                      s:= 'N: ';
                      writeln(f,UTF8ToAnsi(s));
                      s:= 'ФИО: ';
                      writeln(f,UTF8ToAnsi(s));
                      s:='ПОЛВОЗРАСТ: ';
                      writeln(f,UTF8ToAnsi(s));
                      s:='Статус: ';
                      writeln(f,UTF8ToAnsi(s));
                      s:='Отдел: ';
                      writeln(f,UTF8ToAnsi(s));
                    end;
                    mkod:=SQLQuery1.FieldByName('KVD').Text;
                    if Dzap.Active then Dzap.Close;
                    Dzap.SQL.Text:='SELECT "NKOD","NUM" FROM "SVD" WHERE "SVD"."KOD"='''+mkod+'''';
                    Dzap.Open;
                    s:='Услуга:';
                    sl:='';
                    sl:=Dzap.FieldByName('NUM').Text;
                    Case sl of
                         '1.1.','1.3.','1.4.','1.10.','1.11.','1.12.','1.13.','1.14.','8.2.','8.3.','8.5.','8.7.' : s:=s+'Соц.-бытовая('+Dzap.FieldByName('NKOD').Text+')';
                         '2.2.','2.3.','2.4.','2.6.','2.7.','2.8.' : s:=s+'Соц.-медицинская('+Dzap.FieldByName('NKOD').Text+')';
                         '4.1.' : s:=s+'Соц.-психологическая('+Dzap.FieldByName('NKOD').Text+')';
                         '5.1.','5.2.' : s:=s+'Соц.-педагогическая('+Dzap.FieldByName('NKOD').Text+')';
                         '6.1.','7.3.','7.4.' : s:=s+'Соц.-экономическая('+Dzap.FieldByName('NKOD').Text+')';
                         '7.2.','7.6.','7.7.' : s:=s+'Соц.-правовая('+Dzap.FieldByName('NKOD').Text+')';
                    end;
                    writeln(f,UTF8ToAnsi(s));
                    s:='Количество:';
                    X:=0;
                    while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) And (SQLQuery1.FieldByName('KVD').Text=mkod) do begin
                          X:=X+1;
                     //     if (Copy(SQLQuery1.FieldByName('DATA').Text,4,10)<>mmes) then begin
                     //         mmes:=Copy(SQLQuery1.FieldByName('DATA').Text,4,10);
                     //         mpos[X]:=mpos[X]+1;
                     //     end;
                          SQLQuery1.Next;
                          if SQLQuery1.EOF then break;
                    end;
                    s:=s+IntToStr(X);
                    writeln(f,UTF8ToAnsi(s));
                    mk:=mk+1;
                    if SQLQuery1.EOF then break;
              end;
              s:='%ТАБЛИЦА';
              writeln(f,UTF8ToAnsi(s));
        end;

  if Fdatv.ComboBox1.Text<>'' Then s:='Специалист по социальной работе: '+Fdatv.ComboBox1.Text
  else s:='Специалист по социальной работе: По всем';
  writeln(f,UTF8ToAnsi(s));
  s:='Категория: '+FrmPY.ListBox1.GetSelectedText;
  writeln(f,UTF8ToAnsi(s));
  s:='Период с: '+Fdatv.DateEdit1.Text+' по: '+Fdatv.DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='Отчет сформирован: '+DateToStr(NOW());
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c otplat.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
end;

procedure TFrmMenuosn.MenuItem11Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath, sSQL, msdat, mpy, mnkar: String;
    X,pn, mm1, mm2, yy1, yy2, mk: LongInt;

begin
  FrmSplash.memFl:='STAT';
  FPY.FrmPY.ShowModal;
  if SQLQuery1.Active then SQLQuery1.Close;
  if FrmSplash.memPY<>'' then FrmSplash.memFl:='SPEC';
  Fdatv.ShowModal;

 // SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\otspovp.txt');
//  APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\otspvp.txt');
  Rewrite(f);
  pn:=0;
  msdat:=Fdatv.DateEdit1.Text;
  mm1:=StrToInt(Copy(msdat,4,2));
  yy1:=StrToInt(Copy(msdat,7,4));
  mm2:=StrToInt(Copy(Fdatv.DateEdit2.Text,4,2));
  yy2:=StrToInt(Copy(Fdatv.DateEdit2.Text,7,4));

       if SQLQuery1.Active then SQLQuery1.Close;
       sSQL:= 'SELECT "F2"."FAMIL","F2"."IMJA","F2"."OTCH","MEROP"."DATA","MEROP"."KVD","MEROP"."NKAR","MEROP"."PY","S20"."NISP"';
       sSQL:= sSQL +' FROM "F2","MEROP","S20" WHERE "F2"."PY"="MEROP"."PY" AND "F2"."NKAR"="MEROP"."NKAR" AND "MEROP"."KISP"="S20"."KISP"' ;
       sSQL:=sSQL+' AND "MEROP"."DATA" BETWEEN '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+'''';

       if FrmSplash.memPY<>'024' then sSQL:=sSQL+' AND "F2"."PY"='''+FrmSplash.memPY+'''';
       if Fdatv.ComboBox1.Text<>'' Then begin
         if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+Fdatv.ComboBox1.Text+'''';
         SQLQuery1.Open;
         sSQL:=sSQL+' AND "MEROP"."KISP"='+SQLQuery1.FieldByName('KISP').Text ;
         SQLQuery1.Close;
        end;
        sSQL:=sSQL+' ORDER BY "FAMIL","IMJA","OTCH","MEROP"."DATA","MEROP"."KVD"';
        SQLQuery1.SQL.Text:=sSQL;
        SQLQuery1.Open;
        SQLQuery1.First;
       // writeln(f,UTF8ToAnsi(sSQL));
        while Not SQLQuery1.EOF do begin
              pn:= pn + 1;
              s:= 'N:'+IntToStr(pn);
              writeln(f,UTF8ToAnsi(s));
              if Copy(SQLQuery1.FieldByName('NKAR').Text,8,2)='00' then
               begin
                 ms:=SQLQuery1.FieldByName('IMJA').Text;
                 s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                 ms:=SQLQuery1.FieldByName('OTCH').Text;
                 s:=s+Copy(ms,1,2)+'.';

               end
              else begin
                   if Dzap.Active then Dzap.Close;
                   Dzap.SQL.Text:='SELECT "FAMIL","IMJA","OTCH" FROM "F2" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
                   Dzap.Open;
                   ms:=Dzap.FieldByName('IMJA').Text;
                   s:= 'ФИО:'+ Dzap.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:= Dzap.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'. реб.(';
                   ms:=SQLQuery1.FieldByName('IMJA').Text;
                   s:= s+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:=SQLQuery1.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'.)';
              end;
              writeln(f,UTF8ToAnsi(s));
              mpy:= SQLQuery1.FieldByName('PY').Text;
              mnkar:=SQLQuery1.FieldByName('NKAR').Text;
              mk:=0;
              while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) do begin
                    if mk>0 then begin
                       s:= 'N: ';
                       writeln(f,UTF8ToAnsi(s));
                       s:= 'ФИО: ';
                       writeln(f,UTF8ToAnsi(s));
                    end;
                    mkod:=Copy(SQLQuery1.FieldByName('KVD').Text,1,2);
                    msdat:=SQLQuery1.FieldByName('DATA').Text;
                    s:='ДАТА:'+SQLQuery1.FieldByName('DATA').Text;
                    writeln(f,UTF8ToAnsi(s));
                    s:='СПЕЦ:'+SQLQuery1.FieldByName('NISP').Text;
                    writeln(f,UTF8ToAnsi(s));
                    if Dzap.Active then Dzap.Close;
                    Dzap.SQL.Text:='SELECT * FROM "SVD" WHERE "KOD"='''+mkod+'''';
                    Dzap.Open;
                    s:= 'УСЛУГА:'+Dzap.FieldByName('NKOD').Text;
                    writeln(f,UTF8ToAnsi(s));
                    X:=0;
                    while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) And (Copy(SQLQuery1.FieldByName('KVD').Text,1,2)=mkod) And (SQLQuery1.FieldByName('DATA').Text=msdat) do begin
                          X:=X+1;
                          SQLQuery1.Next;
                          if SQLQuery1.EOF then break;
                    end;
                    s:='КОЛ-ВО:'+ IntToStr(X);
                    writeln(f,UTF8ToAnsi(s));
                    s:='%ТАБЛИЦА';
                    writeln(f,UTF8ToAnsi(s));
                    mk:=mk+1;
                    if SQLQuery1.EOF then break;
              end;
             // for X:=1 to 14 do begin
             //     if md[X]<>0 then s:=IntToStr(X)+':'+intToStr(md[X])
             //     else s:=IntToStr(X)+': ';
             //     writeln(f,UTF8ToAnsi(s));
             // end;
            //  s:='%ТАБЛИЦА';
            //  writeln(f,UTF8ToAnsi(s));
        end;


  if Fdatv.ComboBox1.Text<>'' Then s:='Специалист по социальной работе: '+Fdatv.ComboBox1.Text
  else s:='Специалист по социальной работе: По всем';
  writeln(f,UTF8ToAnsi(s));
  s:='Категория: '+FrmPY.ListBox1.GetSelectedText;
  writeln(f,UTF8ToAnsi(s));
  s:='Период с: '+Fdatv.DateEdit1.Text+' по: '+Fdatv.DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='Отчет сформирован: '+DateToStr(NOW());
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c otspovp.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
end;



procedure TFrmMenuosn.MenuItem2Click(Sender: TObject);
begin
  FrmSplash.memFl:='ARHIV';
  FSVU.SQLQuery1.Close;
  FSVU.SQLQuery1.SQL.Text:='SELECT DISTINCT *  FROM "F2" WHERE "PAR"=TRUE AND "NKAR" LIKE ''_______00'' ORDER BY "FAMIL"';
  FSVU.SQLQuery1.Open;
  FSVU.SQLQuery1.Active:=True;
  FSVU.SQLQuery1.Last;
  FSVU.SQLQuery1.First;
  FSVU.Grid_nastr();
  FSVU.Caption:='Список карточек в архиве ('+IntToStr(fsvu.SQLQuery1.RecordCount)+' семей)';
  frmsvu.FSVU.Show;
end;

procedure TFrmMenuosn.MenuItem4Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath, sSQL, msdat, mpy, mnkar: String;
    X,pn, mm1, mm2, yy1, yy2: LongInt;
    md: array[1..27] of Integer;
begin
  FrmSplash.memFl:='STAT';
  FPY.FrmPY.ShowModal;
  if SQLQuery1.Active then SQLQuery1.Close;
  if FrmSplash.memPY<>'' then FrmSplash.memFl:='SPEC';
  Fdatv.ShowModal;

 // SQLQuery1.First;
//  APath:=GetEnvironmentVariableUTF8('USERPROFILE');
//  AssignFile(f,APath+'\Local Settings\Temp\otspgor.txt');
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\otspgor.txt');
  Rewrite(f);
  pn:=0;
  msdat:=Fdatv.DateEdit1.Text;
  mm1:=StrToInt(Copy(msdat,4,2));
  yy1:=StrToInt(Copy(msdat,7,4));
  mm2:=StrToInt(Copy(Fdatv.DateEdit2.Text,4,2));
  yy2:=StrToInt(Copy(Fdatv.DateEdit2.Text,7,4));
  repeat begin
       if SQLQuery1.Active then SQLQuery1.Close;
       sSQL:= 'SELECT "F2"."FAMIL","F2"."IMJA","F2"."OTCH","F2"."PLATA","MEROP"."DATA","MEROP"."KVD","MEROP"."NKAR","MEROP"."PY","SVD"."NUM"';
       sSQL:= sSQL +' FROM "F2","MEROP","SVD" WHERE "F2"."PY"="MEROP"."PY" AND "F2"."NKAR"="MEROP"."NKAR" AND "MEROP"."KVD"="SVD"."KOD"';
       if (mm1=mm2) and (yy1=yy2) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" BETWEEN '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+'''';
       if (mm1<>mm2) and (yy1=StrToInt(Copy(msdat,7,4))) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" >='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if (mm1=mm2) and (yy1=yy2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND "MEROP"."DATA" <='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm2)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy2);
       if (mm1<>mm2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if FrmSplash.memPY<>'024' then sSQL:=sSQL+' AND "F2"."PY"='''+FrmSplash.memPY+'''';
       if Fdatv.ComboBox1.Text<>'' Then begin
         if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+Fdatv.ComboBox1.Text+'''';
         SQLQuery1.Open;
         sSQL:=sSQL+' AND "MEROP"."KISP"='+SQLQuery1.FieldByName('KISP').Text ;
         SQLQuery1.Close;
        end;
        sSQL:=sSQL+' ORDER BY "FAMIL","IMJA","OTCH","MEROP"."DATA","SVD"."NUM"';
        SQLQuery1.SQL.Text:=sSQL;
        SQLQuery1.Open;
        SQLQuery1.First;
       // writeln(f,UTF8ToAnsi(sSQL));
        while Not SQLQuery1.EOF do begin
              pn:= pn + 1;
              s:= 'N:'+IntToStr(pn);
              writeln(f,UTF8ToAnsi(s));
              if Copy(SQLQuery1.FieldByName('NKAR').Text,8,2)='00' then
               begin
                 ms:=SQLQuery1.FieldByName('IMJA').Text;
                 s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                 ms:=SQLQuery1.FieldByName('OTCH').Text;
                 s:=s+Copy(ms,1,2)+'.';

               end
              else begin
                   if Dzap.Active then Dzap.Close;
                   Dzap.SQL.Text:='SELECT "FAMIL","IMJA","OTCH" FROM "F2" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
                   Dzap.Open;
                   ms:=Dzap.FieldByName('IMJA').Text;
                   s:= 'ФИО:'+ Dzap.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:= Dzap.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'. реб.(';
                   ms:=SQLQuery1.FieldByName('IMJA').Text;
                   s:= s+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:=SQLQuery1.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'.)';
              end;
              writeln(f,UTF8ToAnsi(s));
              mpy:= SQLQuery1.FieldByName('PY').Text;
              mnkar:=SQLQuery1.FieldByName('NKAR').Text;
              for X:=1 to 27 do md[X]:=0;
              while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) do begin
                    mkod:=SQLQuery1.FieldByName('NUM').Text;
                  //  mmes:='';
                    Case mkod of
                         '1.1.' : X:=1;
                         '1.3.' : X:=2;
                         '1.4.' : X:=3;
                         '1.10.': X:=4;
                         '1.11.': X:=5;
                         '1.12.': X:=6;
                         '1.13.': X:=7;
                         '1.14.': X:=8;
                         '2.2.' : X:=9;
                         '2.3.' : X:=10;
                         '2.4.' : X:=11;
                         '2.6.' : X:=12;
                         '2.7.' : X:=13;
                         '2.8.' : X:=14;
                         '4.1.' : X:=15;
                         '5.1.' : X:=16;
                         '5.2.' : X:=17;
                         '6.1.' : X:=18;
                         '7.2.' : X:=19;
                         '7.3.' : X:=20;
                         '7.4.' : X:=21;
                         '7.6.' : X:=22;
                         '7.7.' : X:=23;
                         '8.2.' : X:=24;
                         '8.3.' : X:=25;
                         '8.5.' : X:=26;
                         '8.7.' : X:=27;
                         else X:=23;
                    end;
                    while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) And (SQLQuery1.FieldByName('NUM').Text=mkod) do begin
                          md[X]:=md[X]+1;
                     //     if (Copy(SQLQuery1.FieldByName('DATA').Text,4,10)<>mmes) then begin
                     //         mmes:=Copy(SQLQuery1.FieldByName('DATA').Text,4,10);
                     //         mpos[X]:=mpos[X]+1;
                     //     end;
                          SQLQuery1.Next;
                          if SQLQuery1.EOF then break;
                    end;
                    if SQLQuery1.EOF then break;
              end;
              for X:=1 to 27 do begin
                  if md[X]<>0 then s:=IntToStr(X)+':'+intToStr(md[X])
                  else s:=IntToStr(X)+': ';
                  writeln(f,UTF8ToAnsi(s));
              end;
              s:='%ТАБЛИЦА';
              writeln(f,UTF8ToAnsi(s));
        end;
        if (mm1 = mm2) and (yy1=yy2) then break;
        mm1:=mm1+1;
        if mm1=13 then begin
          mm1:=1;
          yy1:=yy1+1;
        end;
  end;
  until (mm1-1 = mm2) and (yy1=yy2);
  if Fdatv.ComboBox1.Text<>'' Then s:='Специалист по социальной работе: '+Fdatv.ComboBox1.Text
  else s:='Специалист по социальной работе: По всем';
  writeln(f,UTF8ToAnsi(s));
  s:='Категория: '+FrmPY.ListBox1.GetSelectedText;
  writeln(f,UTF8ToAnsi(s));
  s:='Период с: '+Fdatv.DateEdit1.Text+' по: '+Fdatv.DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='Отчет сформирован: '+DateToStr(NOW());
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c otspgor.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
//  SQLQuery1.First;
end;

procedure TFrmMenuosn.MenuItem5Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath, sSQL, msdat, mpy, mnkar: String;
    X,pn, mm1, mm2, yy1, yy2: LongInt;
    md: array[1..26] of Integer;
begin
  FrmSplash.memFl:='STAT';
  FPY.FrmPY.ShowModal;
  if SQLQuery1.Active then SQLQuery1.Close;
  if FrmSplash.memPY<>'' then FrmSplash.memFl:='SPEC';
  Fdatv.ShowModal;

 // SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\otspvp.txt');
//  APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\otspvp.txt');
  Rewrite(f);
  pn:=0;
  msdat:=Fdatv.DateEdit1.Text;
  mm1:=StrToInt(Copy(msdat,4,2));
  yy1:=StrToInt(Copy(msdat,7,4));
  mm2:=StrToInt(Copy(Fdatv.DateEdit2.Text,4,2));
  yy2:=StrToInt(Copy(Fdatv.DateEdit2.Text,7,4));
  repeat begin
       if SQLQuery1.Active then SQLQuery1.Close;
       sSQL:= 'SELECT "F2"."FAMIL","F2"."IMJA","F2"."OTCH","F2"."PLATA","MEROP"."DATA","MEROP"."KVD","MEROP"."NKAR","MEROP"."PY","F2"."REG","F2"."NASP"';
       sSQL:= sSQL +' FROM "F2","MEROP" WHERE "F2"."PY"="MEROP"."PY" AND "F2"."NKAR"="MEROP"."NKAR"' ;
       if (mm1=mm2) and (yy1=yy2) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" BETWEEN '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+'''';
       if (mm1<>mm2) and (yy1=StrToInt(Copy(msdat,7,4))) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" >='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if (mm1=mm2) and (yy1=yy2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND "MEROP"."DATA" <='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm2)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy2);
       if (mm1<>mm2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if FrmSplash.memPY<>'024' then sSQL:=sSQL+' AND "F2"."PY"='''+FrmSplash.memPY+'''';
       if Fdatv.ComboBox1.Text<>'' Then begin
         if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+Fdatv.ComboBox1.Text+'''';
         SQLQuery1.Open;
         sSQL:=sSQL+' AND "MEROP"."KISP"='+SQLQuery1.FieldByName('KISP').Text ;
         SQLQuery1.Close;
        end;
        sSQL:=sSQL+' ORDER BY "FAMIL","IMJA","OTCH","MEROP"."DATA","MEROP"."KVD"';
        SQLQuery1.SQL.Text:=sSQL;
        SQLQuery1.Open;
        SQLQuery1.First;
       // writeln(f,UTF8ToAnsi(sSQL));
        while Not SQLQuery1.EOF do begin
              pn:= pn + 1;
              s:= 'N:'+IntToStr(pn);
              writeln(f,UTF8ToAnsi(s));
              if Copy(SQLQuery1.FieldByName('NKAR').Text,8,2)='00' then
               begin
                 ms:=SQLQuery1.FieldByName('IMJA').Text;
                 s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                 ms:=SQLQuery1.FieldByName('OTCH').Text;
                 s:=s+Copy(ms,1,2)+'.';

               end
              else begin
                   if Dzap.Active then Dzap.Close;
                   Dzap.SQL.Text:='SELECT "FAMIL","IMJA","OTCH" FROM "F2" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
                   Dzap.Open;
                   ms:=Dzap.FieldByName('IMJA').Text;
                   s:= 'ФИО:'+ Dzap.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:= Dzap.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'. реб.(';
                   ms:=SQLQuery1.FieldByName('IMJA').Text;
                   s:= s+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:=SQLQuery1.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'.)';
              end;
              writeln(f,UTF8ToAnsi(s));
              mpy:= SQLQuery1.FieldByName('PY').Text;
              mnkar:=SQLQuery1.FieldByName('NKAR').Text;
              s:='РЕГ:';
              if Trim(SQLQuery1.FieldByName('NASP').Text)='г.Красноярск' then
               s:=s+'Г'
               else if Trim(SQLQuery1.FieldByName('REG').Text)='Красноярский край' then
                s:=s+'К'
                else s:=s+'Р';
              writeln(f,UTF8ToAnsi(s));
              if Dzap.Active then Dzap.Close;
              Dzap.SQL.Text:='SELECT "KOD" FROM "F1" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
              Dzap.Open;
              s:='ИП:';
              if Dzap.FieldByName('KOD').Text='45' then s:=s+'П'
                 else if Copy(Dzap.FieldByName('KOD').Text,1,2)='21' then s:=s+'И'
                 else s:=s+'';
              writeln(f,UTF8ToAnsi(s));
              s:='ОС:';
              writeln(f,UTF8ToAnsi(s));
              for X:=1 to 14 do md[X]:=0;
              while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) do begin
                    mkod:=Copy(SQLQuery1.FieldByName('KVD').Text,1,2);
                  //  mmes:='';
                    Case mkod of
                         '08','09' : X:=1;
                         '03','05','17' : X:=2;
                         '31': X:=3;
                         '06': X:=4;
                         '29': X:=5;
                         '12': X:=6;
                         '34': X:=7;
                         '37': X:=8;
                         '36': X:=9;
                         '01','18','24','35','13','27' : X:=10;
                         '26' : X:=11;
                         '19' : X:=12;
                         '10' : X:=13;
                         '38' : X:=14;
                    end;
                    while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) And (Copy(SQLQuery1.FieldByName('KVD').Text,1,2)=mkod) do begin
                          md[X]:=md[X]+1;
                     //     if (Copy(SQLQuery1.FieldByName('DATA').Text,4,10)<>mmes) then begin
                     //         mmes:=Copy(SQLQuery1.FieldByName('DATA').Text,4,10);
                     //         mpos[X]:=mpos[X]+1;
                     //     end;
                          SQLQuery1.Next;
                          if SQLQuery1.EOF then break;
                    end;
                    if SQLQuery1.EOF then break;
              end;
              for X:=1 to 14 do begin
                  if md[X]<>0 then s:=IntToStr(X)+':'+intToStr(md[X])
                  else s:=IntToStr(X)+': ';
                  writeln(f,UTF8ToAnsi(s));
              end;
              s:='%ТАБЛИЦА';
              writeln(f,UTF8ToAnsi(s));
        end;
        if (mm1 = mm2) and (yy1=yy2) then break;
        mm1:=mm1+1;
        if mm1=13 then begin
          mm1:=1;
          yy1:=yy1+1;
        end;
  end;
  until (mm1-1 = mm2) and (yy1=yy2);
  if Fdatv.ComboBox1.Text<>'' Then s:='Специалист по социальной работе: '+Fdatv.ComboBox1.Text
  else s:='Специалист по социальной работе: По всем';
  writeln(f,UTF8ToAnsi(s));
  s:='Категория: '+FrmPY.ListBox1.GetSelectedText;
  writeln(f,UTF8ToAnsi(s));
  s:='Период с: '+Fdatv.DateEdit1.Text+' по: '+Fdatv.DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='Отчет сформирован: '+DateToStr(NOW());
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c otspvp.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
//  SQLQuery1.First;
end;

procedure TFrmMenuosn.MenuItem6Click(Sender: TObject);
begin
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c backup.bat';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
end;

procedure TFrmMenuosn.MenuItem7Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath, sSQL, msdat, mpy, mnkar: String;
    X,pn, mm1, mm2, yy1, yy2: LongInt;
    md: array[1..27] of Integer;
begin
  FrmSplash.memFl:='STAT';
  FPY.FrmPY.ShowModal;
  if SQLQuery1.Active then SQLQuery1.Close;
  if FrmSplash.memPY<>'' then FrmSplash.memFl:='SPEC';
  Fdatv.ShowModal;

 // SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\otspgor.txt');
 // APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\otspgor.txt');
  Rewrite(f);
  pn:=0;
  msdat:=Fdatv.DateEdit1.Text;
  mm1:=StrToInt(Copy(msdat,4,2));
  yy1:=StrToInt(Copy(msdat,7,4));
  mm2:=StrToInt(Copy(Fdatv.DateEdit2.Text,4,2));
  yy2:=StrToInt(Copy(Fdatv.DateEdit2.Text,7,4));
  repeat begin
       if SQLQuery1.Active then SQLQuery1.Close;
       sSQL:= 'SELECT "F2"."FAMIL","F2"."IMJA","F2"."OTCH","F2"."PLATA","MEROP"."DATA","MEROP"."KVD","MEROP"."NKAR","MEROP"."PY","SVD"."NUM"';
       sSQL:= sSQL +' FROM "F2","F1","MEROP","SVD" WHERE "F2"."PY"="MEROP"."PY" AND "F2"."NKAR"="MEROP"."NKAR" AND "F2"."PY"="F1"."PY" AND "F2"."NKAR"="F1"."NKAR" AND "MEROP"."KVD"="SVD"."KOD" AND "F1"."KOD" LIKE ''21__''';
       if (mm1=mm2) and (yy1=yy2) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" BETWEEN '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+'''';
       if (mm1<>mm2) and (yy1=StrToInt(Copy(msdat,7,4))) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" >='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if (mm1=mm2) and (yy1=yy2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND "MEROP"."DATA" <='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm2)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy2);
       if (mm1<>mm2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if FrmSplash.memPY<>'024' then sSQL:=sSQL+' AND "F2"."PY"='''+FrmSplash.memPY+'''';
       if Fdatv.ComboBox1.Text<>'' Then begin
         if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+Fdatv.ComboBox1.Text+'''';
         SQLQuery1.Open;
         sSQL:=sSQL+' AND "MEROP"."KISP"='+SQLQuery1.FieldByName('KISP').Text ;
         SQLQuery1.Close;
        end;
        sSQL:=sSQL+' ORDER BY "FAMIL","IMJA","OTCH","MEROP"."DATA","SVD"."NUM"';
        SQLQuery1.SQL.Text:=sSQL;
        SQLQuery1.Open;
        SQLQuery1.First;
       // writeln(f,UTF8ToAnsi(sSQL));
        while Not SQLQuery1.EOF do begin
              pn:= pn + 1;
              s:= 'N:'+IntToStr(pn);
              writeln(f,UTF8ToAnsi(s));
              if Copy(SQLQuery1.FieldByName('NKAR').Text,8,2)='00' then
               begin
                 ms:=SQLQuery1.FieldByName('IMJA').Text;
                 s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                 ms:=SQLQuery1.FieldByName('OTCH').Text;
                 s:=s+Copy(ms,1,2)+'.';

               end
              else begin
                   if Dzap.Active then Dzap.Close;
                   Dzap.SQL.Text:='SELECT "FAMIL","IMJA","OTCH" FROM "F2" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
                   Dzap.Open;
                   ms:=Dzap.FieldByName('IMJA').Text;
                   s:= 'ФИО:'+ Dzap.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:= Dzap.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'. реб.(';
                   ms:=SQLQuery1.FieldByName('IMJA').Text;
                   s:= s+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:=SQLQuery1.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'.)';
              end;
              writeln(f,UTF8ToAnsi(s));
              mpy:= SQLQuery1.FieldByName('PY').Text;
              mnkar:=SQLQuery1.FieldByName('NKAR').Text;
              for X:=1 to 27 do md[X]:=0;
              while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) do begin
                    mkod:=SQLQuery1.FieldByName('NUM').Text;
                  //  mmes:='';
                    Case mkod of
                         '1.1.' : X:=1;
                         '1.3.' : X:=2;
                         '1.4.' : X:=3;
                         '1.10.': X:=4;
                         '1.11.': X:=5;
                         '1.12.': X:=6;
                         '1.13.': X:=7;
                         '1.14.': X:=8;
                         '2.2.' : X:=9;
                         '2.3.' : X:=10;
                         '2.4.' : X:=11;
                         '2.6.' : X:=12;
                         '2.7.' : X:=13;
                         '2.8.' : X:=14;
                         '4.1.' : X:=15;
                         '5.1.' : X:=16;
                         '5.2.' : X:=17;
                         '6.1.' : X:=18;
                         '7.2.' : X:=19;
                         '7.3.' : X:=20;
                         '7.4.' : X:=21;
                         '7.6.' : X:=22;
                         '7.7.' : X:=23;
                         '8.2.' : X:=24;
                         '8.3.' : X:=25;
                         '8.5.' : X:=26;
                         '8.7.' : X:=27;
                         else X:=23;
                    end;
                    while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) And (SQLQuery1.FieldByName('NUM').Text=mkod) do begin
                          md[X]:=md[X]+1;
                     //     if (Copy(SQLQuery1.FieldByName('DATA').Text,4,10)<>mmes) then begin
                     //         mmes:=Copy(SQLQuery1.FieldByName('DATA').Text,4,10);
                     //         mpos[X]:=mpos[X]+1;
                     //     end;
                          SQLQuery1.Next;
                          if SQLQuery1.EOF then break;
                    end;
                    if SQLQuery1.EOF then break;
              end;
              for X:=1 to 27 do begin
                  if md[X]<>0 then s:=IntToStr(X)+':'+intToStr(md[X])
                  else s:=IntToStr(X)+': ';
                  writeln(f,UTF8ToAnsi(s));
              end;
              s:='%ТАБЛИЦА';
              writeln(f,UTF8ToAnsi(s));
        end;
        if (mm1 = mm2) and (yy1=yy2) then break;
        mm1:=mm1+1;
        if mm1=13 then begin
          mm1:=1;
          yy1:=yy1+1;
        end;
  end;
  until (mm1-1 = mm2) and (yy1=yy2);
  if Fdatv.ComboBox1.Text<>'' Then s:='Специалист по социальной работе: '+Fdatv.ComboBox1.Text
  else s:='Специалист по социальной работе: По всем';
  writeln(f,UTF8ToAnsi(s));
  s:='Категория: Инвалиды  Группа учета: '+FrmPY.ListBox1.GetSelectedText;
  writeln(f,UTF8ToAnsi(s));
  s:='Период с: '+Fdatv.DateEdit1.Text+' по: '+Fdatv.DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='Отчет сформирован: '+DateToStr(NOW());
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c otspgor.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
end;

procedure TFrmMenuosn.MenuItem8Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath, sSQL, msdat, mpy, mnkar, mpol: String;
    X,pn, mm1, mm2, yy1, yy2, mdy: LongInt;
    md: array[1..27] of Integer;
begin
  FrmSplash.memFl:='STAT';
  FPY.FrmPY.ShowModal;
  if SQLQuery1.Active then SQLQuery1.Close;
  if FrmSplash.memPY<>'' then FrmSplash.memFl:='SPEC';
  Fdatv.ShowModal;

 // SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\otspgor.txt');
 // APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\otspgor.txt');
  Rewrite(f);
  pn:=0;
  msdat:=Fdatv.DateEdit1.Text;
  mm1:=StrToInt(Copy(msdat,4,2));
  yy1:=StrToInt(Copy(msdat,7,4));
  mm2:=StrToInt(Copy(Fdatv.DateEdit2.Text,4,2));
  yy2:=StrToInt(Copy(Fdatv.DateEdit2.Text,7,4));
  repeat begin
       if SQLQuery1.Active then SQLQuery1.Close;
       sSQL:= 'SELECT "F2"."FAMIL","F2"."IMJA","F2"."OTCH","F2"."PLATA","F2"."POL","F2"."DROG","MEROP"."DATA","MEROP"."KVD","MEROP"."NKAR","MEROP"."PY","SVD"."NUM"';
       sSQL:= sSQL +' FROM "F2","F1","MEROP","SVD" WHERE "F2"."PY"="MEROP"."PY" AND "F2"."NKAR"="MEROP"."NKAR" AND "F2"."PY"="F1"."PY" AND "F2"."NKAR"="F1"."NKAR" AND "MEROP"."KVD"="SVD"."KOD" AND "F1"."KOD" LIKE ''21__''';
       sSQL:= sSQL +' AND ((('+IntToStr(yy2)+' - EXTRACT(YEAR FROM "F2"."DROG"))<55 AND "F2"."POL"=''1'') OR (('+IntToStr(yy2)+' - EXTRACT(YEAR FROM "F2"."DROG"))<60 AND "F2"."POL"=''2''))';
       if (mm1=mm2) and (yy1=yy2) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" BETWEEN '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+'''';
       if (mm1<>mm2) and (yy1=StrToInt(Copy(msdat,7,4))) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" >='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if (mm1=mm2) and (yy1=yy2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND "MEROP"."DATA" <='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm2)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy2);
       if (mm1<>mm2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if FrmSplash.memPY<>'024' then sSQL:=sSQL+' AND "F2"."PY"='''+FrmSplash.memPY+'''';
       if Fdatv.ComboBox1.Text<>'' Then begin
         if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+Fdatv.ComboBox1.Text+'''';
         SQLQuery1.Open;
         sSQL:=sSQL+' AND "MEROP"."KISP"='+SQLQuery1.FieldByName('KISP').Text ;
         SQLQuery1.Close;
        end;
        sSQL:=sSQL+' ORDER BY "FAMIL","IMJA","OTCH","MEROP"."DATA","SVD"."NUM"';
        SQLQuery1.SQL.Text:=sSQL;
        SQLQuery1.Open;
        SQLQuery1.First;
       // writeln(f,UTF8ToAnsi(sSQL));
        while Not SQLQuery1.EOF do begin
              mpol:=SQLQuery1.FieldByName('POL').Text;
              mdy:=StrToInt(Copy(SQLQuery1.FieldByName('DROG').Text,7,4));

              pn:= pn + 1;
              s:= 'N:'+IntToStr(pn);
              writeln(f,UTF8ToAnsi(s));
              if Copy(SQLQuery1.FieldByName('NKAR').Text,8,2)='00' then
               begin
                 ms:=SQLQuery1.FieldByName('IMJA').Text;
                 s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                 ms:=SQLQuery1.FieldByName('OTCH').Text;
                 s:=s+Copy(ms,1,2)+'.';

               end
              else begin
                   if Dzap.Active then Dzap.Close;
                   Dzap.SQL.Text:='SELECT "FAMIL","IMJA","OTCH" FROM "F2" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
                   Dzap.Open;
                   ms:=Dzap.FieldByName('IMJA').Text;
                   s:= 'ФИО:'+ Dzap.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:= Dzap.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'. реб.(';
                   ms:=SQLQuery1.FieldByName('IMJA').Text;
                   s:= s+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:=SQLQuery1.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'.)';
              end;
              writeln(f,UTF8ToAnsi(s));
              mpy:= SQLQuery1.FieldByName('PY').Text;
              mnkar:=SQLQuery1.FieldByName('NKAR').Text;
              for X:=1 to 27 do md[X]:=0;
              while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) do begin
                    mkod:=SQLQuery1.FieldByName('NUM').Text;
                  //  mmes:='';
                    Case mkod of
                         '1.1.' : X:=1;
                         '1.3.' : X:=2;
                         '1.4.' : X:=3;
                         '1.10.': X:=4;
                         '1.11.': X:=5;
                         '1.12.': X:=6;
                         '1.13.': X:=7;
                         '1.14.': X:=8;
                         '2.2.' : X:=9;
                         '2.3.' : X:=10;
                         '2.4.' : X:=11;
                         '2.6.' : X:=12;
                         '2.7.' : X:=13;
                         '2.8.' : X:=14;
                         '4.1.' : X:=15;
                         '5.1.' : X:=16;
                         '5.2.' : X:=17;
                         '6.1.' : X:=18;
                         '7.2.' : X:=19;
                         '7.3.' : X:=20;
                         '7.4.' : X:=21;
                         '7.6.' : X:=22;
                         '7.7.' : X:=23;
                         '8.2.' : X:=24;
                         '8.3.' : X:=25;
                         '8.5.' : X:=26;
                         '8.7.' : X:=27;
                         else X:=23;
                    end;
                    while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) And (SQLQuery1.FieldByName('NUM').Text=mkod) do begin
                          md[X]:=md[X]+1;
                     //     if (Copy(SQLQuery1.FieldByName('DATA').Text,4,10)<>mmes) then begin
                     //         mmes:=Copy(SQLQuery1.FieldByName('DATA').Text,4,10);
                     //         mpos[X]:=mpos[X]+1;
                     //     end;
                          SQLQuery1.Next;
                          if SQLQuery1.EOF then break;
                    end;
                    if SQLQuery1.EOF then break;
              end;
              for X:=1 to 27 do begin
                  if md[X]<>0 then s:=IntToStr(X)+':'+intToStr(md[X])
                  else s:=IntToStr(X)+': ';
                  writeln(f,UTF8ToAnsi(s));
              end;
              s:='%ТАБЛИЦА';
              writeln(f,UTF8ToAnsi(s));
        end;
        if (mm1 = mm2) and (yy1=yy2) then break;
        mm1:=mm1+1;
        if mm1=13 then begin
          mm1:=1;
          yy1:=yy1+1;
        end;
  end;
  until (mm1-1 = mm2) and (yy1=yy2);
  if Fdatv.ComboBox1.Text<>'' Then s:='Специалист по социальной работе: '+Fdatv.ComboBox1.Text
  else s:='Специалист по социальной работе: По всем';
  writeln(f,UTF8ToAnsi(s));
  s:='Категория: Инвалиды  Группа учета: '+FrmPY.ListBox1.GetSelectedText;
  writeln(f,UTF8ToAnsi(s));
  s:='Период с: '+Fdatv.DateEdit1.Text+' по: '+Fdatv.DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='Отчет сформирован: '+DateToStr(NOW());
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c otspgor.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
end;

procedure TFrmMenuosn.MenuItem9Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath, sSQL, msdat, mpy, mnkar: String;
    X,pn, mm1, mm2, yy1, yy2: LongInt;
begin
  FrmSplash.memFl:='STAT';
  FrmSplash.mstr:='SVD';
  fsprawm.mkpsu:=0;
  fsprawm.Caption:='Справочник: выбор видов деятельности';
  fsprawm.mdata.SQL.Text:='SELECT * FROM "SVD" WHERE "UR"=1 ORDER BY "NKOD"';
  fsprawm.mdata.Open;
  fsprawm.mdata.Last;
  fsprawm.mdata.First;
  fsprawm.ListBox1.Clear;
    while (not fsprawm.mdata.EOF) do begin
          fsprawm.ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
          fsprawm.mdata.Next;
    end;
    FrmSplash.minf:='Карточка';
  fsprawm.ShowModal;

  FPY.FrmPY.ShowModal;
  if SQLQuery1.Active then SQLQuery1.Close;
  if FrmSplash.memPY<>'' then FrmSplash.memFl:='SPEC';
  Fdatv.ShowModal;

 // SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\otspgor.txt');
 // APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\otspgor.txt');
  Rewrite(f);
  pn:=0;
  msdat:=Fdatv.DateEdit1.Text;
  mm1:=StrToInt(Copy(msdat,4,2));
  yy1:=StrToInt(Copy(msdat,7,4));
  mm2:=StrToInt(Copy(Fdatv.DateEdit2.Text,4,2));
  yy2:=StrToInt(Copy(Fdatv.DateEdit2.Text,7,4));
  repeat begin
       if SQLQuery1.Active then SQLQuery1.Close;
       sSQL:= 'SELECT "F2"."FAMIL","F2"."IMJA","F2"."OTCH","F2"."PLATA","MEROP"."DATA","MEROP"."KVD","MEROP"."NKAR","MEROP"."PY"';
       sSQL:= sSQL +' FROM "F2","MEROP" WHERE "F2"."PY"="MEROP"."PY" AND "F2"."NKAR"="MEROP"."NKAR" AND "MEROP"."KVD" LIKE '''+FrmSplash.mkod+'%''';
       if (mm1=mm2) and (yy1=yy2) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" BETWEEN '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND '''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+'''';
       if (mm1<>mm2) and (yy1=StrToInt(Copy(msdat,7,4))) and (mm1=StrToInt(Copy(msdat,4,2))) and (yy1=StrToInt(Copy(msdat,7,4))) then
        sSQL:=sSQL+' AND "MEROP"."DATA" >='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit1.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if (mm1=mm2) and (yy1=yy2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND "MEROP"."DATA" <='''+FormatDateTime('YYYY-MM-DD',Fdatv.DateEdit2.Date)+''' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm2)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy2);
       if (mm1<>mm2) and (mm1<>StrToInt(Copy(msdat,4,2)))  then
        sSQL:=sSQL+' AND EXTRACT(MONTH FROM "MEROP"."DATA")='+IntToStr(mm1)+' AND EXTRACT(YEAR FROM "MEROP"."DATA")='+IntToStr(yy1);
       if FrmSplash.memPY<>'024' then sSQL:=sSQL+' AND "F2"."PY"='''+FrmSplash.memPY+'''';
       if Fdatv.ComboBox1.Text<>'' Then begin
         if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+Fdatv.ComboBox1.Text+'''';
         SQLQuery1.Open;
         sSQL:=sSQL+' AND "MEROP"."KISP"='+SQLQuery1.FieldByName('KISP').Text ;
         SQLQuery1.Close;
        end;
        sSQL:=sSQL+' ORDER BY "FAMIL","IMJA","OTCH","MEROP"."DATA"';
        SQLQuery1.SQL.Text:=sSQL;
        SQLQuery1.Open;
        SQLQuery1.First;
       // writeln(f,UTF8ToAnsi(sSQL));
        while Not SQLQuery1.EOF do begin
              pn:= pn + 1;
              s:= 'N:'+IntToStr(pn);
              writeln(f,UTF8ToAnsi(s));
              if Copy(SQLQuery1.FieldByName('NKAR').Text,8,2)='00' then
               begin
                 ms:=SQLQuery1.FieldByName('IMJA').Text;
                 s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                 ms:=SQLQuery1.FieldByName('OTCH').Text;
                 s:=s+Copy(ms,1,2)+'.';

               end
              else begin
                   if Dzap.Active then Dzap.Close;
                   Dzap.SQL.Text:='SELECT "FAMIL","IMJA","OTCH" FROM "F2" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text+''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '00''';
                   Dzap.Open;
                   ms:=Dzap.FieldByName('IMJA').Text;
                   s:= 'ФИО:'+ Dzap.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:= Dzap.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'. реб.(';
                   ms:=SQLQuery1.FieldByName('IMJA').Text;
                   s:= s+ SQLQuery1.FieldByName('FAMIL').Text+' '+ Copy(ms,1,2) +'.';
                   ms:=SQLQuery1.FieldByName('OTCH').Text;
                   s:=s+Copy(ms,1,2)+'.)';
              end;
              writeln(f,UTF8ToAnsi(s));
              mpy:= SQLQuery1.FieldByName('PY').Text;
              mnkar:=SQLQuery1.FieldByName('NKAR').Text;
              X:=0;
              while (SQLQuery1.FieldByName('PY').Text=mpy) And (SQLQuery1.FieldByName('NKAR').Text=mnkar) do begin
                    X:=X+1;

                    SQLQuery1.Next;
                    if SQLQuery1.EOF then break;

              end;
              if X<>0 then s:='1:'+IntToStr(X)
                  else s:='1: ';
                  writeln(f,UTF8ToAnsi(s));
              s:='%ТАБЛИЦА';
              writeln(f,UTF8ToAnsi(s));
        end;
        if (mm1 = mm2) and (yy1=yy2) then break;
        mm1:=mm1+1;
        if mm1=13 then begin
          mm1:=1;
          yy1:=yy1+1;
        end;
  end;
  until (mm1-1 = mm2) and (yy1=yy2);
  if Fdatv.ComboBox1.Text<>'' Then s:='Специалист по социальной работе: '+Fdatv.ComboBox1.Text
  else s:='Специалист по социальной работе: По всем';
  writeln(f,UTF8ToAnsi(s));
  s:='Категория: '+FrmPY.ListBox1.GetSelectedText;
  writeln(f,UTF8ToAnsi(s));
  s:='Период с: '+Fdatv.DateEdit1.Text+' по: '+Fdatv.DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='Отчет сформирован: '+DateToStr(NOW());
  writeln(f,UTF8ToAnsi(s));
  s:='Вид услуги: '+FrmSplash.mtext;
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c otspvus.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
end;


procedure TFrmMenuosn.mnuspawgrClick(Sender: TObject);
begin
   FrmSplash.memFl:='OGLAVL';
   FrmSprav.Show;
end;

procedure TFrmMenuosn.mruchClick(Sender: TObject);
begin
  FrmSplash.memFl:='New';
  FPY.FrmPY.Show;
end;

procedure TFrmMenuosn.mstatClick(Sender: TObject);
begin

end;

initialization
  {$I unmenu.lrs}

end.

