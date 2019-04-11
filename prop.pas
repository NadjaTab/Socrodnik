unit Prop;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, EditBtn;

type

  { TFrmProp }

  TFrmProp = class(TForm)
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
        mDat: String;
    { public declarations }
  end; 

var
  FrmProp: TFrmProp;

implementation
   uses kuch,shelp,frmsvu,Unlogin;

{ TFrmProp }

procedure TFrmProp.FormClose(Sender: TObject; var CloseAction: TCloseAction);
  var sql: String;
begin
  if MessageDlg('Сохранить изменения?',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
    if FrmSplash.memN=False then
    begin
         sql:='UPDATE "PROPIS" SET "DatFrom"='''+FormatDateTime('YYYY-MM-DD',DateEdit1.Date)+''',';
         sql:=sql+'"DatTo"='''+FormatDateTime('YYYY-MM-DD',DateEdit2.Date)+''',"Nsv"=';
         if Edit1.Text='' then
         sql:=sql+'Null' else
         sql:=sql+Edit1.Text;
         sql:=sql+',"Prim"='''+Edit2.Text+''' WHERE "PY"='''+FrmKuch.mpy+''' AND "NKAR"='''+FrmKuch.mnkar+''' AND "DatFrom"='''+mDat+'''';
    end
    else
    begin
         sql:= 'INSERT INTO "PROPIS"("PY","NKAR","DatFrom","DatTo","Nsv","Prim") VALUES (''' + FrmKuch.mpy + ''',''' + FrmKuch.mnkar + ''','''+FormatDateTime('YYYY-MM-DD',DateEdit1.Date)+''','''+FormatDateTime('YYYY-MM-DD',DateEdit2.Date)+''',';
         if Edit1.Text='' then
         sql:=sql+'Null' else
         sql:=sql+Edit1.Text;
         sql:=sql+','''+Edit2.Text+''')';
    end;
       FrmKuch.Dmer.Close;
       FrmKuch.Dmer.SQL.Text:=sql;
       FrmKuch.Dmer.ExecSQL;
       frmlogin.SQLTransaction1.Commit;
       frmlogin.SQLTransaction1.Active:=True;
       fsvu.SQLQuery1.Open;
       fsvu.Grid_nastr();
       FrmKuch.Grid_nstr2();
  end;
end;

procedure TFrmProp.FormCreate(Sender: TObject);
begin
 //
end;

initialization
  {$I prop.lrs}

end.

