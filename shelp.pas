unit shelp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type

  { TFrmSplash }

  TFrmSplash = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
        mtext: String;
        mstr: String;
        mkod: String;
        mksy: String;
        minf: String;
        memFl: String;
        memPY: String;
        mkpsu: Integer;
        memN: Boolean;
    { public declarations }
  end; 

var
  FrmSplash: TFrmSplash;

implementation
 uses Unlogin, unmenu;
{ TFrmSplash }

procedure TFrmSplash.Button1Click(Sender: TObject);
begin
      Unlogin.FrmLogin.Show;
      FrmSplash.Hide;
end;

initialization
  {$I shelp.lrs}

end.

