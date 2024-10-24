#ifndef FUNCA_H
#define FUNCA_H

class FuncA {
public:
    // Constructor
    FuncA();
    
    /*
        This function calculates the sum of the first n terms of the series expansion 
        for sqrt(1 + x).

        Parameters:
        - x: The input value to the series.
        - n: The number of terms to calculate.
        
        Returns:
        - The sum of the first n terms of the series expansion.
    */
    double calculate(double x, int n);
};

#endif // FUNCA_H


