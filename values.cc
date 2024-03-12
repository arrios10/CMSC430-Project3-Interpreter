/*
 Name: Andrew Rios
 Class: CMSC430
 Project: Project 3
 Date: 12/10/23
*/


// This file contains the bodies of the evaluation functions

#include <string>
#include <vector>
#include <cmath>

using namespace std;

#include "values.h"
#include "listing.h"

double evaluateReduction(Operators operator_, double head, double tail)
{
	if (operator_ == ADD)
		return head + tail;
	return head * tail;
}


double evaluateRelational(double left, Operators operator_, double right)
{
	double result;
	switch (operator_)
	{
		case LESS:
			result = left < right;
			break;
		case EQUAL:
            		result = (left == right) ? 1 : 0;
            		break;
            	case NOT_EQUAL:
       		     	result = (left != right) ? 1 : 0;
       		     	break;
        	case GREATER:
        		result = (left > right) ? 1 : 0;
	 	        break;
        	case GREATER_EQUAL:
			result = (left >= right) ? 1 : 0;
 	           	break;
	        case LESS_EQUAL:
	            	result = (left <= right) ? 1 : 0;
        	    	break;
	}
	return result;
}

double evaluateArithmetic(double left, Operators operator_, double right)
{
	double result;
	switch (operator_)
	{
		case ADD:
			result = left + right;
			break;
		case MULTIPLY:
			result = left * right;
			break;
		case SUBTRACT:
            		result = left - right;
            		break;
            	 case DIVIDE: 
            	 	if (right != 0)
                	result = left / right;
                	break;
                	}
                		
	return result;
}


