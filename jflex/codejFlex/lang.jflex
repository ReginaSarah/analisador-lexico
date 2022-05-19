
 /*  Esta seção é copiada antes da declaração da classe do analisador léxico.
  *  É nesta seção que se deve incluir imports e declaração de pacotes.
  *  Neste exemplo não temos nada a incluir nesta seção.
  */

  /* Alunos: 
    Henrique Colonese Echternarcht - 201835028
    Regina Sarah Monferrari Amorim de Paula - 201835007
  */
  
%%

%unicode
%line
%column
%class LextTest
%function nextToken
%type Token

%{
    
    /* Código arbitrário pode ser inserido diretamente no analisador dessa forma. 
     * Aqui podemos declarar variáveis e métodos adicionais que julgarmos necessários. 
     */
    private int ntk;
    
    public int readedTokens(){
       return ntk;
    }
    private Token symbol(TOKEN_TYPE t) {
        ntk++;
        return new Token(t,yytext(), yyline+1, yycolumn+1);
        
    }
    private Token symbol(TOKEN_TYPE t, Object value) {
        ntk++;
        return new Token(t, value, yyline+1, yycolumn+1);
    }
    private int ntks;

    private void incTks() { ++ntks; }
    private int numTokens() { return ntks; }
        
%}

%init{
    ntk = 0; // Isto é copiado direto no construtor do lexer. 
    
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

selecao = "if" | "then" | "else" | "while"

btype = "Int" | "Char" | "Bool" | "Float"

separadores = "," | ":" | "::"


LineComment = "//" (.)* {FimDeLinha}
FimDeLinha  = \r | \n | \r\n
Brancos     = {FimDeLinha} | [ \t\f]
  
%state COMMENT

%%

<YYINITIAL>{

    {logico}                {  return symbol(TOKEN_TYPE.LOGICO);  }
    {return}                {  return symbol(TOKEN_TYPE.RETURN);  }
    {leituraescrita}        {  return symbol(TOKEN_TYPE.READPRINT);  }
    {selecao}               {  return symbol(TOKEN_TYPE.SELECAO);  } 
    {btype}                 {  return symbol(TOKEN_TYPE.TYPE);  }
    {parenteses}            { return symbol(TOKEN_TYPE.PARENTESES); } 


    {identificador}         { return symbol(TOKEN_TYPE.ID);   }
    {nomeDeTipo}            { return symbol(TOKEN_TYPE.IDNOME);   }
    {numero}                { return symbol(TOKEN_TYPE.INT, Integer.parseInt(yytext()) );  }
    {pontoFlutuante}        { return symbol(TOKEN_TYPE.FLOAT, Float.parseFloat(yytext()) );  }
    {caractere}             { return symbol(TOKEN_TYPE.CARACTERE);  }
    {separadores}           { return symbol(TOKEN_TYPE.SEPARADOR);  }


    {relacional}            { return symbol(TOKEN_TYPE.RELACIONAL);  }  
    "="                     { return symbol(TOKEN_TYPE.EQ);   }
    ";"                     { return symbol(TOKEN_TYPE.SEMI); }
    "*"                     { return symbol(TOKEN_TYPE.TIMES); }
    "+"                     { return symbol(TOKEN_TYPE.PLUS); }
    "-"                     { return symbol(TOKEN_TYPE.MINUS); }
    "/"                     { return symbol(TOKEN_TYPE.BARRA); }
    "%"                     { return symbol(TOKEN_TYPE.MOD);  }
    "&&"                    { return symbol(TOKEN_TYPE.CONJUNCAO);  }

    "/*"                    { yybegin(COMMENT);               }
    {Brancos}               { /* Não faz nada  */             }
    {LineComment}           {                       }

}

<COMMENT>{
   "*/"     { yybegin(YYINITIAL); } 
   [^"*/"]* {                     }
}



[^]                 { throw new RuntimeException("Illegal character <"+yytext()+">"); }



