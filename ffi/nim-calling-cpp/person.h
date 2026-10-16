#pragma once
#include <string>

class Person {
    public:
        Person();
        Person(std::string name);
        ~Person();

        std::string getName();
        void setName(std::string name);

    private:
        std::string _name;
};

