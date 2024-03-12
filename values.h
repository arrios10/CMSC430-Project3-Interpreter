/*
 Name: Andrew Rios
 Class: CMSC430
 Project: Project 3
 Date: 12/10/23
*/


// This file contains function definitions for the evaluation functions

typedef char* CharPtr;
enum Operators {LESS, ADD, MULTIPLY, SUBTRACT, DIVIDE, EQUAL, GREATER, GREATER_EQUAL, LESS_EQUAL, NOT_EQUAL};

double evaluateReduction(Operators operator_, double head, double tail);
double evaluateRelational(double left, Operators operator_, double right);
double evaluateArithmetic(double left, Operators operator_, double right);

