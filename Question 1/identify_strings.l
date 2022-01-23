%{
 #include"tokens.h"
%}
%%

^.{4}"a".*$   {return STRING_HAVING_5TH_ELEMENT_AS_a ;}

^.*"p"$       {return STRING_HAVING_LAST_LETTER_AS_p ;}

^"ab"$        {return STRING_ab;}

^([A-Z][^a-zA-Z0-9][0-9]|[A-Z][0-9][^a-zA-Z0-9]|[0-9][A-Z][^a-zA-Z0-9]|[0-9][^a-zA-Z0-9][A-Z]|[^a-zA-Z0-9][A-Z][0-9]|[^a-zA-Z0-9][0-9][A-Z])$  {return STRING_HAVING_ONECAP_ONENUM_ONESPECIAL;}

^.*"Darshan".*$  {return STRING_HAVING_MY_NAME;}

^.*"LP".*$        {return STRING_WITH_LP;}

[ \t\n]           {return NEW_LINE_OR_TAB_OR_SPACE;}
.           {return INVALID_STRING}

%%

int yywrap(void)
{
    return 1;
}