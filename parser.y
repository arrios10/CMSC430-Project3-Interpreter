/*
 Name: Andrew Rios
 Class: CMSC430
 Project: Project 3
 Date: 12/10/23
 File: Bison Input File
*/


/* Project 3 */

%{

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <cmath>

using namespace std;

#include "values.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<double> symbols;

double result;
double* params;
int param_index = 0;
double inherited_value; 

%}

%define parse.error verbose

%union
{
	CharPtr iden;
	Operators oper;
	double value;
}


%token <iden> IDENTIFIER

%token <oper> ADDOP MULOP RELOP REMOP EXPOP

%token ANDOP

%token IF THEN ELSE ENDIF

%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS RETURNS 

%token REDUCE REAL CASE ARROW OTHERS WHEN ENDCASE NOTOP OROP

%type <value> expression and_expression relation term factor primary unary exponent statement_ statement reductions body case cases

%type <oper> operator

%token <value> INT_LITERAL REAL_LITERAL BOOL_LITERAL TRUE FALSE

%%

function:	
	function_header optional_variable body {result = $3;};
	
function_header:
	FUNCTION IDENTIFIER parameters RETURNS type ';' |
	FUNCTION error ';'
	;
	

optional_variable:
	optional_variable variable | 
	error ';' | 
    	;
	
variable:
	IDENTIFIER ':' type IS statement_ {symbols.insert($1, $5);};

parameters:
       	| parameter_list
   	 ;

parameter_list:
	parameter |
	parameter_list ',' parameter
	;	

parameter:
	IDENTIFIER ':' type {symbols.insert($1, params[param_index++]);}
	;	

type:
	INTEGER |
	REAL |
	BOOLEAN;

body:
	BEGIN_ statement_ END ';' {$$ = $2;};
    
statement_:
	statement ';' { $$ = $<value>1; }|
	error ';' {$$ = 0;};
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE {$$ = $3;}|
	IF expression THEN statement_ ELSE statement_ ENDIF {$$ = $2 ? $4 : $6;}|
	CASE expression IS cases OTHERS ARROW statement_ ENDCASE {inherited_value = $2; $$ = !isnan($4) ? $4 : $7;};

operator:
    	ADDOP |
    	RELOP |
    	EXPOP |
    	MULOP ;

reductions:
	reductions statement_ {$$ = evaluateReduction($<oper>0, $1, $2);}|
	{$$ = $<oper>0 == ADD ? 0 : 1;}	;
	
cases:
	cases case {$$ = !isnan($1) ? $1 : $2;}| 
	{$$ = NAN; }
	;

case:
	WHEN INT_LITERAL ARROW statement_  {$$ = ($<value>1 == inherited_value) ? $<value>3 : NAN;};


expression:
	expression OROP and_expression {$$ = $1 || $3;}|
	and_expression ;
	
and_expression:
	and_expression ANDOP relation {$$ = $1 && $3;}|
	relation ;
		    		    

relation:
	relation RELOP term {$$ = evaluateRelational($1, $2, $3);}|
	term ;

term:
	term ADDOP factor {
        if ($2 == ADD)
            $$ = evaluateArithmetic($1, $2, $3);
        else if ($2 == SUBTRACT)
            $$ = evaluateArithmetic($1, $2, $3);
    }|
	factor ;
      
factor:
	factor MULOP exponent {
        if ($2 == MULTIPLY) 
            $$ = evaluateArithmetic($1, $2, $3);
        else if ($2 == DIVIDE)
            $$ = evaluateArithmetic($1, $2, $3);
    	}
    	| factor REMOP exponent {$$ = fmod($1, $3);}|
	exponent ;

exponent:
	unary EXPOP exponent {$$ = pow($1, $3);}|
	unary ; 

unary:
	NOTOP unary {$$ = !$2;}|
	primary ;


primary:
	'(' expression ')' {$$ = $2;}|
	INT_LITERAL |
	REAL_LITERAL {$$ = $1;}|
	BOOL_LITERAL | 
	IDENTIFIER {if (!symbols.find($1, $$)) appendError(UNDECLARED, $1);};


%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	params = new double[argc - 1]; 
    	
    	for (int i = 1; i < argc; i++) {
		params[i - 1] = atof(argv[i]); 
	}
	
	firstLine();
	yyparse();
	if (lastLine() == 0)
		cout << "Result = " << result << endl;
	
	delete[] params;
	return 0;
} 
