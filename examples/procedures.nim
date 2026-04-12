echo "Procedures"

# {{## BEGIN definition ##}}
proc fibonacci(n: int): int =
  if n < 2:
    return n
  else:
    return fibonacci(n - 1) + (n - 2).fibonacci

proc fibo2(n: int): int =
  proc innerfibo(n:int): int = innerfibo(n-1) + innerfibo(n-2)
  result = if n < 2: n else: innerfibo(n)

#echo innerfibo(5)       # Error: undeclared identifier 'innerfibo'
# {{## END definition ##}}

# {{## BEGIN overloads ##}}
proc ol(p: int): string = "You called the p:int version"
proc ol(q: int): string = "You called the q:int version"
proc ol(p: float): string = "You called the p:float version"
proc ol(p: int8): string = "You called the p:int8 version"
#echo ol(4)              # Error: ambiguity between p:int and q:int
echo ol(p=4)            # No error
echo ol(4.0)            # No error
echo ol(4'i8)           # No error
# {{## END overloads ##}}

# {{## BEGIN calling-1 ##}}
var f1 = fibonacci(5)
var f2 = 5.fibonacci()
echo "f1 == f2: ", f1 == f2

proc foo(a: string, b: string) =
  echo "foo ", a, " and ", b

var a = "hello"
var b = "world"
foo(a,b)
a.foo(b)
# {{## END calling-1 ##}}

# {{## BEGIN calling-2 ##}}
# Forward declaration
proc callme(x, y: int, s: string = "", c: char, b: bool = false)

# call with positional arguments      # parameter bindings:
callme(0, 1, "abc", '\t', true)       # (x=0, y=1, s="abc", c='\t', b=true)
# call with named and positional arguments:
callme(y=1, x=0, "def", '\t')         # (x=0, y=1, s="def", c='\t', b=false)
# call with named arguments (order is not relevant):
callme(c='\t', y=1, x=0)              # (x=0, y=1, s="", c='\t', b=false)
# call as a command statement: no () needed:
callme 0, 1, "ghi", '\t'              # (x=0, y=1, s="ghi", c='\t', b=false)
# {{## END calling-2 ##}}

proc callme(x, y: int, s: string = "", c: char, b: bool = false) =
    echo "x: ", x, " y: ", y, " s: ", s, " c: ", c, " b: ", b

# {{## BEGIN result ##}}
proc yes(question: string): bool =
  echo question, " (y/n)"
  var answered = false
  while answered != true:
    case readLine(stdin)
    of "y", "Y", "yes", "Yes": answered = true; result = true
    of "n", "N", "no", "No": answered = true; result = false
    else: echo "Please be clear: yes or no"

if yes("Should I delete all your important files?"):
  echo "I'm sorry Dave, I'm afraid I can't do that."
else:
  echo "I think you know what the problem is just as well as I do."

proc returnsInt(): auto = 1984
# {{## END result ##}}

# {{## BEGIN operators ##}}
# The "UFO" operator, doing all the comparisons at once
proc `<==>`(lhs, rhs: int): int =
  if lhs < rhs:
    result = -1
  elif lhs > rhs: 
    result = 1
  else: 
    result = 0

echo 5 <==> 6
echo 7 <==> 6
echo 6 <==> 6
echo `<==>`(4, 5)
# {{## END operators ##}}

# {{## BEGIN no-side-effects ##}}

# {{## END no-side-effects ##}}

# {{## BEGIN anonymous ##}}
import sequtils

let powersOfTwo = @[1, 2, 4, 8, 16, 32, 64, 128, 256]

echo(powersOfTwo.filter do (x: int) -> bool: x > 32)
echo powersOfTwo.filter(proc (x: int): bool = x > 32)

proc greaterThan32(x: int): bool = x > 32
echo powersOfTwo.filter(greaterThan32)

proc forEach(str: string, c: proc (x: int): int ) =
  for ch in str:
    echo c(ord(ch))
# {{## END anonymous ##}}

# {{## BEGIN sugar ##}}
import sugar

# sugar provides a "->" macro that simplifies writing type declarations
# e.x. (char) -> char instead of 
proc map(str: string, fun: (char) -> char): string =
  for c in str:
    result &= fun(c)

# sugar also provides a "=>" macro for the actual lambda value
echo "foo".map((c) => char(ord(c) + 1))
# the following code is exactly equivalent:
echo "foo".map(proc (c: char): char = char(ord(c) + 1))
# {{## END sugar ##}}
