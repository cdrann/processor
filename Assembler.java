import java.io.*;
import java.lang.Integer;

public class Assembler {

    public static String removeFirstTwoSymb(String s) {
        String res = s.substring(2);
        return res;
    }

    public static String printNZeroes(int n) {
        String s = "";
        for (int i = 0; i < n; i++) {
            s += "0";
        }
        return s;
    }

    //<single line of> assembly code -> machine code
    public static String parseCommand(String inputString, int numLines) {
        String[] code = inputString.split(" ");
        String result = "";
        //System.out.println(inputString); //TODO file_output

        //Determine the instruction and construct the machine code
        switch(code[0]) {
            case "SET":
                result = "0a";
                result += removeFirstTwoSymb(code[1]);
                break;
            case "ACC":
                result = "01";
                result += removeFirstTwoSymb(code[1]);
                break;
            case "STO":
                result = "02";
                result += removeFirstTwoSymb(code[1]);
                break;
            case "ADD":
                result = "03";
                result += removeFirstTwoSymb(code[1]);
                break;
            case "SUB":
                result = "04";
                result += removeFirstTwoSymb(code[1]);
                break;
            case "DIV":
                result = "05";
                result += removeFirstTwoSymb(code[1]);
                break;
            case "MUL":
                result = "06";
                result += removeFirstTwoSymb(code[1]);
                break;
            case "INC":
                result = "0b";
                result += "00";
                break;
            case "DEC":
                result = "0c";
                result += "00";
                break;
            case "INP":
                result = "09";
                result += "00";
                break;
            case "OUT":
                result = "00";
                result += "00";
                break;
            case "TST":
                result = "08";
                result += "00";
                break;
            /* case "JMP":
                if(code[1].equals("HERE")) {
                    String str = Integer.toHexString(numLines - 1);
                    result = printNZeroes(2 -  (str.substring(2)).length());
                    result += (Integer.toHexString(numLines - 1)).substring(2);
                } else if(code[1].equals("OFFSET")) {
                    String str = Integer.toHexString(numLines - 1 + Integer.parseInt(code[2]));
                    result = printNZeroes(2 -  (str.
                            substring(2)).length());
                    result += (Integer.toHexString(numLines - 1) + (Integer.parseInt(code[3]))).substring(2); // [2:]
                }
                break; */
             default:
                 //TODO
                 break;
        }
        return result;
    }

    //assembly code @input_file -> machine code @output_file
    public static void main(String args[]) throws IOException{
        File file = new File("/Users/Admin/IdeaProjects/HelloWorld/program.txt");
        FileReader fr = new FileReader(file);
        BufferedReader reader = new BufferedReader(fr);

        String binaryCode = "";
        PrintWriter writer = new PrintWriter("machine_code.txt");
        String cmd = reader.readLine();
        int numLines = 0;
        while (cmd != null) {
            numLines++;
            binaryCode = parseCommand(cmd, numLines);
            writer.println(binaryCode);
            cmd = reader.readLine();
        }

        while (numLines < 256) {
            numLines++;
            writer.println("0000");
        }
        reader.close();
        fr.close();
        writer.close();
    }
}
