unit Lexer;
{$MODE OBJFPC}
interface
uses
  SysUtils,
  character,
  Token      in 'FunctionalCFG/Token/Token.pas',
  TokenType  in 'FunctionalCFG/Token/TokenType.pas',
  TokenStack in 'FunctionalCFG/Token/TokenStack.pas';

type
  TLexer = Class
  private
          Source : string;
    CurrentIndex : integer;
  public
    constructor Create(LSource : string);
    destructor Destroy; override;

    function LexToken : TToken;
    function LexWord : string;
    function LexNumber : string;
    function LexSource : TTokenStack;

    procedure Debug;
end;

implementation

constructor TLexer.Create(LSource : string);
begin
  Source := LSource;
  CurrentIndex := 1;
end;

destructor TLexer.Destroy;
begin
  inherited;
end;

function TLexer.LexToken : TToken;
var
  TempString : string;
begin

  while Source[CurrentIndex] = ' ' do
    CurrentIndex := CurrentIndex + 1;

  if IsLetter(Source[CurrentIndex]) then
    begin
      TempString := LexWord;
      if CompareStr(TempString, 'sin') = 0 then
        exit(TToken.Create(TokenSin, TempString));
      if CompareStr(TempString, 'cos') = 0 then
        exit(TToken.Create(TokenCos, TempString));
      if CompareStr(TempString, 'tan') = 0 then
        exit(TToken.Create(TokenTan, TempString));
      if CompareStr(TempString, 'arcsin') = 0 then
        exit(TToken.Create(TokenArcSin, TempString));
      if CompareStr(TempString, 'arccos') = 0 then
        exit(TToken.Create(TokenArcCos, TempString));
      if CompareStr(TempString, 'arctan') = 0 then
        exit(TToken.Create(TokenArcTan, TempString));
      if CompareStr(TempString, 'log') = 0 then
        exit(TToken.Create(TokenLog, TempString));
      if pos('.', TempString) = 0 then
        exit(TToken.Create(TokenVar, TempString));
      exit(TToken.Create(TokenFileName, TempString));
    end;

  if IsDigit(Source[CurrentIndex]) then
      exit(TToken.Create(TokenNumber, LexNumber));

  Case Source[CurrentIndex] of
    '(':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenLParen, '('));
      end;
    ')':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenRParen, ')'));
      end;
    '^':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenPower, '^'));
      end;
    '+':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenPlus, '+'));
      end;
    '-':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenMinus, '-'));
      end;
    '*':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenMult, '*'));
      end;
    '/':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenDiv, '/'));
      end;
    ',':
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenComma, ','));
      end;
    #10:
      begin
        inc(CurrentIndex);
        exit(TToken.Create(TokenNewline, #10));
      end;
  end;
end;

function TLexer.LexWord : string;
var
  TheWord : string;
  Start : integer;
begin
  TheWord := Source[CurrentIndex];
  Start := CurrentIndex;
  while IsLetter(Source[CurrentIndex]) or (Source[CurrentIndex] = '.') do
    begin
      if CurrentIndex > Start then
        TheWord := TheWord + Source[CurrentIndex];
      inc(CurrentIndex);
    end;
    LexWord := TheWord;
end;

function TLexer.LexNumber : string;
var
  TheNumber : string;
  Start : integer;
begin
  Start := CurrentIndex;
  TheNumber := Source[CurrentIndex];
  while IsDigit(Source[CurrentIndex]) or (Source[CurrentIndex] = '.') do
    begin
      if CurrentIndex <> Start then
        TheNumber := TheNumber + Source[CurrentIndex];
      inc(CurrentIndex);
    end;
    LexNumber := TheNumber;
end;

function TLexer.LexSource : TTokenStack;
var tokStack : TTokenStack;
begin
  tokStack := TTokenStack.Create(LexToken);
  while tokStack.GetValue.GetTokType <> TokenNewline do
    tokStack := tokStack.Push(LexToken);
  LexSource := tokStack;
end;

procedure TLexer.Debug;
begin
  Writeln('Index: ', CurrentIndex);
  Writeln('Source: ''', Source, '''');
end;

end.
