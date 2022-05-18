
 /*  Esta seção é copiada antes da declaração da classe do analisador léxico.
  *  É nesta seção que se deve incluir imports e declaração de pacotes.
  *  Neste exemplo não temos nada a incluir nesta seção.
  */
  
  
import java.util.Stack;
import java.util.ArrayList;

%%

%unicode
%line
%column
%class Palin
%function nextToken
%type Token

%{
    
    /* Código arbitrário pode ser inserido diretamente no analisador dessa forma. 
     * Aqui podemos declarar variáveis e métodos adicionais que julgarmos necessários. 
     */
    private ArrayList<Integer> stk;
    private String s; 
    
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
    
    private void checkPalin(){
        Testa se os dígitos no arrayList são palindromos. 
    }
%}

%init{
    ntk = 0; // Isto é copiado direto no construtor do lexer.
    stk = new Stack<Integer>();
%init}

  
  /* Agora vamos definir algumas macros */
  FimDeLinha  = \r|\n|\r\n
  Brancos     = {FimDeLinha} | [ \t\f]
  binDigit      = "0" | "1"
  identificador = [:lowercase:]
  LineComment = "//" (.)* {FimDeLinha}
  
%state COMMENT
%state BINARY

%%

<YYINITIAL>{
    {identificador} { return symbol(TOKEN_TYPE.ID);   }
    {binDigit}      { s = yytext() ; yybegin(BINARY);  }
    "="             { return symbol(TOKEN_TYPE.EQ);   }
    ";"             { return symbol(TOKEN_TYPE.SEMI); }
    "*"             { return symbol(TOKEN_TYPE.TIMES); }
    "+"             { return symbol(TOKEN_TYPE.PLUS); }
    "/*"            { yybegin(COMMENT);               }
    {Brancos}       { /* Não faz nada  */             }
    {LineComment}   {                       }
}

<COMMENT>{
   "*/"     { yybegin(YYINITIAL); } 
   [^"*/"]* {                     }
}

<BINARY>{
   [^{binDigit}]         { yybegin(YYINITIAL);checkPalin(); } 
   {binDigi}*            {  s = s + yytext();    }
   
}



[^]                 { throw new RuntimeException("Illegal character <"+yytext()+">"); }



