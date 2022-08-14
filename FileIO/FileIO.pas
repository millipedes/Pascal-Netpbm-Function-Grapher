unit FileIO;
{$MODE OBJFPC}
interface
uses
  SysUtils,
  Canvas in 'GraphingPackage/GraphEncoding/Canvas.pas',
  Token in 'FunctionalCFG/Token/Token.pas',
  TokenType in 'FunctionalCFG/Token/TokenType.pas',
  TokenStack in 'FunctionalCFG/Token/TokenStack.pas',
  AbstractSyntaxTree in 'FunctionalCFG/Parser/AbstractSyntaxTree.pas';

var
  FilePointer : TextFile;

procedure WriteCanvasToFile(FileName : string; Can : TCanvas);

implementation

procedure WriteCanvasToFile(FileName : string; Can : TCanvas);
begin
  AssignFile(FilePointer, FileName);
  rewrite(FilePointer);
  Can.DumpFile(FilePointer);
  CloseFile(FilePointer);
end;

end.
