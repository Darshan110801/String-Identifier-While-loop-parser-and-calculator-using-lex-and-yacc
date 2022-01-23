%{

#include <stdio.h>
#include <stdlib.h>
int symbols[52];
int getValueOf( char var);
int setValueOf( char var,int val);
void yyerror(char* s);
int yylex();
%}
%union num{ int val; char identifier; }
%start LOOP
%token WHILE
%token EQ
%token ';'
%token <val> value
%token <identifier> id

%type <val> LOOP EXPRESSION EQUALITY_CHECKER 

%%
LOOP:WHILE'('EQUALITY_CHECKER')''{'LOOP'}'   { printf("\n\nLoop parsed successfully.\n\n"); exit(EXIT_SUCCESS);}
      |WHILE'('EQUALITY_CHECKER')''{'EXPRESSION'}' { printf("\n\nLoop parsed successfully.\n\n"); exit(EXIT_SUCCESS);}

EXPRESSION:id'='value';' {
                            setValueOf($1,$3); 
                            printf("%c assigned with value %d\n",$1,$3);
                            $$=$3;
                        }      

EQUALITY_CHECKER:value EQ value{
                                    $$ = ($1 == $3);
                                    printf("Equality of %d and %d is checked\n",$1,$3);
                                } 

                |value EQ id{
                                 $$ =($1 == getValueOf($3));
                                 printf("Equality of %d and %d is checked\n",$1,getValueOf($3));
                            }
                
                |id EQ id{
                            $$=(getValueOf($1) == getValueOf($3));
                            printf("Equality of %d and %d is checked\n",getValueOf($1),getValueOf($3));
                        }

                |id EQ value{
                                $$ =(getValueOf($1) == $3);
                                printf("Equality of %d and %d is checked\n",getValueOf($1),$3);

                            }
%%

int getValueOf(char var)
{
    int c = (int) var;
    int index = (c <= 90?c-65:c-71);
    return symbols[index];
}
int setValueOf(char var, int val)
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