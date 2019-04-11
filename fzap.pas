unit fzap;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, EditBtn;

type

  { TFrmzap }

  TFrmzap = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Frmzap: TFrmzap;

implementation
  uses unlogin, shelp, frmsvu, sprawm, FPY;

{ TFrmzap }

procedure TFrmzap.Button1Click(Sender: TObject);
begin
  FrmSplash.mstr:='S1';
  fsprawm.mkpsu:=0;
  fsprawm.Caption:='Справочник: выбор категории';
  fsprawm.mdata.SQL.Text:='SELECT * FROM "S1" WHERE "UR"=1 ORDER BY "NKOD"';
  fsprawm.mdata.Open;
  fsprawm.mdata.Last;
  fsprawm.mdata.First;
  fsprawm.ListBox1.Clear;
    while (not fsprawm.mdata.EOF) do begin
          fsprawm.ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
          fsprawm.mdata.Next;
    end;
    FrmSplash.minf:='Условия отбора';
  fsprawm.Show;
end;

procedure TFrmzap.Button2Click(Sender: TObject);
begin
  FrmSplash.minf:='Условия отбора';
  FrmPY.ShowModal;
end;

procedure TFrmzap.Button3Click(Sender: TObject);
begin
  FrmSplash.mstr:='S2';
  fsprawm.mkpsu:=0;
  fsprawm.Label2.Caption:='';
  fsprawm.Caption:='Справочник: признаки учета';
  if fsprawm.mdata.Active then fsprawm.mdata.Close;
  fsprawm.mdata.SQL.Text:='SELECT * FROM "S2" WHERE "UR"=1 ORDER BY "NKOD"';
  fsprawm.mdata.Open;
  fsprawm.mdata.Last;
  fsprawm.mdata.First;
  fsprawm.ListBox1.Clear;
    while (not fsprawm.mdata.EOF) do
    begin
         fsprawm.ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
         fsprawm.mdata.Next;
    end;
    FrmSplash.minf:='Условия отбора';
    fsprawm.Button6.Visible:=True;
  fsprawm.Show;
end;

procedure TFrmzap.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var ssql: String;
  sd: String;
begin
  sd:= 'SELECT DISTINCT * FROM "F2F1","PROPIS" WHERE "PROPIS"."PY"="F2F1"."PY" AND "PROPIS"."NKAR"="F2F1"."NKAR" AND "F2F1"."PSY" IS NULL AND "F2F1"."NKAR" LIKE ''_______00'' AND EXTRACT(MONTH FROM "PROPIS"."DatTo")='+Edit2.Text+' AND EXTRACT(YEAR FROM "PROPIS"."DatTo")='+FormatDateTime('YYYY',Date);
  if FrmSplash.memFl='NOUCH' then
     if Edit2.Text<>'' then ssql:='SELECT DISTINCT * FROM "F2F1P" WHERE "PSY"<>0 AND "PAR"=FALSE AND EXTRACT(MONTH FROM "DatTo")='+Edit2.Text+' AND EXTRACT(YEAR FROM "DatTo")='+FormatDateTime('YYYY',Date)
     else
     ssql:='SELECT DISTINCT *  FROM "F2F1" WHERE "PSY"<>0 AND "PAR"=FALSE';
  if FrmSplash.memFl='PROSM' then
      if Edit2.Text<>'' then ssql:='SELECT * FROM "F2F1P" WHERE "PSY" IS NULL AND "PAR"=FALSE AND EXTRACT(MONTH FROM "DatTo")='+Edit2.Text+' AND EXTRACT(YEAR FROM "DatTo")='+FormatDateTime('YYYY',Date)
      else
      ssql:='SELECT DISTINCT *  FROM "F2F1" WHERE "PSY" IS NULL AND "PAR"=FALSE';
  if FrmSplash.memFl='ARHIV' then
      if Edit2.Text<>'' then ssql:='SELECT DISTINCT * FROM "F2F1P" WHERE "PAR"=TRUE AND EXTRACT(MONTH FROM "DatTo")='+Edit2.Text+' AND EXTRACT(YEAR FROM "DatTo")='+FormatDateTime('YYYY',Date)
      else
      ssql:='SELECT DISTINCT *  FROM "F2F1" WHERE "PAR"=TRUE';
  if FrmSplash.mkod<>'' then ssql:=ssql+' AND "KOD" LIKE '''+ FrmSplash.mkod+'%''' ;
  if FrmSplash.memPY<>'' then ssql:=ssql+' AND "PY"='''+ FrmSplash.memPY+'''';
  if FrmSplash.mksy<>'' then ssql:=ssql+' AND "KSY" LIKE ''%'+copy(FrmSplash.mksy,1,Length(FrmSplash.mksy)-1)+'%''';
  if ComboBox1.Text<>'' then
  if ComboBox1.Text='Ж' then ssql:=ssql+' AND "POL"=''1'''
      else ssql:=ssql+' AND "POL"=''2''';
  if Edit1.Text<>'' then ssql:=ssql+' AND EXTRACT(MONTH FROM "DROG")='+Edit1.Text;
  //if Edit3.Text<>'' then ssql:=ssql+' AND EXTRACT(MONTH FROM "DATZK")='+Edit3.Text;
  if DateEdit1.Text<>'' then ssql:=ssql+' AND "DATZK">='''+FormatDateTime('YYYY-MM-DD',DateEdit1.Date)+'''';
  if DateEdit2.Text<>'' then ssql:=ssql+' AND "DATZK"<='''+FormatDateTime('YYYY-MM-DD',DateEdit2.Date)+'''';
  ssql:=ssql+' ORDER BY "FAMIL"';
  //ShowMessage(ssql);
     fsvu.SQLQuery1.Close;
     fsvu.SQLQuery1.SQL.Text:=ssql;
     fsvu.SQLQuery1.Open;
     //fsvu.SQLQuery1.Active:=True;
     fsvu.SQLQuery1.Last;
     fsvu.SQLQuery1.First;
     fsvu.Grid_nastr();
     Label1.Caption:='';
  Label2.Caption:='';
  Label3.Caption:='';
  FrmSplash.mkod:='';
  FrmSplash.minf:='';
  FrmSplash.memPY:='';
  FrmSplash.mksy:='';
  ComboBox1.Text:='';
  Edit1.Text:='';
  Edit2.Text:='';
  DateEdit1.Text:='';
  DateEdit2.Text:='';
end;

procedure TFrmzap.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
  Label2.Caption:='';
  Label3.Caption:='';
  FrmSplash.mkod:='';
  ComboBox1.Text:='';
  ComboBox1.AddItem('Ж',nil);
  ComboBox1.AddItem('М',nil);
  Edit1.Text:='';
  Edit2.Text:='';
  DateEdit1.Text:='';
  DateEdit2.Text:='';
end;

initialization
  {$I fzap.lrs}

end.

