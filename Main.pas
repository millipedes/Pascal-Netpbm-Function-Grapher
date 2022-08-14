program Main;
uses
  SysUtils,
  FileIO in 'FileIO/FileIO.pas',
  Token in 'FunctionalCFG/Token/Token.pas',
  TokenType in 'FunctionalCFG/Token/TokenType.pas',
  TokenStack in 'FunctionalCFG/Token/TokenStack.pas',
  Color in 'GraphingPackage/GraphEncoding/Color.pas',
  GraphRelation in 'GraphingPackage/GraphRelation.pas',
  Lexer in 'FunctionalCFG/Lexer/Lexer.pas',
  AbstractSyntaxTree in 'FunctionalCFG/Parser/AbstractSyntaxTree.pas',
  Parser in 'FunctionalCFG/Parser/Parser.pas',
  GraphScale in 'GraphingPackage/GraphPresets/GraphScale.pas',
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas';

var
     P : TCanvas;
    GS : TGraphScale;
    TT : TTokenStack;
     L : TLexer;
  Tree : TAbstractSyntaxTree;
   Col : TColor;

begin
  GS := TGraphScale.Create(-10, 10, -10, 10);
  P := TCanvas.Create(1000, 1000);
  GS.WriteGraphScaleToCanvas(P);
  L := TLexer.Create('2 * x ^ 2'#10'');
  TT := L.LexSource;
  TT := TT.ReverseStack(TT);
  Tree := ParseExpression(TT);
  Col := TColor.Create(0, 23, 66);
  WriteRelationToCanvas(Tree, P, GS, Col, 0.001);
  WriteCanvasToFile('test.ppm', P);
  Tree.Free;
  Col.Free;
  L.Free;
  TT := TT.PopStack;
  P.Free;
  GS.Free;
end.
