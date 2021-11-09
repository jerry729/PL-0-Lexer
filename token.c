#include <stdio.h>
#include "token.h"

void print_token(int token){
    char* token_strs[] = {
        "T_Le", "T_Ge", "T_Eq", "T_IntConstant", "T_StringConstant", "T_Identifier",
        "constsym"," varsym", "procsym", "beginsym", "endsym", "oddsym", "ifsym", "thensym", 
        "callsym", "whilesym", "dosym", "readsym", "writesym"
    };
    if(token < 256){
        printf("%-20c", token);
    }else{
        printf("%-20s", token_strs[token-256]);
    }
}