import java.io.*;
import java.lang.Integer;

public class Assembler {

    // decimal number[inputString] -> a 4-bit binary String[outputString]
    public static String convertToBinary (String inputString) {
        int num = Integer.parseInt(inputString);
        String outputString = Integer.toBinaryString(num);

        if(outputString.length() == 1)
            outputString = "000" + outputString;
        else if(outputString.length() == 2)
            outputString = "00" + outputString;
        else if(outputString.length() == 3)
            outputString = "0" + outputString;

        return outputString;
    }

    // decimal number -> 5-bit binary string
    public static String toBinary5 (String inputString) {
        int num = Integer.parseInt(inputString);
        String outputString = Integer.toBinaryString(num);

        if(outputString.length() == 1)
            outputString = "0000" + outputString;
        else if(outputString.length() == 2)
            outputString = "000" + outputString;
        else if(outputString.length() == 3)
            outputString = "00" + outputString;
        else if(outputString.length() == 4)
            outputString = "0" + outputString;

        return outputString;
    }

    //Register parse methods

    //string[inputString] (contains the register name and number) -> 2-bit Binary string[outputString] (register)
    public static String toReg2(String inputString) {
        String reg = inputString.substring(1);
        int regNum = Integer.parseInt(reg);
        String outputString = Integer.toBinaryString(regNum);
        if(outputString.length() == 1) outputString = "0" + outputString;
        return outputString;
    }

    //string[inputString] (contains the register name and number) -> 3-bit Binary string[outputString] (register)
    public static String toReg3(String inputString) {
        String reg = inputString.substring(1);
        int regNum = Integer.parseInt(reg);
        String outputString = Integer.toBinaryString(regNum);
        if(outputString.length() == 1)
            outputString = "00" + outputString;
        else if (outputString.length() == 2)
            outputString = "0" + outputString;
        return outputString;
    }

    //string[inputString] (contains the register name and number) -> 4-bit Binary string[outputString] (register)
    public static String toReg4(String inputString) {
        String reg = inputString.substring(1);
        String outputString = convertToBinary(reg);
        return outputString;
    }

    //<single line of> assembly code -> machine code
    public static String parseCommand(String inputString) {
        String[] code = inputString.split(" ");
        String result = "";
        System.out.println(inputString);

        //Determine the instruction and construct the machine code
        switch(code[0]) {
            case "rs":
                result = "0001";    //opcode
                result += convertToBinary(code[1]);
                result += code[2];
                break;

            case "ls":
                result = "0010";    //opcode
                result += convertToBinary(code[1]);
                result += code[2];
                break;
            case "mv":
                result = "0011";    //opcode
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "beq":
                result = "0100";    //opcode
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "bgt":
                result = "0101";    //opcode
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "blt":
                result = "0110";    //opcode
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "lsd":
                result = "0111";    //opcode
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "get":
                result = "1000";    //opcode
                //result += toBinary5(inst[1]);
                result += code[1];
                break;
            case "add":
                result = "1001";
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "seq":
                result = "1010";
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "sqb":
                result = "1011";
                result += toReg3(code[1]);
                result += toReg2(code[2]);
                break;
            case "scp":
                result = "1100";
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "rlz":
                result = "1101";
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "sg":
                result = "1110";
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "so":
                result = "1111";
                result += toReg4(code[1]);
                result += code[2];
                break;
            case "halt":
                result = "000000000";
                break;
        }
        return result;
    }

    //assembly code @input_file -> machine code @output_file
    public static void main(String args[]) throws IOException{
        File file = new File(args[0]);
        PrintWriter writer = new PrintWriter(args[0]+"_binary");
        String binaryCode = "";

        BufferedReader reader = new BufferedReader(new FileReader(file));
        String text;

        while((text = reader.readLine()) != null) {
            binaryCode = parseCommand(text);
            writer.println(binaryCode);
        }
        writer.close();
    }
}
