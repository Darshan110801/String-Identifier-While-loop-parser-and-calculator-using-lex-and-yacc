#include<stdio.h>
#include "tokens.h"

extern int yylex();
extern int yylineno;
extern char* yytext;


char* string_patterns[] = {NULL, "STRING_HAVING_5TH_ELEMENT_AS_a","STRING_HAVING_LAST_LETTER_AS_p",
                        "STRING_ab", "STRING_HAVING_ONECAP_ONENUM_ONESPECIAL",
                        "STRING_HAVING_MY_NAME","STRING_WITH_LP","NEW_LINE_OR_TAB_OR_SPACE",
                        "INVALID_STRING"};

int main(int argc, char** argv)
{
  printf("Strings identified in a file are - \n\n");
  int token = yylex();
  while(token)
  {
     if(token != NEW_LINE_OR_TAB_OR_SPACE)
     {
        printf("%s\t\t%s\n\n",yytext,string_patterns[token]);
     }
     token  = yylex();
  }
  return 0;
}




