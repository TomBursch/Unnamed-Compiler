.class public Print
.super java/lang/Object

.field private static _runTimer LRunTimer;
.field private static _standardIn LPascalTextIn;

; i:int;

.field private static i I

.method public <init>()V

	aload_0
	invokenonvirtual    java/lang/Object/<init>()V
	return

.limit locals 1
.limit stack 1
.end method

.method public static main([Ljava/lang/String;)V

	new RunTimer
	dup
	invokenonvirtual RunTimer/<init>()V
	putstatic        Print/_runTimer LRunTimer;
	new PascalTextIn
	dup
	invokenonvirtual PascalTextIn/<init>()V
	putstatic        Print/_standardIn LPascalTextIn;

	; i=0;

	ldc	0
	putstatic	Print/i I

	; loopwhile(i<5){writeln("loop");i=i+1;}

L001:
	getstatic	Print/i I
	ldc	5
	if_icmplt L003
	iconst_0
	goto L004
L003:
	iconst_1
L004:
	ifeq L002


	; {writeln("loop");i=i+1;}


	; writeln("loop");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"loop"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	; i=i+1;

	getstatic	Print/i I
	ldc	1
	iadd
	putstatic	Print/i I
	goto L001
L002:

	getstatic     Print/_runTimer LRunTimer;
	invokevirtual RunTimer.printElapsedTime()V

	return

.limit locals 16
.limit stack 16
.end method
