unit MenuUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

implementation

//procedure TForm1.FormCreate(Sender: TObject);
//begin
//  Timer1.Enabled := False;
//  Timer1.Interval := 1;
//  //PanelMenu.Left := 0;
//  //Appear := true;
//  //PanelMenu.AnchorToNeighbour(akLeft, 0, Form1);
//  PanelMenu.AnchorSide[akLeft].Control := PanelMinimized;
//  PanelMenu.AnchorSide[akLeft].Side:=asrLeft;
//end;
//
//procedure TForm1.SpeedButtonMaximizeClick(Sender: TObject);
//begin
//  PanelMenu.AnchorSide[akRight].Control := nil;
//  Appear := True;
//  Form1.Timer1.Enabled := True;
//end;
//
//procedure TForm1.SpeedButtonMinimizeClick(Sender: TObject);
//begin
//  PanelMenu.AnchorSide[akLeft].Control := nil;
//  Appear := False;
//  Form1.Timer1.Enabled := True;
//end;
//
//
//procedure TForm1.Timer1Timer(Sender: TObject);
//const
//  OffsetX: array[Boolean] of Integer = (-20, 20);
//begin
//  PanelMenu.Left := PanelMenu.Left + OffsetX[Appear];
//  PanelMinimized.Width := Max(PanelMenu.Left, 64);
//  //if (PanelMenu.Left <= -300) then
//  //begin
//  //  Timer1.Enabled := False;
//  //  PanelMenu.AnchorSide[akLeft].Control := Form1;
//  //  PanelMenu.AnchorSide[akLeft].Side:=asrLeft;
//  //end;
//  if (PanelMenu.Left <= -300) then
//  begin
//    Timer1.Enabled := False;
//    PanelMenu.AnchorSide[akRight].Control := PanelMinimized;
//    PanelMenu.AnchorSide[akRight].Side:=asrLeft;
//  end
//  else if (PanelMenu.Left >= 0) then begin
//    Timer1.Enabled := False;
//    PanelMenu.AnchorSide[akLeft].Control := PanelMinimized;
//    PanelMenu.AnchorSide[akLeft].Side:=asrLeft;
//  end;
//  //Timer1.Enabled := not ((PanelMenu.Left <= -300) or (PanelMenu.Left >= 0));
//end;
//
end.

