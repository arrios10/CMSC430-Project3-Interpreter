/*
 Name: Andrew Rios
 Class: CMSC430
 Project: Project 3
 Date: 12/10/23
*/


// This file contains the bodies of the functions that produces the compilation
// listing

// Project 3
#include <cstdio>
#include <string>
#include <vector> 

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";

// error message variable 
static vector<string> errorQueue;

// error counters
static int totalErrors = 0;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	
	// display errors or 'Compiled Successfully'
    	if (totalErrors > 0) {
     	   	printf("Total Errors: %d\n", totalErrors);
     	   	printf("Lexical Errors: %d\n", lexicalErrors);
     	   	printf("Syntax Errors: %d\n", syntaxErrors);
     	   	printf("Semantic Errors: %d\n", semanticErrors);
     	} else {
     	   	printf("Compiled Successfully\n");
    	}

	printf("     \n");
	return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared " };

	error = messages[errorCategory] + message;
	
	errorQueue.push_back({error});

	totalErrors++;
	
	
	if (errorCategory == LEXICAL) {
			lexicalErrors++;
	} else if (errorCategory == SYNTAX) {
        		syntaxErrors++;
    	} else {
        		semanticErrors++;
    	}
	
}

void displayErrors()
{
	for (const string& error : errorQueue) {
        		printf("%s\n", error.c_str());
    	}
		
	errorQueue.clear();
}
