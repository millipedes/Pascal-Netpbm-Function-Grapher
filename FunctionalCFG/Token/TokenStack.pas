unit TokenStack;
{$MODE OBJFPC}
interface
uses
  Token in 'FunctionalCFG/Token/Token.pas',
  contnrs;

type
  TTokenStack = Class
  private
    Value : TToken;
    Previous : TTokenStack;
  public
    constructor Create(Tok : TToken);
    destructor Destroy; override;

    procedure SetPrevious(tokenStack : TTokenStack);
    procedure Debug;

    function Push(token : TToken) : TTokenStack;
    function Pop : TTokenStack;
    function PopStack : TTokenStack;
    function GetValue : TToken;
    function GetPrevious : TTokenStack;
    function ReverseStack(TokStack : TTokenStack) : TTokenStack;
end;

implementation

constructor TTokenStack.Create(Tok : TToken);
begin
  Value := Tok;
  Previous := nil;
end;

destructor TTokenStack.Destroy;
begin
  Value.Free;
  inherited;
end;

procedure TTokenStack.SetPrevious(tokenStack : TTokenStack);
begin
  Previous := tokenStack;
end;

procedure TTokenStack.Debug;
begin
  Writeln('Value:');
  Value.Debug;
  if Previous <> nil then
    begin
      Writeln('Prev:');
      Previous.Debug;
    end
  else
    begin
      Writeln('Prev:');
      Writeln('nil');
    end;
end;

function TTokenStack.Push(token : TToken) : TTokenStack;
var
  TempStack : TTokenStack;
begin
  TempStack := TTokenStack.Create(token);
  TempStack.SetPrevious(self);
  Push := TempStack;
end;

function TTokenStack.Pop : TTokenStack;
var
  TempStack : TTokenStack;
begin
  if Value <> nil then
    begin
      Value.Free;
      Value := nil;
    end;
  TempStack := Previous;
  Destroy;
  if TempStack <> nil then
    begin
      if TempStack.GetValue <> nil then
        Pop := TempStack;
    end
  else
    Pop := nil;
end;

function TTokenStack.ReverseStack(TokStack : TTokenStack) : TTokenStack;
var
  Reverse : TTokenStack;
begin
  Reverse := TTokenStack.Create(TToken.Create(TokStack.GetValue.GetTokType, TokStack.GetValue.GetTokenLiteral));
  TokStack := TokStack.Pop;
  while TokStack <> nil do
    begin
      Reverse := Reverse.Push(TToken.Create(TokStack.GetValue.GetTokType, TokStack.GetValue.GetTokenLiteral));
      TokStack := TokStack.Pop;
    end;
  ReverseStack := Reverse;
end;

function TTokenStack.PopStack : TTokenStack;
begin
  while Previous <> nil do
    begin
      self := Pop;
    end;
  Destroy;
  PopStack := nil;
end;

function TTokenStack.GetValue : TToken;
begin
  GetValue := Value;
end;

function TTokenStack.GetPrevious : TTokenStack;
begin
  GetPrevious := Previous;
end;

end.
