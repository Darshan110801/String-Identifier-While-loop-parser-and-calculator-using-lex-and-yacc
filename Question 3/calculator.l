%{
	#include"y.tab.h"
	#include<stdlib.h>
	extern void yyerror(char* s);
%}

%%
"print"		 {return print;}
"bye" 			 {return bye;}

[a-z][A-Za-z0-9]+ {printf("variable should be of single character only.\n"); exit(EXIT_FAILURE);}
[a-zA-Z]		 {yylval.identifier = yytext[0]; return id;}
[0-9]+("."[0-9]+)?                 {yylval.val = atof(yytext); return value;}
[ \t\n]		 {;}
[-()+*/%^=;]	        {return yytext[0];}
.		        {ECHO; printf("Unexpected token %s",yytext);exit(EXIT_FAILURE);}

%%

int yywrap(void)
{
   return 1;
}
