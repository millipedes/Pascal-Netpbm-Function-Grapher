program Main;
uses
  Token in 'FunctionalCFG/Token/Token.pas',
  TokenType in 'FunctionalCFG/Token/TokenType.pas',
  TokenStack in 'FunctionalCFG/Token/TokenStack.pas',
  Lexer in 'FunctionalCFG/Lexer/Lexer.pas',
  AbstractSyntaxTree in 'FunctionalCFG/Parser/AbstractSyntaxTree.pas',
  Parser in 'FunctionalCFG/Parser/Parser.pas',
  GraphScale in 'GraphingPackage/GraphPresets/GraphScale.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
    P  : TCanvas;
    GS : TGraphScale;
    TT : TTokenStack;
    L  : TLexer;
  Tree : TAbstractSyntaxTree;

begin
  {GS := TGraphScale.Create(-10, 9, -10, 9);}
  {P := TCanvas.Create(1000, 1000);}
  {GS.WriteGraphScaleToCanvas(P);}
  L := TLexer.Create('(2 + x) * 4'#10'');
  TT := L.LexSource;
  {TT.Debug;}
  TT := TT.ReverseStack(TT);
  {TT.Debug;}
  Tree := ParseExpression(TT);
  {Tree.Debug;}
  Writeln(EvaluateTree(Tree, 2.0));
  Tree.Free;
  {L.Debug;}
  L.Free;
  TT := TT.PopStack;
  {P.Dump;}
  {TT.GetPrevious.Free;}
  {TT.Free;}
  {P.Free;}
  {GS.Free;}
end.
