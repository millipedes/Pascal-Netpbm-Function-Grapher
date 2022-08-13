unit AbstractSyntaxTree;
{$MODE OBJFPC}
interface
uses
  character,
  Token in 'FunctionalCFG/Token/Token.pas',
  TokenType in 'FunctionalCFG/Token/TokenType.pas',
  TokenStack in 'FunctionalCFG/Token/TokenStack.pas';

type
  TAbstractSyntaxTree = Class
  private
         Value : TToken;
      Children : array of TAbstractSyntaxTree;
    NoChildren : integer;
  public
    constructor Create(Tok : TToken);
    destructor Destroy; override;
    procedure SetNoChildren(Index : integer);
    procedure SetChild(Index : integer; NewValue : TAbstractSyntaxTree);

    function GetValue : TToken;
    function GetChild(Index : integer) : TAbstractSyntaxTree;

    procedure Debug;
end;

implementation

constructor TAbstractSyntaxTree.Create(Tok : TToken);
begin
  Value := Tok;
  NoChildren := 0;
end;

destructor TAbstractSyntaxTree.Destroy;
var
  index : integer;
begin
  Value.Free;
  for index := 0 to NoChildren - 1 do
    Children[index].Free;
  inherited;
end;

procedure TAbstractSyntaxTree.SetNoChildren(Index : integer);
begin
  Setlength(Children, Index);
  NoChildren := Index;
end;

procedure TAbstractSyntaxTree.SetChild(Index : integer;
  NewValue : TAbstractSyntaxTree);
begin
  Children[Index] := NewValue
end;

procedure TAbstractSyntaxTree.Debug;
var
  index : integer;
begin
  Writeln('Abstract Syntax Tree');
  Value.Debug;
  Writeln('Children: ', NoChildren);
  if NoChildren > 0 then
    begin
      for index := 0 to NoChildren - 1 do
          Children[index].Debug;
    end;
  Writeln('--');
end;

function TAbstractSyntaxTree.GetValue : TToken;
begin
  GetValue := Value;
end;

function TAbstractSyntaxTree.GetChild(Index : integer) : TAbstractSyntaxTree;
begin
  GetChild := Children[Index];
end;

end.
