// Pull in the header that Nim generated
extern "C" {
    #include "calc.h" 
}

class Calculator {
private:
    // The actual Nim data structure
    NimCalculator m_calc;

public:
    // Constructor wraps the Nim initializer
    Calculator(double initialValue) {
        m_calc = init_calculator(initialValue);
    }

    // Wrap the method calls seamlessly
    void add(double amount) {
        ::add(&m_calc, amount); // Nim expects 'var' types as pointers
    }

    double getValue() const {
        return ::getValue(m_calc);
    }
};

// main.cpp
#include <iostream>

int main() {
    NimMain(); // Initialize Nim runtime

    Calculator calc(10.0);
    calc.add(5.5);
    
    std::cout << "Result: " << calc.getValue() << std::endl; // Outputs 15.5
    return 0;
}

