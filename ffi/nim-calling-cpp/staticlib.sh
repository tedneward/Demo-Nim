#!/bin/bash

# Compile person.cpp into an object file.
gcc -std=c++17 -Wall -Wextra -c person.cpp -o person.o

# Package the object file into a static library.
ar rcs libperson.a person.o

# Compile cppmain.cpp against the static library.
gcc -std=c++17 -Wall -Wextra -o cppmain cppmain.cpp -L. -lperson -lstdc++
