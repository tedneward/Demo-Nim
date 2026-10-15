#include <string>

class Person {
    public:
        Person();
        Person(std::string name);

        std::string getName();
        void setName(std::string name);

    private:
        std::string _name;
};

