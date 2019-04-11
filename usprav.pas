unit Usprav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, DBGrids, StdCtrls, Buttons;

type

  { Tfsprav }

  Tfsprav = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    Dzap: TSQLQuery;
    Edit1: TEdit;
    POISK: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
        mzap: String;
    { public declarations }
  end; 

var
  fsprav: Tfsprav;

implementation
 uses kuch, uspraw, shelp,unlogin;

{ Tfsprav }

procedure Tfsprav.Button1Click(Sender: TObject);
begin
    if kuch.mbut=2 then begin
     frmkuch.Edit12.Text:=Dzap.FieldByName('S_NAME').Text+' '+Dzap.FieldByName('S_SOCR').Text;
       kuch.mrkod:=copy(Dzap.FieldByName('S_CODE').Text,1,2);
    end;
    if kuch.mbut=3 then begin
     frmkuch.Edit13.Text:=Dzap.FieldByName('S_NAME').Text+' '+Dzap.FieldByName('S_SOCR').Text;
       kuch.mrk:=copy(Dzap.FieldByName('S_CODE').Text,1,5);
    end;
    if kuch.mbut=4 then begin
     frmkuch.Edit15.Text:=Dzap.FieldByName('S_NAME').Text+' '+Dzap.FieldByName('S_SOCR').Text;
       kuch.mpunkt:=Dzap.FieldByName('S_CODE').Text;
    end;
    if kuch.mbut=5 then begin
     frmkuch.Edit16.Text:=Dzap.FieldByName('S_NAME').Text+' '+Dzap.FieldByName('S_SOCR').Text;
     if Dzap.FieldByName('S_INDEX').Text<>'' then  frmkuch.Edit14.Text:=Dzap.FieldByName('S_INDEX').Text;
    end;
    Edit1.Text:='';
    fsprav.Close;
end;

procedure Tfsprav.Button2Click(Sender: TObject);
 var sSQL, mst: String;
     X: Integer;
begin
  mst:= InputBox('Добавление строки справочника','Введите наименование','');
  if mst<>'' then  begin
     if POISK.Active=True then POISK.Close;
     Dzap.Close;
     Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "'+FrmSprav.mk+'"';
     fsprav.Dzap.Open;
     fsprav.Dzap.Last;
     X:=StrToInt(Dzap.Fields[0].Text)+1;
     if FrmSplash.mstr='S20' then sSQL:='INSERT INTO "S20" ("'+FrmSprav.mk+'","'+FrmSprav.mn+'","UVOL","PAROL") VALUES ('+IntToStr(X)+',''' + mst + ''','' '',''1'')'
     else sSQL:='INSERT INTO "'+FrmSplash.mstr+'" ("'+FrmSprav.mk+'","'+FrmSprav.mn+'") VALUES ('+IntToStr(X)+',''' + mst + ''')';
     Poisk.SQL.Text:=sSQL;
     Poisk.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "'+FrmSprav.mn+'"';
     fsprav.Dzap.Open;
     fsprav.Dzap.First;
  end;
end;

procedure Tfsprav.Button3Click(Sender: TObject);
var sSQL, mst: String;
    X: Integer;
begin
   if MessageDlg('Удалить? ('+Dzap.Fields[1].Text+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
     if POISK.Active=True then POISK.Close;
     sSQL:='DELETE FROM "'+FrmSplash.mstr+'" WHERE "'+FrmSprav.mk+'"=' + Dzap.Fields[0].Text ;
     Poisk.SQL.Text:=sSQL;
     Poisk.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "'+FrmSprav.mn+'"';
     fsprav.Dzap.Open;
     fsprav.Dzap.First;
  end;
end;

procedure Tfsprav.Button4Click(Sender: TObject);
var sSQL, mst: String;
     X: Integer;
begin
    mst:= InputBox('Изменение строки справочника','Введите наименование',Dzap.Fields[1].Text);
  if mst<>'' then  begin
     if POISK.Active=True then POISK.Close;
     X:=StrToInt(Dzap.Fields[0].Text);
     sSQL:='UPDATE "'+FrmSplash.mstr+'" SET "'+FrmSprav.mn+'"='''+mst+''' WHERE "'+FrmSprav.mk+'"='+ IntToStr(X);
     Poisk.SQL.Text:=sSQL;
     Poisk.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "'+FrmSprav.mn+'"';
     fsprav.Dzap.Open;
     fsprav.Dzap.First;
  end;
end;

procedure Tfsprav.Button5Click(Sender: TObject);
var sSQL: String;
begin
     if POISK.Active=True then POISK.Close;
     if Dzap.Fields[2].Text=' ' Then
     sSQL:='UPDATE "'+FrmSplash.mstr+'" SET "UVOL"=''+'' WHERE "'+FrmSprav.mk+'"='+ Dzap.Fields[0].Text
     else
     sSQL:='UPDATE "'+FrmSplash.mstr+'" SET "UVOL"='' '' WHERE "'+FrmSprav.mk+'"='+ Dzap.Fields[0].Text;
     Poisk.SQL.Text:=sSQL;
     Poisk.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "'+FrmSprav.mn+'"';
     fsprav.Dzap.Open;
     fsprav.Dzap.First;
end;

procedure Tfsprav.Button6Click(Sender: TObject);
var mst, sSQL: String;
begin
     mst:= InputBox('Изменение пароля','Введите пароль',Dzap.Fields[3].Text);
     if POISK.Active=True then POISK.Close;
     if mst='' Then
     sSQL:='UPDATE "'+FrmSplash.mstr+'" SET "PAROL"=NULL WHERE "'+FrmSprav.mk+'"='+ Dzap.Fields[0].Text
     else
     sSQL:='UPDATE "'+FrmSplash.mstr+'" SET "PAROL"='''+mst+''' WHERE "'+FrmSprav.mk+'"='+ Dzap.Fields[0].Text;
     Poisk.SQL.Text:=sSQL;
     Poisk.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "'+FrmSprav.mn+'"';
     fsprav.Dzap.Open;
     fsprav.Dzap.First;
end;


procedure Tfsprav.Edit1Change(Sender: TObject);
 var X: Integer;
     mst: String;
begin
     mst:='';
     if POISK.Active=True then POISK.Close;
     if Edit1.Text<>'' then
     begin
        mst:= Edit1.Text;
        Poisk.SQL.Text:= mzap +' AND "S_NAME" LIKE ''' + mst+ '%'' ORDER BY "S_NAME"';
        Poisk.Open;
        if POISK.RecordCount>0 then
        begin
        mst:=POISK.FieldByName('S_NAME').Text;
        Poisk.Close;
    //ShowMessage(mst);
        Dzap.Last;
        Dzap.First;
        for X:=0 to Dzap.RecordCount-1 do begin
            if Dzap.FieldByName('S_NAME').Text=mst then break
            else Dzap.Next;
            end;
        end;
     end;
end;


procedure Tfsprav.FormCreate(Sender: TObject);
begin
   Edit1.Text:='';
end;

procedure Tfsprav.FormShow(Sender: TObject);
begin
     Button2.Visible:=False;
     Button3.Visible:=False;
     Button4.Visible:=False;
     Button5.Visible:=False;
     Button6.Visible:=False;
     if FrmSplash.memFl='KAT' then begin

      Button1.Visible:=False;
      Edit1.Visible:=False;
      if (FrmSplash.mstr='S20')  then begin
         if (Frmlogin.mpolz='Администратор') then begin
             Button2.Visible:=True;
             Button3.Visible:=True;
             Button4.Visible:=True;
             Button5.Visible:=True;
             Button6.Visible:=True;
             Dzap.Fields[3].Visible:=True;
         end
         else Dzap.Fields[3].Visible:=False;
      end
      else begin
           Button2.Visible:=True;
           Button3.Visible:=True;
           Button4.Visible:=True;
      end;
  end
  else begin
      Button1.Visible:=True;
      Edit1.Visible:=True;
  end;
end;

initialization
  {$I usprav.lrs}

end.

