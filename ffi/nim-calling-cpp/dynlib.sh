#!/bin/bash

# Compile person.cpp into a position-independent object file.
gcc -std=c++17 -Wall -Wextra -fPIC -c person.cpp -o person.o

# Package the object into a dynamic (shared) library (link C++ runtime).
gcc -shared -o libperson.so person.o -lstdc++

# Compile cppmain.cpp against the dynamic library (set rpath so it runs in place).
gcc -std=c++17 -Wall -Wextra -o cppmain cppmain.cpp -L. -lperson -lstdc++ -Wl,-rpath,'$ORIGIN'
