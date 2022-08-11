unit Token;
{$MODE OBJFPC}
interface
uses
  TokenType in 'FunctionalCFG/Token/TokenType.pas';

type
  TToken = Class
  private
         TokType : TTokenType;
    TokenLiteral : string;
  public
    constructor Create(TType : TTokenType; TLiteral : string);
    destructor Destroy; override;

    function GetTokType : TTokenType;
    function GetTokenLiteral : string;

    procedure Debug;
end;

implementation

constructor TToken.Create(TType : TTokenType; TLiteral : string);
begin 
  TokType := TType; 
  TokenLiteral := TLiteral;
end; 
 
destructor TToken.Destroy;
begin 
  inherited; 
end; 

function TToken.GetTokType : TTokenType;
begin
  GetTokType := TokType;
end;

function TToken.GetTokenLiteral : string;
begin
  GetTokenLiteral := TokenLiteral;
end;
 
procedure TToken.Debug;
begin 
  Writeln('Token');
  Writeln('Literal: ', TokenLiteral);
  Writeln('Type: ', TokenTypeToString(TokType));
end;

end.
