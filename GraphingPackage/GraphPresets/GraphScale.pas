unit GraphScale;
{$MODE OBJFPC}
interface
uses
  Numeric in 'GraphingPackage/GraphPresets/Numeric.pas',
  GraphBorder in 'GraphingPackage/GraphPresets/GraphBorder.pas',
  CoordinateAxis in 'GraphingPackage/GraphPresets/CoordinateAxis.pas',
  AxisTicMarks in 'GraphingPackage/GraphPresets/AxisTicMarks.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

type
  TGraphScale = Class
  private
       GSGraphBorder : TGraphBorder;
           GSNumeric : array of TNumeric;        {0 : X, 1 : Y}
    GSCoordinateAxes : array of TCoordinateAxis; {0 : X, 1 : Y}
      GSAxesTicMarks : array of TAxisTicMarks;   {0 : X, 1 : Y}
  public
    constructor Create; overload;
    constructor Create(XMin, XMax, YMin, YMax : real); overload;
    destructor Destroy; override;

    procedure WriteGraphScaleToCanvas(Can : TCanvas);
end;

implementation

constructor TGraphScale.Create;
var
  YNumericLiteral, XNumericLiteral : real;
begin
  setLength(GSCoordinateAxes, 2);
  GSCoordinateAxes[0] := TCoordinateAxis.Create(-10, 10, 10, 'X');
  GSCoordinateAxes[1] := TCoordinateAxis.Create(-10, 10, 10, 'Y');
  setLength(GSAxesTicMarks, 2);
  GSAxesTicMarks[0] := TAxisTicMarks.Create(10, 12, 30, 'X');
  GSAxesTicMarks[1] := TAxisTicMarks.Create(10, 30, 12, 'Y');
  GSGraphBorder := TGraphBorder.Create(15);
  setLength(GSNumeric, 2);
  XNumericLiteral :=
    real(GSCoordinateAxes[0].GetAxisMax - GSCoordinateAxes[0].GetAxisMin)
    / real(GSAxesTicMarks[0].GetATMQuantity);
  YNumericLiteral :=
    real(GSCoordinateAxes[1].GetAxisMax - GSCoordinateAxes[1].GetAxisMin)
    / real(GSAxesTicMarks[1].GetATMQuantity);
  GSNumeric[0] := TNumeric.Create(XNumericLiteral, 40, 25);
  GSNumeric[1] := TNumeric.Create(YNumericLiteral, 40, 25);
end;

constructor TGraphScale.Create(XMin, XMax, YMin, YMax : real);
var
  YNumericLiteral, XNumericLiteral : real;
begin
  setLength(GSCoordinateAxes, 2);
  GSCoordinateAxes[0] := TCoordinateAxis.Create(XMin, XMax, 10, 'X');
  GSCoordinateAxes[1] := TCoordinateAxis.Create(YMin, YMax, 10, 'Y');
  setLength(GSAxesTicMarks, 2);
  GSAxesTicMarks[0] := TAxisTicMarks.Create(10, 12, 30, 'X');
  GSAxesTicMarks[1] := TAxisTicMarks.Create(10, 30, 12, 'Y');
  GSGraphBorder := TGraphBorder.Create(15);
  setLength(GSNumeric, 2);
  XNumericLiteral :=
    real(GSCoordinateAxes[0].GetAxisMax - GSCoordinateAxes[0].GetAxisMin)
    / real(GSAxesTicMarks[0].GetATMQuantity);
  YNumericLiteral :=
    real(GSCoordinateAxes[1].GetAxisMax - GSCoordinateAxes[1].GetAxisMin)
    / real(GSAxesTicMarks[1].GetATMQuantity);
  GSNumeric[0] := TNumeric.Create(XNumericLiteral, 50, 30);
  GSNumeric[1] := TNumeric.Create(YNumericLiteral, 50, 30);
end;

destructor TGraphScale.Destroy;
begin
  GSAxesTicMarks[0].Free;
  GSAxesTicMarks[1].Free;
  GSCoordinateAxes[0].Free;
  GSCoordinateAxes[1].Free;
  GSGraphBorder.Free;
  GSNumeric[0].Free;
  GSNumeric[1].Free;
  inherited;
end;

procedure TGraphScale.WriteGraphScaleToCanvas(Can : TCanvas);
var
  XNumericXC, XNumericYC, YNumericXC, YNumericYC : integer;
begin
  XNumericXC := (Can.GetCanvasHeight div 2) + 2*GSAxesTicMarks[1].GetATMHeight;
  XNumericYC := (GSAxesTicMarks[0].GetATMQuantity div 2 + 1) *
    (Can.GetCanvasWidth div GSAxesTicMarks[0].GetATMQuantity);
  GSNumeric[0].WriteNumericToCanvas(XNumericXC, XNumericYC, Can);
  YNumericYC := (Can.GetCanvasWidth div 2) + 2*GSAxesTicMarks[1].GetATMHeight;
  YNumericXC := (GSAxesTicMarks[1].GetATMQuantity div 2 - 1) *
    (Can.GetCanvasHeight div GSAxesTicMarks[1].GetATMQuantity);
  GSNumeric[1].WriteNumericToCanvas(YNumericXC, YNumericYC, Can);
  GSGraphBorder.WriteBorderToCanvas(Can);
  GSCoordinateAxes[0].WriteCoordinateAxisToCanvas(Can);
  GSCoordinateAxes[1].WriteCoordinateAxisToCanvas(Can);
  GSAxesTicMarks[0].WriteATMToCanvas(Can);
  GSAxesTicMarks[1].WriteATMToCanvas(Can);
end;

end.
