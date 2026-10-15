#include "person.h"

Person::Person() : _name("") {}

Person::Person(std::string name) : _name(name) {}

std::string Person::getName() {
    return _name;
}
void Person::setName(std::string name) {
    _name = name;
}

