unit uspraw;

{$mode objfpc}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls;

type

  { TFrmSprav }

  TFrmSprav = class(TForm)
    ListBox1: TListBox;
    Dzap: TSQLQuery;
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { private declarations }
  public
    mk, mn: String;
    { public declarations }
  end; 

var
  FrmSprav: TFrmSprav;


implementation
uses unlogin, frmsvu, FPY, shelp, unmenu, sprawm, usprav;

{ TFrmSprav }

procedure TFrmSprav.FormShow(Sender: TObject);
begin
  if Dzap.Active then Dzap.Close;
  ListBox1.Clear;
   if FrmSplash.memFl='OGLAVL' then begin
     Dzap.SQL.Text:='SELECT * FROM "OGLAVL" ORDER BY "IMJK"';
     Dzap.Open;
     Dzap.First;
     while (not Dzap.EOF) do begin
        ListBox1.Items.Add(Dzap.FieldByName('IMJK').Text+': '+Dzap.FieldByName('NAIMK').Text);
        Dzap.Next;
     end;
   end
   else begin
     Dzap.SQL.Text:='SELECT * FROM "KAT" ORDER BY "KS"';
     Dzap.Open;
     Dzap.First;
     while (not Dzap.EOF) do begin
        ListBox1.Items.Add(Dzap.FieldByName('KS').Text+': Справочник '+Dzap.FieldByName('N').Text);
        Dzap.Next;
     end;
   end;
end;

procedure TFrmSprav.ListBox1Click(Sender: TObject);
begin
   if FrmSplash.memFl='OGLAVL' then begin
      FrmSplash.mstr:=ListBox1.Items.Strings[ListBox1.ItemIndex];
      FrmSplash.mstr:=copy(FrmSplash.mstr,1,(Pos(':',FrmSplash.mstr)-1));
      fsprawm.mkpsu:=0;
      fsprawm.Caption:=copy(ListBox1.Items.Strings[ListBox1.ItemIndex],(Pos(':',ListBox1.Items.Strings[ListBox1.ItemIndex])+1),Length(FrmSplash.mstr));
      fsprawm.mdata.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" WHERE "UR"=1 ORDER BY "NKOD"';
      fsprawm.mdata.Open;
      fsprawm.mdata.Last;
      fsprawm.mdata.First;
      fsprawm.ListBox1.Clear;
      while (not fsprawm.mdata.EOF) do begin
          fsprawm.ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
          fsprawm.mdata.Next;
      end;
      Fsprawm.Show;
   end
   else begin
      FrmSplash.mstr:=ListBox1.Items.Strings[ListBox1.ItemIndex];
      FrmSplash.mstr:=copy(FrmSplash.mstr,1,(Pos(':',FrmSplash.mstr)-1));
      if Dzap.Active then Dzap.Close;
      Dzap.SQL.Text:='SELECT * FROM "KAT" WHERE "KS"='''+FrmSplash.mstr+'''';
      Dzap.Open;
      Dzap.First;
      mn:=Dzap.FieldByName('ND').Text;
      mk:=Dzap.FieldByName('KD').Text;
         if fsprav.Dzap.Active=True then fsprav.Dzap.Close;
         FrmSplash.mstr:=Trim(FrmSplash.mstr);
         fsprav.Dzap.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" ORDER BY "'+mn+'"';
         //fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE ''__000000000'' ORDER BY "S_NAME"';
         fsprav.Dzap.Open;
         // fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE ''__000000000''';
         // fsprav.Dzap.Active:=True;
         fsprav.Dzap.First;
         fsprav.DBGRid1.Columns[0].Title.Caption:='Код';
         fsprav.DBGRid1.Columns[1].Title.Caption:='Название';
       //  fsprav.DBGRid1.Columns[2].Visible:=False;
       //  fsprav.DBGRid1.Columns[3].Visible:=False;
         fsprav.DBGRid1.AutoEdit:=False;
         //fsprav.DBGRid1.Columns[0].Title.Caption:='Сокращение';
         //fsprav.DBGRid1.Columns[1].Title.Caption:='Название';
         //fsprav.DBGRid1.Columns[2].Title.Caption:='Индекс';
         //fsprav.DBGRid1.Columns[3].Visible:=False;
         //fsprav.DBGRid1.AutoEdit:=False;

         fsprav.Caption:='Справочник '+Dzap.Fields[1].Text;
         fsprav.Show;
   end;
end;

initialization
  {$I uspraw.lrs}

end.

