/* Alunos: 
Henrique Colonese Echternarcht - 201835028
Regina Sarah Monferrari Amorim de Paula - 201835007
*/

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;


public class Main{
     public static void main(String args[]) throws IOException{
          HashMap<Integer, String> tokens = new HashMap<Integer, String>();
          LextTest lx = new LextTest(new FileReader(args[0]));
          Token t = lx.nextToken();
          int i = 0;
          while(t != null){
               String s = t.toStringLex();
              System.out.println(s);
              t= lx.nextToken();
              tokens.put(i, s);
              i++;
          }
          System.out.println("Total de tokens lidos " + lx.readedTokens());
          //System.out.println(tokens);
     }

     
}
