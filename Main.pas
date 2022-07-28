program Main;
uses
  Numeric in 'GraphingPackage/GraphPresets/Numeric.pas',
  GraphBorder in 'GraphingPackage/GraphPresets/GraphBorder.pas',
  CoordinateAxis in 'GraphingPackage/GraphPresets/CoordinateAxis.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
  P : TCanvas;
  N : TNumeric;
  BG : TGraphBorder;
  CA : TCoordinateAxis;
  CB : TCoordinateAxis;

begin
  P := TCanvas.Create(1000, 1000);
  N := TNumeric.Create(5.26, 50, 30);
  BG := TGraphBorder.Create(15);
  CB := TCoordinateAxis.Create(-10, 10, 5, 'Y');
  CA := TCoordinateAxis.Create(-10, 10, 5, 'X');
  BG.WriteBorderToCanvas(P);
  N.WriteNumericToCanvas(70, 70, P);
  CA.WriteCoordinateAxisToCanvas(P);
  CB.WriteCoordinateAxisToCanvas(P);
  {N.Debug;}
  P.Dump;
  P.Free;
  N.Free;
end.
