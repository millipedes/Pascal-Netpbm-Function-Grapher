unit TokenStack;
{$MODE OBJFPC}
interface
uses
  Token in 'FunctionalCFG/Token/Token.pas',
  contnrs;

type
  TTokenStack = Class(TObjectStack)
  private
    Value : TToken;
  public
    constructor Create(Tok : TToken);
    destructor Destroy; override;

    function GetValue : TToken;
end;

implementation

constructor TTokenStack.Create(Tok : TToken);
begin
  Value := Tok;
end;

destructor TTokenStack.Destroy;
begin
  Value.Free;
  inherited;
end;

function TTokenStack.GetValue : TToken;
begin
  GetValue := Value;
end;

end.
