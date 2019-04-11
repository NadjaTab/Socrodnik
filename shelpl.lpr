program shelpl;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, shelp, Unlogin, unmenu, frmsvu, kuch,
Usprav, sprawm, Merop, Prop, FPY, fzap, Udatv, uspraw;

{$IFDEF WINDOWS}{$R shelpl.rc}{$ENDIF}

begin
 // {$I shelpl.lrs}
  Application.Initialize;
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmMenuosn, FrmMenuosn);
  Application.CreateForm(TFSVU, FSVU);
  Application.CreateForm(TFrmKuch, FrmKuch);
  Application.CreateForm(Tfsprav, fsprav);
  Application.CreateForm(TFSprawm, FSprawm);
  Application.CreateForm(TFrmMerop, FrmMerop);
  Application.CreateForm(TFrmProp, FrmProp);
  Application.CreateForm(TFrmPY, FrmPY);
  Application.CreateForm(TFrmzap, Frmzap);
  Application.CreateForm(TFDatv, FDatv);
  Application.CreateForm(TFrmSprav, FrmSprav);
  Application.Run;
end.

