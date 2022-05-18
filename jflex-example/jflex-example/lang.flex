
  /*  Esta seção é copiada antes da declaração da classe do analisador léxico gerado.
  *  É nesta seção que se deve incluir imports e declaração de pacotes.
  *  Neste exemplo não temos nada a incluir nesta seção.
  */

%%

  /* Nesta seção são definidas ERs e configurações da ferramenta */

%unicode
%line
%column
%class Lexer

// %function nextToken : nome da funções
// %type Token : tipo do Token retornado
%standalone // somente léxico, sem sintático


%{
  private int ntks;

  private void incTks() { ++ntks; }
  private int numTokens() { return ntks; }
  
%}

%init{
  ntks = 0; // copiado para o construtor
%init}

/* Agora vamos definir algumas macros */

dot = "."
lower = [:lowercase:] [:lowercase:]*
upper = [:uppercase:] [:uppercase:]*

logico = "true" | "false"

numero      = [:digit:]+
pontoFlutuante = [:digit:]+("."[:digit:]+)

identificador = {lower}+(""[:digit]*) | {lower}+("_"[:digit:]*)
nomeDeTipo = [:uppercase:] {lower} | [:uppercase:]*
caractere = "'"+[:lowercase:]+"'" | "'"+[:uppercase:]+"'" | "'"+"\\"+"'"

parenteses = "[" | "]" | "(" | ")" | "." | "{" | "}"

relacional = "<" | ">" | ">=" | "<=" | "==" | "!=" 

return = "return"

leituraescrita = "read" | "print"

selecao = "if" | "then" | "else"

btype = "Int" | "Char" | "Bool" | "Float"

separadores = "," | ":" | "::"


LineComment = "//" (.)* {FimDeLinha}
FimDeLinha  = \r | \n | \r\n
Brancos     = {FimDeLinha} | [ \t\f]

%state COMMENT

%%

<YYINITIAL>{ 
    {logico}          { System.out.println("LÓGICO: " + yytext());          incTks();  }
    {return}          { System.out.println(yytext().toUpperCase());         incTks();  }
    {leituraescrita}  { System.out.println(yytext().toUpperCase());         incTks();  }
    {selecao}         { System.out.println(yytext().toUpperCase());         incTks();  } 
    {btype}           { System.out.println(yytext());                       incTks();  }   
    {identificador}   { System.out.println("ID: " + yytext());              incTks();  }
    {nomeDeTipo}      { System.out.println("ID: " + yytext());              incTks();  }
    {numero}          { System.out.println("INT: " + yytext());             incTks();  }
    {pontoFlutuante}  { System.out.println("FLOAT: " + yytext());           incTks();  }   
    {caractere}       { System.out.println("CARACTERE: " + yytext());       incTks();  }  
    {parenteses}      { System.out.println(yytext());                       incTks();  } 
    {relacional}      { System.out.println("RELACIONAL: " + yytext());      incTks();  }  
    "="               { System.out.println("EQ: " + yytext());              incTks();  }
    ";"               { System.out.println("SEMI: " + yytext());            incTks();  }
    "*"               { System.out.println("MULTIPLICAÇÃO: " + yytext());   incTks();  }
    "+"               { System.out.println("ADIÇÃO: " + yytext());          incTks();  }
    "-"               { System.out.println("SUBTRAÇÃO: " + yytext());       incTks();  }
    "/"               { System.out.println("DIVISAO: " + yytext());         incTks();  }
    "%"               { System.out.println("RESTO: " + yytext());           incTks();  }
    "&&"              { System.out.println("CONJUNÇÃO: " + yytext());       incTks();  }
    {separadores}     { System.out.println("SEPARADOR: " + yytext());       incTks();  }
    "/*"              { yybegin(COMMENT);                                              }
    {Brancos}         { /* Não faz nada - Skip */                                      }
    {LineComment}     {                                                                }
}

<COMMENT>{
   "*/"     { yybegin(YYINITIAL); } 
   [^"*/"]  {                     }
}

// erros
[^]                 { throw new RuntimeException("Illegal character <"+yytext()+">"); }