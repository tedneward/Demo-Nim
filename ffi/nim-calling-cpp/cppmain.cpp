#include "person.h"

#include <iostream>

int main() {
    Person p;
    p.setName("John");
    std::cout << p.getName() << std::endl;
    return 0;
}
