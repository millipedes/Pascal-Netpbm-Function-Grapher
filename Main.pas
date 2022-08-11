program Main;
uses
  Token in 'FunctionalCFG/Token/Token.pas',
  TokenType in 'FunctionalCFG/Token/TokenType.pas',
  TokenStack in 'FunctionalCFG/Token/TokenStack.pas',
  GraphScale in 'GraphingPackage/GraphPresets/GraphScale.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
  P : TCanvas;
  GS : TGraphScale;
  TT : TTokenStack;

begin
  {GS := TGraphScale.Create(-10, 9, -10, 9);}
  {P := TCanvas.Create(1000, 1000);}
  {GS.WriteGraphScaleToCanvas(P);}
  TT := TTokenStack.Create(TToken.Create(TokenSin, 'sin'));
  TT := TT.Push(TToken.Create(TokenCos, 'cos'));
  TT := TT.Push(TToken.Create(TokenTan, 'tan'));
  TT.Debug;
  TT := TT.PopStack;
  {P.Dump;}
  {TT.GetPrevious.Free;}
  {TT.Free;}
  {P.Free;}
  {GS.Free;}
end.
