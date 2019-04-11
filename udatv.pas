unit Udatv;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, EditBtn;

type

  { TFDatv }

  TFDatv = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FDatv: TFDatv;

implementation
uses frmsvu,unlogin,shelp,kuch,unmenu, fzap;

{ TFDatv }

procedure TFDatv.FormCreate(Sender: TObject);
begin
  ComboBox1.Text:='';
  FrmLogin.SQLQuery1.First;
      while (not FrmLogin.SQLQuery1.EOF) do begin
        ComboBox1.AddItem(FrmLogin.SQLQuery1.FieldByName('NISP').Text, nil);
        FrmLogin.SQLQuery1.Next;
       // inc(Count);
      end;
  DateEdit1.Text:=DateToStr(Now());
  DateEdit2.Text:=DateToStr(Now());
end;

procedure TFDatv.Button1Click(Sender: TObject);
begin
  FDatv.Close;
end;

initialization
  {$I udatv.lrs}

end.

