#include <iostream>
#include "FuncA.h"
int CreateHTTPserver();
int main() {
    // Create an instance of FuncA
    FuncA myFunc;

    // Input value for x and number of terms in the series
    double x;
    int terms;

    std::cout << "Enter a value for x: ";
    std::cin >> x;

    std::cout << "Enter the number of terms to calculate in the series: ";
    std::cin >> terms;

    // Call the calculate function and output the result
    double result = myFunc.calculate(x, terms);
    std::cout << "The result of the series expansion for sqrt(1 + " << x << ") is: " << result << std::endl;
    CreateHTTPserver();
    return 0;
}

