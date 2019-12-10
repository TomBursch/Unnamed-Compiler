.class public functions
.super java/lang/Object

.field private static _runTimer LRunTimer;
.field private static _standardIn LPascalTextIn;

; i:int

.field private static i I

; j:int


.method public <init>()V

	aload_0
	invokenonvirtual    java/lang/Object/<init>()V
	return

.limit locals 1
.limit stack 1
.end method

.method static foo()V

	; write("foo: "+i);

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"foo: "
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	getstatic	functions/i I
	invokevirtual java/lang/StringBuffer/append(I)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	return

.limit stack 16
.limit locals 16
.end method

.method static fuu(I)V

	; write("fuu: "+i);

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"fuu: "
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	iload_0	
	invokevirtual java/lang/StringBuffer/append(I)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	return

.limit stack 16
.limit locals 16
.end method

.method static fee()Ljava/lang/String;

	; j=5;

	ldc	5
	istore_0	

	; return("fee: "+j);

	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"fee: "
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	iload_0	
	invokevirtual java/lang/StringBuffer/append(I)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	areturn

	return

.limit stack 16
.limit locals 16
.end method

.method public static main([Ljava/lang/String;)V

	new RunTimer
	dup
	invokenonvirtual RunTimer/<init>()V
	putstatic        functions/_runTimer LRunTimer;
	new PascalTextIn
	dup
	invokenonvirtual PascalTextIn/<init>()V
	putstatic        functions/_standardIn LPascalTextIn;

	; i=0;

	ldc	0
	putstatic	functions/i I

	; loopwhile(i<5){foo();write(" | ");fuu(4-i);write(" | ");write(fee());writeln("");i=i+1;}

L001:
	getstatic	functions/i I
	ldc	5
	if_icmplt L003
	iconst_0
	goto L004
L003:
	iconst_1
L004:
	ifeq L002


	; {foo();write(" | ");fuu(4-i);write(" | ");write(fee());writeln("");i=i+1;}


	; foo();

	invokestatic functions/foo()V

	; write(" | ");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	ldc	" | "
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	; fuu(4-i);

	ldc	4
	getstatic	functions/i I
	isub
	invokestatic functions/fuu(I)V

	; write(" | ");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	ldc	" | "
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	; write(fee());

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	invokestatic functions/fee()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	; writeln("");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	""
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	; i=i+1;

	getstatic	functions/i I
	ldc	1
	iadd
	putstatic	functions/i I
	goto L001
L002:

	getstatic     functions/_runTimer LRunTimer;
	invokevirtual RunTimer.printElapsedTime()V

	return

.limit locals 32
.limit stack 32
.end method
