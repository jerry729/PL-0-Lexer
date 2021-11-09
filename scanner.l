%{

#include "token.h"
int cur_line_num = 1;
void init_scanner();
void lex_error(char* msg, int line);

%}

INTEGER             ([0-9]+)
UNTERM_STRING       (\"[^"\n]*)
STRING              (\"[^"\n]*\")
IDENTIFIER          ([a-zA-z][_a-zA-z0-9]*)
OPERATOR            ([+*-/=#<>:(),;.])
SINGLE_COMMENT1     ("//"[^\n]*)

%%

[\n]                {cur_line_num++;}
[ \t\r\a]+             {/*ignore all spaces*/}
{SINGLE_COMMENT1}   {/*skip single line comment*/}

"<="                {return T_Le;}
">="                {return T_Ge;}
":="                {return T_Eq;}
"const"             {return constsym;}
"var"               {return varsym;}
"procedure"         {return procsym;}
"begin"             {return beginsym;}
"end"               {return endsym;}
"odd"               {return oddsym;}
"if"                {return ifsym;}
"then"              {return thensym;}
"call"              {return callsym;}
"while"             {return whilesym;}
"do"                {return dosym;}
"read"              {return readsym;}
"write"             {return writesym;}
{OPERATOR}          {return yytext[0];}
{INTEGER}           {return T_IntConstant;}
{STRING}            {return T_StringConstant;}
{IDENTIFIER}        {return T_Identifier;}

<<EOF>>             {return 0;}

{UNTERM_STRING}     {lex_error("Unterminated string constant", cur_line_num);}
.                   {lex_error("Unrecognized character", cur_line_num);}

%%

int main(int argc, char* argv[]){
    int token;
    init_scanner();
    while(token = yylex()){
        print_token(token);
        puts(yytext);
    }
    return 0;
}

void init_scanner(){
    printf("%-20s%s\n", "TOKEN_TYPE", "TOKEN_VALUE");
    printf("---------------------------------\n");
}

void lex_error(char* msg, int line){
    printf("\nFATAL ERROR at line %-3d: %s\n", line, msg);
}

int yywrap(void){
    return 1;
}