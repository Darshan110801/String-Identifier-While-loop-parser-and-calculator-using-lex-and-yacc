%{
#include "y.tab.h"
#include<string.h>
extern void yyerror(char* s);

%}

%%

"while"              {return WHILE;}
[a-zA-Z]		   {yylval.identifier = yytext[0]; return id;}
[0-9]+               {yylval.val = atoi(yytext); return value;}
"=="                  {return EQ;}
"="        	   {return yytext[0];}
[(){}]             {return yytext[0];}
";"                 {return ';';}
[ \t\n]             {;}
.                       { 
                            char error[1000];
                            sprintf(error,"Error at token %s",yytext);
                            yyerror (error);
                        }

%%

int yywrap (void) {
    return 1;
}
