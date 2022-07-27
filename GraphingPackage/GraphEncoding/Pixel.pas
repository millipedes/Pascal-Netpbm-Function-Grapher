unit Pixel;
{$MODE OBJFPC}
interface
uses
  Color in 'GraphingPackage/GraphEncoding/Color.pas';

type
  TPixel = Class
  private
    PixelColor : TColor;
    PixelLayer : integer; { Bottom 0, Top 5 }
  public
    constructor Create; overload;
    constructor Create(Color : TColor); overload;
    constructor Create(Color : TColor; Layer : integer); overload;
    destructor Destroy; override;

    procedure SetPixelColor(Color : TColor);
    procedure SetLayer(Layer : integer);
    function GetPixelColor() : TColor;
    function GetPixelLayer() : integer;

    procedure Debug;
end;

implementation

constructor TPixel.Create; overload;
begin
  self.PixelColor := TColor.Create;
  self.PixelLayer := 0;
end;

constructor TPixel.Create(Color : TColor); overload;
begin
  PixelColor := Color;
  PixelLayer := 5;
end;

constructor TPixel.Create(Color : TColor; Layer : integer); overload;
begin
  PixelColor := Color;
  PixelLayer := Layer;
end;

destructor TPixel.Destroy;
begin
  inherited;
end;

procedure TPixel.SetPixelColor(Color : TColor);
begin
  PixelColor := Color;
end;

procedure TPixel.SetLayer(Layer : integer);
begin
  PixelLayer := Layer;
end;

function TPixel.GetPixelColor() : TColor;
begin
  GetPixelColor := PixelColor;
end;

function TPixel.GetPixelLayer() : integer;
begin
  GetPixelLayer := PixelLayer;
end;

procedure TPixel.Debug;
begin
  Writeln('Pixel');
  Writeln('Layer: ', PixelLayer);
  PixelColor.Debug;
  Writeln('--');
end;

end.
