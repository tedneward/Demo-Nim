# Nim example using the C++ Person class defined in person.h/person.cpp.
#
# Build & run with:
#   nim cpp -r nimperson.nim

{.compile: "person.cpp".}

type
  Person {.importcpp: "Person", header: "person.h".} = object

# Constructors exposed via Nim's constructor pragma.
proc newPerson(): Person {.importcpp: "Person()", constructor.}
proc newPerson(name: cstring): Person {.importcpp: "Person(@)", constructor.}

# Methods.
proc getName(p: Person): cstring {.importcpp: "#.getName().data()".}
proc setName(p: var Person, name: cstring) {.importcpp: "#.setName(@)".}

when isMainModule:
  var ted = newPerson("Ted")
  echo "name = ", ted.getName()

  ted.setName("Edward")
  echo "name = ", ted.getName()

  var anon = newPerson()
  anon.setName("Anonymous")
  echo "name = ", anon.getName()
