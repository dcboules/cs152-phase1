   /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
   int line = 1;
   int column = 1;
%}

   /* some common rules */
DIGIT                [0-9]
IDENT                [a-zA-Z][a-zA-Z0-9_]*
COMMENT              (##(.)*)

%%
   /* specific lexer rules in regex */
{COMMENT}            { column += yyleng; }
function					{ printf("FUNCTION\n"); column += yyleng; }
beginparams					{ printf("BEGIN_PARAMS\n"); column += yyleng; }
endparams					{ printf("END_PARAMS\n"); column += yyleng; }
beginlocals					{ printf("BEGIN_LOCALS\n"); column += yyleng; }
endlocals					{ printf("END_LOCALS\n"); column += yyleng; }
beginbody					{ printf("BEGIN_BODY\n"); column += yyleng; }
endbody					{ printf("END_BODY\n"); column += yyleng; }
integer					{ printf("INTEGER\n"); column += yyleng; }
array					{ printf("ARRAY\n"); column += yyleng; }
enum					{ printf("ENUM\n"); column += yyleng; }
of					{ printf("OF\n"); column += yyleng; }
if					{ printf("IF\n"); column += yyleng; }
then					{ printf("THEN\n"); column += yyleng; }
endif					{ printf("ENDIF\n"); column += yyleng; }
else					{ printf("ELSE\n"); column += yyleng; }
for					{ printf("FOR\n"); column += yyleng; }
while					{ printf("WHILE\n"); column += yyleng; }
do					{ printf("DO\n"); column += yyleng; }
beginloop					{ printf("BEGINLOOP\n"); column += yyleng; }
endloop					{ printf("ENDLOOP\n"); column += yyleng; }
continue					{ printf("CONTINUE\n"); column += yyleng; }
read					{ printf("READ\n"); column += yyleng; }
write					{ printf("WRITE\n"); column += yyleng; }
and					{ printf("AND\n"); column += yyleng; }
or					{ printf("OR\n"); column += yyleng; }
not					{ printf("NOT\n"); column += yyleng; }
true					{ printf("TRUE\n"); column += yyleng; }
false					{ printf("FALSE\n"); column += yyleng; }
return					{ printf("RETURN\n"); column += yyleng; }
"-"					{ printf("SUB\n"); column += yyleng; }
"+"					{ printf("ADD\n"); column += yyleng; }
"*"					{ printf("MULT\n"); column += yyleng; }
"/"					{ printf("DIV\n"); column += yyleng; }
"%"					{ printf("MOD\n"); column += yyleng; }
"=="					{ printf("EQ\n"); column += yyleng; }
"<>"					{ printf("NEQ\n"); column += yyleng; }
"<"					{ printf("LT\n"); column += yyleng; }
">"					{ printf("GT\n"); column += yyleng; }
"<="					{ printf("LTE\n"); column += yyleng; }
">="					{ printf("GTE\n"); column += yyleng; }
";"					{ printf("SEMICOLON\n"); column += yyleng; }
":"					{ printf("COLON\n"); column += yyleng; }
","					{ printf("COMMA\n"); column += yyleng; }
"("					{ printf("L_PAREN\n"); column += yyleng; }
")"					{ printf("R_PAREN\n"); column += yyleng; }
"["					{ printf("L_SQUARE_BRACKET\n"); column += yyleng; }
"]"					{ printf("R_SQUARE_BRACKET\n"); column += yyleng; }
":="					{ printf("ASSIGN\n"); column += yyleng; }
{DIGIT}+          { printf("NUMBER %s\n", yytext); column += yyleng; }
{DIGIT}{IDENT}    { printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line, column, yytext); }
{IDENT}_          { printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line, column, yytext); }
{IDENT}           { printf("IDENT %s\n", yytext); column += yyleng; }
"\t"|" "          { column += yyleng; }
"\n"              { ++line; column = 1; }
.                 { printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", line, column, yytext); }

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
         yyin = stdin;
      }
   }
   else
   {
      yyin = stdin;
   }

   yylex();
}
