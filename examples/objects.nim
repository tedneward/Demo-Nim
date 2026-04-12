echo "Objects"

# {{## BEGIN basic-syntax ##}}
type Person = object
    first_name: string
    last_name: string
    age: int

var ted = Person(first_name: "Ted", last_name: "Neward", age: 55)
echo ted    # "(first_name: "Ted", last_name: "Neward", age: 55)"
# {{## END basic-syntax ##}}

# {{## BEGIN properties ##}}
# Person fields are all inaccessible due to non-exported syntax

proc firstName*(p: Person): string = p.first_name
proc lastName*(p: Person): string = p.last_name
proc age*(p: Person): int = p.age

echo ted.firstName()  # or ted.firstName would work

proc `firstName=`*(p: var Person, newName: string) = p.first_name = newName
proc `lastName=`*(p: var Person, newName: string) = p.last_name = newName
#proc `age=`*(p: var Person, newAge: int) = p.age = age # This causes problems

ted.firstName = "Theodore"
echo ted
# {{## END properties ##}}

# {{## BEGIN dynamic-dispatch ##}}
type
  Expression = ref object of RootObj ## abstract base class for expressions
  Literal = ref object of Expression
    x: int
  PlusExpr = ref object of Expression
    a, b: Expression
proc newLit(x: int): Literal = Literal(x: x)
proc newPlus(a, b: Expression): PlusExpr = PlusExpr(a: a, b: b)

method eval(e: Expression): int {.base.} = quit "E_NOTIMPL"
method eval(e: Literal): int = e.x
method eval(e: PlusExpr): int = eval(e.a) + eval(e.b)

echo eval(newPlus(newPlus(newLit(1), newLit(2)), newLit(4)))
# {{## END dynamic-dispatch ##}}