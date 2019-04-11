unit kuch;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, ExtCtrls, EditBtn, StdCtrls, MaskEdit, Buttons, DBGrids,
  Menus, types, process;

type

  { TFrmKuch }

  TFrmKuch = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Datasource1: TDatasource;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DateEdit3: TDateEdit;
    DateEdit4: TDateEdit;
    DateEdit5: TDateEdit;
    DateEdit6: TDateEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Edit1: TEdit;
    Edit14: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PageControl1: TPageControl;
    Dzap: TSQLQuery;
    Dyn: TSQLQuery;
    Dmer: TSQLQuery;
    Process1: TProcess;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DBLClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Grid_nstr();
    procedure Grid_nstr2();
    procedure kart_new();
    procedure kart_view();
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { private declarations }
  public
    mpy: String;
  mnkar: String;
   mkod: String;
   midn: Integer;
    { public declarations }
  end; 

var
  FrmKuch: TFrmKuch;
  mbut: Integer;
  mrkod: String;
  mrk: String;
  mpunkt: String;
  mfam: ShortString;

implementation
 uses frmsvu, Usprav,unlogin,sprawm,shelp,Merop,Prop,FPY;

{ TFrmKuch }
procedure TFrmKuch.Grid_nstr();
Var
   X: Integer;
   sql: String;
begin
     if Dzap.Active then Dzap.Close;
  sql:='SELECT "MEROP"."IDN","MEROP"."DATA","S20"."NISP","SVD01"."NKOD" AS "NAME","SVD"."NKOD" AS "NKOD","MEROP"."ORG","MEROP"."OBR","MEROP"."KVD"';
  sql:=sql+' FROM "MEROP","S20","SVD01","SVD" WHERE "MEROP"."KISP"="S20"."KISP" AND "MEROP"."KVD"="SVD"."KOD" AND "SVD01"."KOD"=SUBSTR("SVD"."KOD",1,2) AND "PY"='''+mpy+''' AND "NKAR"='''+mnkar+''' ORDER BY "MEROP"."DATA","MEROP"."IDN"';
  Dzap.SQL.Text:=sql;
  Dzap.Open;
 // DBGRid1.DataSource.DataSet:=Dzap;
  DBGRid1.Columns[1].Title.Caption:='Дата';
  DBGRid1.Columns[2].Title.Caption:='Соц.работник';
  DBGRid1.Columns[3].Title.Caption:='Вид деятельности';
  DBGRid1.Columns[4].Title.Caption:='Что сделано';
  DBGRid1.Columns[5].Title.Caption:='Организация';
  DBGRid1.Columns[6].Title.Caption:='Обращение';
  DBGRid1.Columns[0].Visible:=False;
  DBGRid1.Columns[7].Visible:=False;
  //for X:=1 to Dzap.FieldCount-1 do Dzap.Columns[X].Visible:=False ;
   for  X:=1 to 7 do begin
   //       DBGRid1.Columns[X].Visible:=True;
          DBGRid1.Columns[X].Width:=90;
    end;
   DBGRid1.Columns[3].Width:=160;
   DBGRid1.Columns[4].Width:=160;
   Dzap.Last;
  //  Datasource1.DataSet:= Dzap;
   //Label1.Caption:=IntToStr(fsvu.SQLQuery1.RecordCount) + '  ' + IntToStr(fsvu.SQLQuery1.FieldCount) ;
    Label33.Caption:='Всего мероприятий ('+IntToStr(Dzap.RecordCount)+')';

 end;

procedure TFrmKuch.Grid_nstr2();
Var X: Integer;
begin
   if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:='SELECT * FROM "PROPIS" WHERE "PY"='''+mpy+''' AND "NKAR"='''+mnkar+''' ORDER BY "DatFrom"';
  Dzap.Open;
  DBGRid2.Columns[2].Title.Caption:='Дата прописки';
  DBGRid2.Columns[3].Title.Caption:='Дата выбытия';
  DBGRid2.Columns[4].Title.Caption:='№ свидетельства';
  DBGRid2.Columns[5].Title.Caption:='Примечание';
  DBGRid2.Columns[0].Visible:=False;
  DBGRid2.Columns[1].Visible:=False;
   for  X:=2 to 5 do begin
          DBGRid1.Columns[X].Width:=90;
    end;
   Dzap.Last;
end;

procedure TFrmKuch.kart_new();
begin
   if Dyn.Active then Dyn.Close;
  Dyn.SQL.Text:='SELECT * FROM "F2" WHERE "NKAR"='''+mnkar+''' AND "PY"='''+mpy+'''';
  Dyn.Open;
  frmkuch.Edit1.Text:='';
  frmkuch.Edit2.Text:='';
  frmkuch.Edit3.Text:='';
  frmkuch.Label5.Caption:=mnkar;
  frmkuch.DateEdit1.Text:=Dyn.FieldByName('DATZK').Text;
 // Dzap.Close;
  If Dyn.FieldByName('KISP').Text<>'' then  begin
  Dzap.SQL.Text:='SELECT "NISP" FROM "S20" WHERE "KISP"='+Dyn.FieldByName('KISP').Text;
  Dzap.Open;
  frmkuch.ComboBox1.Text:=Dzap.FieldByName('NISP').Text;
  end
  else ComboBox1.Text:='';
  frmkuch.ComboBox5.Visible:=False;
  frmkuch.Button1.Visible:=True;
  frmkuch.Button17.Visible:=False;
  frmkuch.ComboBox2.Text:='Ж';
  frmkuch.ComboBox3.Text:='Б/ПЛ';
  frmkuch.Label8.Caption:='';
  frmkuch.Label8.Caption:='';
  frmkuch.mkod:='';
  FrmSplash.mksy:='';
  FrmSplash.mkpsu:=0;
  frmkuch.Memo1.Text:='';
  if copy(mnkar,8,2)<>'00' then begin
     frmkuch.ComboBox5.Text:='';
     frmkuch.Button1.Visible:=False;
     frmkuch.ComboBox5.Visible:=True;
     frmkuch.Label8.Caption:='Статус в семье:';
  end;
  frmkuch.DateEdit2.Text:='';
  frmkuch.Edit4.Text:='';
  frmkuch.Edit5.Text:='';
  frmkuch.Edit6.Text:='';
  frmkuch.Combobox4.Text:='паспорт';
  frmkuch.Edit7.Text:='';
  frmkuch.Edit8.Text:='';
  frmkuch.DateEdit3.Text:='';
  frmkuch.Edit9.Text:='';
  frmkuch.MaskEdit2.Text:='';
  frmkuch.MaskEdit1.Text:='';
  frmkuch.Edit11.Text:='';
  frmkuch.Edit12.Text:='';
  frmkuch.Edit13.Text:='';
  frmkuch.Edit14.Text:='';
  frmkuch.Edit15.Text:='';
  frmkuch.Edit16.Text:='';
  frmkuch.Edit17.Text:='';
  frmkuch.Edit18.Text:='';
  frmkuch.Edit19.Text:='';
  frmkuch.Edit20.Text:='';
  frmkuch.DateEdit4.Text:='';
  frmkuch.DateEdit5.Text:='';
  Dzap.Close;
  Dzap.SQL.Text:='SELECT "NAIM" FROM "OTDEL" WHERE "OTD"='''+Dyn.FieldByName('PY').Text+'''';
  Dzap.Open;
  frmkuch.Caption:='Карточка учета. '+Dzap.FieldByName('NAIM').Text;
  frmSplash.memFl:='PROSM';
end;

procedure TFrmKuch.kart_view();
Var mksy, ms, sl,mkd: String;
       X: Integer;
begin
  if Dyn.Active then Dyn.Close;
  Dyn.SQL.Text:='SELECT * FROM "F2" WHERE "NKAR"='''+mnkar+''' AND "PY"='''+mpy+'''';
  Dyn.Open;
  frmkuch.Edit1.Text:=Dyn.FieldByName('FAMIL').Text;
  frmkuch.Edit2.Text:=Dyn.FieldByName('IMJA').Text;
  frmkuch.Edit3.Text:=Dyn.FieldByName('OTCH').Text;
  frmkuch.Label5.Caption:=Dyn.FieldByName('NKAR').Text;
  frmkuch.DateEdit1.Text:=Dyn.FieldByName('DATZK').Text;
  If Dyn.FieldByName('KISP').Text<>'' then  begin
     if Dzap.Active then Dzap.Close;
     Dzap.SQL.Text:='SELECT "NISP" FROM "S20" WHERE "KISP"='+Dyn.FieldByName('KISP').Text;
     Dzap.Open;
     ComboBox1.Text:=Dzap.FieldByName('NISP').Text;
     end
  else ComboBox1.Text:='';
  If Dyn.FieldByName('PSY').Text<>'' then  begin
     frmkuch.DateEdit6.Visible:=True;
     frmkuch.Label35.Visible:=True;
     frmkuch.Label36.Visible:=True;
  Dzap.Close;
  Dzap.SQL.Text:='SELECT "NPSY" FROM "S22" WHERE "KPSY"='+Dyn.FieldByName('PSY').Text;
  Dzap.Open;
  if  Dzap.FieldByName('NPSY').Text<>'' then Label36.Caption:=Dzap.FieldByName('NPSY').Text
  else Label36.Caption:='';
  if frmkuch.Dyn.FieldByName('DSY').Text<>'' then
     frmkuch.DateEdit6.Text:=frmkuch.Dyn.FieldByName('DSY').Text
     else frmkuch.DateEdit6.Text:='';
  end
  else begin
       frmkuch.DateEdit6.Visible:=False;
       frmkuch.Label35.Visible:=False;
       frmkuch.Label36.Visible:=False;
       Label36.Caption:='';
  end;
  ComboBox5.Visible:=False;
  Button1.Visible:=True;
  if frmkuch.Dyn.FieldByName('POL').Text='1' then
  frmkuch.ComboBox2.Text:='Ж'
  else frmkuch.ComboBox2.Text:='M';
  if frmkuch.Dyn.FieldByName('PLATA').Text='П' then
  frmkuch.ComboBox3.Text:='Полная'
  else if frmkuch.Dyn.FieldByName('PLATA').Text='Ч' then
  frmkuch.ComboBox3.Text:='Частичная'
  else frmkuch.ComboBox3.Text:='Б/ПЛ';
  frmkuch.Label8.Caption:='';
  fsvu.DF1.Close;
  fsvu.DF1.SQL.Text:='SELECT * FROM "F1" WHERE "PY"='''+Dyn.FieldByName('PY').Text
        +''' AND "NKAR"='''+Dyn.FieldByName('NKAR').Text + '''';
  fsvu.DF1.Open;
  frmkuch.Memo1.Text:='';
  if  fsvu.DF1.FieldByName('KOD').Text<>'' then frmkuch.mkod:=fsvu.DF1.FieldByName('KOD').Text
  else frmkuch.mkod:='';
  if frmkuch.mkod='0' then frmkuch.mkod:='';
 // if fsvu.DF1.RecordCount>0 then begin
     if Dzap.Active then Dzap.Close;
     Dzap.SQL.Text:='SELECT "NKOD" FROM "S1" WHERE "KOD"='''+fsvu.DF1.FieldByName('KOD').Text+'''';
     Dzap.Open;
     if Dzap.RecordCount>0 then begin
        frmkuch.Label8.Caption:=Dzap.FieldByName('NKOD').Text;
        mksy:=fsvu.DF1.FieldByName('KSY').Text;
        if length(fsvu.DF1.FieldByName('KSY').Text)>0 then begin
                mkd:='';
                for X:=1 to length(fsvu.DF1.FieldByName('KSY').Text) do begin
                    ms:=copy(fsvu.DF1.FieldByName('KSY').Text,X,1);
                    if ms<>';' then mkd:=mkd+ms else begin
                       Dzap.Close;
                       Dzap.SQL.Text:='SELECT "NKOD" FROM "S2" WHERE "KOD"='''+mkd+'''';
                       Dzap.Open;
                       if Dzap.RecordCount>0 then sl:=sl+'; '+Dzap.FieldByName('NKOD').Text+' ';
                       mkd:='';
                    end;
                end;
        FrmSplash.mksy:=fsvu.Df1.FieldByName('KSY').Text;
        FrmSplash.mkpsu:=StrToInt(fsvu.Df1.FieldByName('KPSU').Text);
        frmkuch.Memo1.Text:=Copy(sl,2,length(sl)-1);
        end;

      //
     end;
 // end;
  if copy(mnkar,8,2)<>'00' then begin
     if Dyn.FieldByName('KSS').Text<>'' then begin
        Dzap.Close;
        Dzap.SQL.Text:='SELECT * FROM "S15" WHERE "KSS"='+Dyn.FieldByName('KSS').Text;
        Dzap.Open;
        ComboBox5.Text:=Dzap.FieldByName('NSS').Text;
     end
     else ComboBox5.Text:='';
     Button1.Visible:=False;
     ComboBox5.Visible:=True;
     Label8.Caption:='Статус в семье:';
  end;
  frmkuch.DateEdit2.Text:=frmkuch.Dyn.FieldByName('DROG').Text;
  frmkuch.Edit4.Text:=frmkuch.Dyn.FieldByName('RREG').Text;
  frmkuch.Edit5.Text:=frmkuch.Dyn.FieldByName('MRAI').Text;
  frmkuch.Edit6.Text:=frmkuch.Dyn.FieldByName('RNAS').Text;
  if Dyn.FieldByName('KDOK').Text<>'' then begin
     Dzap.Close;
     Dzap.SQL.Text:='SELECT "NAME" FROM "SDOK" WHERE "NUM"='+frmkuch.Dyn.FieldByName('KDOK').Text;
     Dzap.Open;
     frmkuch.Combobox4.Text:=Dzap.FieldByName('NAME').Text;
  end else Combobox4.Text:='';
  frmkuch.Edit7.Text:=frmkuch.Dyn.FieldByName('PSR').Text;
  frmkuch.Edit8.Text:=frmkuch.Dyn.FieldByName('PNM').Text;
  frmkuch.DateEdit3.Text:=frmkuch.Dyn.FieldByName('PDV').Text;
  frmkuch.Edit9.Text:=frmkuch.Dyn.FieldByName('PKV').Text;
  frmkuch.MaskEdit2.Text:=frmkuch.Dyn.FieldByName('KOD_PODR').Text;
  frmkuch.MaskEdit1.Text:=frmkuch.Dyn.FieldByName('SVPF').Text;
  frmkuch.Edit11.Text:=frmkuch.Dyn.FieldByName('NAPR').Text;
  frmkuch.Edit12.Text:=frmkuch.Dyn.FieldByName('REG').Text;
  frmkuch.Edit13.Text:=frmkuch.Dyn.FieldByName('RAI').Text;
  frmkuch.Edit14.Text:=frmkuch.Dyn.FieldByName('PIND').Text;
  frmkuch.Edit15.Text:=frmkuch.Dyn.FieldByName('NASP').Text;
  frmkuch.Edit16.Text:=frmkuch.Dyn.FieldByName('YLIC').Text;
  frmkuch.Edit17.Text:=frmkuch.Dyn.FieldByName('NDOM').Text;
  frmkuch.Edit18.Text:=frmkuch.Dyn.FieldByName('NKORP').Text;
  frmkuch.Edit19.Text:=frmkuch.Dyn.FieldByName('NKW').Text;
  frmkuch.Edit20.Text:=frmkuch.Dyn.FieldByName('NTEL').Text;
  frmkuch.DateEdit4.Text:=frmkuch.Dyn.FieldByName('DATPROP').Text;
  frmkuch.DateEdit5.Text:=frmkuch.Dyn.FieldByName('DATVIP').Text;
  Dzap.Close;
  Dzap.SQL.Text:='SELECT "NAIM" FROM "OTDEL" WHERE "OTD"='''+Dyn.FieldByName('PY').Text+'''';
  Dzap.Open;
  frmkuch.Caption:='Карточка учета. '+Dzap.FieldByName('NAIM').Text
end;

procedure TFrmKuch.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;



function  convert_cyr_string(str : string; from, to_ : char) : string;
 var
   i       : integer;
   p       : integer;
   c       : char;
   fromstr : string;
   tostr   : string;
   outstr  : string;
 begin
      outstr:='';
   case from of
     'w' : fromstr := 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
    // 'd' : fromstr :=  #160#161#162#163#164#165#241#166#167#168#169#170#171#172#173#174#175#224#225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#128#129#130#131#132#133#240#134#135#136#137#138#139#140#141#142#143#144#145#146#147#148#149#150#151#152#153#154#155#156#157#158#159;
     'd' : fromstr :=  #176#177#178#179#180#181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197#198#199#200#201#202#203#204#144#145#146#147#148#149#150#151#152#153#154#155#156#157#158#159;
     'k' : fromstr := 'БВЧЗДЕJЦЪЙКЛМНОПРТУФХЖИГЮЫЭЯЩШЬАСбвчздеjцъйклмнопртуфхжигюыэящшьас';
   else
           fromstr := 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
   end;
  // case to_ of
  //   'w' : tostr := 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
  //   'd' : tostr :=  #160#161#162#163#164#165#241#166#167#168#169#170#171#172#173#174#175#224#225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#128#129#130#131#132#133#240#134#135#136#137#138#139#140#141#142#143#144#145#146#147#148#149#150#151#152#153#154#155#156#157#158#159;
  //   'k' : tostr := 'БВЧЗДЕJЦЪЙКЛМНОПРТУФХЖИГЮЫЭЯЩШЬАСбвчздеjцъйклмнопртуфхжигюыэящшьас';
  // else
           tostr := 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
 //  end;

   for i := 1 to length(str)*2 do
   begin
     c := str[i];
     p := pos(c, fromstr);
     if p <> 0 then
     begin
       outstr := outstr+tostr[p];
       c      := tostr[p];
       str[i] := c;
     end;
     str[i] := c;
   end;

   convert_cyr_string := str;
 end;


function UnicodeToWin(var mText: string): string;
var InString, OutString: string;
    i, Len: integer;
    b: Char;
    //b: string;
begin
i:=1;
InString:=mText; OutString:='';
//Delete(InString, 1, 2);
Len:=Length(InString);
try
	repeat
//  	case InString[i+1] of
//  		#0: case InString[i] of
//{a english}     #97: b:=#97; #98: b:=#98; #99: b:=#99; #100: b:=#100; #101: b:=#101; #102: b:=#102; #103: b:=#103; #104: b:=#104; #105: b:=#105; #106: b:=#106; #107: b:=#107; #108: b:=#108; #109: b:=#109; #110: b:=#110; #111: b:=#111; #112: b:=#112; #113: b:=#113; #114: b:=#114; #115: b:=#115; #116: b:=#116; #117: b:=#117; #118: b:=#118; #119: b:=#119; #120: b:=#120; #121: b:=#121; #122: b:=#122;
//{A english}     #65: b:=#65; #66: b:=#66; #67: b:=#67; #68: b:=#68; #69: b:=#67; #70: b:=#70; #71: b:=#71; #72: b:=#72; #73: b:=#73; #74: b:=#74; #75: b:=#75; #76: b:=#76; #77: b:=#77; #78: b:=#78; #79: b:=#79; #80: b:=#80; #81: b:=#81; #82: b:=#82; #83: b:=#83; #84: b:=#84; #85: b:=#85; #86: b:=#86; #87: b:=#87; #88: b:=#88; #89: b:=#89; #90: b:=#90;
//{0..9}          #48: b:=#48; #49: b:=#49; #50: b:=#50; #51: b:=#51; #52: b:=#52; #53: b:=#53; #54: b:=#54; #55: b:=#55; #56: b:=#56; #57: b:=#57;
//{Спец символы}  #33: b:=#33; #13: b:=#13; #9: b:=#9; #10: b:=#10; #32: b:=#32; #64: b:=#64; #35: b:=#35; #36: b:=#36; #37: b:=#37; #94: b:=#94; #38: b:=#38; #42: b:=#42; #40: b:=#40; #41: b:=#41; #45: b:=#45; #95: b:=#95; #43: b:=#43; #61: b:=#61; #92: b:=#92; #47: b:=#47; #124: b:=#124; #46: b:=#46; #44: b:=#44; #59: b:=#59; #58: b:=#58; #123: b:=#123; #125: b:=#125; #63: b:=#63; #60: b:=#60; #62: b:=#62; #34: b:=#34; #91: b:=#91; #93: b:=#93; #96: b:=#96; #126: b:=#126
//                end;
//    	#4: case InString[i] of
//{а русские}     #48: b:=#224; #49: b:=#225; #50: b:=#226; #51: b:=#227; #52: b:=#228; #53: b:=#229; #54: b:=#230; #55: b:=#231; #56: b:=#232; #57: b:=#233; #58: b:=#234; #59: b:=#235; #60: b:=#236; #61: b:=#237; #62: b:=#238; #63: b:=#239; #64: b:=#240; #65: b:=#241; #66: b:=#242; #67: b:=#243; #68: b:=#244; #69: b:=#245; #70: b:=#246; #71: b:=#247; #72: b:=#248; #73: b:=#249; #74: b:=#250; #75: b:=#251; #76: b:=#252; #77: b:=#253; #78: b:=#254; #79: b:=#255; #81: b:=#184;
//{А русские}     #16: b:=#192; #17: b:=#193; #18: b:=#194; #19: b:=#195; #20: b:=#196; #21: b:=#197; #22: b:=#198; #23: b:=#199; #24: b:=#200; #25: b:=#201; #26: b:=#202; #27: b:=#203; #28: b:=#204; #29: b:=#205; #30: b:=#206; #31: b:=#207; #32: b:=#208; #33: b:=#209; #34: b:=#210; #35: b:=#211; #36: b:=#212; #37: b:=#213; #38: b:=#214; #39: b:=#215; #40: b:=#216; #41: b:=#217; #42: b:=#218; #43: b:=#219; #44: b:=#220; #45: b:=#221; #46: b:=#222; #47: b:=#223; #1: b:=#168
//                end
//                else if (InString[i]=#84) and (InString[i+1]=#70) then b:=#185
//    	end;
        if InString[i] = #208 then
        begin
             case InString[i+1] of
             #176: b:=#224; #177: b:=#225;
             end;
        end;
OutString:=OutString+b;
  	i:=i+2
	until i>Len;
  mText:=OutString
  except
//  Result:=false
  end
end;



procedure TFrmKuch.FormCreate(Sender: TObject);
Var
    sql: String;
begin
 // if Dyn.Active then Dyn.Close;
 // sql:='SELECT "MEROP"."IDN","MEROP"."DATA","S20"."NISP","SVD01"."NKOD" AS "NAME","SVD"."NKOD" AS "NKOD","MEROP"."MATHELP","MEROP"."ORG","MEROP"."OBR"';
 // sql:=sql+' FROM "MEROP","S20","SVD01","SVD" WHERE "MEROP"."KISP"="S20"."KISP" AND "MEROP"."KVD"="SVD"."KOD" AND "SVD01"."KOD"=SUBSTR("SVD"."KOD",1,2) AND "PY"='''+mpy+''' AND "NKAR"='''+mnkar+''' ORDER BY "MEROP"."DATA","MEROP"."IDN"';
 // Dyn.SQL.Text:=sql;
 // Dyn.Open;
    if Dzap.Active then Dzap.Close;
     Dzap.SQL.Text:='SELECT "NISP" FROM "S20" ORDER BY "NISP"';
     Dzap.Open;
     Dzap.First;
     while (not Dzap.EOF) do begin
        ComboBox1.AddItem(Dzap.FieldByName('NISP').Text, nil);
        Dzap.Next;
     end;
     Dzap.Close;
     Dzap.SQL.Text:='SELECT "NAME" FROM "SDOK" ORDER BY "NUM"';
     Dzap.Open;
     Dzap.First;
     while (not Dzap.EOF) do begin
        ComboBox4.AddItem(Dzap.FieldByName('NAME').Text, nil);
        Dzap.Next;
     end;
     Dzap.Close;
     Dzap.SQL.Text:='SELECT "NSS" FROM "S15" ORDER BY "NSS"';
     Dzap.Open;
     Dzap.First;
     while (not Dzap.EOF) do begin
        ComboBox5.AddItem(Dzap.FieldByName('NSS').Text, nil);
        Dzap.Next;
     end;
     ComboBox2.AddItem('Ж',nil);
     ComboBox2.AddItem('М',nil);
     ComboBox3.AddItem('Полная',nil);
     ComboBox3.AddItem('Частичная',nil);
     ComboBox3.AddItem('Б/ПЛ',nil);
     Dzap.Close;
     mfam:= Edit1.Text;
     Grid_nstr();
     PageControl1.ActivePage:=TabSheet1;
end;

procedure TFrmKuch.FormShow(Sender: TObject);
begin
  mfam:= Edit1.Text;
     Grid_nstr();
     PageControl1.ActivePage:=TabSheet1;
end;

procedure TFrmKuch.ListBox1Click(Sender: TObject);
begin

end;

procedure TFrmKuch.ListBox1DBLClick(Sender: TObject);
begin
    mnkar:=COPY(mnkar,1,7)+COPY(ListBox1.Items.Strings[ListBox1.ItemIndex],1,2);
    frmSplash.memFl:='PROSM';
    PageControl1.ActivePage:=TabSheet1;
end;

procedure TFrmKuch.MenuItem1Click(Sender: TObject);
begin

end;

procedure TFrmKuch.MenuItem2Click(Sender: TObject);
  var f: TextFile;
    s,sl,ms,APath, madr: String;
    X: Integer;
begin
  //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
  //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
  Rewrite(f);
  s:= 'ФИО:'+ Dyn.FieldByName('FAMIL').Text+' '+ Dyn.FieldByName('IMJA').Text +' '
        +Dyn.FieldByName('OTCH').Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАР:'+ Dyn.FieldByName('DROG').Text;
  writeln(f,UTF8ToAnsi(s));
  if Edit17.Text<>'' then
  madr:=Edit14.Text+','+Edit12.Text+' '+Edit13.Text+' '+Edit15.Text+' '+Edit16.Text+' д.'+Edit17.Text+' корп.'+Edit18.Text+' кв.'+Edit19.Text
  else
  madr:='Постоянного места жительства не имеет';
  //if DateEdit5.Text<>'' then madr:=madr+' Снят с регистрационного учета '+DateEdit5.Text+'г.';
  s:='АДРЕС:'+madr;
  writeln(f,UTF8ToAnsi(s));
  if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:='SELECT *  FROM "PROPIS" WHERE "PY"='''+mpy +''' AND "NKAR"='''+mnkar+ ''' AND "Nsv"=0 ORDER BY "DatFrom"';
  Dzap.Open;
  if Dzap.RecordCount>0 then begin
     Dzap.Last;
     s:='ДАТАСПР:'+ Dzap.FieldByName('DatFrom').Text;
     writeln(f,UTF8ToAnsi(s));
     s:='ДАТАПОПР:'+ Dzap.FieldByName('DatTo').Text;
     writeln(f,UTF8ToAnsi(s));
  end
  else
  begin
     s:='ДАТАСПР: ';
     writeln(f,UTF8ToAnsi(s));
     s:='ДАТАПОПР: ';
     writeln(f,UTF8ToAnsi(s));
  end ;
  if copy(mnkar,8,2)<>'00' then
     begin
          if Dzap.Active then Dzap.Close;
          Dzap.SQL.Text:='SELECT * FROM "F2" WHERE "PY"='''+mpy+''' AND "NKAR" LIKE '''+COPY(mnkar,1,7)+'00''';
          Dzap.Open;
          s:='ФИОР: мать '+ Dzap.FieldByName('FAMIL').Text+' '+ Dzap.FieldByName('IMJA').Text +' '
          +Dzap.FieldByName('OTCH').Text+' паспорт: серия '+Dzap.FieldByName('PSR').Text+' № '+Dzap.FieldByName('PNM').Text+' выдан ';
          if length(Dzap.FieldByName('DKV').Text)>0 then begin
           Dmer.Close;
           Dmer.SQL.Text:='SELECT "NAME" FROM "SDV" WHERE "NUM"='+Dzap.FieldByName('DKV').Text;
           Dmer.Open;
           if Dmer.RecordCount>0 then s:=s+Dmer.FieldByName('NAME').Text+' ';
          end;
          s:=s+Dzap.FieldByName('PDV').Text;
     end
  else s:='ФИОР:__________________________________________';
  writeln(f,UTF8ToAnsi(s));
  s:='ВИДДОК:'+ComboBox4.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='СДОК:'+Edit7.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='НДОК:'+Edit8.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КЕМВЫДАН:'+Edit9.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КОД:'+MaskEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАП:'+DateEdit3.Text;
  writeln(f,UTF8ToAnsi(s));
  if copy(mnkar,8,2)<>'00' then
     s:='ФИОРК:'+ Dzap.FieldByName('FAMIL').Text+' '+ copy(Dzap.FieldByName('IMJA').Text,1,2) +'.'
          +copy(Dzap.FieldByName('OTCH').Text,1,2)+'.'
  else s:='ФИОРК: '+ Dyn.FieldByName('FAMIL').Text+' '+ Copy(Dyn.FieldByName('IMJA').Text,1,2) +'.'
        +Copy(Dyn.FieldByName('OTCH').Text,1,2) ;

  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
  Process1.CommandLine:='cmd /c zajavreg.ott';
  Process1.Options := Process1.Options + [poWaitOnExit];
  Process1.Execute;
  Process1.Free;
end;

procedure TFrmKuch.MenuItem3Click(Sender: TObject);
  var f: TextFile;
      s,APath: String;

begin
  //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
  //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
  Rewrite(f);
  s:= 'ФИО:'+ Dyn.FieldByName('FAMIL').Text+' '+ Dyn.FieldByName('IMJA').Text +' '
        +Dyn.FieldByName('OTCH').Text;
  writeln(f,UTF8ToAnsi(s));
  if Dzap.Active Then Dzap.Close;
  Dzap.SQL.Text:='SELECT "NAIM" FROM "OTDEL" WHERE "OTD"='''+Dyn.FieldByName('PY').Text+'''';
  Dzap.Open;
  s:='ОТДЕЛ:'+ Dzap.FieldByName('NAIM').Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАП:'+ Dyn.FieldByName('DATZK').Text;
  writeln(f,UTF8ToAnsi(s));
  if DateEdit6.Text<>'' then s:='ДАТАК:'+ DateEdit6.Text
  else s:='ДАТАК:настоящее время';
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
  Process1.CommandLine:='cmd /c spravtr.ott';
  Process1.Options := Process1.Options + [poWaitOnExit];
  Process1.Execute;
  Process1.Free;
end;

procedure TFrmKuch.MenuItem4Click(Sender: TObject);
 var f: TextFile;
    s,sl,ms,APath, madr: String;
    X: Integer;
begin
  //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
  //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
  Rewrite(f);
  s:= 'ФАМИЛИЯ:'+ Edit1.Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ИМЯ:'+ Edit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ОТЧЕСТВО:'+ Edit3.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАР:'+ DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  if  ComboBox2.Text='Ж'  then s:='ПОЛ:жен.'
  else s:='ПОЛ:муж.';
  writeln(f,UTF8ToAnsi(s));
  s:='МРЕГИОН:'+ Edit4.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='МРАЙОН:'+ Edit5.Text;
  writeln(f,UTF8ToAnsi(s));
  madr:=copy(Edit6.Text,1,3);
  if madr='г.' then begin
     s:='МГОРОД:'+copy(Edit6.Text,4,length(Edit6.Text));
     writeln(f,UTF8ToAnsi(s));
     s:='МНАСПУНКТ: ';
     writeln(f,UTF8ToAnsi(s));
  end
  else begin
     s:='МГОРОД: ';
     writeln(f,UTF8ToAnsi(s));
     s:='МНАСПУНКТ:'+Edit6.Text;
     writeln(f,UTF8ToAnsi(s));
  end;
  s:='ВИДДОК:'+ComboBox4.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='СДОК:'+Edit7.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='НДОК:'+Edit8.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАП:'+DateEdit3.Text;
  writeln(f,UTF8ToAnsi(s));
  writeln(f,UTF8ToAnsi(s));
  s:='КЕМВЫДАН:'+Edit9.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КОД:'+MaskEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='РЕГИОН:'+ Edit12.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='РАЙОН:'+ Edit13.Text;
  writeln(f,UTF8ToAnsi(s));
  madr:=Edit15.Text;
  if copy(madr,1,3)='г.' then begin
     s:='ГОРОД:'+copy(madr,4,length(madr));
     writeln(f,UTF8ToAnsi(s));
     s:='НАСПУНКТ: ';
     writeln(f,UTF8ToAnsi(s));
  end
  else begin
     s:='ГОРОД: ';
     writeln(f,UTF8ToAnsi(s));
     s:='НАСПУНКТ:'+madr;
     writeln(f,UTF8ToAnsi(s));
  end;
  s:='УЛИЦА:'+ Edit16.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДОМ:'+ Edit17.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КОРП:'+ Edit18.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КВ:'+ Edit19.Text;
  writeln(f,UTF8ToAnsi(s));
  if (DateEdit4.Text='') or (DateEdit5.Text<>'') or (DateEdit6.Text<>'') then  s:='ПМЖ: постоянного места жительства не имеет'
  else s:='ПМЖ: ';
  writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
  Process1.CommandLine:='cmd /c listpr.ott';
  Process1.Options := Process1.Options + [poWaitOnExit];
  Process1.Execute;
  Process1.Free;
end;

procedure TFrmKuch.MenuItem5Click(Sender: TObject);
var f: TextFile;
    s,sl,ms,APath, madr: String;
    X: Integer;
begin
  //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
  //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
  Rewrite(f);
  s:= 'НКАР:'+ Label5.Caption;
  writeln(f,UTF8ToAnsi(s));
  fsvu.DF1.Close;
  fsvu.DF1.SQL.Text:='SELECT * FROM "F1" WHERE "PY"='''+Dyn.FieldByName('PY').Text
        +''' AND "NKAR"='''+Dyn.FieldByName('NKAR').Text + '''';
  fsvu.DF1.Open;
  frmkuch.Memo1.Text:='';
  if  fsvu.DF1.FieldByName('KOD').Text<>'' then frmkuch.mkod:=fsvu.DF1.FieldByName('KOD').Text
  else frmkuch.mkod:='';
  if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:='SELECT * FROM "S1" WHERE "KOD"='''+mkod+'''';
  Dzap.Open;
  s:='КАТ:'+ Dzap.FieldByName('T_PER').Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ФАМИЛИЯ:'+ Edit1.Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ИМЯ:'+ Edit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ОТЧЕСТВО:'+ Edit3.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАР:'+ DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  if Edit17.Text<>'' then
  madr:=Edit14.Text+','+Edit12.Text+' '+Edit13.Text+' '+Edit15.Text+' д.'+Edit17.Text+' корп.'+Edit18.Text+' кв.'+Edit19.Text
  else
  madr:='Постоянного места жительства не имеет';
  if DateEdit5.Text<>'' then madr:=madr+' Снят с регистрационного учета '+DateEdit5.Text+'г.';
  s:='АДРЕС:'+madr;
  writeln(f,UTF8ToAnsi(s));
  s:='НПЕНС:'+ MaskEdit1.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='МРОЖ:'+ Edit4.Text + Edit5.Text + Edit6.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ВИДДОК:'+ComboBox4.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='СДОК:'+Edit7.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='НДОК:'+Edit8.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАП:'+DateEdit3.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КЕМВЫДАН:'+Edit9.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КЕМНАПР:'+Edit11.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДКАР:'+DateEdit1.Text;
  writeln(f,UTF8ToAnsi(s));
  if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:='SELECT "NKAR","FAMIL","IMJA","OTCH","DROG","PPROG","KSS" FROM "F2" WHERE "PY"='''+mpy+''' AND "NKAR" LIKE '''+COPY(mnkar,1,7)+'__'' AND "NKAR" NOT LIKE ''_______00''  ORDER BY "NKAR"';
  Dzap.Open;
  s:='СКЕМПРОЖ: ';
  X:=1;
  while (not Dzap.EOF) do begin
        s:=s+Dzap.FieldByName('FAMIL').Text+' '+Dzap.FieldByName('IMJA').Text+' '+Dzap.FieldByName('OTCH').Text;
       if Dzap.FieldByName('KSS').Text<>'' then begin
       if Dmer.Active then Dmer.Close;
       Dmer.SQL.Text:='SELECT "NSS" FROM "S15" WHERE "KSS"='+Dzap.FieldByName('KSS').Text;
       Dmer.Open;
       s:=s+' - '+Dmer.FieldByName('NSS').Text+';';
       end;
       X:= X + 1;
       Dzap.Next;
  end;
  writeln(f,UTF8ToAnsi(s));
  s:='КЧЕЛ:'+IntToStr(X);
  writeln(f,UTF8ToAnsi(s));
  if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:='SELECT *  FROM "PROPIS" WHERE "PY"='''+mpy +''' AND "NKAR"='''+mnkar+ ''' ORDER BY "DatFrom"';
  Dzap.Open;
  s:='ТАБЛИЦА1';
  writeln(f,UTF8ToAnsi(s));
  Dzap.First;
  while Not Dzap.EOF do begin
        s:='ДАТАС:'+ Dzap.FieldByName('DatFrom').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ДАТАПО:'+ Dzap.FieldByName('DatTo').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='НОМСВ:'+ Dzap.FieldByName('Nsv').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ПРИМ:'+ Dzap.FieldByName('Prim').Text;
        writeln(f,UTF8ToAnsi(s));
        Dzap.Next;
  end;
  s:='%ТАБЛИЦА1';
  writeln(f,UTF8ToAnsi(s));
  if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:='SELECT "MEROP"."IDN","MEROP"."DATA" ,"SVD"."NKOD","S20"."NISP"  FROM "MEROP","SVD","S20" WHERE "MEROP"."KISP"="S20"."KISP" AND "MEROP"."KVD"="SVD"."KOD" AND "PY"='''+mpy +''' AND "NKAR"='''+mnkar+ ''' ORDER BY "MEROP"."DATA"';
  Dzap.Open;
  s:='ТАБЛИЦА2';
  writeln(f,UTF8ToAnsi(s));

  Dzap.First;
  while Not Dzap.EOF do begin
        s:='ДАТА:'+ Dzap.FieldByName('DATA').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ВИДД:'+ Dzap.FieldByName('NKOD').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ИСП:'+ Dzap.FieldByName('NISP').Text;
        writeln(f,UTF8ToAnsi(s));
        Dzap.Next;
  end;
  s:='%ТАБЛИЦА2';
  writeln(f,UTF8ToAnsi(s));
 // s:='КОД:'+MaskEdit2.Text;
 // writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
  Process1.CommandLine:='cmd /c kartau.ott';
  Process1.Options := Process1.Options + [poWaitOnExit];
  Process1.Execute;
  Process1.Free;

end;

procedure TFrmKuch.MenuItem6Click(Sender: TObject);
  var f: TextFile;
    s,sl,ms,APath, madr: String;
    X: Integer;
begin
  //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
  //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
  APath:=ExtractFileDir(ParamStr(0));
  AssignFile(f,APath+'\test.txt');
  Rewrite(f);
  s:= 'ДКАР:'+ DateEdit1.Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ФАМИЛИЯ:'+ Edit1.Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ИМЯ:'+ Edit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:= 'ОТЧЕСТВО:'+ Edit3.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАР:'+ DateEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  madr:=Edit14.Text+','+Edit12.Text+' '+Edit13.Text+' '+Edit15.Text+' '+Edit16.Text+' д.'+Edit17.Text+' корп.'+Edit18.Text+' кв.'+Edit19.Text;
  //if DateEdit5.Text<>'' then madr:=madr+' Снят с регистрационного учета '+DateEdit5.Text+'г.';
  s:='АДРЕС:'+madr;
  writeln(f,UTF8ToAnsi(s));
  s:='НПЕНС:'+ MaskEdit1.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='МРОЖ:'+ Edit4.Text +'  '+ Edit5.Text+ '  ' + Edit6.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ВИДДОК:'+ComboBox4.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='СДОК:'+Edit7.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='НДОК:'+Edit8.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='ДАТАП:'+DateEdit3.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КЕМВЫДАН:'+Edit9.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='КОДПОДРАЗД:'+MaskEdit2.Text;
  writeln(f,UTF8ToAnsi(s));
  s:='АДРЕСПРОП:'+madr+', '+DateEdit4.Text;
  writeln(f,UTF8ToAnsi(s));

 // if Dzap.Active then Dzap.Close;
 // Dzap.SQL.Text:='SELECT "NKAR","FAMIL","IMJA","OTCH","DROG","PPROG","KSS" FROM "F2" WHERE "PY"='''+mpy+''' AND "NKAR" LIKE '''+COPY(mnkar,1,7)+'__'' AND "NKAR" NOT LIKE ''_______00''  ORDER BY "NKAR"';
 // Dzap.Open;
 // s:='СКЕМПРОЖ: ';
 // X:=1;
 // while (not Dzap.EOF) do begin
 //       s:=s+Dzap.FieldByName('FAMIL').Text+' '+Dzap.FieldByName('IMJA').Text+' '+Dzap.FieldByName('OTCH').Text;
 //      if Dzap.FieldByName('KSS').Text<>'' then begin
  //     if Dmer.Active then Dmer.Close;
  //     Dmer.SQL.Text:='SELECT "NSS" FROM "S15" WHERE "KSS"='+Dzap.FieldByName('KSS').Text;
  //     Dmer.Open;
  //     s:=s+' - '+Dmer.FieldByName('NSS').Text+';';
  //     end;
  //     X:= X + 1;
   //    Dzap.Next;
 // end;
 // writeln(f,UTF8ToAnsi(s));
 // s:='КЧЕЛ:'+IntToStr(X);
 // writeln(f,UTF8ToAnsi(s));
  if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:='SELECT DISTINCT "MEROP"."DATA","S20"."NISP","SVD01"."NKOD" AS "NAME" FROM "MEROP","S20","SVD01","SVD" WHERE "MEROP"."KISP"="S20"."KISP" AND "MEROP"."KVD"="SVD"."KOD" AND "SVD01"."KOD"=SUBSTR("SVD"."KOD",1,2) AND "PY"='''+mpy +''' AND "NKAR"='''+mnkar+ ''' ORDER BY "MEROP"."DATA"';
  Dzap.Open;
  s:='ТАБЛИЦА2';
  writeln(f,UTF8ToAnsi(s));
  Dzap.First;
  while Not Dzap.EOF do begin
        s:='ДАТА:'+ Dzap.FieldByName('DATA').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ВИДД:'+ Dzap.FieldByName('NAME').Text;
        writeln(f,UTF8ToAnsi(s));
        s:='ИСП:'+ Dzap.FieldByName('NISP').Text;
        writeln(f,UTF8ToAnsi(s));
        Dzap.Next;
  end;
  s:='%ТАБЛИЦА2';
  writeln(f,UTF8ToAnsi(s));
 // s:='КОД:'+MaskEdit2.Text;
 // writeln(f,UTF8ToAnsi(s));
  CloseFile(f);
  Process1:=TProcess.Create(nil);;
  Process1.CommandLine:='cmd /c indkarta.ott';
  Process1.Options := Process1.Options + [poWaitOnExit];
  Process1.Execute;
  Process1.Free;

end;

procedure TFrmKuch.MenuItem7Click(Sender: TObject);
  var f: TextFile;
      s,sl,ms,APath, madr: String;
      X: Integer;
  begin
    //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
    //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
    APath:=ExtractFileDir(ParamStr(0));
    AssignFile(f,APath+'\test.txt');
    Rewrite(f);
    s:= 'ФИО:'+ Dyn.FieldByName('FAMIL').Text+' '+ Dyn.FieldByName('IMJA').Text +' '
          +Dyn.FieldByName('OTCH').Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ДАТАР:'+ Dyn.FieldByName('DROG').Text;
    writeln(f,UTF8ToAnsi(s));
    if Edit17.Text<>'' then
    madr:=Edit14.Text+','+Edit12.Text+' '+Edit13.Text+' '+Edit15.Text+' '+Edit16.Text+' д.'+Edit17.Text+' корп.'+Edit18.Text+' кв.'+Edit19.Text
    else
    madr:=' ';
    //if DateEdit5.Text<>'' then madr:=madr+' Снят с регистрационного учета '+DateEdit5.Text+'г.';
    s:='АДРЕС:'+madr;
    writeln(f,UTF8ToAnsi(s));

   // if copy(mnkar,8,2)<>'00' then
  //     begin
  //          if Dzap.Active then Dzap.Close;
  //          Dzap.SQL.Text:='SELECT * FROM "F2" WHERE "PY"='''+mpy+''' AND "NKAR" LIKE '''+COPY(mnkar,1,7)+'00''';
  //          Dzap.Open;
  //          s:='ФИОР: мать '+ Dzap.FieldByName('FAMIL').Text+' '+ Dzap.FieldByName('IMJA').Text +' '
   //         +Dzap.FieldByName('OTCH').Text+' паспорт: серия '+Dzap.FieldByName('PSR').Text+' № '+Dzap.FieldByName('PNM').Text+' выдан ';
  //          if length(Dzap.FieldByName('DKV').Text)>0 then begin
  //           Dmer.Close;
  //           Dmer.SQL.Text:='SELECT "NAME" FROM "SDV" WHERE "NUM"='+Dzap.FieldByName('DKV').Text;
  //           Dmer.Open;
  //           if Dmer.RecordCount>0 then s:=s+Dmer.FieldByName('NAME').Text+' ';
  //          end;
   //         s:=s+Dzap.FieldByName('PDV').Text;
   //    end
 //   else s:='ФИОР:__________________________________________';
  //  writeln(f,UTF8ToAnsi(s));
  //  s:='ВИДДОК:'+ComboBox4.Text;
  //  writeln(f,UTF8ToAnsi(s));
    s:='СДОК:'+Edit7.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='НДОК:'+Edit8.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='КЕМВЫДАН:'+Edit9.Text;
    writeln(f,UTF8ToAnsi(s));
  //  s:='КОД:'+MaskEdit2.Text;
 //   writeln(f,UTF8ToAnsi(s));
    s:='ДАТАП:'+DateEdit3.Text;
    writeln(f,UTF8ToAnsi(s));
   // if copy(mnkar,8,2)<>'00' then
   //    s:='ФИОРК:'+ Dzap.FieldByName('FAMIL').Text+' '+ copy(Dzap.FieldByName('IMJA').Text,1,2) +'.'
   //         +copy(Dzap.FieldByName('OTCH').Text,1,2)+'.'
   // else s:='ФИОРК: '+ Dyn.FieldByName('FAMIL').Text+' '+ Copy(Dyn.FieldByName('IMJA').Text,1,2) +'.'
   //       +Copy(Dyn.FieldByName('OTCH').Text,1,2) ;

   // writeln(f,UTF8ToAnsi(s));
    s:= 'ФамилияИО:'+ Dyn.FieldByName('FAMIL').Text+' '+ copy(Dyn.FieldByName('IMJA').Text,1,2) +'.'
            +copy(Dyn.FieldByName('OTCH').Text,1,2)+'.';
    writeln(f,UTF8ToAnsi(s));
    CloseFile(f);
    Process1:=TProcess.Create(nil);;
    Process1.CommandLine:='cmd /c tipdogus.ott';
    Process1.Options := Process1.Options + [poWaitOnExit];
    Process1.Execute;
    Process1.Free;
end;

procedure TFrmKuch.MenuItem8Click(Sender: TObject);
  var f: TextFile;
      s,sl,ms,APath,madr: String;
      X: Integer;
  begin
    //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
    //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
    APath:=ExtractFileDir(ParamStr(0));
    AssignFile(f,APath+'\test.txt');
    Rewrite(f);
    s:= 'ФИО:'+ Edit1.Text +' '+Edit2.Text+ ' '+ Edit3.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='СНИЛС:'+ MaskEdit1.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ВИДДОК:'+ComboBox4.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='КЕМВЫДАН:'+Edit9.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='КОД:'+MaskEdit2.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='СДОК:'+Edit7.Text+ ' '+Edit8.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ДАТАП:'+DateEdit3.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ДАТАР:'+ DateEdit2.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='МЕСТОР:'+ Edit4.Text+ ' '+ Edit5.Text + ' ' + Edit6.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='РАЙОН:'+ Edit13.Text;
    writeln(f,UTF8ToAnsi(s));
    if Edit17.Text<>'' then
    madr:=Edit14.Text+','+Edit12.Text+' '+Edit13.Text+' '+Edit15.Text+' '+Edit16.Text+' д.'+Edit17.Text+' корп.'+Edit18.Text+' кв.'+Edit19.Text
    else
    madr:=' ';
    //if DateEdit5.Text<>'' then madr:=madr+' Снят с регистрационного учета '+DateEdit5.Text+'г.';
    s:='АДРЕС:'+madr;
    writeln(f,UTF8ToAnsi(s));
    if mkod='45' then s:='ВИДПЕНС:по возрасту';
    if copy(mkod,1,2)='21' then s:='ВИДПЕНС:по инвалидности';
    writeln(f,UTF8ToAnsi(s));
    CloseFile(f);
    Process1:=TProcess.Create(nil);;
    Process1.CommandLine:='cmd /c zaprpens.ott';
    Process1.Options := Process1.Options + [poWaitOnExit];
    Process1.Execute;
    Process1.Free;
end;

procedure TFrmKuch.MenuItem9Click(Sender: TObject);
  var f: TextFile;
      s,sl,ms,APath, madr: String;
      X: Integer;
  begin
    //APath:=GetEnvironmentVariableUTF8('USERPROFILE');
    //AssignFile(f,APath+'\Local Settings\Temp\test.txt');
    APath:=ExtractFileDir(ParamStr(0));
    AssignFile(f,APath+'\test.txt');
    Rewrite(f);
    s:= 'ФАМИЛИЯ:'+ Edit1.Text;
    writeln(f,UTF8ToAnsi(s));
    s:= 'ИМЯ:'+ Edit2.Text;
    writeln(f,UTF8ToAnsi(s));
    s:= 'ОТЧЕСТВО:'+ Edit3.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ДАТАР:'+ DateEdit2.Text;
    writeln(f,UTF8ToAnsi(s));
    if  ComboBox2.Text='Ж'  then s:='ПОЛ:жен.'
    else s:='ПОЛ:муж.';
    writeln(f,UTF8ToAnsi(s));
    s:='МРЕГИОН:'+ Edit4.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='МРАЙОН:'+ Edit5.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='МНАСПУНКТ:'+Edit6.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ВИДДОК:'+ComboBox4.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='СДОК:'+Edit7.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='НДОК:'+Edit8.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ДАТАП:'+DateEdit3.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='КЕМВЫДАН:'+Edit9.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='КОД:'+MaskEdit2.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='РЕГИОН:'+ Trim(Edit12.Text);
    writeln(f,UTF8ToAnsi(s));
    s:='РАЙОН:'+ Edit13.Text;
    writeln(f,UTF8ToAnsi(s));
    madr:=Edit15.Text;
    s:='НАСПУНКТ:'+madr;
    writeln(f,UTF8ToAnsi(s));
    s:='УЛИЦА:'+ Edit16.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='ДОМ:'+ Edit17.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='КОРП:'+ Edit18.Text;
    writeln(f,UTF8ToAnsi(s));
    s:='КВ:'+ Edit19.Text;
    writeln(f,UTF8ToAnsi(s));
    if (DateEdit4.Text='') or (DateEdit5.Text<>'') or (DateEdit6.Text<>'') then  s:='ПМЖ: постоянного места жительства не имеет'
    else s:='ПМЖ: ';
    writeln(f,UTF8ToAnsi(s));
    CloseFile(f);
    Process1:=TProcess.Create(nil);;
    Process1.CommandLine:='cmd /c uvedin.ots';
    Process1.Options := Process1.Options + [poWaitOnExit];
    Process1.Execute;
    Process1.Free;
end;



procedure TFrmKuch.PageControl1Change(Sender: TObject);
Var
   X: Integer;
   sql: String;
    ms, sl, mksy: String;
begin
  if Dzap.Active then Dzap.Close;
 if FrmKuch.PageControl1.ActivePage=TabSheet1 then begin
  if Dyn.Active then Dyn.Close;
  Dyn.SQL.Text:='SELECT * FROM "F2" WHERE "NKAR"='''+mnkar+''' AND "PY"='''+mpy+'''';
  Dyn.Open;
  if FrmSplash.memFl='New' then kart_new()
  else kart_view();
 end;
 if FrmKuch.PageControl1.ActivePage=TabSheet2 then begin
  if MessageDlg('Сохранить изменения?',mtConfirmation,[mbYes,mbNo],0)=mrYes then  frmkuch.Button7.Click;
  sql:='SELECT "MEROP"."IDN","MEROP"."DATA","S20"."NISP","SVD01"."NKOD" AS "NAME","SVD"."NKOD" AS "NKOD","MEROP"."ORG","MEROP"."OBR"';
  sql:=sql+' FROM "MEROP","S20","SVD01","SVD" WHERE "MEROP"."KISP"="S20"."KISP" AND "MEROP"."KVD"="SVD"."KOD" AND "SVD01"."KOD"=SUBSTR("SVD"."KOD",1,2) AND "PY"='''+mpy+''' AND "NKAR"='''+mnkar+''' ORDER BY "MEROP"."DATA","MEROP"."IDN"';
  if Dzap.Active then Dzap.Close;
  Dzap.SQL.Text:=sql;
  Dzap.Open;
  DBGRid1.Columns[1].Title.Caption:='Дата';
  DBGRid1.Columns[2].Title.Caption:='Соц.работник';
  DBGRid1.Columns[3].Title.Caption:='Вид деятельности';
  DBGRid1.Columns[4].Title.Caption:='Что сделано';
  DBGRid1.Columns[5].Title.Caption:='Организация';
  DBGRid1.Columns[6].Title.Caption:='Обращение';
  DBGRid1.Columns[0].Visible:=False;
  //for X:=1 to Dzap.FieldCount-1 do Dzap.Columns[X].Visible:=False ;
   for  X:=1 to 6 do begin
   //       DBGRid1.Columns[X].Visible:=True;
          DBGRid1.Columns[X].Width:=90;
    end;
   DBGRid1.Columns[3].Width:=160;
   DBGRid1.Columns[4].Width:=160;
   Dzap.Last;
    Label33.Caption:='Всего мероприятий ('+IntToStr(Dzap.RecordCount)+')';
 end;
 if FrmKuch.PageControl1.ActivePage=TabSheet3 then begin
  sql:='SELECT * FROM "PROPIS" WHERE "PY"='''+mpy+''' AND "NKAR"='''+mnkar+''' ORDER BY "DatFrom"';
  Dzap.SQL.Text:=sql;
  Dzap.Open;
  DBGRid2.Columns[2].Title.Caption:='Дата прописки';
  DBGRid2.Columns[3].Title.Caption:='Дата выбытия';
  DBGRid2.Columns[4].Title.Caption:='№ свидетельства';
  DBGRid2.Columns[5].Title.Caption:='Примечание';
  DBGRid2.Columns[0].Visible:=False;
  DBGRid2.Columns[1].Visible:=False;
   for  X:=2 to 5 do begin
          DBGRid1.Columns[X].Width:=90;
    end;
   Dzap.Last;
 end;
 if FrmKuch.PageControl1.ActivePage=TabSheet4 then begin
 //  if copy(mnkar,8,2)='00' then
//   sql:='SELECT "F2"."NKAR","F2"."FAMIL","F2"."IMJA","F2"."OTCH","F2"."DROG","S15"."NSS","F2"."PPROG" FROM "F2","S15" WHERE "PY"='''+mpy+''' AND "NKAR"='''+COPY(mnkar,1,7)+'00'' AND "F2"."KSS"="S15"."KSS" ORDER BY "F2"."NKAR"'
 //  else
   sql:='SELECT "NKAR","FAMIL","IMJA","OTCH","DROG","PPROG","KSS" FROM "F2" WHERE "PY"='''+mpy+''' AND "NKAR" LIKE '''+COPY(mnkar,1,7)+'__'' AND "NKAR" NOT LIKE ''_______00''  ORDER BY "NKAR"';
  Dzap.SQL.Text:=sql;
  Dzap.Open;
  ListBox1.Clear;
  while (not Dzap.EOF) do begin
       if Dzap.FieldByName('KSS').Text='' then sl:='                    '
       else begin
       if Dmer.Active then Dmer.Close;
       Dmer.SQL.Text:='SELECT "NSS" FROM "S15" WHERE "KSS"='+Dzap.FieldByName('KSS').Text;
       Dmer.Open;
       sl:=Dmer.FieldByName('NSS').Text;
       end;
       if Dzap.FieldByName('PPROG').Text='False' then
       ListBox1.Items.Add(COPY(Dzap.FieldByName('NKAR').Text,8,2)+'   Раздельно     '+sl+'     '+Dzap.FieldByName('DROG').Text+'   '+Dzap.FieldByName('FAMIL').Text+' '+Dzap.FieldByName('IMJA').Text+' '+Dzap.FieldByName('OTCH').Text)
       else
       ListBox1.Items.Add(COPY(Dzap.FieldByName('NKAR').Text,8,2)+'   Совместно     '+sl+'     '+Dzap.FieldByName('DROG').Text+'   '+Dzap.FieldByName('FAMIL').Text+' '+Dzap.FieldByName('IMJA').Text+' '+Dzap.FieldByName('OTCH').Text);
          Dzap.Next;
    end;

  // Dzap.Last;
 end;
end;



procedure TFrmKuch.Button2Click(Sender: TObject);
begin
    // Dzap.Close;
     mbut:=2;
     mrkod:='';
     mrk:='';
     mpunkt:='';
     if fsprav.Dzap.Active=True then fsprav.Dzap.Close;
     fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE ''__000000000'' ORDER BY "S_NAME"';
     fsprav.Dzap.Open;
     fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE ''__000000000''';
     fsprav.Dzap.Active:=True;
     fsprav.Dzap.First;
     fsprav.DBGRid1.Columns[0].Title.Caption:='Сокращение';
     fsprav.DBGRid1.Columns[1].Title.Caption:='Название';
     fsprav.DBGRid1.Columns[2].Title.Caption:='Индекс';
     fsprav.DBGRid1.Columns[3].Visible:=False;
     fsprav.DBGRid1.AutoEdit:=False;
     fsprav.Show;

     //fsprav.Dzap.Close;
    // while (not Dzap.EOF) do begin
    //    fsprav.ComboBox1.AddItem(Dzap.FieldByName('s_name').Text+Dzap.FieldByName('s_socr').Text, nil);
    //    Dzap.Next;
    // end;
end;

procedure TFrmKuch.Button1Click(Sender: TObject);
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
    FrmSplash.minf:='Карточка';
  fsprawm.Show;
end;

procedure TFrmKuch.Button10Click(Sender: TObject);
Var
   sSQL: String;
begin
     if Dmer.Active=True then Dmer.Close;
     sSQL:='SELECT * FROM "MEROP" WHERE "PY" = ''' + mpy + ''' AND "NKAR" = ''' + mnkar + ''' ORDER BY "IDN"';
     Dmer.SQL.Text:= sSQL;
     Dmer.Open;
     if Dmer.RecordCount>0 then begin
        Dmer.Last;
        midn:=StrToInt(Dmer.FieldByName('IDN').Text)+1;
     end
     else midn:=1;
     sSQL:= 'INSERT INTO "MEROP"("IDN","PY","NKAR","DATA","KISP","KVD","ORG","OBR") VALUES (' + IntToStr(midn) + ',''' + mpy + ''',''' + mnkar + ''','''+FormatDateTime('YYYY-MM-DD',Now())+''',';
     Dmer.Close;
     Dmer.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+FrmLogin.mpolz+'''';
     Dmer.Open;
     if Dmer.RecordCount=1 then
     sSQL:=sSQL+Dmer.FieldByName('KISP').Text+',''';
     midn:=StrToInt(Dzap.FieldByName('IDN').Text);
     Dmer.Close;
     Dmer.SQL.Text:='SELECT "KVD" FROM "MEROP" WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + mnkar + ''' AND "IDN"=' + IntToStr(midn);
     Dmer.Open;
     sSQL:=sSQL+Dmer.FieldByName('KVD').Text+''',''';
     sSQL:=sSQL+Dzap.FieldByName('ORG').Text+''','''+Dzap.FieldByName('OBR').Text+''')';
     Dmer.Close;
     Dmer.SQL.Text:=sSQL;
     Dmer.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     FrmKuch.Grid_nstr();
  //   PageControl1.FindNextPage(TabSheet2,False,True);
  //   PageControl1.SelectNextPage(True);
end;

procedure TFrmKuch.Button11Click(Sender: TObject);
var sql: String;
begin
  if MessageDlg('Удалить?',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
     if Dmer.Active then Dmer.Close;
     sql:='DELETE FROM "MEROP" WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + mnkar + ''' AND "IDN"='+Dzap.FieldByName('IDN').Text;
     Dmer.SQL.Text:=sql;
     Dmer.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     FrmKuch.Grid_nstr();
  end;
end;

procedure TFrmKuch.Button12Click(Sender: TObject);
begin
     FrmSplash.memN:=True;
     FrmProp.DateEdit1.Text:=DateToStr(Now());
     FrmProp.DateEdit2.Text:='';
     FrmProp.Edit1.Text:='';
     FrmProp.Edit2.Text:='';
     FrmProp.ShowModal;
end;

procedure TFrmKuch.Button13Click(Sender: TObject);
begin
     FrmSplash.memN:=False;
     FrmProp.DateEdit1.Text:=Dzap.FieldByName('DatFrom').Text;
     FrmProp.mDat:=FormatDateTime('YYYY-MM-DD',FrmProp.DateEdit1.Date);
     FrmProp.DateEdit2.Text:=Dzap.FieldByName('DatTo').Text;
     FrmProp.Edit1.Text:=Dzap.FieldByName('Nsv').Text;
     FrmProp.Edit2.Text:=Dzap.FieldByName('Prim').Text;
     FrmProp.ShowModal;
end;

procedure TFrmKuch.Button14Click(Sender: TObject);
var sql: String;
begin
  if MessageDlg('Удалить?',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
     sql:='DELETE FROM "PROPIS" WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + mnkar + ''' AND "DatFrom"='''+FormatDateTime('YYYY-MM-DD',StrToDate(Dzap.FieldByName('DatFrom').Text))+'''';
     if Dmer.Active=True then Dmer.Close;
     Dmer.SQL.Text:=sql;
     Dmer.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     FrmKuch.Grid_nstr2();
  end;
end;

procedure TFrmKuch.Button15Click(Sender: TObject);
begin
     if Dzap.RecordCount>0 then begin
        Dzap.Last;
        if StrToInt(COPY(Dzap.FieldByName('NKAR').Text,1,2))<9 then
        mnkar:=COPY(mnkar,1,7)+'0'+IntToStr(StrToInt(COPY(Dzap.FieldByName('NKAR').Text,9,1))+1)
        else
        mnkar:=COPY(mnkar,1,7)+IntToStr(StrToInt(COPY(Dzap.FieldByName('NKAR').Text,9,1))+1);
     end
     else mnkar:=COPY(mnkar,1,7)+'01';
     if Dzap.Active=True then Dzap.Close;
     if fsvu.Dzap.Active=True then fsvu.Dzap.Close;
     fsvu.Dzap.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+FrmLogin.mpolz+'''';
     fsvu.Dzap.Open;
     Dzap.SQL.Text:='INSERT INTO "F2"("PY","NKAR","DATZK","KISP","PPROG") VALUES('''+mpy+''','''+mnkar+''','''+FormatDateTime('YYYY-MM-DD',Now())+''','+fsvu.Dzap.FieldByName('KISP').Text+',TRUE)';
     Dzap.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     frmSplash.memFl:='New';
    PageControl1.ActivePage:=TabSheet1;
end;

procedure TFrmKuch.Button16Click(Sender: TObject);
var mm: String;
begin
if copy(Dzap.FieldByName('NKAR').Text,8,2)<>'00' then begin
  if MessageDlg('Удалить?',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
     mm:=Dzap.FieldByName('NKAR').Text;
     if Dmer.Active then Dmer.Close;
     Dmer.SQL.Text:='DELETE FROM "MEROP" WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + mm + '''';
     Dmer.ExecSQL;
     Dmer.SQL.Text:='DELETE FROM "PROPIS" WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + mm + '''';
     Dmer.ExecSQL;
     Dmer.SQL.Text:='DELETE FROM "F2" WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + mm + '''';
     Dmer.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     FrmKuch.Grid_nstr();
     if Dzap.Active then Dzap.Close;
     Dzap.SQL.Text:='SELECT "NKAR","FAMIL","IMJA","OTCH","DROG","PPROG","KSS" FROM "F2" WHERE "PY"='''+mpy+''' AND "NKAR" LIKE '''+COPY(mnkar,1,7)+'__'' AND "NKAR" NOT LIKE ''_______00''  ORDER BY "NKAR"';
     Dzap.Open;
     ListBox1.Clear;
     while (not Dzap.EOF) do begin
           if Dzap.FieldByName('KSS').Text='' then mm:='                    '
           else begin
           if Dmer.Active then Dmer.Close;
           Dmer.SQL.Text:='SELECT "NSS" FROM "S15" WHERE "KSS"='+Dzap.FieldByName('KSS').Text;
           mm:=Dmer.FieldByName('NSS').Text;
           end;
           if Dzap.FieldByName('PPROG').Text='False' then
           ListBox1.Items.Add(COPY(Dzap.FieldByName('NKAR').Text,8,2)+'   Раздельно     '+mm+'     '+Dzap.FieldByName('DROG').Text+'   '+Dzap.FieldByName('FAMIL').Text+' '+Dzap.FieldByName('IMJA').Text+' '+Dzap.FieldByName('OTCH').Text)
           else
           ListBox1.Items.Add(COPY(Dzap.FieldByName('NKAR').Text,8,2)+'   Совместно     '+mm+'     '+Dzap.FieldByName('DROG').Text+'   '+Dzap.FieldByName('FAMIL').Text+' '+Dzap.FieldByName('IMJA').Text+' '+Dzap.FieldByName('OTCH').Text);
           Dzap.Next;
           end;
     end;
end;
end;

procedure TFrmKuch.Button17Click(Sender: TObject);
var mm, memnkar: String;
begin
  if MessageDlg('Изменить группу учета у карточки? ('+Edit1.Text+' '+Edit2.Text+' '+Edit3.Text+')',mtConfirmation,[mbYes,mbNo],0)=mrYes then  begin
     frmPY.ShowModal;
     mm:=frmkuch.mnkar;
     if Dzap.Active then Dzap.Close;
     Dzap.SQL.Text:='SELECT "NKAR" FROM "F2" WHERE "PY"='''+FrmSplash.memPY+''' ORDER BY "NKAR"';
     Dzap.Open;
     if Dzap.RecordCount=0 then frmkuch.mnkar:='000000100'
     else begin
          Dzap.Last;
          frmkuch.mnkar:=IntToStr((StrToInt(copy(Dzap.FieldByName('NKAR').Text,1,7))+1))+'00';
          while Length(frmkuch.mnkar)<9 do frmkuch.mnkar:='0'+frmkuch.mnkar;
     end;
     if Dmer.Active=True then Dmer.Close;
     Dmer.SQL.Text:='SELECT "NKAR" FROM "F2" WHERE "PY"=''' + mpy + ''' AND "NKAR" LIKE ''' + copy(mm,1,7) + '__''';
     Dmer.Open;
     while (not Dmer.EOF) do begin
           memnkar:=copy(mnkar,1,7)+copy(Dmer.FieldByName('NKAR').Text,8,2);
           if Dzap.Active=True then Dzap.Close;
           Dzap.SQL.Text:='UPDATE "F2" SET "PY"='''+FrmSplash.memPY+''', "NKAR"='''+memnkar+''' WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + Dmer.FieldByName('NKAR').Text + '''';
           Dzap.ExecSQL;

           Dzap.Close;
           Dzap.SQL.Text:='UPDATE "F1" SET "PY"='''+FrmSplash.memPY+''', "NKAR"='''+memnkar+''' WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + Dmer.FieldByName('NKAR').Text + '''';
           Dzap.ExecSQL;

           Dzap.Close;
           Dzap.SQL.Text:='UPDATE "F3" SET "PY"='''+FrmSplash.memPY+''', "NKAR"='''+memnkar+''' WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + Dmer.FieldByName('NKAR').Text + '''';
           Dzap.ExecSQL;

           Dzap.Close;
           Dzap.SQL.Text:='UPDATE "F5" SET "PY"='''+FrmSplash.memPY+''', "NKAR"='''+memnkar+''' WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + Dmer.FieldByName('NKAR').Text + '''';
           Dzap.ExecSQL;

           Dzap.Close;
           Dzap.SQL.Text:='UPDATE "MEROP" SET "PY"='''+FrmSplash.memPY+''', "NKAR"='''+memnkar+''' WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + Dmer.FieldByName('NKAR').Text + '''';
           Dzap.ExecSQL;

           Dzap.Close;
           Dzap.SQL.Text:='UPDATE "PROPIS" SET "PY"='''+FrmSplash.memPY+''', "NKAR"='''+memnkar+''' WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + Dmer.FieldByName('NKAR').Text + '''';
           Dzap.ExecSQL;

           Dmer.Next;
     end;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     FrmKuch.Grid_nstr2();
     mpy:=FrmSplash.memPY;
     Dzap.Close;
     Dzap.SQL.Text:='SELECT "NAIM" FROM "OTDEL" WHERE "OTD"='''+mpy+'''';
     Dzap.Open;
     frmkuch.Caption:='Карточка учета. '+Dzap.FieldByName('NAIM').Text;
     if Dyn.Active then Dyn.Close;
     Dyn.SQL.Text:='SELECT * FROM "F2" WHERE "NKAR"='''+mnkar+''' AND "PY"='''+mpy+'''';
     Dyn.Open;
  end;
end;

procedure TFrmKuch.Button3Click(Sender: TObject);
begin
    mbut:=3;
     if fsprav.Dzap.Active=True then fsprav.Dzap.Close;
     if mrkod<>'' then
        begin
        fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE '''+mrkod+'%'' AND "S_SOCR"=''р-н'' ORDER BY "S_NAME"';
        fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE '''+mrkod+'%'' AND "S_SOCR"=''р-н''';
        end
     else
         begin
         fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_SOCR"=''р-н'' ORDER BY "S_NAME"';
         fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_SOCR"=''р-н''';
         end;
     fsprav.Dzap.Open;
     fsprav.Dzap.Active:=True;
     fsprav.Dzap.First;
     fsprav.DBGRid1.Columns[0].Title.Caption:='Сокращение';
     fsprav.DBGRid1.Columns[1].Title.Caption:='Название';
     fsprav.DBGRid1.Columns[2].Title.Caption:='Индекс';
     fsprav.DBGRid1.Columns[3].Visible:=False;
     fsprav.DBGRid1.AutoEdit:=False;
     fsprav.Show;
end;

procedure TFrmKuch.Button4Click(Sender: TObject);
begin
    mbut:=4;
     if fsprav.Dzap.Active=True then fsprav.Dzap.Close;
     if mrk<>'' then
     begin
     fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE '''+mrk+'%'' AND "S_SOCR"<>''р-н'' ORDER BY "S_NAME"';
     fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE '''+mrk+'%'' AND "S_SOCR"<>''р-н''';
     end
     else
     begin
     if mrkod='' then mrkod:='24';
     fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE '''+mrkod+'%'' AND "S_SOCR"<>''р-н'' ORDER BY "S_NAME"';
     fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "KLADR" WHERE "S_CODE" LIKE '''+mrkod+'%'' AND "S_SOCR"<>''р-н''';
     end;
     fsprav.Dzap.Open;
     fsprav.Dzap.Active:=True;
     fsprav.Dzap.First;
     fsprav.DBGRid1.Columns[0].Title.Caption:='Сокращение';
     fsprav.DBGRid1.Columns[1].Title.Caption:='Название';
     fsprav.DBGRid1.Columns[2].Title.Caption:='Индекс';
     fsprav.DBGRid1.Columns[3].Visible:=False;
     fsprav.DBGRid1.AutoEdit:=False;
     fsprav.Show;
end;

procedure TFrmKuch.Button5Click(Sender: TObject);
begin
     mbut:=5;
     if fsprav.Dzap.Active=True then fsprav.Dzap.Close;
     if mpunkt<>'' then
        begin
        fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "STREET" WHERE "S_CODE" LIKE '''+mpunkt+'%'' ORDER BY "S_NAME"';
        fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "STREET" WHERE "S_CODE" LIKE '''+mpunkt+'%''';
        end
     else
         begin
         fsprav.Dzap.SQL.Text:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "STREET" WHERE "S_CODE" LIKE ''24000001000%'' ORDER BY "S_NAME"';
         fsprav.mzap:='SELECT "S_NAME","S_SOCR", "S_INDEX", "S_CODE" FROM "STREET" WHERE "S_CODE" LIKE ''24000001000%''';
         end;
     fsprav.Dzap.Open;
     fsprav.Dzap.Active:=True;
     fsprav.Dzap.First;
     fsprav.DBGRid1.Columns[0].Title.Caption:='Сокращение';
     fsprav.DBGRid1.Columns[1].Title.Caption:='Название';
     fsprav.DBGRid1.Columns[2].Title.Caption:='Индекс';
     fsprav.DBGRid1.Columns[3].Visible:=False;
     fsprav.DBGRid1.AutoEdit:=False;
     fsprav.Show;
end;

procedure TFrmKuch.Button6Click(Sender: TObject);
Var
  mint: Integer;
begin
  FrmSplash.mstr:='S2';
  fsprawm.mkpsu:=FrmSplash.mkpsu;
  fsprawm.Label2.Caption:=IntToStr(FrmSplash.mkpsu);
  fsprawm.Caption:='Справочник: признаки учета';
  if fsprawm.mdata.Active then fsprawm.mdata.Close;
  fsprawm.mdata.SQL.Text:='SELECT * FROM "S2" WHERE "UR"=1 ORDER BY "NKOD"';
  fsprawm.mdata.Open;
  fsprawm.mdata.Last;
  fsprawm.mdata.First;
  fsprawm.ListBox1.Clear;
    while (not fsprawm.mdata.EOF) do
    begin
         mint:=Pos(fsprawm.mdata.FieldByName('KOD').Text,FrmSplash.mksy);
         if mint>0 then begin
         if mint=1 then
         if Copy(FrmSplash.mksy,mint+Length(fsprawm.mdata.FieldByName('KOD').Text),1)=';' then
         fsprawm.ListBox1.Items.Add('*'+fsprawm.mdata.FieldByName('NKOD').Text)
         else fsprawm.ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
         if mint>1 then
         if (Copy(FrmSplash.mksy,mint+Length(fsprawm.mdata.FieldByName('KOD').Text),1)+Copy(FrmSplash.mksy,mint-1,1))=';;' then
         fsprawm.ListBox1.Items.Add('*'+fsprawm.mdata.FieldByName('NKOD').Text)
         else fsprawm.ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
         end
         else
         fsprawm.ListBox1.Items.Add(' '+fsprawm.mdata.FieldByName('NKOD').Text);
         fsprawm.mdata.Next;
    end;
    FrmSplash.minf:='Карточка';
    fsprawm.Button6.Visible:=True;
  fsprawm.Show;
end;

procedure TFrmKuch.Button7Click(Sender: TObject);
Var
   sql: String;
begin
     sql:='';
      sql:='UPDATE "F2" SET ';
      if ComboBox2.Text='Ж' then sql:=sql+'"POL"=''1'','
      else sql:=sql+'"POL"=''2'',';
      if ComboBox3.Text='Полная' then
      sql:=sql+'"PLATA"=''П'','
      else if ComboBox3.Text='Частичная' then
      sql:=sql+'"PLATA"=''Ч'','
      else sql:=sql+'"PLATA"=''Б'',';
      if Edit1.Text<>'' then sql:=sql+'"FAMIL"='''+Edit1.Text+''',';
      if Edit2.Text<>'' then sql:=sql+'"IMJA"='''+Edit2.Text+''',';
      if Edit3.Text<>'' then sql:=sql+'"OTCH"='''+Edit3.Text+''',';
      if ComboBox1.Text<>'' Then
      begin
           Dzap.Close;
           Dzap.SQL.Text:='SELECT "KISP" FROM "S20" WHERE "NISP"='''+ComboBox1.Text+'''';
           Dzap.Open;
           if Dzap.RecordCount=1 then
           sql:=sql+'"KISP"='+Dzap.FieldByName('KISP').Text+',';
      end;
      if DateEdit2.Text<>'' then sql:=sql+'"DROG"='''+FormatDateTime('YYYY-MM-DD',DateEdit2.Date)+''','
      else           sql:=sql+'"DROG"='''+FormatDateTime('YYYY-MM-DD',Now())+''',';
      if Edit4.Text<>'' then sql:=sql+'"RREG"='''+Edit4.Text+''',' else sql:=sql+'"RREG"=NULL,';
      if Edit5.Text<>'' then sql:=sql+'"MRAI"='''+Edit5.Text+''',' else sql:=sql+'"MRAI"=NULL,';
      if Edit6.Text<>'' then sql:=sql+'"RNAS"='''+Edit6.Text+''',' else sql:=sql+'"RNAS"=NULL,';
      if ComboBox4.Text<>'' Then
      begin
           Dzap.Close;
           Dzap.SQL.Text:='SELECT "NUM" FROM "SDOK" WHERE "NAME"='''+ComboBox4.Text+'''';
           Dzap.Open;
           if Dzap.RecordCount=1 then
           sql:=sql+'"KDOK"='+Dzap.FieldByName('NUM').Text+',';
      end;
      if ComboBox5.Text<>'' Then
      begin
           Dzap.Close;
           Dzap.SQL.Text:='SELECT "KSS" FROM "S15" WHERE "NSS"='''+ComboBox5.Text+'''';
           Dzap.Open;
           if Dzap.RecordCount=1 then
           sql:=sql+'"KSS"='+Dzap.FieldByName('KSS').Text+',';
      end;
      if Edit7.Text<>'' then sql:=sql+'"PSR"='''+Edit7.Text+''',' else sql:=sql+'"PSR"=NULL,';
      if Edit8.Text<>'' then sql:=sql+'"PNM"='''+Edit8.Text+''',' else sql:=sql+'"PNM"=NULL,';
      if DateEdit3.Text<>'' then sql:=sql+'"PDV"='''+FormatDateTime('YYYY-MM-DD',DateEdit3.Date)+''',' else sql:=sql+'"PDV"=NULL,';
      if Edit9.Text<>'' then sql:=sql+'"PKV"='''+Edit9.Text+''',' else sql:=sql+'"PKV"=NULL,';
      if MaskEdit2.Text<>'   -   ' then sql:=sql+'"KOD_PODR"='''+MaskEdit2.Text+''',' else sql:=sql+'"KOD_PODR"=NULL,';
      if MaskEdit1.Text<>'   -   -      ' then sql:=sql+'"SVPF"='''+MaskEdit1.Text+''',' else sql:=sql+'"SVPF"=NULL,';
      if Edit11.Text<>'' then sql:=sql+'"NAPR"='''+Edit11.Text+''',' else sql:=sql+'"NAPR"=NULL,';
      if Edit12.Text<>'' then sql:=sql+'"REG"='''+Edit12.Text+''',' else sql:=sql+'"REG"=NULL,';
      if Edit13.Text<>'' then sql:=sql+'"RAI"='''+Edit13.Text+''',' else sql:=sql+'"RAI"=NULL,';
      if Edit14.Text<>'' then sql:=sql+'"PIND"='''+Edit14.Text+''',' else sql:=sql+'"PIND"=NULL,';
      if Edit15.Text<>'' then sql:=sql+'"NASP"='''+Edit15.Text+''',' else sql:=sql+'"NASP"=NULL,';
      if Edit16.Text<>'' then sql:=sql+'"YLIC"='''+Edit16.Text+''',' else sql:=sql+'"YLIC"=NULL,';
      if Edit17.Text<>'' then sql:=sql+'"NDOM"='''+Edit17.Text+''',' else sql:=sql+'"NDOM"=NULL,';
      if Edit18.Text<>'' then sql:=sql+'"NKORP"='''+Edit18.Text+''',' else sql:=sql+'"NKORP"=NULL,';
      if Edit19.Text<>'' then sql:=sql+'"NKW"='''+Edit19.Text+''',' else sql:=sql+'"NKW"=NULL,';
      if Edit20.Text<>'' then sql:=sql+'"NTEL"='''+Edit20.Text+''',' else sql:=sql+'"NTEL"=NULL,';
      if DateEdit4.Text<>'' then sql:=sql+'"DATPROP"='''+FormatDateTime('YYYY-MM-DD',DateEdit4.Date)+''',' else sql:=sql+'"DATPROP"=NULL,';
      if DateEdit5.Text<>'' then sql:=sql+'"DATVIP"='''+FormatDateTime('YYYY-MM-DD',DateEdit5.Date)+''',' else sql:=sql+'"DATVIP"=NULL,';
      if DateEdit6.Text<>'' then sql:=sql+'"DSY"='''+FormatDateTime('YYYY-MM-DD',DateEdit6.Date)+''',' else sql:=sql+'"DSY"=NULL,';
      sql:=sql+'"DATZK"='''+FormatDateTime('YYYY-MM-DD',DateEdit1.Date)+'''';
      sql:=sql+' WHERE "PY"='''+mpy+''' AND "NKAR"='''+mnkar + '''';
    // ShowMessage(sql);
     if Dzap.Active=True then Dzap.Close;
     Dzap.SQL.Text:=sql;
     Dzap.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     if mkod<>'' then begin
     sql:='';
     Dzap.Close;
     Dzap.SQL.Text:='SELECT * FROM "F1" WHERE "PY"='''+mpy+''' AND "NKAR"='''+mnkar + '''';
     Dzap.Open;
     if Dzap.RecordCount=1 then begin
        sql:='UPDATE "F1" SET "KOD"='''+mkod+'''';
        if FrmSplash.mksy<>'' then sql:=sql+',"KSY"='''+FrmSplash.mksy+''''
        else sql:=sql+',"KSY"=NULL';
        if FrmSplash.mkpsu<>0 then sql:=sql+',"KPSU"='+IntToStr(FrmSplash.mkpsu)
        else sql:=sql+',"KPSU"=0';
        sql:=sql+ ' WHERE "PY"='''+mpy+''' AND "NKAR"='''+mnkar + '''';
     end
     else begin
          if Dzap.RecordCount>1 then begin
             sql:='DELETE FROM "F1" WHERE "PY"='''+mpy+''' AND "NKAR"='''+mnkar + '''';
             if Dzap.Active=True then Dzap.Close;
             Dzap.SQL.Text:=sql;
             Dzap.ExecSQL;
             frmlogin.SQLTransaction1.Commit;
             frmlogin.SQLTransaction1.Active:=True;
          end;
          sql:='INSERT INTO "F1"("PY","NKAR","DATZK","KOD","KPSU","KSY") VALUES('''+mpy+''','''+mnkar+''',''';
          if DateEdit1.Text<>'' then sql:=sql+FormatDateTime('YYYY-MM-DD',DateEdit1.Date)+''','''
          else           sql:=sql+FormatDateTime('YYYY-MM-DD',Now())+''',''';
          sql:=sql+mkod+'''';
        if FrmSplash.mkpsu<>0 then sql:=sql+','+IntToStr(FrmSplash.mkpsu)
        else sql:=sql+',0';
        if FrmSplash.mksy<>'' then sql:=sql+','''+FrmSplash.mksy+''')'
        else sql:=sql+',NULL)';
     end;
     if Dzap.Active=True then Dzap.Close;
     Dzap.SQL.Text:=sql;
     Dzap.ExecSQL;
     frmlogin.SQLTransaction1.Commit;
     frmlogin.SQLTransaction1.Active:=True;
     fsvu.SQLQuery1.Open;
     fsvu.Grid_nastr();
     frmkuch.kart_view();
    // Grid_nstr2()
     end;

end;

procedure TFrmKuch.Button8Click(Sender: TObject);
begin
     FrmSplash.memN:=True;
     FrmSplash.mkpsu:=0;
     FrmSplash.mkod:='';
     Frmsplash.mksy:='';
     FrmMerop.DateEdit1.Text:=DateToStr(Now());
     FrmMerop.ComboBox1.Text:=FrmLogin.mpolz;
     FrmMerop.Label4.Caption:='';
     FrmMerop.Label6.Caption:='';
     FrmMerop.Edit2.Text:='';
     FrmMerop.Edit3.Text:='';
     FrmMerop.ShowModal;
end;

procedure TFrmKuch.Button9Click(Sender: TObject);
begin
     FrmMerop.DateEdit1.Text:=Dzap.FieldByName('DATA').Text;
     FrmMerop.ComboBox1.Text:=Dzap.FieldByName('NISP').Text;
     FrmMerop.Label4.Caption:=Dzap.FieldByName('NAME').Text;
     FrmMerop.Label6.Caption:=Dzap.FieldByName('NKOD').Text;
     Dmer.Close;
     Dmer.SQL.Text:='SELECT "KVD" FROM "MEROP" WHERE "PY"=''' + mpy + ''' AND "NKAR"=''' + mnkar + ''' AND "IDN"=' + Dzap.FieldByName('IDN').Text;
     Dmer.Open;
     FrmSplash.mkod:=Dmer.FieldByName('KVD').Text;
     FrmMerop.Edit2.Text:=Dzap.FieldByName('ORG').Text;
     FrmMerop.Edit3.Text:=Dzap.FieldByName('OBR').Text;
     FrmSplash.memN:=False;
  FrmMerop.ShowModal;
end;



procedure TFrmKuch.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var X: Integer;
begin
     if MessageDlg('Сохранить изменения?',mtConfirmation,[mbYes,mbNo],0)=mrYes then  frmkuch.Button7.Click;
     FrmSplash.mkpsu:=0;
     FrmSplash.mksy:='';
     frmkuch.Show;
  fsvu.SQLQuery1.First;
  for X:=0 to fsvu.SQLQuery1.RecordCount-1 do begin
        if (fsvu.SQLQuery1.FieldByName('PY').Text=frmkuch.mpy) and (fsvu.SQLQuery1.FieldByName('NKAR').Text=frmkuch.mnkar)  then break
        else fsvu.SQLQuery1.Next;
  end;
end;



initialization
  {$I kuch.lrs}

end.

