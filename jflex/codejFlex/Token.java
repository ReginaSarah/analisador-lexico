/* Alunos: 
Henrique Colonese Echternarcht - 201835028
Regina Sarah Monferrari Amorim de Paula - 201835007
*/

public class Token {
      public int l, c;
      public TOKEN_TYPE t;
      public String lexeme;
      public Object info;

      public Token(TOKEN_TYPE t, String lex, Object o, int l, int c) {
            this.t = t;
            lexeme = lex;
            info = o;
            this.l = l;
            this.c = c;
      }

      public Token(TOKEN_TYPE t, String lex, int l, int c) {
            this.t = t;
            lexeme = lex;
            info = null;
            this.l = l;
            this.c = c;
      }

      public Token(TOKEN_TYPE t, Object o, int l, int c) {
            this.t = t;
            lexeme = "";
            info = o;
            this.l = l;
            this.c = c;
      }

      @Override
      public String toString() {
            return "[(" + l + "," + c + ") \"" + lexeme + "\" : <" + (info == null ? "" : info.toString()) + ">]";
      }

      private Boolean palavrasReservadas(){
            return (t == TOKEN_TYPE.LOGICO || t == TOKEN_TYPE.RETURN || t == TOKEN_TYPE.READPRINT || t == TOKEN_TYPE.SELECAO || t == TOKEN_TYPE.TYPE || t == TOKEN_TYPE.PARENTESES);
      }

      private Boolean operacoes(){
            String s = t.name();
            return (t == TOKEN_TYPE.RELACIONAL || t.equals(TOKEN_TYPE.EQ) || t.equals(TOKEN_TYPE.EQ) || 
            t.equals(TOKEN_TYPE.PLUS) || t.equals(TOKEN_TYPE.MINUS) || t.equals(TOKEN_TYPE.TIMES) || t.equals(TOKEN_TYPE.BARRA) || 
            t.equals(TOKEN_TYPE.MOD) || t.equals(TOKEN_TYPE.CONJUNCAO) || t.equals(TOKEN_TYPE.SEMI));
      }

      public String toStringLex() {
            String imprime = "";
            if (palavrasReservadas()) {
                  return lexeme.toUpperCase();
            }
            if(operacoes()){
                  return t.name();
            }
            imprime = t + ": ";
            if (lexeme == "") {
                  imprime += info.toString();
            } else {
                  imprime += lexeme;
            }
            return imprime;
      }

      public String toStringReal() {
            if (lexeme == "") {
                  return info.toString();
            }
            return lexeme;
      }
}
