%option noyywrap
%{
#include<stdio.h>
#include<string.h>
int i;
int visited[4]={0};
struct opcode
{
	char operand[10];
	char opcode[10];
};
struct opcode ref[4]={{"add ","0C"},{"sub ","0D"},{"lda ","AB"},{"sta ","18"}};
struct optab
{
    char res_operand[10];
    char res_opcode[10];
};
struct optab s[10];
int j=0;

void extract(char opc[10])
{  
    for(i=0;i<4;i++)
    {
        if(!strcmp(ref[i].operand,opc) && visited[i]==0)
        {
            
            for(int k=0;k<3;k++)
            {
                s[j].res_operand[k]=opc[k];
                s[j].res_opcode[k]=ref[i].opcode[k];
            }
            j++;
            visited[i]=1;
        }
    }   
}
%}
%%
"lda "|"sta "|"add "|"sub "|"start "|"end "|"word "|"resw " {extract(yytext);}
[a-zA-Z]* ;
[0-9]+ ;
[\n] ;
. ;
%%
int main()
{
	yyin=fopen("sic.asm","r");
    yylex();
	printf("\n\n----OPTAB CONTENTS\n");
	printf("INSTRUCTION\tOPCODE\n");
	for(int i=0; i<j; i++)
	{
		printf("\n%s\t\t%s",s[i].res_operand,s[i].res_opcode);
	}
	printf("\n");
	return 0;
}
