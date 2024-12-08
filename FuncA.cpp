#include "FuncA.h"
#include <cmath>

// Constructor
FuncA::FuncA() {}

// Function to calculate the sum of the first n elements of the series for sqrt(1 + x)
/*
    This function calculates the sum of the first n terms of the infinite series expansion 
    for sqrt(1 + x).

    Parameters:
    - x: The input value to the series.
    - n: The number of terms to calculate.

    Returns:
    - The sum of the first n terms of the series expansion.
*/
double FuncA::calculate(double x, int n) {
    double result = 1.0;  // First term in the series (for n=0)
    double term = 1.0;    // Holds the current term

    // Loop to calculate the first n terms of the series
    for (int i = 1; i <= n; ++i) {
        term *= (-1.0) * x / (2.0 * i);  // Update the term in series expansion
        result += term;  // Add to the result
    }
    return result;
}

