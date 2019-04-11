unit FPY;

{$mode objfpc}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls;

type

  { TFrmPY }

  TFrmPY = class(TForm)
    ListBox1: TListBox;
    Dzap: TSQLQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FrmPY: TFrmPY;

implementation
uses frmsvu,unlogin,shelp,kuch,unmenu, fzap;
{ TFrmPY }


procedure TFrmPY.FormShow(Sender: TObject);
begin
  if Dzap.Active then Dzap.Close;
   if FrmSplash.memFl='STAT' then Dzap.SQL.Text:='SELECT * FROM "OTDEL"'
   else Dzap.SQL.Text:='SELECT * FROM "OTDEL" WHERE "OTD"<>''024''';
   Dzap.Open;
   Dzap.First;
   Listbox1.Clear;
   while (not Dzap.EOF) do begin
      ListBox1.Items.Add(Dzap.FieldByName('NAIM').Text);
      Dzap.Next;
   end;
end;

procedure TFrmPY.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FrmSplash.minf='Условия отбора' then
  frmzap.Label2.Caption:=ListBox1.Items.Strings[ListBox1.ItemIndex];
end;

procedure TFrmPY.ListBox1Click(Sender: TObject);
begin
  If Dzap.Active then  Dzap.Close;
  Dzap.SQL.Text:='SELECT * FROM "OTDEL" WHERE "NAIM"='''+ListBox1.Items.Strings[ListBox1.ItemIndex]+'''';
  Dzap.Open;
  FrmSplash.memPY:=Dzap.FieldByName('OTD').Text;
  if FrmSplash.memFl='New' then begin
     frmkuch.mpy:=Dzap.FieldByName('OTD').Text;
     Dzap.Close;
     Dzap.SQL.Text:='SELECT "NKAR" FROM "F2" WHERE "PY"='''+frmkuch.mpy+''' ORDER BY "NKAR"';
     Dzap.Open;
     if Dzap.RecordCount=0 then frmkuch.mnkar:='000000100'
     else begin
     Dzap.Last;
     frmkuch.mnkar:=IntToStr((StrToInt(copy(Dzap.FieldByName('NKAR').Text,1,7))+1))+'00';
     while Length(frmkuch.mnkar)<9 do frmkuch.mnkar:='0'+frmkuch.mnkar;
     end;
     Dzap.Close;
     if frmkuch.Dzap.Active=True then frmkuch.Dzap.Close;
     frmkuch.Dzap.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+FrmLogin.mpolz+'''';
     frmkuch.Dzap.Open;
     Dzap.SQL.Text:='INSERT INTO "F2"("PY","NKAR","DATZK","KISP","PPROG") VALUES('''+frmkuch.mpy+''','''+frmkuch.mnkar+''','''+FormatDateTime('YYYY-MM-DD',Now())+''','+frmkuch.Dzap.FieldByName('KISP').Text+',TRUE)';
     Dzap.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
    frmkuch.kart_new();
    frmkuch.Show;
  end;
  FrmPy.Close;
end;

initialization
  {$I fpy.lrs}

end.

