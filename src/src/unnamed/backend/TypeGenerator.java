package unnamed.backend;

import unnamed.intermediate.TypeSpec;
import unnamed.intermediate.symtabimpl.Predefined;

public class TypeGenerator {
    public static String getTypeIndicator(TypeSpec typeSpec) {
        if (typeSpec == Predefined.integerType) {
            return "I";
        } else if (typeSpec == Predefined.realType) {
            return "F";
        } else if (typeSpec == Predefined.stringType) {
            return "Ljava/lang/String;";
        } else if (typeSpec == Predefined.booleanType) {
            return "Z";
        } else if (typeSpec == Predefined.charType) {
            return "C";
        }
        return "?";
    }

    public static boolean isComparable(TypeSpec type1, TypeSpec type2, boolean isEqOp){
        if(isEqOp && type1 == type2) return true;
        if(type1 == Predefined.integerType || type1 == Predefined.realType){
            if(type2 == Predefined.integerType || type2 == Predefined.realType) return true;
        }
        return false;
    }

    public static String getTypeReturnStatement(TypeSpec typeSpec) {
        if (typeSpec == Predefined.integerType) {
            return "ireturn";
        } else if (typeSpec == Predefined.realType) {
            return "freturn";
        } else if (typeSpec == Predefined.booleanType) {
            return "ireturn";
        } else if (typeSpec == Predefined.charType) {
            return "ireturn";
        }
        return "areturn";
    }
}
