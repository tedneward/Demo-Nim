#!/bin/bash

NIMCACHE=$HOME/.cache/nim

# Compile person.nim into a static library (libperson.a) usable from C++.
nim cpp -d:release --app:staticLib --noMain person.nim

# Generate the header
nim cpp --header:nimperson.h --noMain --noLinking person.nim

# Compile staticperson.cpp and link it with the static library
#g++ -std=c++17 -Wall -Wextra -I$NIMCACHE/person_d -o staticperson staticperson.cpp ./libperson.a -lpthread -ldl -lm
g++ -std=c++17 -Wall -Wextra -I"$NIMCACHE/person_d" -I/usr/local/include \
    -o staticperson staticperson.cpp ./libperson.a -lpthread -ldl -lm
