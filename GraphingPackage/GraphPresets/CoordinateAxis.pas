unit CoordinateAxis;
{$MODE OBJFPC}
interface
uses
  Color in 'GraphingPackage/GraphEncoding/Color.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

type
  TCoordinateAxis = Class
  private
    CAColor : TColor;
    AxisMin : integer;
    AxisMax : integer;
    AxisWidth : integer;
    Axis : char;
  public
    constructor Create(Min, Max, Width : integer; Ax : char);
    destructor Destroy; override;

    function GetAxisMin() : integer;
    function GetAxisMax() : integer;

    procedure WriteCoordinateAxisToCanvas(Can : TCanvas);
end;

implementation

constructor TCoordinateAxis.Create(Min, Max, Width : integer; Ax : char);
begin
  CAColor := TColor.Create(0, 0, 0);
  AxisMin := Min;
  AxisMax := Max;
  AxisWidth := Width;
  Axis := Ax;
end;

destructor TCoordinateAxis.Destroy;
begin
  inherited;
end;

function TCoordinateAxis.GetAxisMin() : integer;
begin
  GetAxisMin := AxisMin;
end;

function TCoordinateAxis.GetAxisMax() : integer;
begin
  GetAxisMax := AxisMax;
end;

procedure TCoordinateAxis.WriteCoordinateAxisToCanvas(Can : TCanvas);
var
  i, j : integer;
begin
  if Axis = 'X' then
    begin
      for i := 0 to Can.GetCanvasHeight - 1 do
        for j := 0 to Can.GetCanvasWidth - 1 do
          if (j > Can.GetCanvasWidth div 2 - AxisWidth)
              and (j < Can.GetCanvasWidth div 2 + AxisWidth) then
                Can.GetPixelInstance(i, j).GetPixelColor.SetChannel(0, 0, 0);
    end
  else
    begin
      for i := 0 to Can.GetCanvasHeight - 1 do
        for j := 0 to Can.GetCanvasWidth - 1 do
          if (i > Can.GetCanvasWidth div 2 - AxisWidth)
              and (i < Can.GetCanvasWidth div 2 + AxisWidth) then
                Can.GetPixelInstance(i, j).GetPixelColor.SetChannel(0, 0, 0);
    end;
end;

end.
