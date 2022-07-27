unit Color;
{$MODE OBJFPC}
interface

type
  TColor = Class
  private
      RedC : integer;
    GreenC : integer;
     BlueC : integer;
  public
    constructor Create; overload;
    constructor Create(r, g, b: integer); overload;
    destructor Destroy; override;

    procedure SetRedC(r: integer);
    procedure SetGreenC(g: integer);
    procedure SetBlueC(b: integer);
    function GetRedC() : integer;
    function GetGreenC() : integer;
    function GetBlueC() : integer;

    procedure Debug;
end;

implementation

constructor TColor.Create;
begin
  self.RedC := 255;
  self.BlueC := 255;
  self.GreenC := 255;
end;

constructor TColor.Create(r, g, b: integer); overload;
begin
  RedC := r;
  BlueC := g;
  GreenC := b;
end;

destructor TColor.Destroy;
begin
  inherited;
end;

procedure TColor.SetRedC(r: integer);
begin
  RedC := r;
end;

procedure TColor.SetGreenC(g: integer);
begin
  GreenC := g;
end;

procedure TColor.SetBlueC(b: integer);
begin
  BlueC := b;
end;

function TColor.GetRedC() : integer;
begin
  GetRedC := RedC;
end;

function TColor.GetGreenC() : integer;
begin
  GetGreenC := GreenC;
end;

function TColor.GetBlueC() : integer;
begin
  GetBlueC := BlueC;
end;

procedure TColor.Debug;
begin
  Writeln('Color: (', RedC, ',', GreenC, ',', BlueC, ')');
end;

end.
