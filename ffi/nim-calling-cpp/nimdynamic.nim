# Nim example using the C++ Person class from the *dynamic* (shared) library
# libperson.so (built by dynlib.sh). Does NOT compile person.cpp itself; links
# against the shared library at build time (and records an rpath so it runs
# in place).
#
# Build & run with:
#   nim cpp -r nimdynamic.nim

# {{## BEGIN declarations ##}}
# Link the shared library and embed an rpath to the current directory.
{.passL: "-L. -lperson -Wl,-rpath,'$ORIGIN'".}

type
  Person {.importcpp: "Person", header: "person.h".} = object

# Constructors exposed via Nim's constructor pragma.
proc newPerson(): Person {.importcpp: "Person()", constructor.}
proc newPerson(name: cstring): Person {.importcpp: "Person(@)", constructor.}

# Methods.
proc getName(p: Person): cstring {.importcpp: "#.getName().data()".}
proc setName(p: var Person, name: cstring) {.importcpp: "#.setName(@)".}
# {{## END declarations ##}}

when isMainModule:
  var ted = newPerson("Ted")
  echo "name = ", ted.getName()

  ted.setName("Edward")
  echo "name = ", ted.getName()

  var anon = newPerson()
  anon.setName("Anonymous")
  echo "name = ", anon.getName()
