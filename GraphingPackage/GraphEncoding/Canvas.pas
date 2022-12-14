unit Canvas;
{$MODE OBJFPC}
interface
uses
  SysUtils,
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

    function GetPixelInstance(i, j : integer) : TPixel;
    function GetCanvasHeight() : integer;
    function GetCanvasWidth() : integer;
    procedure WriteRectangle(Left, Top, Height, Width : integer);
    procedure DumpFile(var Name : TextFile);

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
var
  i, j : integer;
begin
  for i := 0 to CanvasHeight - 1 do
    for j := 0 to CanvasWidth - 1 do
      PixelInstance[i][j].Free;
  inherited;
end;

function TCanvas.GetPixelInstance(i, j : integer) : TPixel;
begin
  GetPixelInstance := PixelInstance[i][j];
end;

function TCanvas.GetCanvasHeight() : integer;
begin
  GetCanvasHeight := CanvasHeight;
end;

function TCanvas.GetCanvasWidth() : integer;
begin
  GetCanvasWidth := CanvasWidth;
end;

procedure TCanvas.WriteRectangle(Left, Top, Height, Width : integer);
var
  i, j : integer;
begin
  for i := Top to (Top + Height) do
    for j := Left to (Left + Width) do
      if (j > 0) and (i > 0) and (j < CanvasWidth) and (i < CanvasHeight) then
      GetPixelInstance(i, j).GetPixelColor.SetChannel(0, 0, 0);
end;

procedure TCanvas.DumpFile(var Name : TextFile);
var
  i, j : integer;
begin
  Writeln(Name, 'P3');
  Writeln(Name, CanvasWidth, ' ', CanvasHeight);
  Writeln(Name, '255');
  for i := 0 to (CanvasHeight - 1) do
    for j := 0 to (CanvasWidth - 1) do
      Writeln(Name, PixelInstance[i][j].GetPixelColor.GetChannel);
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
