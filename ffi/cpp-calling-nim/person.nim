type Person* = object
  first_name*: string

# You must initialize the Nim runtime if you use strings, sequences, 
# or garbage-collected types.
proc NimMain() {.importc.}

proc initNimLibrary*() {.exportcpp, cdecl.} =
  NimMain()

proc addNumbers*(a: cint, b: cint): cint {.exportcpp, cdecl.} =
  result = a + b

proc personNew(firstName: cstring): ptr Person {.exportc: "person_new".} =
  result = cast[ptr Person](allocShared0(sizeof(Person)))
  result.first_name = $firstName

proc personName(p: ptr Person): cstring {.exportc: "person_name".} =
  result = p.first_name.cstring

proc personFree(p: ptr Person) {.exportc: "person_free".} =
  discard
