%{
	#include<stdio.h>
	#include "y.tab.h"
%}

%%
[0-9]+ {yylval = atoi(yytext);
	return INTEGER;
}
[ \t ]+   ; /* skip whitespace */
.|\n {return yytext[0];}
%%
int yywrap(void)
{
	return 1;
}
