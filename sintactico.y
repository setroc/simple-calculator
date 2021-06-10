%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
%}

%union {
    int entero;
    float real;
}
%token <entero> ENTERO 
%token <real> REAL 
%token MOD
%type <entero> expEntera
%type <real> expReal

%left '+' '-'
%left '*' '/' MOD

%%

input: /* cadena vacia */ | input line ;

line:    '\n' 
        | expEntera '\n' {printf("\tResultado: %f\n",$1);} 
        | expReal '\n' {printf("\tResultdao: %f\n",$1);}

expReal:     REAL {$$ = $1;}
            | expReal '+' expReal {$$ = $1 + $3;}
            | expReal '-' expReal {$$ = $1 - $3;}
            | expReal '*' expReal {$$ = $1 * $3;}
            | expReal '/' expReal {$$ = $1 / $3;}
            | expEntera '+' expReal {$$ = $1 + $3;}
            | expEntera '-' expReal {$$ = $1 - $3;}
            | expEntera '*' expReal {$$ = $1 * $3;}
            | expEntera '/' expReal {$$ = $1 / $3;}
            | expReal '+' expEntera {$$ = $1 + $3;}
            | expReal '-' expEntera {$$ = $1 - $3;}
            | expReal '*' expEntera {$$ = $1 * $3;}
            | expReal '/' expEntera {$$ = $1 / $3;}
            | MOD '(' expEntera ',' expReal ')' {$$ = fmod($3,$5);}
            | MOD '(' expReal ',' expEntera ')' {$$ = fmod($3,$5);}
            | MOD '(' expReal ',' expReal ')' {$$ = fmod($3,$5);}
            | expEntera '/' expEntera { $$ = (float)$1 / $3; } 
            
expEntera:    ENTERO {$$ = $1;} 
            | expEntera '+' expEntera { $$ = $1 + $3; } 
            | expEntera '-' expEntera { $$ = $1 - $3; } 
            | expEntera '*' expEntera { $$ = $1 * $3; } 
            | MOD '(' expEntera ',' expEntera ')' { $$ = $3 % $5; } 

%%
int main(){ 
    yyparse();
}
yyerror(char *s) {
    printf("--- %s ---\n", s);
}
int yywrap() {
    return 1;
}

