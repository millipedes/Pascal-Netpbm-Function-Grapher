unit GraphRelation;
interface
uses
  SysUtils,
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas',
  Color in 'GraphingPackage/GraphEncoding/Color.pas',
  GraphScale in 'GraphingPackage/GraphPresets/GraphScale.pas',
  Parser in 'FunctionalCFG/Parser/Parser.pas',
  AbstractSyntaxTree in 'FunctionalCFG/Parser/AbstractSyntaxTree.pas';

function MapScaleToCanvas(Can : TCanvas; Scale : TGraphScale; IsX : boolean;
  Quantity : real) : integer;
procedure WriteRelationToCanvas(Tree : TAbstractSyntaxTree; Can : TCanvas;
  Scale : TGraphScale; Col : TColor; Delta : real);

implementation

function MapScaleToCanvas(Can : TCanvas; Scale : TGraphScale; IsX : boolean;
  Quantity : real) : integer;
begin
  if IsX then
    exit(round(Quantity / (Scale.GetCoordAxis(0).GetAxisMax
      - Scale.GetCoordAxis(0).GetAxisMin) * Can.GetCanvasWidth))
  else
    exit(round(Quantity / (Scale.GetCoordAxis(1).GetAxisMax
      - Scale.GetCoordAxis(1).GetAxisMin) * Can.GetCanvasHeight));
end;

procedure WriteRelationToCanvas(Tree : TAbstractSyntaxTree; Can : TCanvas;
  Scale : TGraphScale; Col : TColor; Delta : real);
var
  XIndex, YIndex : integer;
  i, y : real;
begin
  i := Scale.GetCoordAxis(0).GetAxisMin;
  while i < Scale.GetCoordAxis(0).GetAxisMax do
    begin
      y := EvaluateTree(Tree, i);
      if Scale.GetCoordAxis(0).GetAxisMin >= 0 then
        XIndex := MapScaleToCanvas(Can, Scale, true, i)
      else
        XIndex := MapScaleToCanvas(Can, Scale, true,
          i - Scale.GetCoordAxis(0).GetAxisMin);

      if Scale.GetCoordAxis(1).GetAxisMin >= 0 then
        YIndex := Can.GetCanvasHeight - MapScaleToCanvas(Can, Scale, false, y)
      else
        YIndex := Can.GetCanvasHeight - MapScaleToCanvas(Can, Scale, false,
          y - Scale.GetCoordAxis(0).GetAxisMin);

      if (y < Scale.GetCoordAxis(1).GetAxisMax) and
         (y >= Scale.GetCoordAxis(0).GetAxisMin) and
         ((XIndex >= 0) and (XIndex < Can.GetCanvasWidth)) and
         ((YIndex >= 0) and (YIndex < Can.GetCanvasHeight)) then
           if Can.GetPixelInstance(YIndex, XIndex).GetPixelColor.IsColorWhite then
             begin
               Can.GetPixelInstance(YIndex, XIndex - 1).GetPixelColor
                 .SetChannel(Col.GetRedC, Col.GetGreenC, Col.GetBlueC);
               Can.GetPixelInstance(YIndex - 1, XIndex).GetPixelColor
                 .SetChannel(Col.GetRedC, Col.GetGreenC, Col.GetBlueC);
               Can.GetPixelInstance(YIndex - 1, XIndex - 1).GetPixelColor
                 .SetChannel(Col.GetRedC, Col.GetGreenC, Col.GetBlueC);
               Can.GetPixelInstance(YIndex, XIndex).GetPixelColor
                 .SetChannel(Col.GetRedC, Col.GetGreenC, Col.GetBlueC);
               Can.GetPixelInstance(YIndex, XIndex + 1).GetPixelColor
                 .SetChannel(Col.GetRedC, Col.GetGreenC, Col.GetBlueC);
               Can.GetPixelInstance(YIndex + 1, XIndex).GetPixelColor
                 .SetChannel(Col.GetRedC, Col.GetGreenC, Col.GetBlueC);
               Can.GetPixelInstance(YIndex + 1, XIndex + 1).GetPixelColor
                 .SetChannel(Col.GetRedC, Col.GetGreenC, Col.GetBlueC);
             end;

      i := i + Delta;
    end;
end;

end.
