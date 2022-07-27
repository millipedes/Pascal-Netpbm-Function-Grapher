unit Canvas;
{$MODE OBJFPC}
interface
uses
  Pixel in 'GraphingPackage/GraphEncoding/Pixel.pas';

type
  TCanvas = Class
  private
    PixelInstance : array of array of TPixel;
     CanvasHeight : integer;
      CanvasWidth : integer;
  public
    constructor Create; overload;
    constructor Create(Height, Width : integer); overload;
    destructor Destroy; override;

    function GetCanvasHeight() : integer;
    function GetCanvasWidth() : integer;

    procedure Debug;
end;

implementation

constructor TCanvas.Create;
var
  i, j : integer;
begin
  self.CanvasHeight := 100;
  self.CanvasWidth := 100;
  setLength(PixelInstance, self.CanvasHeight, self.CanvasWidth);
  for i := 0 to self.CanvasHeight do
    for j := 0 to self.CanvasWidth do
      self.PixelInstance[i, j] := TPixel.Create;
end;

constructor TCanvas.Create(Height, Width : integer); overload;
var
  i, j : integer;
begin
  CanvasHeight := Height;
  CanvasWidth := Width;
  setLength(PixelInstance, CanvasHeight, CanvasWidth);
  for i := 0 to (CanvasHeight - 1) do
    for j := 0 to (CanvasWidth - 1) do
      PixelInstance[i][j] := TPixel.Create;
end;

destructor TCanvas.Destroy;
begin
  inherited;
end;

function TCanvas.GetCanvasHeight() : integer;
begin
  GetCanvasHeight := CanvasHeight;
end;

function TCanvas.GetCanvasWidth() : integer;
begin
  GetCanvasWidth := CanvasWidth;
end;

procedure TCanvas.Debug;
var
  i, j : integer;
begin
  Writeln('Canvas ', CanvasWidth, 'x', CanvasHeight);
  for i := 0 to (CanvasHeight - 1) do
    for j := 0 to (CanvasWidth - 1) do
      PixelInstance[i][j].Debug;
  Writeln('--');
end;

end.
