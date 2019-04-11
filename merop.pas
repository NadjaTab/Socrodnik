unit Merop;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, EditBtn;

type

  { TFrmMerop }

  TFrmMerop = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    DateEdit1: TDateEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FrmMerop: TFrmMerop;

implementation
   uses kuch,Usprav,unlogin,sprawm,shelp,frmsvu;

{ TFrmMerop }

procedure TFrmMerop.FormCreate(Sender: TObject);
begin
     if FrmKuch.Dmer.Active=True then FrmKuch.Dmer.Close;
     FrmKuch.Dmer.SQL.Text:='SELECT "NISP" FROM "S20" ORDER BY "NISP"';
     FrmKuch.Dmer.Open;
     FrmKuch.Dmer.First;
     while (not FrmKuch.Dmer.EOF) do begin
        ComboBox1.AddItem(FrmKuch.Dmer.FieldByName('NISP').Text, nil);
        FrmKuch.Dmer.Next;
     end;
end;

procedure TFrmMerop.Button1Click(Sender: TObject);
begin
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
  fsprawm.Show;
  if fsprawm.mkpsu > 1 then FrmMerop.Close;
end;

procedure TFrmMerop.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var  sql,minsp: String;
        X,mint: Integer;
begin
  if MessageDlg('Сохранить изменения?',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
    if (Label4.Caption='') or (ComboBox1.Text='') then
       if Label4.Caption='' then ShowMessage('Вид мероприятия заполняется обязательно!')
       else ShowMessage('ФИО социального работника заполняется обязательно!')
    else begin
    if FrmSplash.memN=False then
    begin
         sql:='UPDATE "MEROP" SET "DATA"='''+FormatDateTime('YYYY-MM-DD',DateEdit1.Date)+''',';
         if FrmKuch.Dmer.Active=True then FrmKuch.Dmer.Close;
         FrmKuch.Dmer.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+ComboBox1.Text+'''';
         FrmKuch.Dmer.Open;
         sql:=sql+'"KISP"='+FrmKuch.Dmer.FieldByName('KISP').Text+',"KVD"='''+FrmSplash.mkod+''',';
         sql:=sql+'"ORG"='''+Edit2.Text+''',"OBR"='''+Edit3.Text+''' WHERE "IDN"='+FrmKuch.Dzap.FieldByName('IDN').Text+' AND "PY"='''+FrmKuch.mpy+''' AND "NKAR"='''+FrmKuch.mnkar+'''';
         FrmKuch.Dmer.Close;
       FrmKuch.Dmer.SQL.Text:=sql;
       FrmKuch.Dmer.ExecSQL;
       frmlogin.SQLTransaction1.Commit;
       frmlogin.SQLTransaction1.Active:=True;
       fsvu.SQLQuery1.Open;
       fsvu.Grid_nastr();
       FrmKuch.Grid_nstr();
    end
    else
    begin
         if FrmKuch.Dmer.Active=True then FrmKuch.Dmer.Close;
         sql:='SELECT * FROM "MEROP" WHERE "PY" = ''' + FrmKuch.mpy + ''' AND "NKAR" = ''' + FrmKuch.mnkar + ''' ORDER BY "IDN"';
         FrmKuch.Dmer.SQL.Text:= sql;
         FrmKuch.Dmer.Open;
         if FrmKuch.Dmer.RecordCount>0 then begin
            FrmKuch.Dmer.Last;
            FrmKuch.midn:=StrToInt(FrmKuch.Dmer.FieldByName('IDN').Text)+1;
         end
         else FrmKuch.midn:=1;
         minsp:='';
         FrmKuch.Dmer.Close;
         FrmKuch.Dmer.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+ComboBox1.Text+'''';
         FrmKuch.Dmer.Open;
         minsp:=FrmKuch.Dmer.FieldByName('KISP').Text;
         for X:=1 to fsprawm.mkpsu do
         begin
              mint:=Pos(';',FrmSplash.mksy);
              FrmSplash.mkod:=Copy(FrmSplash.mksy,1,mint-1);
              Delete(FrmSplash.mksy,1,mint);
              sql:= 'INSERT INTO "MEROP"("IDN","PY","NKAR","DATA","KISP","KVD","ORG","OBR") VALUES (' + IntToStr(FrmKuch.midn) + ',''' + FrmKuch.mpy + ''',''' + FrmKuch.mnkar + ''','''+FormatDateTime('YYYY-MM-DD',DateEdit1.Date)+''',';
              sql:=sql+minsp+','''+FrmSplash.mkod+'''';
              sql:=sql+','''+Edit2.Text+''','''+Edit3.Text+''')';
              FrmKuch.Dmer.Close;
              FrmKuch.Dmer.SQL.Text:=sql;
              FrmKuch.Dmer.ExecSQL;
              frmlogin.SQLTransaction1.Commit;
              frmlogin.SQLTransaction1.Active:=True;
              fsvu.SQLQuery1.Open;
              fsvu.Grid_nastr();
              FrmKuch.Grid_nstr();
              FrmKuch.midn:=FrmKuch.midn+1;

         end;
    end;

    end;
  end;
end;

initialization
  {$I merop.lrs}

end.

