unit GraphBorder;
{$MODE OBJFPC}
interface
uses
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas',
  Color  in 'GraphingPackage/GraphEncoding/Color.pas',
  sysutils;

type
  TGraphBorder = Class
  private
    BorderColor : TColor;
    BorderWidth : integer;
  public
    constructor Create(Width : integer);
    destructor Destroy; override;

    procedure WriteBorderToCanvas(Can : TCanvas);

    function GetBorder() : integer;
end;

implementation

constructor TGraphBorder.Create(Width : integer);
begin
  BorderWidth := Width;
  BorderColor := TColor.Create(0, 0, 0);
end;

destructor TGraphBorder.Destroy;
begin
  BorderColor.Free;
  inherited;
end;

procedure TGraphBorder.WriteBorderToCanvas(Can : TCanvas);
var
  i, j : integer;
begin
  for i := 0 to Can.GetCanvasHeight - 1 do
    for j := 0 to Can.GetCanvasWidth - 1 do
      if (i < BorderWidth) or (i > Can.GetCanvasHeight - BorderWidth)
         or (j < BorderWidth) or (j > Can.GetCanvasHeight - BorderWidth) then
        Can.GetPixelInstance(i, j).GetPixelColor.setChannel(0, 0, 0);
end;

function TGraphBorder.GetBorder() : integer;
begin
  GetBorder := BorderWidth;
end;

end.
