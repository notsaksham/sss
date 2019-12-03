%{
#include <stdio.h>
#include <stdlib.h>
int flag=0;
%}

%token ID NUM FOR LE GE EQ NE OR AND

%%
   
S         : ST {printf("Input accepted\n"); exit(0);};
ST       : FOR '(' E ';' E ';' E ')' DEF
           ;
DEF    : '{' BODY '}'
           | E';'
           | ST
           |
           ;
BODY  : BODY BODY
           | E ';'       
           | ST
           |            
           ;
       
E        : ID '=' E
          | E '+' E
          | E '-' E
          | E '*' E
          | E '/' E
          | E '<' E
          | E '>' E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | E '+' '+'
          | E '-' '-'
          | ID 
          | NUM
          |
          ;
 
%%


int main() {
    printf("Enter the expression:\n");
    yyparse();
    if(flag==0)
    	printf("Correct!!");
    else
    	printf("Incorrect!!");
    return 0;
}  

int yyerror()
{
	flag=1;
	return 0;
}
