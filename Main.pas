program Main;
uses
  Numeric in 'GraphingPackage/GraphPresets/Numeric.pas',
  GraphBorder in 'GraphingPackage/GraphPresets/GraphBorder.pas',
  CoordinateAxis in 'GraphingPackage/GraphPresets/CoordinateAxis.pas',
  AxisTicMarks in 'GraphingPackage/GraphPresets/AxisTicMarks.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
  P : TCanvas;
  N : TNumeric;
  BG : TGraphBorder;
  CA : TCoordinateAxis;
  CB : TCoordinateAxis;
  ATMA : TAxisTicMarks;
  ATMB : TAxisTicMarks;

begin
  P := TCanvas.Create(1000, 1000);
  N := TNumeric.Create(1.234567809, 50, 30);
  BG := TGraphBorder.Create(15);
  CA := TCoordinateAxis.Create(-10, 10, 10, 'X');
  CB := TCoordinateAxis.Create(-10, 10, 10, 'Y');
  ATMA := TAxisTicMarks.Create(10, 12, 30, 'X');
  ATMB := TAxisTicMarks.Create(10, 30, 12, 'Y');
  BG.WriteBorderToCanvas(P);
  N.WriteNumericToCanvas(70, 70, P);
  CA.WriteCoordinateAxisToCanvas(P);
  CB.WriteCoordinateAxisToCanvas(P);
  ATMA.WriteATMToCanvas(P);
  ATMB.WriteATMToCanvas(P);
  {N.Debug;}
  P.Dump;
  P.Free;
  ATMA.Free;
  ATMB.Free;
  CA.Free;
  CB.Free;
  BG.Free;
  N.Free;
end.
