unit TokenType;
interface

type
  TTokenType = (
                 TokenVar,
                 TokenFileName,
                 TokenNumber,
                 TokenPlus,
                 TokenMinus,
                 TokenMult,
                 TokenDiv,
                 TokenLParen,
                 TokenRParen,
                 TokenComma,
                 TokenPower,
                 TokenSin,
                 TokenCos,
                 TokenTan,
                 TokenArcSin,
                 TokenArcCos,
                 TokenArcTan,
                 TokenLog,
                 TokenNewline
                );
function TokenTypeToString(TType : TTokenType) : string;

implementation

function TokenTypeToString(TType : TTokenType) : string;
begin
  Case TType of
    TokenVar:      TokenTypeToString := 'Token Var';
    TokenFileName: TokenTypeToString := 'Token File Name';
    TokenNumber:   TokenTypeToString := 'Token Number';
    TokenPlus:     TokenTypeToString := 'Token Plus';
    TokenMinus:    TokenTypeToString := 'Token Minus';
    TokenMult:     TokenTypeToString := 'Token Mult';
    TokenDiv:      TokenTypeToString := 'Token Div';
    TokenLParen:   TokenTypeToString := 'Token Left Paren';
    TokenRParen:   TokenTypeToString := 'Token R Paren';
    TokenComma:    TokenTypeToString := 'Token Comma';
    TokenPower:    TokenTypeToString := 'Token Power';
    TokenSin:      TokenTypeToString := 'Token Sin';
    TokenCos:      TokenTypeToString := 'Token Cos';
    TokenTan:      TokenTypeToString := 'Token Tan';
    TokenArcSin:   TokenTypeToString := 'Token ArcSin';
    TokenArcCos:   TokenTypeToString := 'Token ArcCos';
    TokenArcTan:   TokenTypeToString := 'Token ArcTan';
    TokenLog:      TokenTypeToString := 'Token Log';
    TokenNewline:  TokenTypeToString := 'Token Newline';
  end;
end;

end.
