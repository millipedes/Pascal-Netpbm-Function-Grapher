unit RealOperators;
interface
{uses}


function Addition(RealOne, RealTwo : real) : real;
function Subtraction(RealOne, RealTwo : real) : real;
function Multiplication(RealOne, RealTwo : real) : real;
function Division(RealOne, RealTwo : real) : real;

implementation

function Addition(RealOne, RealTwo : real) : real;
begin
  Addition := RealTwo + RealTwo;
end;

function Subtraction(RealOne, RealTwo : real) : real;
begin
  Subtraction := RealTwo - RealTwo;
end;

function Multiplication(RealOne, RealTwo : real) : real;
begin
  Multiplication := RealTwo * RealTwo;
end;

function Division(RealOne, RealTwo : real) : real;
begin
  Division := RealTwo / RealTwo;
end;

end.
