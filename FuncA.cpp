#include "FuncA.h"

// Constructor
FuncA::FuncA() {}

// Function to calculate the sum of the first 3 elements of the series for sqrt(1 + x)
double FuncA::calculate(double x, int n) {
    double result = 1.0;  // First term in the series (for n=0)
    double term = 1.0;    // Holds the current term

    // Limit calculation to the first 3 terms
    for (int i = 1; i <= 3; ++i) {
        term *= (-1.0) * x / (2.0 * i);  // Update the term in series expansion
        result += term;  // Add to the result
    }

    return result;
}

