/*
 Name: Andrew Rios
 Class: CMSC430
 Project: Project 3
 Date: 12/10/23
*/


// This file contains the function prototypes for the functions that produce the // compilation listing

// Project 3

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

