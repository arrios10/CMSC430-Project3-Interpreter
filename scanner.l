/*
 Name: Andrew Rios
 Class: CMSC430
 Project: Project 3
 Date: 12/10/23
*/


/* This file contains flex input file */

/* Project 3 */

%{
#include <string>
#include <vector>

using namespace std;

#include "values.h"
#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		\-\-.*\n
newcomment	\/\/.*\n
line		[\n]
id		[A-Za-z]([A-Za-z0-9]*_?[A-Za-z0-9]+)*
real_literal	[+-]?((([0-9]+\.[0-9]*|\.[0-9]+)([eE][+-]?[0-9]+)?)|[0-9]+[eE][+-]?[0-9]+)
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{newcomment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
{real_literal}	{ ECHO; yylval.value = atof(yytext); return(REAL_LITERAL); }
"<"		{ ECHO; yylval.oper = LESS; return(RELOP); }
"+"		{ ECHO; yylval.oper = ADD; return(ADDOP); }
"-"		{ ECHO; yylval.oper = SUBTRACT;return(ADDOP); }
"*"		{ ECHO; yylval.oper = MULTIPLY; return(MULOP); }
rem		{ ECHO; return(REMOP); }
begin		{ ECHO; return(BEGIN_); } 
boolean		{ ECHO; return(BOOLEAN); }
or		{ ECHO; return(OROP); }
not		{ ECHO; return(NOTOP); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
"=>"		{ ECHO; return(ARROW); }
case		{ ECHO; return(CASE); }
else		{ ECHO; return(ELSE); }
endcase		{ ECHO; return(ENDCASE); }
endif		{ ECHO; return(ENDIF); }
if		{ ECHO; return(IF); }
others		{ ECHO; return(OTHERS); }
real		{ ECHO; return(REAL); }
then		{ ECHO; return(THEN); }
when		{ ECHO; return(WHEN); }
true		{ ECHO; yylval.value = 1; return(BOOL_LITERAL); }
false		{ ECHO; yylval.value = 0; return(BOOL_LITERAL); }
{id}		{ ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
			strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{int}		{ ECHO; yylval.value = atof(yytext); return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
"="		{ ECHO; yylval.oper = EQUAL; return(RELOP); }
"/="		{ ECHO; yylval.oper = NOT_EQUAL; return(RELOP); }
">"		{ ECHO; yylval.oper = GREATER;return(RELOP); }
">="		{ ECHO; yylval.oper = GREATER_EQUAL;return(RELOP); }
"<="		{ ECHO; yylval.oper = LESS_EQUAL;return(RELOP); }
"/"		{ ECHO; yylval.oper = DIVIDE; return(MULOP); }
"**"		{ ECHO; return(EXPOP); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%
