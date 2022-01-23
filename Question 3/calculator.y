%{

#include <stdio.h>
#include <stdlib.h>
#include<math.h>

float symbols[52];
float getValueOf( char var);
int setValueOf( char var,float val);
void yyerror(char* s);
int yylex();
%}

%union num{ float val; char identifier; }
%token print bye
%start START
%token ';'


%right '='
%left '-''+'
%left '*''/''%'
%right '^'
%left'('')'



%token <val> value
%token <identifier> id
%type <val> E

%%

START:print'('E')'';'  { printf("%f\n",$3); }
	|E';'  {;}
	|bye';'  {printf("Bye user !!!\n");exit(EXIT_SUCCESS);};
	|START print'('E')'';' {printf("%f\n",$4);}
	|START E';'  {;}
	|START bye';'  {printf("Bye user !!!\n");exit(EXIT_SUCCESS);};


E:E'+'E 	{ $$ = $1+$3; } 
  |E'-'E 	{ $$ = $1-$3; }
  |E'*'E 	{ $$ = $1*$3; }
  |E'/'E 	{ if($3 == 0){yyerror("Denominator can't be 0"); exit(EXIT_FAILURE);} $$ = $1/$3; } 
  |E'^'E 	{ $$ = pow($1, $3); }
  |E'%'E 	{ 
  		  if(floor($1) != $1 || floor($3) != $3){yyerror("Invalid 'float' operands for '%' operator");exit(EXIT_FAILURE);}
  		  if($3 == 0){yyerror("Denominator can't be 0"); exit(EXIT_FAILURE);} 
  	          $$ = (int)$1%(int)$3; 
  		}
  |id'='E 	{ setValueOf($1,$3); $$=$3; }
  |'('E')'		{ $$ = $2; }
  |id 		{ $$=getValueOf($1); }
  |value 		{ $$=$1; };
  
  


%%

float getValueOf(char var)
{
    int c = (int) var;
    int index = (c <= 90?c-65:c-71);
    return symbols[index];
}
int setValueOf(char var, float val)
{
    int c = (int) var;
    int index = (c <= 90?c-65:c-71);
    return symbols[index] = val; 
}
void yyerror( char*s)
{
    fprintf(stderr,"%s\n",s);
}
int main()
{
    int i;
    for(i=0;i<52;i++)
    {
        symbols[i] = 0;
    }
   
    yyparse();
}
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
