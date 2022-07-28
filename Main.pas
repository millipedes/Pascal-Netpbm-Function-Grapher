program Main;
uses
  Numeric in 'GraphingPackage/GraphPresets/Numeric.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
  P : TCanvas;
  N : TNumeric;

begin
  P := TCanvas.Create(1000, 1000);
  N := TNumeric.Create(5.26, 50, 30);
  N.WriteNumericToCanvas(15, 15, P);
  {N.Debug;}
  P.Dump;
  P.Free;
  N.Free;
end.
