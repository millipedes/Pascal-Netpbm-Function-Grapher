program Main;
uses
  GraphScale in 'GraphingPackage/GraphPresets/GraphScale.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
  P : TCanvas;
  GS : TGraphScale;

begin
  GS := TGraphScale.Create(-10, 9, -10, 9);
  P := TCanvas.Create(1000, 1000);
  GS.WriteGraphScaleToCanvas(P);
  P.Dump;
  P.Free;
  GS.Free;
end.
