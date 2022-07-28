unit AxisTicMarks;
{$MODE OBJFPC}
interface
uses
  Color in 'GraphingPackage/GraphEncoding/Color.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

type
  TAxisTicMarks = Class
  private
       ATMColor : TColor;
    ATMQuantity : integer;
       ATMWidth : integer;
      ATMHeight : integer;
  public
    constructor Create(Quantity, Width, Height : integer);
    destructor Destroy; override;

    procedure WriteATMToCanvas(Can : TCanvas);
end;

implementation

constructor Create(Quantity, Width, Height : integer);
begin
end;

destructor Destroy;
begin
  inherited;
end;

procedure WriteATMToCanvas(Can : TCanvas);
begin
end;

end.
