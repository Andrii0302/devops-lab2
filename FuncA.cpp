#include "FuncA.h"

// Constructor
FuncA::FuncA() {}

// Function to calculate the series expansion of sqrt(1 + x)
double FuncA::calculate(double x, int terms) {
    double result = 1.0;  // First term in the series (for n=0)
    double term = 1.0;    // Holds the current term

    for (int n = 1; n <= terms; ++n) {
        // Calculate the next term in the series
        term *= (-1.0) * x / (2.0 * n);  // Recursive calculation
        result += term;
    }
    
    return result;
}

