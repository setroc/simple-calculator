%{
    #include <stdio.h>
    #include "sintactico.tab.h"
%}
SEPARADOR ([ \t])+
NUM [0-9]+
REAL {NUM}\.{NUM} 

%%
{SEPARADOR}     { }    
"-"?{REAL}      {
                    printf("Numero real %s\n",yytext);
                    yylval.real = atof(yytext);
                    return (REAL);
                }
"-"?{NUM}           {
                    printf("Numero entero %s\n",yytext);
                    yylval.entero = atoi(yytext);
                    return (ENTERO);    
                }
"+"|"-"|"*"|"/" {
                    printf("Signo op\n");
                    return (yytext[0]);        
                }
"("|")"         {
                    printf("Signo parentesis\n");
                    return (yytext[0]);        
                }
","             {
                    printf("Coma\n");
                    return (yytext[0]);        
                }
[Mm][Oo][Dd]    {
                    printf("Modulo\n");
                    return (MOD);   
                }
"\n"            {
                    printf("Salto de linea\n");
                    return (yytext[0]);
                }
%%