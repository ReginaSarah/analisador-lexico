import java.util.HashMap;


public class Main {
    public static void main(String[] argv) {
        HashMap<Integer, Lexer> tokens = new HashMap<Integer, Lexer>();
        if (argv.length == 0) {
          System.out.println("Usage : java Lexer [ --encoding <name> ] <inputfile(s)>");
        }
        else {
          int firstFilePos = 0;
          String encodingName = "UTF-8";
          if (argv[0].equals("--encoding")) {
            firstFilePos = 2;
            encodingName = argv[1];
            try {
              // Side-effect: is encodingName valid?
              java.nio.charset.Charset.forName(encodingName);
            } catch (Exception e) {
              System.out.println("Invalid encoding '" + encodingName + "'");
              return;
            }
          }
          for (int i = firstFilePos; i < argv.length; i++) {
            Lexer scanner = null;
            try {
              java.io.FileInputStream stream = new java.io.FileInputStream(argv[i]);
              java.io.Reader reader = new java.io.InputStreamReader(stream, encodingName);
              scanner = new Lexer(reader);
              int j = 0;
              while ( !scanner.zzAtEOF ) {
                  scanner.yylex();
                  tokens.put(j, scanner);
                  j++;
                  
              }
              System.out.println("oi");
            }
            catch (java.io.FileNotFoundException e) {
              System.out.println("File not found : \""+argv[i]+"\"");
            }
            catch (java.io.IOException e) {
              System.out.println("IO error scanning file \""+argv[i]+"\"");
              System.out.println(e);
            }
            catch (Exception e) {
              System.out.println("Unexpected exception:");
              e.printStackTrace();
            }
          }
        }
      }
    
}
