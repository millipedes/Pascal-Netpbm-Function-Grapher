unit Numeric;
{$MODE OBJFPC}
interface
uses
  Color in 'GraphingPackage/GraphEncoding/Color.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas',
  sysutils;

type
  TNumeric = Class
  private
    MonoSegment : array of array of integer;
    Complement : array of boolean;
    NumericLiteral : string;
    NumericHeight : integer;
    NumericWidth : integer;
  public
    constructor Create(Literal : real; Height, Width : integer);
    destructor Destroy; override;

    procedure WriteNumericToCanvas(Top, Left : integer; Can : TCanvas);
    procedure WriteMonoDigitToCanvas(Index, Top, Left : integer;
      Can : TCanvas);
    procedure WriteComplementToCanvas(Index, Top, Left : integer;
      Can : TCanvas);

    procedure Debug;
end;

implementation

constructor TNumeric.Create(Literal : real; Height, Width : integer);
var
  C : Char;
  index : integer;
begin
  NumericHeight := Height;
  NumericWidth := Width;
  index := 0;
  NumericLiteral := FloatToStr(Literal);
  setLength(MonoSegment, Length(NumericLiteral));
  setLength(Complement, Length(NumericLiteral));
  for C in NumericLiteral do
    begin
      Case C of
        '1':
          begin
            Complement[index] := false;
            setLength(MonoSegment[index], 5);
            MonoSegment[index][0] := 1;
            MonoSegment[index][1] := 4;
            MonoSegment[index][2] := 7;
            MonoSegment[index][3] := 10;
            MonoSegment[index][4] := 13;
          end;
        '2':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 4);
            MonoSegment[index][0] := 3;
            MonoSegment[index][1] := 4;
            MonoSegment[index][2] := 10;
            MonoSegment[index][3] := 11;
          end;
        '3':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 4);
            MonoSegment[index][0] := 3;
            MonoSegment[index][1] := 4;
            MonoSegment[index][2] := 9;
            MonoSegment[index][3] := 10;
          end;
        '4':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 6);
            MonoSegment[index][0] := 1;
            MonoSegment[index][1] := 4;
            MonoSegment[index][2] := 9;
            MonoSegment[index][3] := 10;
            MonoSegment[index][4] := 12;
            MonoSegment[index][5] := 13;
          end;
        '5':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 4);
            MonoSegment[index][0] := 4;
            MonoSegment[index][1] := 5;
            MonoSegment[index][2] := 9;
            MonoSegment[index][3] := 10;
          end;
        '6':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 3);
            MonoSegment[index][0] := 4;
            MonoSegment[index][1] := 5;
            MonoSegment[index][2] := 10;
          end;
        '7':
          begin
            Complement[index] := false;
            setLength(MonoSegment[index], 7);
            MonoSegment[index][0] := 0;
            MonoSegment[index][1] := 1;
            MonoSegment[index][2] := 2;
            MonoSegment[index][3] := 5;
            MonoSegment[index][4] := 8;
            MonoSegment[index][5] := 11;
            MonoSegment[index][6] := 14;
          end;
        '8':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 2);
            MonoSegment[index][0] := 4;
            MonoSegment[index][1] := 10;
          end;
        '9':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 3);
            MonoSegment[index][0] := 4;
            MonoSegment[index][1] := 9;
            MonoSegment[index][2] := 10;
          end;
        '0':
          begin
            Complement[index] := true;
            setLength(MonoSegment[index], 3);
            MonoSegment[index][0] := 4;
            MonoSegment[index][1] := 7;
            MonoSegment[index][2] := 10;
          end;
        '.':
          begin
            Complement[index] := false;
            setLength(MonoSegment[index], 1);
            MonoSegment[index][0] := 13;
          end;
      else
        Writeln('Unknown Char: ', C);
      end;
      inc(index);
    end;
end;

destructor TNumeric.Destroy;
begin
  inherited;
end;

procedure TNumeric.WriteNumericToCanvas(Top, Left : integer; Can : TCanvas);
var
  i, MonoSpacer : integer;
begin
  MonoSpacer := round(real(NumericWidth) / 20.0);
  for i := 0 to Length(MonoSegment) - 1 do
    begin
      if Complement[i] then
        begin
          WriteComplementToCanvas(i, Top,
            Left + (i * (NumericWidth + MonoSpacer)), Can);
        end
      else
        begin
          WriteMonoDigitToCanvas(i, Top,
            Left + (i * (NumericWidth + MonoSpacer)), Can);
        end;
    end;
end;

procedure TNumeric.WriteMonoDigitToCanvas(Index, Top, Left : integer;
  Can : TCanvas);
var
  i, j, CurrentIndex, OneFifthHeight, OneThirdWidth : integer;
begin
  OneFifthHeight := NumericHeight div 5;
  OneThirdWidth := NumericWidth div 3;
  CurrentIndex := 0;
  for i := 0 to 4 do
    for j := 0 to 2 do
      if (i * 3) + j = MonoSegment[Index][CurrentIndex] then
        begin
          Can.WriteRectangle(Left + OneThirdWidth * j, Top + OneFifthHeight * i,
            OneFifthHeight, OneThirdWidth);
          inc(CurrentIndex);
        end;
end;

procedure TNumeric.WriteComplementToCanvas(Index, Top, Left : integer;
  Can : TCanvas);
var
  i, j, CurrentIndex, OneFifthHeight, OneThirdWidth : integer;
begin
  OneFifthHeight := NumericHeight div 5;
  OneThirdWidth := NumericWidth div 3;
  CurrentIndex := 0;
  for i := 0 to 4 do
    for j := 0 to 2 do
      if (i * 3) + j <> MonoSegment[Index][CurrentIndex] then
          Can.WriteRectangle(Left + OneThirdWidth * j, Top + OneFifthHeight * i,
            OneFifthHeight, OneThirdWidth)
      else
          inc(CurrentIndex);
end;

procedure TNumeric.Debug;
var
  i, j : integer;
begin
  Writeln('Numeric of ', NumericHeight, 'x', NumericWidth);
  Writeln('MonoSegment Sets');
  for i := 0 to (Length(MonoSegment) - 1) do
    begin
      if Complement[i] = true then
        Writeln('Complement')
      else
        Writeln('Not Complement');
      Write('{ ');
      for j := 0 to (Length(MonoSegment[i]) - 1) do
        Write(MonoSegment[i][j], ' ');
      Writeln('}');
    end;
end;

end.
