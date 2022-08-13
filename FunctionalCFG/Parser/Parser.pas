unit Parser;
interface
uses
  SysUtils,
  Math,
  Token in 'FunctionalCFG/Token/Token.pas',
  TokenType in 'FunctionalCFG/Token/TokenType.pas',
  TokenStack in 'FunctionalCFG/Token/TokenStack.pas',
  AbstractSyntaxTree in 'FunctionalCFG/Parser/AbstractSyntaxTree.pas';

function EvaluateTree(Tree : TAbstractSyntaxTree; X : real) : real;
function ParseExpression(var TokStack : TTokenStack) : TAbstractSyntaxTree;
function ParseTerm(var TokStack : TTokenStack) : TAbstractSyntaxTree;
function ParseFactor(var TokStack : TTokenStack) : TAbstractSyntaxTree;
function BinaryTree(var Parent, LeftChild, RightChild : TAbstractSyntaxTree)
  : TAbstractSyntaxTree;
function UnaryTree(var Parent, Child : TAbstractSyntaxTree)
  : TAbstractSyntaxTree;

implementation

function EvaluateTree(Tree : TAbstractSyntaxTree; X : real) : real;
begin
  Case Tree.GetValue.GetTokType of
    TokenNumber:
        exit(StrToFloat(Tree.GetValue.GetTokenLiteral));
    TokenVar:
        exit(X);
    TokenPlus:
        EvaluateTree := EvaluateTree(Tree.GetChild(0), X)
          + EvaluateTree(Tree.GetChild(1), X);
    TokenMinus:
        EvaluateTree := EvaluateTree(Tree.GetChild(0), X)
          - EvaluateTree(Tree.GetChild(1), X);
    TokenMult:
        EvaluateTree := EvaluateTree(Tree.GetChild(0), X)
          * EvaluateTree(Tree.GetChild(1), X);
    TokenDiv:
        EvaluateTree := EvaluateTree(Tree.GetChild(0), X)
          / EvaluateTree(Tree.GetChild(1), X);
    TokenPower:
        EvaluateTree := power(EvaluateTree(Tree.GetChild(0), X),
          EvaluateTree(Tree.GetChild(1), X));
    TokenSin:
      EvaluateTree := Sin(EvaluateTree(Tree.GetChild(0), X));
    TokenCos:
      EvaluateTree := Cos(EvaluateTree(Tree.GetChild(0), X));
    TokenTan:
      EvaluateTree := Tan(EvaluateTree(Tree.GetChild(0), X));
    TokenArcSin:
      EvaluateTree := ArcSin(EvaluateTree(Tree.GetChild(0), X));
    TokenArcCos:
      EvaluateTree := ArcCos(EvaluateTree(Tree.GetChild(0), X));
    TokenArcTan:
      EvaluateTree := ArcTan2(EvaluateTree(Tree.GetChild(0), X), 1);
    TokenLog:
      EvaluateTree := Log2(EvaluateTree(Tree.GetChild(0), X));
  end;
end;

function ParseExpression(var TokStack : TTokenStack) : TAbstractSyntaxTree;
var
  LeftChild : TAbstractSyntaxTree;
  RightChild : TAbstractSyntaxTree;
  Parent : TAbstractSyntaxTree;
begin
  if TokStack.GetValue <> nil then
    begin
      LeftChild := ParseTerm(TokStack);
      Case TokStack.GetValue.GetTokType of
        TokenPlus:
          begin
            TokStack := TokStack.Pop;
            RightChild := ParseExpression(TokStack);
            Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenPlus, '+'));
            exit(BinaryTree(Parent, LeftChild, RightChild));
          end;
        TokenMinus:
          begin
            TokStack := TokStack.Pop;
            RightChild := ParseExpression(TokStack);
            Parent :=
              TAbstractSyntaxTree.Create(TToken.Create(TokenMinus, '-'));
            exit(BinaryTree(Parent, LeftChild, RightChild));
          end;
        TokenRParen:
            exit(LeftChild);
        TokenVar:
            exit(LeftChild);
        TokenNumber:
            exit(LeftChild);
        TokenNewLine:
            exit(LeftChild);
      end;
    end;
  ParseExpression := nil;
end;

function ParseTerm(var TokStack : TTokenStack) : TAbstractSyntaxTree;
var
  LeftChild : TAbstractSyntaxTree;
  RightChild : TAbstractSyntaxTree;
  Parent : TAbstractSyntaxTree;
begin
  if TokStack.GetValue <> nil then
    begin
      LeftChild := ParseFactor(TokStack);
      Case TokStack.GetValue.GetTokType of
        TokenVar:
            exit(LeftChild);
        TokenNumber:
            exit(LeftChild);
        TokenMult:
          begin
            TokStack := TokStack.Pop;
            RightChild := ParseTerm(TokStack);
            Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenMult, '*'));
            exit(BinaryTree(Parent, LeftChild, RightChild));
          end;
        TokenDiv:
          begin
            TokStack := TokStack.Pop;
            RightChild := ParseTerm(TokStack);
            Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenDiv, '/'));
            exit(BinaryTree(Parent, LeftChild, RightChild));
          end;
        TokenNewLine:
            exit(LeftChild);
        TokenMinus:
            exit(LeftChild);
        TokenPlus:
            exit(LeftChild);
        TokenPower:
            exit(LeftChild);
        TokenRParen:
            exit(LeftChild);
        TokenSin:
            exit(LeftChild);
        TokenCos:
            exit(LeftChild);
        TokenTan:
            exit(LeftChild);
        TokenArcSin:
            exit(LeftChild);
        TokenArcCos:
            exit(LeftChild);
        TokenArcTan:
            exit(LeftChild);
        TokenLog:
            exit(LeftChild);
      end;
    end;
  ParseTerm := nil;
end;

function ParseFactor(var TokStack : TTokenStack) : TAbstractSyntaxTree;
var
  LeftChild : TAbstractSyntaxTree;
  RightChild : TAbstractSyntaxTree;
  Parent : TAbstractSyntaxTree;
begin
  Case TokStack.GetValue.GetTokType of
    TokenVar:
      begin
        LeftChild := TAbstractSyntaxTree.Create(TToken.Create(
            TokStack.GetValue.GetTokType, TokStack.GetValue.GetTokenLiteral));
        TokStack := TokStack.Pop;
        if TokStack.GetValue.GetTokType <> TokenPower then
          exit(LeftChild);
        TokStack := TokStack.Pop;
        RightChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenPower, '^'));
        exit(BinaryTree(Parent, LeftChild, RightChild));
      end;
    TokenNumber:
      begin
        LeftChild := TAbstractSyntaxTree.Create(TToken.Create(
            TokStack.GetValue.GetTokType, TokStack.GetValue.GetTokenLiteral));
        TokStack := TokStack.Pop;
        if TokStack.GetValue.GetTokType <> TokenPower then
            exit(LeftChild);
        TokStack := TokStack.Pop;
        RightChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenPower, '^'));
        exit(BinaryTree(Parent, LeftChild, RightChild));
      end;
    TokenLParen:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseExpression(TokStack);
        if TokStack.GetValue.GetTokType = TokenRParen then
          begin
            TokStack := TokStack.Pop;
            if TokStack.GetValue.GetTokType <> TokenPower then
                exit(LeftChild);
            TokStack := TokStack.Pop;
            RightChild := ParseFactor(TokStack);
            Parent :=
              TAbstractSyntaxTree.Create(TToken.Create(TokenPower, '^'));
            exit(BinaryTree(Parent, LeftChild, RightChild));
          end;
      end;
    TokenSin:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenSin, 'sin'));
        exit(UnaryTree(Parent, LeftChild));
      end;
    TokenCos:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenCos, 'cos'));
        exit(UnaryTree(Parent, LeftChild));
      end;
    TokenTan:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenTan, 'tan'));
        exit(UnaryTree(Parent, LeftChild));
      end;
    TokenArcSin:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenArcSin, 'arcsin'));
        exit(UnaryTree(Parent, LeftChild));
      end;
    TokenArcCos:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenArcCos, 'arccos'));
        exit(UnaryTree(Parent, LeftChild));
      end;
    TokenArcTan:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenArcTan, 'arctan'));
        exit(UnaryTree(Parent, LeftChild));
      end;
    TokenLog:
      begin
        TokStack := TokStack.Pop;
        LeftChild := ParseFactor(TokStack);
        Parent := TAbstractSyntaxTree.Create(TToken.Create(TokenLog, 'log'));
        exit(UnaryTree(Parent, LeftChild));
      end;
  end;
end;

function BinaryTree(var Parent, LeftChild, RightChild : TAbstractSyntaxTree)
  : TAbstractSyntaxTree;
begin
  Parent.SetNoChildren(2);
  Parent.SetChild(0, LeftChild);
  Parent.SetChild(1, RightChild);
  BinaryTree := Parent;
end;

function UnaryTree(var Parent, Child : TAbstractSyntaxTree)
  : TAbstractSyntaxTree;
begin
  Parent.SetNoChildren(1);
  Parent.SetChild(0, Child);
  UnaryTree := Parent;
end;

end.
