%{
	#include<stdio.h>
	void yyerror(char *);
%}

%token INTEGER
%left '+' '-'
%left '*' '/'
%right UnaryMinus

%% 
line : line expr '\n' {printf("%d\n",$2);}
	|line '\n'
	|
	|error '\n' {yyerror("Re-enter previous line"); yyerrok;}
	;

expr: expr '+' expr{$$ = $1 + $3;}
	|expr '-' expr{$$ = $1 - $3;}
	|expr '*' expr{$$ = $1*$3;}
	|expr '/' expr{
	        if ($3==0){
			yyerror("divided 0 error!");
			getchar();
		}
		else{
			$$ = $1/$3;
		}
	}
	| '(' expr ')' {$$=$2;}
	|'-' expr %prec UnaryMinus {$$ = -$2;}
	|INTEGER {$$= $1;}
	;
	
%%
void yyerror( char *s)
{
	printf("%s\n", s);
}
int main(){
	yyparse();
	return 0;
}