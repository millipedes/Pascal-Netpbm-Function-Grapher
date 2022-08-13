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

end.
