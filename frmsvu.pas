unit frmsvu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  DBGrids, db, DbCtrls, sqldb, StdCtrls, process;

type

  { TFSVU }

  TFSVU = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    Process1: TProcess;
    SQLQuery1: TSQLQuery;
    Dzap: TSQLQuery;
    Dsdv: TSQLQuery;
    DF1: TSQLQuery;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Grid_nastr();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FSVU: TFSVU;

implementation
 uses unlogin, kuch, shelp, FPY, fzap, usprav;
{ TFSVU }

procedure TFSVU.Grid_nastr();
var X: Integer;
begin
     fsvu.DBGRid1.Columns[0].Visible:=False;
     fsvu.DBGRid1.Columns[1].Visible:=False;
     fsvu.DBGRid1.Columns[2].Visible:=False;
     fsvu.DBGRid1.Columns[3].Title.Caption:='Фамилия';
     fsvu.DBGRid1.Columns[4].Title.Caption:='Имя';
     fsvu.DBGRid1.Columns[5].Title.Caption:='Отчество';
     for X:=6 to fsvu.SQLQuery1.FieldCount-1 do fsvu.DBGRid1.Columns[X].Visible:=False ;
     for  X:=3 to 5 do begin
          fsvu.DBGRid1.Columns[X].Visible:=True;
          fsvu.DBGRid1.Columns[X].Width:=144;
     end;
    // Datasource1.DataSet:= SQLQuery1;
    // fsvu.Label1.Caption:=IntToStr(fsvu.SQLQuery1.RecordCount) + '  ' + IntToStr(fsvu.SQLQuery1.FieldCount) ;
     SQLQuery1.Last;
     SQLQuery1.First;
     if (Frmlogin.mpolz='Администратор') then Button7.Visible:=True
     else Button7.Visible:=False;
     if  FrmSplash.memFl='NOUCH' then begin
     FSVU.Caption:='Сведения о гражданах, снятых с учета ('+IntToStr(fsvu.SQLQuery1.RecordCount)+' семей)';
     Button2.Visible:=True;
     Button2.Caption:='Запись в архив';
     Button3.Visible:=True;
     Button3.Caption:='Поставить на учет';
     end;
     if  FrmSplash.memFl='PROSM' then begin
     FSVU.Caption:='Сведения о гражданах, стоящих на учете ('+IntToStr(fsvu.SQLQuery1.RecordCount)+' семей)';
     Button2.Visible:=False;
     Button3.Visible:=True;
     Button3.Caption:='Снять с учета';
     end;
     if  FrmSplash.memFl='ARHIV' then begin
     FSVU.Caption:='Список карточек в архиве ('+IntToStr(fsvu.SQLQuery1.RecordCount)+' семей)';
     Button2.Visible:=True;
     Button2.Caption:='Вернуть из архива';
     Button3.Visible:=False;
     end;
end;

procedure TFSVU.Button4Click(Sender: TObject);
var mst,mCC: String;
    X: Integer;
begin
  Dzap.Close;
  mst:= InputBox('Поиск по фамилии','Введите фамилию или несколько первых букв','');
  if mst<>'' then
   begin
        if FrmSplash.memFl='ARHIV' then Dzap.SQL.Text:= 'SELECT "FAMIL" FROM "F2" WHERE "PAR"=TRUE  AND "NKAR" LIKE ''_______00'' AND lower("FAMIL") LIKE lower(''' + mst+ '%'') ORDER BY "FAMIL"';
        if FrmSplash.memFl='NOUCH' then Dzap.SQL.Text:= 'SELECT "FAMIL" FROM "F2" WHERE "PSY"<>0 AND "PAR"=FALSE AND "NKAR" LIKE ''_______00'' AND lower("FAMIL") LIKE lower(''' + mst+ '%'') ORDER BY "FAMIL"';
        if FrmSplash.memFl='PROSM' then Dzap.SQL.Text:= 'SELECT "FAMIL" FROM "F2" WHERE "PSY" IS NULL AND "PAR"=FALSE AND "NKAR" LIKE ''_______00'' AND lower("FAMIL") LIKE lower(''' + mst+ '%'') ORDER BY "FAMIL"';
   end;
  Dzap.Open;
  if Dzap.RecordCount>0 then
  begin
    mCC:=Dzap.FieldByName('FAMIL').Text;
   // ShowMessage(mCC);
    SQLQuery1.First;
    for X:=0 to SQLQuery1.RecordCount-1 do begin
        if SQLQuery1.FieldByName('FAMIL').Text=mCC then break
        else SQLQuery1.Next;
    end;
  end
  else
    ShowMessage('Не найдено!');
end;

procedure TFSVU.Button5Click(Sender: TObject);
begin
  FrmSplash.mkod:='' ;
  FrmSplash.memPY:='';
  FrmSplash.mksy:='';
  Frmzap.ShowModal;
end;

procedure TFSVU.Button6Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath: String;
    X,pn: Integer;
begin
  SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
 // APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  Rewrite(f);
  pn:=0;
  while Not SQLQuery1.EOF do begin
        pn:= pn + 1;
        s:= 'N:'+IntToStr(pn);
        writeln(f,UTF8ToAnsi(s));
        s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ SQLQuery1.FieldByName('IMJA').Text +' '
        +SQLQuery1.FieldByName('OTCH').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ДАТАР:'+ SQLQuery1.FieldByName('DROG').Text;
        writeln(f,UTF8ToAnsi(s));
        if length(SQLQuery1.FieldByName('SVPF').Text)>0 then s:='НПЕНС:'+ SQLQuery1.FieldByName('SVPF').Text
        else s:='НПЕНС: ';
        writeln(f,UTF8ToAnsi(s));
        s:='ПАСПОРТ:'+SQLQuery1.FieldByName('PSR').Text+' № '+SQLQuery1.FieldByName('PNM').Text+' выдан ';
        if length(SQLQuery1.FieldByName('DKV').Text)>0 then begin
           Dsdv.Close;
          Dsdv.SQL.Text:='SELECT "NAME" FROM "SDV" WHERE "NUM"='+SQLQuery1.FieldByName('DKV').Text;
           Dsdv.Open;
           if Dsdv.RecordCount>0 then s:=s+Dsdv.FieldByName('NAME').Text+' ';
        end;
        s:=s+SQLQuery1.FieldByName('PDV').Text;
        writeln(f,UTF8ToAnsi(s));
        DF1.Close;
        sl:='SELECT * FROM "F1" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text
        +''' AND "NKAR"='''+SQLQuery1.FieldByName('NKAR').Text + '''';
        DF1.SQL.Text:=sl;
        DF1.Open;
        sl:='';
        if DF1.RecordCount>0 then begin
             Dzap.Close;
             Dzap.SQL.Text:='SELECT "NKOD" FROM "S1" WHERE "KOD"='''+DF1.FieldByName('KOD').Text+'''';
             Dzap.Open;
             if Dzap.RecordCount>0 then sl:=Dzap.FieldByName('NKOD').Text+' ';
             if length(DF1.FieldByName('KSY').Text)>0 then begin
                mkod:='';
                for X:=1 to length(DF1.FieldByName('KSY').Text) do begin
                    ms:=copy(DF1.FieldByName('KSY').Text,X,1);
                    if ms<>';' then mkod:=mkod+ms else begin
                       Dzap.Close;
                       Dzap.SQL.Text:='SELECT "NKOD" FROM "S2" WHERE "KOD"='''+mkod+'''';
                       Dzap.Open;
                     //  ShowMessage(SQLQuery1.FieldByName('FAMIL').Text+Dzap.SQL.Text+', '+IntToStr(length(DF1.FieldByName('KSY').Text)));
                       if Dzap.RecordCount>0 then sl:=sl+','+Dzap.FieldByName('NKOD').Text+' ';
                       mkod:='';
                    end;
                end;
             end;
        end;
        s:='КАТЕГОРИЯ:'+ sl+' ';
        writeln(f,UTF8ToAnsi(s));
        s:='ПЛАТА:'+SQLQuery1.FieldByName('PLATA').Text+' ';
        //s:=s+SQLQuery1.FieldByName('PDV').Text+';'+sl+';'+SQLQuery1.FieldByName('PLATA').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='%ТАБЛИЦА';
        writeln(f,UTF8ToAnsi(s));
        SQLQuery1.Next;
  end;
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c spis.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
  SQLQuery1.First;
end;

procedure TFSVU.Button7Click(Sender: TObject);
begin
  if MessageDlg('Удалить семью? ('+SQLQuery1.FieldByName('FAMIL').Text+' '+SQLQuery1.FieldByName('IMJA').Text+' '+SQLQuery1.FieldByName('OTCH').Text+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
     if Dzap.Active=True then Dzap.Close;
     Dzap.SQL.Text:='DELETE FROM "F2" WHERE "PY"=''' + SQLQuery1.FieldByName('PY').Text + ''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '__''';
     Dzap.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     FrmKuch.Grid_nstr2();
  end;
end;

procedure TFSVU.Button8Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath: String;
    X,pn: Integer;
begin
  SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
  //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  Rewrite(f);
  pn:=0;
  while Not SQLQuery1.EOF do begin
        pn:= pn + 1;
        s:= 'N:'+IntToStr(pn);
        writeln(f,UTF8ToAnsi(s));
        s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ SQLQuery1.FieldByName('IMJA').Text +' '
        +SQLQuery1.FieldByName('OTCH').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ДАТАР:'+ SQLQuery1.FieldByName('DROG').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='АДРЕС:';
        if length(SQLQuery1.FieldByName('REG').Text)>0 then s:=s+SQLQuery1.FieldByName('REG').Text+' ';
        if length(SQLQuery1.FieldByName('RAI').Text)>0 then s:=s+SQLQuery1.FieldByName('RAI').Text+' ';
        if length(SQLQuery1.FieldByName('NASP').Text)>0 then s:=s+SQLQuery1.FieldByName('NASP').Text+' ';
        if length(SQLQuery1.FieldByName('YLIC').Text)>0 then s:=s+SQLQuery1.FieldByName('YLIC').Text+' ';
        if length(SQLQuery1.FieldByName('NDOM').Text)>0 then s:=s+'д.'+SQLQuery1.FieldByName('NDOM').Text+' ';
        if length(SQLQuery1.FieldByName('NKORP').Text)>0 then s:=s+'корп.'+SQLQuery1.FieldByName('NKORP').Text+' ';
        if length(SQLQuery1.FieldByName('NKW').Text)>0 then s:=s+'кв.'+SQLQuery1.FieldByName('NKW').Text+' ';

        writeln(f,UTF8ToAnsi(s));
        s:='ПАСПОРТ:'+SQLQuery1.FieldByName('PSR').Text+' № '+SQLQuery1.FieldByName('PNM').Text+' выдан ';
        if length(SQLQuery1.FieldByName('DKV').Text)>0 then begin
           Dsdv.Close;
          Dsdv.SQL.Text:='SELECT "NAME" FROM "SDV" WHERE "NUM"='+SQLQuery1.FieldByName('DKV').Text;
           Dsdv.Open;
           if Dsdv.RecordCount>0 then s:=s+Dsdv.FieldByName('NAME').Text+' ';
        end;
        s:=s+SQLQuery1.FieldByName('PDV').Text;
        writeln(f,UTF8ToAnsi(s));
        DF1.Close;
        sl:='SELECT * FROM "F1" WHERE "PY"='''+SQLQuery1.FieldByName('PY').Text
        +''' AND "NKAR"='''+SQLQuery1.FieldByName('NKAR').Text + '''';
        DF1.SQL.Text:=sl;
        DF1.Open;
        sl:='';
        if DF1.RecordCount>0 then begin
             Dzap.Close;
             Dzap.SQL.Text:='SELECT "NKOD" FROM "S1" WHERE "KOD"='''+DF1.FieldByName('KOD').Text+'''';
             Dzap.Open;
             if Dzap.RecordCount>0 then sl:=Dzap.FieldByName('NKOD').Text+' ';
             if length(DF1.FieldByName('KSY').Text)>0 then begin
                mkod:='';
                for X:=1 to length(DF1.FieldByName('KSY').Text) do begin
                    ms:=copy(DF1.FieldByName('KSY').Text,X,1);
                    if ms<>';' then mkod:=mkod+ms else begin
                       Dzap.Close;
                       Dzap.SQL.Text:='SELECT "NKOD" FROM "S2" WHERE "KOD"='''+mkod+'''';
                       Dzap.Open;
                     //  ShowMessage(SQLQuery1.FieldByName('FAMIL').Text+Dzap.SQL.Text+', '+IntToStr(length(DF1.FieldByName('KSY').Text)));
                       if Dzap.RecordCount>0 then sl:=sl+','+Dzap.FieldByName('NKOD').Text+' ';
                       mkod:='';
                    end;
                end;
             end;
        end;
        s:='КАТЕГОРИЯ:'+ sl+' ';
        writeln(f,UTF8ToAnsi(s));
        s:='%ТАБЛИЦА';
        writeln(f,UTF8ToAnsi(s));
        SQLQuery1.Next;
  end;
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c spisadr.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
  SQLQuery1.First;
end;

procedure TFSVU.Button9Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,ms,APath: String;
    X,pn: Integer;
begin
  SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
  //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  Rewrite(f);
  pn:=0;
  while Not SQLQuery1.EOF do begin
        pn:= pn + 1;
        s:= 'N:'+IntToStr(pn);
        writeln(f,UTF8ToAnsi(s));
        s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ SQLQuery1.FieldByName('IMJA').Text +' '
        +SQLQuery1.FieldByName('OTCH').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ДАТАР:'+ SQLQuery1.FieldByName('DROG').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ДАТАРЕГ:';
        if Dsdv.Active then Dsdv.Close;
        Dsdv.Close;
        Dsdv.SQL.Text:='SELECT * FROM "PROPIS" WHERE "PY"=''' + SQLQuery1.FieldByName('PY').Text + ''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '__'' ORDER BY "DatFrom"';
        Dsdv.Open;
        if Dsdv.RecordCount>0 then begin
           Dsdv.Last;
           if length(Dsdv.FieldByName('DatTo').Text)>0 then s:=s+Dsdv.FieldByName('DatTo').Text;
        end;
        writeln(f,UTF8ToAnsi(s));
        s:='%ТАБЛИЦА';
        writeln(f,UTF8ToAnsi(s));
        SQLQuery1.Next;
  end;
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c spisreg.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
  SQLQuery1.First;

end;

procedure TFSVU.Button1Click(Sender: TObject);
Var
   X :Integer;

begin
  frmkuch.mpy:=SQLQuery1.FieldByName('PY').Text;
  frmkuch.mnkar:=SQLQuery1.FieldByName('NKAR').Text;
  frmkuch.kart_view();
 // frmSplash.memFl:='PROSM';
  frmkuch.Button17.Visible:=True;
  frmkuch.Show;
  SQLQuery1.First;
  for X:=0 to SQLQuery1.RecordCount-1 do begin
        if (SQLQuery1.FieldByName('PY').Text=frmkuch.mpy) and (SQLQuery1.FieldByName('NKAR').Text=frmkuch.mnkar)  then break
        else SQLQuery1.Next;
  end;
end;

procedure TFSVU.Button10Click(Sender: TObject);
var f: TextFile;
    s,sl,mkod,APath: String;
    pn: Integer;
begin
  SQLQuery1.First;
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
 // APath:=GetEnvironmentVariableUTF8('USERPROFILE');
 // AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  Rewrite(f);
  pn:=0;
  while Not SQLQuery1.EOF do begin
        pn:= pn + 1;
        s:= 'N:'+IntToStr(pn);
        writeln(f,UTF8ToAnsi(s));
        s:= 'ФИО:'+ SQLQuery1.FieldByName('FAMIL').Text+' '+ SQLQuery1.FieldByName('IMJA').Text +' '
        +SQLQuery1.FieldByName('OTCH').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ДАТАР:'+ SQLQuery1.FieldByName('DROG').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ДАТАП:'+ SQLQuery1.FieldByName('DATZK').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='%ТАБЛИЦА';
        writeln(f,UTF8ToAnsi(s));
        SQLQuery1.Next;
  end;
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
 // Process1.CommandLine:='cscript.exe spis.vbs';
  Process1.CommandLine:='cmd /c spispos.ots';
  Process1.Options := Process1.Options + [poWaitOnExit];
 // Process1.Input.Write('spis.vbs', 8);
  Process1.Execute;
//  if Process1.Running then Process1.Input.Write('spis.vbs', 8);
  Process1.Free;
  SQLQuery1.First;
end;

procedure TFSVU.Button11Click(Sender: TObject);
begin
  FrmSplash.memFl:='New';
  FPY.FrmPY.Show;
end;

procedure TFSVU.Button2Click(Sender: TObject);
begin
  if  FrmSplash.memFl='ARHIV' then begin
     if MessageDlg('Вернуть семью из архива? ('+SQLQuery1.FieldByName('FAMIL').Text+' '+SQLQuery1.FieldByName('IMJA').Text+' '+SQLQuery1.FieldByName('OTCH').Text+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
         if Dzap.Active=True then Dzap.Close;
         Dzap.SQL.Text:='UPDATE "F2" SET "PAR"=FALSE WHERE "PY"=''' + SQLQuery1.FieldByName('PY').Text + ''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '__''';
         Dzap.ExecSQL;
         frmlogin.SQLTransaction1.Commit;
         frmlogin.SQLTransaction1.Active:=True;
         fsvu.SQLQuery1.Open;
         fsvu.Grid_nastr();
         FrmKuch.Grid_nstr2();
     end;
  end
  else begin
      if MessageDlg('Записать семью в архив? ('+SQLQuery1.FieldByName('FAMIL').Text+' '+SQLQuery1.FieldByName('IMJA').Text+' '+SQLQuery1.FieldByName('OTCH').Text+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
         if Dzap.Active=True then Dzap.Close;
         Dzap.SQL.Text:='UPDATE "F2" SET "PAR"=TRUE WHERE "PY"=''' + SQLQuery1.FieldByName('PY').Text + ''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '__''';
         Dzap.ExecSQL;
         frmlogin.SQLTransaction1.Commit;
         frmlogin.SQLTransaction1.Active:=True;
         fsvu.SQLQuery1.Open;
         fsvu.Grid_nastr();
         FrmKuch.Grid_nstr2();
     end;
  end;
end;

procedure TFSVU.Button3Click(Sender: TObject);
var mst: String;
begin
     if  FrmSplash.memFl='PROSM' then begin
         FrmSplash.mstr:='S22';
         fsprav.Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "NPSY"';
         fsprav.Dzap.Open;
         fsprav.Dzap.First;
         fsprav.DBGRid1.Columns[0].Title.Caption:='Код';
         fsprav.DBGRid1.Columns[1].Title.Caption:='Название';
         fsprav.DBGRid1.Columns[0].Visible:=False;
         fsprav.DBGRid1.AutoEdit:=False;
         fsprav.Caption:='Справочник причин снятия с учета';
         fsprav.ShowModal;
         if MessageDlg('Вы действительно хотите снять семью с учета? ('+SQLQuery1.FieldByName('FAMIL').Text+' '+SQLQuery1.FieldByName('IMJA').Text+' '+SQLQuery1.FieldByName('OTCH').Text+'  '+fsprav.Dzap.FieldByName('NPSY').Text+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
             mst:= InputBox('Дата снятия с учета','Введите дату снятия с учета',FormatDateTime('DD-MM-YYYY',Now()));
         if Dzap.Active=True then Dzap.Close;
         Dzap.SQL.Text:='UPDATE "F2" SET "PSY"='+fsprav.Dzap.FieldByName('KPSY').Text+',"DSY"='''+mst+''' WHERE "PY"=''' + SQLQuery1.FieldByName('PY').Text + ''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '__''';
         Dzap.ExecSQL;
         frmlogin.SQLTransaction1.Commit;
         frmlogin.SQLTransaction1.Active:=True;
         fsvu.SQLQuery1.Open;
         fsvu.Grid_nastr();
         FrmKuch.Grid_nstr2();
         end;
     end
     else begin
         if MessageDlg('Поставить семью на учет? ('+SQLQuery1.FieldByName('FAMIL').Text+' '+SQLQuery1.FieldByName('IMJA').Text+' '+SQLQuery1.FieldByName('OTCH').Text+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin

         if Dzap.Active=True then Dzap.Close;
         Dzap.SQL.Text:='UPDATE "F2" SET "PSY"=NULL,"DSY"=NULL WHERE "PY"=''' + SQLQuery1.FieldByName('PY').Text + ''' AND "NKAR" LIKE ''' + copy(SQLQuery1.FieldByName('NKAR').Text,1,7) + '__''';
         Dzap.ExecSQL;
         frmlogin.SQLTransaction1.Commit;
         frmlogin.SQLTransaction1.Active:=True;
         fsvu.SQLQuery1.Open;
         fsvu.Grid_nastr();
         FrmKuch.Grid_nstr2();
         end;
     end;
end;



procedure TFSVU.FormCreate(Sender: TObject);
begin
     //unlogin.FrmLogin.SQLQuery1.Close;
     //unlogin.FrmLogin.SQLQuery1.SQL.Clear;
     if FrmSplash.memFl='NOUCH' then
     SQLQuery1.SQL.Text:='SELECT *  FROM "F2" WHERE "PSY"<>0 AND "NKAR" LIKE ''_______00'' ORDER BY "FAMIL"'
     else
     SQLQuery1.SQL.Text:='SELECT *  FROM "F2" WHERE "PSY" IS NULL AND "NKAR" LIKE ''_______00'' ORDER BY "FAMIL"';
  //   SQLQuery1.ExecSQL;
     SQLQuery1.Open;
     SQLQuery1.Active:=True;
     SQLQuery1.Last;
     SQLQuery1.First;
     Grid_nastr();
end;

initialization
  {$I frmsvu.lrs}

end.

