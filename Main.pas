program Main;
uses
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
  P : TCanvas;

begin
  P := TCanvas.Create(2, 2);
  P.Debug;
  P.Free;
end.
