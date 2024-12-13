%{
#include "y.tab.h"
%}

%option yylineno

digit [0-9]
name  [a-zA-Z_][a-zA-Z_0-9]*

%%
"goto"              { return GOTO; }
"if"                { return IF; }

"%".*               { strcpy(yylval.nd_obj.name, yytext + 1); return ASM; } // plus 1 because of percentage sign, same for others with preceeding symbols
"$"{digit}+         { strcpy(yylval.nd_obj.name, yytext + 1); return MEM; }

"=="                { return EQ_OP; }
"!="                { return NE_OP; }

"~|"                { return BW_NOR; }
"~&"                { return BW_NAND; }
"~^"                { return BW_XNOR; }

{digit}+            { strcpy(yylval.nd_obj.name, yytext); return INTLIT; }
{name}              { strcpy(yylval.nd_obj.name, yytext); return IDENT; }

" "                 { ; }
[\t]*               { ; }
\r?[\n]             { yylineno++; }
\/\/.*              { ; }
\/\*(.|\n)*\*\/     { ; }
.                   { return *yytext; }
%%

int yywrap() {
    return 1;
}
