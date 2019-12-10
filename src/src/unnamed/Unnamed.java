package unnamed;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.PrintWriter;

//import unnamed.frontend.*;
import unnamed.backend.Pass1Visitor;
import unnamed.backend.Pass2Visitor;
import unnamed.frontend.parser.*;
import unnamed.intermediate.SymTabFactory;
import unnamed.intermediate.SymTabStack;
import unnamed.intermediate.symtabimpl.Predefined;

public class Unnamed {
    public static void main(String[] args) throws Exception {
        System.out.println("------ Parsing Start ------");

        String programName = "placeholder";
        String inputFile = null;
        String outputPath = "./";

        if (args.length > 0) inputFile = args[0];
        InputStream is = (inputFile != null)
                ? new FileInputStream(inputFile)
                : System.in;

        if (inputFile != null) {
            String[] inputArray = inputFile.split("/|\\\\");
            outputPath = "";
            for (int i = 0; i < inputArray.length - 2; i++) {
                outputPath += inputArray[i];
            }
            programName = inputArray[inputArray.length - 1].split("\\.")[0];
        }

        if (args.length > 1) outputPath = args[1];
        CharStream cs = CharStreams.fromStream(is);
        UnnamedLexer lexer = new UnnamedLexer(cs);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        UnnamedParser parser = new UnnamedParser(tokens);
        ParseTree tree = parser.program();

        System.out.println("Done");

        // Create the assembly output file.
        PrintWriter jFile;
        try {
            jFile = new PrintWriter(new FileWriter(outputPath + programName + ".j"));
        } catch (Exception ex) {
            ex.printStackTrace();
            return;
        }
        System.out.println("\n------ Compilation Start ------");

        // Create and initialize the symbol table stack.
        SymTabStack symTabStack;
        symTabStack = SymTabFactory.createSymTabStack();
        Predefined.initialize(symTabStack);

        //Compile in 2 passes

        Pass1Visitor pass1 = new Pass1Visitor(programName, jFile, symTabStack);
        pass1.visit(tree);

        Pass2Visitor pass2 = new Pass2Visitor(programName, jFile, symTabStack);
        pass2.visit(tree);
    }
}
