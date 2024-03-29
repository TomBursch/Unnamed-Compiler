package unnamed.backend;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ParseTree;
import unnamed.frontend.FunctionParamVisitor;
import unnamed.frontend.parser.UnnamedParser;
import unnamed.frontend.parser.UnnamedParserBaseVisitor;
import unnamed.intermediate.*;
import unnamed.intermediate.symtabimpl.*;
import unnamed.util.*;

import static unnamed.intermediate.symtabimpl.RoutineCodeImpl.DECLARED;
import static unnamed.intermediate.symtabimpl.SymTabKeyImpl.*;
import static unnamed.intermediate.symtabimpl.DefinitionImpl.*;

public class Pass1Visitor extends UnnamedParserBaseVisitor<Integer> {
    private SymTabStack symTabStack;
    private SymTabEntry programId;
    private PrintWriter jFile;
    private String programName;

    private int functionVariableCounter = 0;

    private ArrayList<SymTabEntry> variableIdList;
    private boolean isConstant;

    public Pass1Visitor(String programName, PrintWriter jFile, SymTabStack symTabStack) {
        this.programName = programName;
        this.jFile = jFile;
        this.symTabStack = symTabStack;
    }


    @Override
    public Integer visitProgram(UnnamedParser.ProgramContext ctx) {
        programId = symTabStack.enterLocal(programName);
        programId.setDefinition(DefinitionImpl.PROGRAM);
        programId.setAttribute(ROUTINE_SYMTAB, symTabStack.push());
        symTabStack.setProgramId(programId);

        // Emit the program header.
        jFile.println(".class public " + programName);
        jFile.println(".super java/lang/Object");

        // Emit the RunTimer and PascalTextIn fields.
        jFile.println();
        jFile.println(".field private static _runTimer LRunTimer;");
        jFile.println(".field private static _standardIn LPascalTextIn;");

        ctx.block().isMainBlock = true;

        Integer value = visitChildren(ctx);

        // Print the cross-reference table.
        CrossReferencer crossReferencer = new CrossReferencer();
        crossReferencer.print(symTabStack);

        return value;
    }

    @Override
    public Integer visitFunctionDeclaration(UnnamedParser.FunctionDeclarationContext ctx) {
        SymTabEntry routineId = symTabStack.enterLocal(ctx.IDENTIFIER().toString());

        DefinitionImpl def = PROCEDURE;
        if (ctx.typeId() != null) {
            SymTabEntry returnEntry = symTabStack.lookup(ctx.typeId().IDENTIFIER().toString());
            if (returnEntry != null) {
                TypeSpec returnType = returnEntry.getTypeSpec();
                if (returnType != null) {
                    def = FUNCTION;
                    routineId.setTypeSpec(returnType);
                }
            }
        }
        routineId.setDefinition(def);
        routineId.setAttribute(ROUTINE_CODE, DECLARED);
        routineId.setAttribute(ROUTINE_SYMTAB, symTabStack.push());

        ArrayList<SymTabEntry> params = new ArrayList<SymTabEntry>();
        if (ctx.functionParamDeclaration() != null) {
            params = new FunctionParamVisitor(symTabStack).visit(ctx.functionParamDeclaration());
        }
        routineId.setAttribute(ROUTINE_PARMS, params);

        functionVariableCounter = params.size();
        Integer value = visit(ctx.block());

        symTabStack.pop();
        return value;
    }

    @Override
    public Integer visitBlock(UnnamedParser.BlockContext ctx) {
        Integer value = defaultResult();
        for (int i = 0; i < ctx.variableDeclaration().size(); i++) {
            value = aggregateResult(value, visit(ctx.variableDeclaration(i)));
        }
        for (int i = 0; i < ctx.functionDeclaration().size(); i++) {
            value = aggregateResult(value, visit(ctx.functionDeclaration(i)));
        }
        value = aggregateResult(value, visit(ctx.compoundStmt()));
        if (ctx.isMainBlock) {
            // Emit the class constructor.
            jFile.println();
            jFile.println(".method public <init>()V");
            jFile.println();
            jFile.println("\taload_0");
            jFile.println("\tinvokenonvirtual    java/lang/Object/<init>()V");
            jFile.println("\treturn");
            jFile.println();
            jFile.println(".limit locals 1");
            jFile.println(".limit stack 1");
            jFile.println(".end method");
        }
        return value;
    }

    @Override
    public Integer visitVariableDeclaration(UnnamedParser.VariableDeclarationContext ctx) {
        jFile.println("\n; " + ctx.getText() + "\n");
        isConstant = ctx.FINAL() != null;
        Integer value = visitChildren(ctx);
        ctx.symTabEntries = variableIdList;
        return value;
    }

    @Override
    public Integer visitVarList(UnnamedParser.VarListContext ctx) {
        variableIdList = new ArrayList<SymTabEntry>();
        return visitChildren(ctx);
    }

    @Override
    public Integer visitVarId(UnnamedParser.VarIdContext ctx) {
        String variableName = ctx.IDENTIFIER().toString();

        SymTabEntry variableId = symTabStack.enterLocal(variableName);
        if (symTabStack.getCurrentNestingLevel() <= 1) {
            if (isConstant) variableId.setDefinition(CONSTANT);
            else variableId.setDefinition(VARIABLE);
        } else {
            if (isConstant) variableId.setDefinition(LOCAL_CONSTANT);
            else variableId.setDefinition(LOCAL_VARIABLE);
            variableId.setAttribute(SLOT, new Integer(functionVariableCounter++));
        }
        variableIdList.add(variableId);

        return visitChildren(ctx);
    }

    @Override
    public Integer visitTypeId(UnnamedParser.TypeIdContext ctx) {
        String identifier = ctx.IDENTIFIER().toString();
        SymTabEntry entry = symTabStack.lookup(identifier);
        TypeSpec type = Predefined.undefinedType;

        if (entry != null && entry.getDefinition() == TYPE) {
            type = entry.getTypeSpec();
        }

        for (SymTabEntry id : variableIdList) {
            id.setTypeSpec(type);
            if (symTabStack.getCurrentNestingLevel() <= 1) {
                // Emit a field declaration.
                jFile.println(".field private static " +
                        id.getName() + " " + TypeGenerator.getTypeIndicator(type));
            }
        }

        return visitChildren(ctx);
    }

    @Override
    public Integer visitReturnStmt(UnnamedParser.ReturnStmtContext ctx) {
        Integer value = visitChildren(ctx);
        ctx.type = Predefined.undefinedType;
        if (ctx.expr() != null) ctx.type = ctx.expr().type;
        return value;
    }

    @Override
    public Integer visitFunctionStmt(UnnamedParser.FunctionStmtContext ctx) {
        String name = ctx.IDENTIFIER().toString();
        ctx.symTabEntry = symTabStack.lookup(name);
        return visitChildren(ctx);
    }

    @Override
    public Integer visitAddSubExpr(UnnamedParser.AddSubExprContext ctx) {
        Integer value = visitChildren(ctx);

        TypeSpec type1 = ctx.expr(0).type;
        TypeSpec type2 = ctx.expr(1).type;

        boolean integerMode = (type1 == Predefined.integerType)
                && (type2 == Predefined.integerType);
        boolean realMode = (type1 == Predefined.realType)
                && (type2 == Predefined.realType);
        boolean stringMode = (type1 == Predefined.stringType)
                && (type2 == Predefined.stringType || type2 == Predefined.integerType || type2 == Predefined.realType);

        TypeSpec type = integerMode ? Predefined.integerType
                : realMode ? Predefined.realType
                : stringMode ? Predefined.stringType
                : Predefined.undefinedType;
        ctx.type = type;

        return value;
    }

    @Override
    public Integer visitMulDivExpr(UnnamedParser.MulDivExprContext ctx) {
        Integer value = visitChildren(ctx);

        TypeSpec type1 = ctx.expr(0).type;
        TypeSpec type2 = ctx.expr(1).type;

        boolean integerMode = (type1 == Predefined.integerType)
                && (type2 == Predefined.integerType);
        boolean realMode = (type1 == Predefined.realType)
                && (type2 == Predefined.realType);


        TypeSpec type = integerMode ? Predefined.integerType
                : realMode ? Predefined.realType
                : Predefined.undefinedType;
        ctx.type = type;

        return value;
    }

    @Override
    public Integer visitRelExpr(UnnamedParser.RelExprContext ctx) {
        Integer value = visitChildren(ctx);

        if (TypeGenerator.isComparable(ctx.expr(0).type, ctx.expr(1).type, ctx.relOp().EQ_OP() != null)) {
            ctx.type = Predefined.booleanType;
        } else ctx.type = Predefined.undefinedType;

        return value;
    }

    @Override
    public Integer visitLogExpr(UnnamedParser.LogExprContext ctx) {
        Integer value = visitChildren(ctx);

        TypeSpec type1 = ctx.expr(0).type;
        TypeSpec type2 = ctx.expr(1).type;

        if (type1 == Predefined.booleanType && type2 == Predefined.booleanType)
            ctx.type = Predefined.booleanType;
        else ctx.type = Predefined.undefinedType;

        return value;
    }

    @Override
    public Integer visitTernaryExpr(UnnamedParser.TernaryExprContext ctx) {
        Integer value = visitChildren(ctx);
        if (ctx.expr(0) == Predefined.booleanType && ctx.expr(1).type == ctx.expr(2)) {
            ctx.type = ctx.expr(1).type;
        } else ctx.type = Predefined.undefinedType;
        return value;
    }

    @Override
    public Integer visitFunctionExpr(UnnamedParser.FunctionExprContext ctx) {
        Integer value = visitChildren(ctx);
        SymTabEntry functionId = ctx.functionStmt().symTabEntry;
        if (functionId.getDefinition() == FUNCTION) {
            ctx.type = functionId.getTypeSpec();
        } else ctx.type = Predefined.undefinedType;
        return value;
    }

    @Override
    public Integer visitVariableExpr(UnnamedParser.VariableExprContext ctx) {
        String variableName = ctx.variable().IDENTIFIER().toString();
        SymTabEntry variableId = symTabStack.lookup(variableName);
        ctx.type = variableId.getTypeSpec();
        return visitChildren(ctx);
    }

    @Override
    public Integer visitConstExpr(UnnamedParser.ConstExprContext ctx) {
        Integer value = visitChildren(ctx);
        ctx.type = ctx.constant().type;
        return value;
    }

    @Override
    public Integer visitIntegerConst(UnnamedParser.IntegerConstContext ctx) {
        if (ctx.sign() != null) ctx.sign().type = Predefined.integerType;
        ctx.type = Predefined.integerType;
        return visitChildren(ctx);
    }

    @Override
    public Integer visitFloatConst(UnnamedParser.FloatConstContext ctx) {
        if (ctx.sign() != null) ctx.sign().type = Predefined.realType;
        ctx.type = Predefined.realType;
        return visitChildren(ctx);
    }

    @Override
    public Integer visitStringConst(UnnamedParser.StringConstContext ctx) {
        ctx.type = Predefined.stringType;
        return visitChildren(ctx);
    }

    @Override
    public Integer visitParenExpr(UnnamedParser.ParenExprContext ctx) {
        Integer value = visitChildren(ctx);
        ctx.type = ctx.expr().type;
        return value;
    }

    public Integer visitList(List<? extends ParseTree> children) {
        Integer result = defaultResult();
        for (ParseTree c : children) {
            Integer childResult = visit(c);
            result = aggregateResult(result, childResult);
        }
        return result;
    }
}