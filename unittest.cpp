#include <cassert>
#include <cmath>
#include "FuncA.h"

void test_funca() {
    FuncA funcA;

    // Test 1: x = 0, n = 1
    assert(funcA.calculate(0, 1) == 1.0);

    // Test 2: x = 0.5, n = 1 
    double result = funcA.calculate(0.5, 1);
    double expected = 1.0; 
    assert(std::abs(result - expected) == 0.25);

}

int main() {
    test_funca();
    return 0;
}