// staticperson.cpp
//
// Uses the static library built from person.nim (libperson.a) to create a
// Person named "Lloyd" and print its name to stdout.
//
// Compile and link (run after ./static.sh):
//   g++ -std=c++17 -Wall -Wextra -o staticperson staticperson.cpp ./libperson.a -lpthread -ldl -lm
//
// Compile with the Nim cache directory plus all of g++'s standard search paths:
//   g++ -std=c++17 -Wall -Wextra \
//     -I"$NIMCACHE" \
//     -I/usr/local/include \
//     -o staticperson staticperson.cpp ./libperson.a -lpthread -ldl -lm
//
// (On macOS you may also need: -framework CoreFoundation -framework Security)
//
// Run:
//   ./staticperson

#include <cstdio>

int main() {
  NimMain();

  Person* p = person_new("Lloyd");
  std::printf("%s\n", person_name(p));
  person_free(p);
  return 0;
}
