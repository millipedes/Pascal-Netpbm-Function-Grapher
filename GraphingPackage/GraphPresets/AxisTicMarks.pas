unit AxisTicMarks;
{$MODE OBJFPC}
interface
uses
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas',
  Color  in 'GraphingPackage/GraphEncoding/Color.pas';

type
  TAxisTicMarks = Class
  private
       ATMColor : TColor;
    ATMQuantity : integer;
       ATMWidth : integer;
      ATMHeight : integer;
        ATMAxis : char;
  public
    constructor Create(Quantity, Width, Height : integer; Ax : char);
    destructor Destroy; override;

    procedure WriteATMToCanvas(Can : TCanvas);
    function GetATMQuantity : integer;
    function GetATMWidth : integer;
    function GetATMHeight : integer;
end;

implementation

constructor TAxisTicMarks.Create(Quantity, Width, Height : integer; Ax : char);
begin
  ATMColor := TColor.Create(0, 0, 0);
  ATMQuantity := Quantity;
  ATMWidth := Width;
  ATMHeight := Height;
  ATMAxis := Ax;
end;

destructor TAxisTicMarks.Destroy;
begin
  ATMColor.Free;
  inherited;
end;

function TAxisTicMarks.GetATMQuantity : integer;
begin
  GetATMQuantity := ATMQuantity;
end;

function TAxisTicMarks.GetATMWidth : integer;
begin
  GetATMWidth := ATMWidth;
end;

function TAxisTicMarks.GetATMHeight : integer;
begin
  GetATMHeight := ATMHeight;
end;

procedure TAxisTicMarks.WriteATMToCanvas(Can : TCanvas);
var
  i : integer;
begin
  if ATMAxis = 'X' then
    for i := 0 to ATMQuantity do
      Can.WriteRectangle(
        (i * (Can.GetCanvasWidth div ATMQuantity)) - (ATMWidth div 2),
        (Can.GetCanvasHeight div 2) - (ATMHeight div 2),
        ATMHeight,
        ATMWidth)
  else
    for i := 0 to ATMQuantity do
      Can.WriteRectangle(
        (Can.GetCanvasWidth div 2) - (ATMWidth div 2),
        i * (Can.GetCanvasHeight div ATMQuantity) - (ATMHeight div 2),
        ATMHeight,
        ATMWidth);
end;

end.
