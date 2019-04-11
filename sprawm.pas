unit sprawm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls;

type

  { TFSprawm }

  TFSprawm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    mdata: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
         murcol: Integer;
    { private declarations }
  public
     mkpsu: Integer;
    { public declarations }
  end; 

var
  FSprawm: TFSprawm;

implementation
    uses kuch,shelp,Merop,fzap,unlogin,frmsvu;

{ TFSprawm }


procedure TFSprawm.FormCreate(Sender: TObject);
begin
    Button6.Visible:=False;
end;

procedure TFSprawm.FormShow(Sender: TObject);
begin
     Button2.Visible:=False;
     Button3.Visible:=False;
     Button4.Visible:=False;
     Button5.Visible:=False;
     if (Frmlogin.mpolz='Администратор') And (FrmSplash.memFl='OGLAVL') then begin
         Button2.Visible:=True;
         Button3.Visible:=True;
         if (FrmSplash.mstr='S1') OR (FrmSplash.mstr='S2') then Button4.Visible:=True;
         if (FrmSplash.mstr='SVD') then Button5.Visible:=True;
     end;

     murcol:=1;

     if (FrmSplash.minf='Карточка') or (FrmSplash.minf='Условия отбора') then begin
        Label2.Caption:=IntToStr(FrmSplash.mkpsu);
        mkpsu:=FrmSplash.mkpsu;
        Button1.Visible:=True;
     end
     else begin
         mkpsu:=0;
         Button1.Visible:=False;
     end;
end;

procedure TFSprawm.ListBox1Click(Sender: TObject);
begin
    FrmSplash.mtext:=ListBox1.Items.Strings[ListBox1.ItemIndex];
    FrmSplash.mtext:=Copy(FrmSplash.mtext,2,Length(FrmSplash.mtext));
    if FrmSplash.mtext<>'..' then
    begin
        mdata.Close;
        mdata.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" WHERE "UR"='+IntToStr(murcol)+' AND "NKOD"='''+FrmSplash.mtext+'''';
        mdata.Open;
        FrmSplash.mkod:=mdata.FieldByName('KOD').Text;
    end;
    Label1.Caption:=FrmSplash.mtext;
end;

procedure TFSprawm.ListBox1DblClick(Sender: TObject);
Var
  mint: Integer;
  mkod: String;
begin
     FrmSplash.mtext:=ListBox1.Items.Strings[ListBox1.ItemIndex];
     FrmSplash.mtext:=Copy(FrmSplash.mtext,2,Length(FrmSplash.mtext));
     Label1.Caption:=FrmSplash.mtext;
     ListBox1.Clear;
     if FrmSplash.mtext='..' then
     begin
        murcol:=murcol-1;
        if murcol>1 then begin
           ListBox1.Items.Add('...');
           FrmSplash.mkod:=Copy(FrmSplash.mkod,1,Length(FrmSplash.mkod)-2);
        end
        else FrmSplash.mkod:='';
          mdata.Close;
          mdata.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" WHERE "UR"='+IntToStr(murcol)+' AND "KOD" LIKE'''+FrmSplash.mkod+'%'' ORDER BY "NKOD"';
          mdata.Open;
          mdata.Last;
          mdata.First;
          while (not mdata.EOF) do begin
               if FrmSplash.mstr='S2' then begin
                  mkod:=mdata.FieldByName('KOD').Text+';';
                  mint:=Pos(mdata.FieldByName('KOD').Text,FrmSplash.mksy);
                  if mint>0 then begin
                  if mint=1 then
                  if Copy(FrmSplash.mksy,mint+Length(mdata.FieldByName('KOD').Text),1)=';' then
                  ListBox1.Items.Add('*'+mdata.FieldByName('NKOD').Text)
                  else ListBox1.Items.Add(' '+mdata.FieldByName('NKOD').Text);
                  if mint>1 then
                  if (Copy(FrmSplash.mksy,mint+Length(mdata.FieldByName('KOD').Text),1)+Copy(FrmSplash.mksy,mint-1,1))=';;' then
                  ListBox1.Items.Add('*'+mdata.FieldByName('NKOD').Text)
                  else ListBox1.Items.Add(' '+mdata.FieldByName('NKOD').Text);
                  end
               else
               ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
               end
               else  ListBox1.Items.Add(' '+mdata.FieldByName('NKOD').Text);
                mdata.Next;
          end;
     end
     else
     begin
          ListBox1.Items.Add('...');
          murcol:=murcol+1;
          mdata.Close;
          mdata.SQL.Text:='SELECT * FROM "'+FrmSplash.mstr+'" WHERE "UR"='+IntToStr(murcol)+' AND "KOD" LIKE'''+FrmSplash.mkod+'%'' ORDER BY "NKOD"';
          mdata.Open;
          mdata.Last;
          mdata.First;
          while (not mdata.EOF) do begin
               if FrmSplash.mstr='S2' then begin
                  mkod:=mdata.FieldByName('KOD').Text+';';
                  mint:=Pos(mdata.FieldByName('KOD').Text,FrmSplash.mksy);
                  if mint>0 then begin
                  if mint=1 then
                  if Copy(FrmSplash.mksy,mint+Length(mdata.FieldByName('KOD').Text),1)=';' then
                  ListBox1.Items.Add('*'+mdata.FieldByName('NKOD').Text)
                  else ListBox1.Items.Add(' '+mdata.FieldByName('NKOD').Text);
                  if mint>1 then
                  if (Copy(FrmSplash.mksy,mint+Length(mdata.FieldByName('KOD').Text),1)+Copy(FrmSplash.mksy,mint-1,1))=';;' then
                  ListBox1.Items.Add('*'+mdata.FieldByName('NKOD').Text)
                  else ListBox1.Items.Add(' '+mdata.FieldByName('NKOD').Text);
               end
               else
               ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
               end
               else  ListBox1.Items.Add(' '+mdata.FieldByName('NKOD').Text);
               mdata.Next;
          end;
     end;
end;


procedure TFSprawm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  mdata.Close;
end;

procedure TFSprawm.Button1Click(Sender: TObject);
var
  mint,mind : Integer;
  mc,mc1    : String;
begin
  if FrmSplash.mstr='S1' then
  begin
       if FrmSplash.minf='Карточка' then begin
          frmkuch.Label8.Caption:=FrmSplash.mtext;
          frmkuch.mkod:=FrmSplash.mkod;
          murcol:=1;
          Label1.Caption:='';
       end;
       if FrmSplash.minf='Условия отбора' then begin
          frmzap.Label1.Caption:=FrmSplash.mtext;
         // frmkuch.mkod:=FrmSplash.mkod;
          murcol:=1;
          Label1.Caption:='';
       end;
       FSprawm.Close;
  end;
  if FrmSplash.mstr='S2' then
  begin
       Label1.Caption:=Copy(ListBox1.Items.Strings[ListBox1.ItemIndex],1,1);
       mc:= FrmSplash.mkod;
       mc1:=Copy(ListBox1.Items.Strings[ListBox1.ItemIndex],1,1);
       mind:= ListBox1.ItemIndex;
       ListBox1.Items.Delete(mind);
       if mc1=' ' then begin
          mkpsu:=mkpsu+1;
          FrmSplash.mksy:=FrmSplash.mksy+mc+';';
          mc1:='*';
          end
          else begin
               mkpsu:=mkpsu-1;
               FrmSplash.mkpsu:=mkpsu;
               if mkpsu=0 then FrmSplash.mksy:=''
               else
                 begin
                      mint:=Pos(mc,FrmSplash.mksy);
                      Delete(FrmSplash.mksy,mint,Length(mc)+1);
                 end;
               mc1:=' ';
          end;
          Label2.Caption:=IntToStr(mkpsu);
          ListBox1.Items.Insert(mind,mc1+FrmSplash.mtext);
          if FrmSplash.minf='Условия отбора' then begin
             frmzap.Label2.Caption:=FrmSplash.mtext;
             FrmSplash.mkod:='';
             FSprawm.Close;
          end;
  end;
  if FrmSplash.mstr='SVD' then
  begin
     Label1.Caption:=Copy(ListBox1.Items.Strings[ListBox1.ItemIndex],1,1);
       mc:= FrmSplash.mkod;
       mc1:=Copy(ListBox1.Items.Strings[ListBox1.ItemIndex],1,1);
       mind:= ListBox1.ItemIndex;
       ListBox1.Items.Delete(mind);
       if mc1=' ' then begin
          mkpsu:=mkpsu+1;
          FrmSplash.mksy:=FrmSplash.mksy+mc+';';
          mc1:='*';
          end
          else begin
               if mkpsu=0 then FrmSplash.mksy:=''
               else
                 begin
                      mint:=Pos(mc,FrmSplash.mksy);
                      Delete(FrmSplash.mksy,mint,Length(mc)+1);
                 end;
               mkpsu:=mkpsu-1;
               mc1:=' ';
          end;
          Label2.Caption:=IntToStr(mkpsu);
          ListBox1.Items.Insert(mind,mc1+FrmSplash.mtext);
       if FrmSplash.memFl='STAT' then begin
             FSprawm.Close;
          end;
       if FrmSplash.minf='Карточка' then begin
            if FrmKuch.Dmer.Active=True then FrmKuch.Dmer.Close;
               FrmKuch.Dmer.SQL.Text:='SELECT "SVD01"."NKOD" AS "NAME","SVD"."NKOD" AS "NKOD" FROM "SVD01","SVD" WHERE "SVD"."KOD"='''+FrmSplash.mkod+''' AND "SVD01"."KOD"=SUBSTR("SVD"."KOD",1,2)';
               FrmKuch.Dmer.Open;
               FrmMerop.Label4.Caption:=FrmKuch.Dmer.FieldByName('NAME').Text;
               FrmMerop.Label6.Caption:=FrmKuch.Dmer.FieldByName('NKOD').Text;
              // frmkuch.Label8.Caption:=FrmSplash.mtext;
         // frmkuch.mkod:=FrmSplash.mkod;
        //  murcol:=1;
        //  Label1.Caption:='';
       end;
      // FSprawm.Close;
  end;
end;

procedure TFSprawm.Button2Click(Sender: TObject);
var mst,mCC, sSQL, mn: String;
    X: Integer;
begin
  mdata.Close;
  mst:= InputBox('Добавление строки справочника','Введите наименование','');
  if mst<>'' then mdata.SQL.Text:= 'SELECT "NKOD" FROM "'+FrmSplash.mstr+'" WHERE "NKOD"=''' + mst+ '''';
  mdata.Open;
  if mdata.RecordCount=0 then
  begin
       if MessageDlg('Добавить? ('+mst+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
        //  if murcol=1 then FrmSplash.mkod:=IntToStr(StrToInt(FrmSplash.mkod)+1);
          mdata.Close;
          if FrmSplash.mkod<>'' then sSQL:= 'SELECT "KOD" FROM "'+FrmSplash.mstr+'" WHERE "UR"='+IntToStr(murcol)+' AND "KOD" LIKE'''+FrmSplash.mkod+'%'' ORDER BY "KOD"'
          else sSQL:= 'SELECT "KOD" FROM "'+FrmSplash.mstr+'" WHERE "UR"='+IntToStr(murcol)+ ' ORDER BY "KOD"';
          mdata.SQL.Text:=sSQL;
          mdata.Open;
          if mdata.RecordCount=0 then mCC:=FrmSplash.mkod+'01'
          else begin
               mdata.Last;
               mCC:=mdata.Fields[0].Text;
               X:=StrToInt(copy(mCC,(murcol*2-1),(murcol*2+3)))+1;
               if X <10 then mCC:=copy(mCC,1,length(mcc)-2)+'0'+IntToStr(X)
               else mCC:=copy(mCC,1,length(mcc)-2)+IntToStr(X);
          end;
               if (FrmSplash.mstr='S1') or (FrmSplash.mstr='S2') then begin
                    mn:= InputBox('','Введите код по типовому перечню (число!)','');
                    if mn<>''  then sSQL:='INSERT INTO "'+FrmSplash.mstr+'" ("UR","KOD","NKOD","T_PER") VALUES('+IntToStr(murcol)+','''+mCC+''','''+mst+''','+mn+')'
                    else sSQL:='INSERT INTO "'+FrmSplash.mstr+'" ("UR","KOD","NKOD") VALUES('+IntToStr(murcol)+','''+mCC+''','''+mst+''')';
               end
               else
                   if FrmSplash.mstr='SVD' then begin
                      mn:= InputBox('Код по перечню услуг в формате Х.Х.!','Введите код по перечню услуг','');
                      sSQL:='INSERT INTO "'+FrmSplash.mstr+'" ("UR","KOD","NKOD","NUM") VALUES('+IntToStr(murcol)+','''+mCC+''','''+mst+''','''+mn+''')';
                      end
                      else sSQL:='INSERT INTO "'+FrmSplash.mstr+'" ("UR","KOD","NKOD") VALUES('+IntToStr(murcol)+','''+mCC+''','''+mst+''')';

          mdata.Close;
          mdata.SQL.Text:=sSQL;
          mdata.ExecSQL;
          frmlogin.SQLTransaction1.Commit;
          frmlogin.SQLTransaction1.Active:=True;
          if FrmSplash.minf='Карточка' then begin
             fsvu.SQLQuery1.Open;
             fsvu.Grid_nastr();
             FrmKuch.Grid_nstr();
             FrmKuch.Grid_nstr2();
             FrmKuch.TabSheet2.TabIndex;
          end;

          ListBox1.Items.Add(' '+mst);
   // ShowMessage(mCC);
       end;

  end
  else
    ShowMessage('Такое наименование уже есть!');
end;

procedure TFSprawm.Button3Click(Sender: TObject);
var
    X:Integer;
begin
  if MessageDlg('Удалить? ('+FrmSplash.mtext+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
     mdata.Close;
     if  FrmSplash.mstr='SVD' then
     begin
        mdata.SQL.Text:='SELECT * FROM "MEROP" WHERE "KVD" LIKE '''+FrmSplash.mkod+'%''';
        mdata.Open;
        if mdata.RecordCount>0 then ShowMessage('Есть мероприятия с кодом '+ FrmSplash.mkod+'. Удаление невозможно!')
        else begin
             X:=ListBox1.ItemIndex;
             mdata.Close;
             mdata.SQL.Text:='DELETE FROM "SVD" WHERE "KOD" LIKE '''+FrmSplash.mkod+'%''';
             mdata.ExecSQL;
             frmlogin.SQLTransaction1.Commit;
             frmlogin.SQLTransaction1.Active:=True;
             if FrmSplash.minf='Карточка' then begin
                fsvu.SQLQuery1.Open;
                fsvu.Grid_nastr();
                FrmKuch.Grid_nstr();
                FrmKuch.Grid_nstr2();
             end;
             ListBox1.Items.Delete(X);
        end;
     end;
  end;
end;

procedure TFSprawm.Button4Click(Sender: TObject);
var mn: String;
begin
      mn:= InputBox('','Введите код по типовому перечню (число!)','');
      if mn<>'' then begin
         if mdata.Active then mdata.Close;
         mdata.SQL.Text:='UPDATE "'+FrmSplash.mstr+'" SET "T_PER"='+mn+''' WHERE "KOD"='''+FrmSplash.mkod+'''';
         mdata.ExecSQL;
         frmlogin.SQLTransaction1.Commit;
         frmlogin.SQLTransaction1.Active:=True;
      end;
end;

procedure TFSprawm.Button5Click(Sender: TObject);
var mn: String;
begin
      mn:= InputBox('Код по перечню услуг в формате Х.Х.!','Введите код по перечню услуг','');
      if mn<>'' then begin
         if mdata.Active then mdata.Close;
         mdata.SQL.Text:='UPDATE "'+FrmSplash.mstr+'" SET "NUM"='''+mn+''' WHERE "KOD"='''+FrmSplash.mkod+'''';
         mdata.ExecSQL;
         frmlogin.SQLTransaction1.Commit;
         frmlogin.SQLTransaction1.Active:=True;
      end;
end;

procedure TFSprawm.Button6Click(Sender: TObject);
Var
   X :Integer;
   mkod, ms, sl, mksy: String;
begin
   if FrmSplash.minf='Карточка' then begin
        mksy:=FrmSplash.mksy;
        if length(FrmSplash.mksy)>0 then begin
                mkod:='';
                for X:=1 to length(FrmSplash.mksy) do begin
                    ms:=copy(FrmSplash.mksy,X,1);
                    if ms<>';' then mkod:=mkod+ms else begin
                       mdata.Close;
                       mdata.SQL.Text:='SELECT "NKOD" FROM "S2" WHERE "KOD"='''+mkod+'''';
                       mdata.Open;
                       if mdata.RecordCount>0 then sl:=sl+'; '+mdata.FieldByName('NKOD').Text+' ';
                       mkod:='';
                    end;
                end;
        frmkuch.Memo1.Text:=Copy(sl,2,length(sl)-1);
        FrmSplash.mkpsu:=mkpsu;
        end
        else
             frmkuch.Memo1.Text:='';
          murcol:=1;
       end;
       FSprawm.Close;
end;

initialization
  {$I sprawm.lrs}

end.

