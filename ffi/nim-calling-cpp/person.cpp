#include "person.h"

#include <iostream>

Person::Person() : _name("") {}

Person::Person(std::string name) : _name(name) {}

Person::~Person() { std::cout << "Person " << _name << " destroyed" << std::endl; }

std::string Person::getName() {
    return _name;
}
void Person::setName(std::string name) {
    _name = name;
}

