proc puts(str: cstring) {. importc, header: "stdio.h" .}
puts("Howdy world")

proc printf(format: cstring): cint {.importc, varargs, header: "stdio.h".}
discard printf("My name is %s and I am %d years old!\n", "Ted", 50)
