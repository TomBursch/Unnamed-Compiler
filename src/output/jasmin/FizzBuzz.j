.class public FizzBuzz
.super java/lang/Object

.field private static _runTimer LRunTimer;
.field private static _standardIn LPascalTextIn;

; i:int

.field private static i I

; output:string

.field private static output Ljava/lang/String;

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
	putstatic        FizzBuzz/_runTimer LRunTimer;
	new PascalTextIn
	dup
	invokenonvirtual PascalTextIn/<init>()V
	putstatic        FizzBuzz/_standardIn LPascalTextIn;
	ldc	""
	putstatic	FizzBuzz/output Ljava/lang/String;

	; i=0;

	ldc	0
	putstatic	FizzBuzz/i I

	; loopwhile(i<=100){if(i%15==0){output=output+"FizzBuzz";writeln("FizzBuzz");}elseif(i%5==0){output=output+"Buzz";writeln("Buzz");}elseif(i%3==0){output=output+"Fizz";writeln("Fizz");}else{writeln("%d",i);output=output+i;}i=i+1;}

L001:
	getstatic	FizzBuzz/i I
	ldc	100
	if_icmple L003
	iconst_0
	goto L004
L003:
	iconst_1
L004:
	ifeq L002


	; {if(i%15==0){output=output+"FizzBuzz";writeln("FizzBuzz");}elseif(i%5==0){output=output+"Buzz";writeln("Buzz");}elseif(i%3==0){output=output+"Fizz";writeln("Fizz");}else{writeln("%d",i);output=output+i;}i=i+1;}


	; if(i%15==0){output=output+"FizzBuzz";writeln("FizzBuzz");}elseif(i%5==0){output=output+"Buzz";writeln("Buzz");}elseif(i%3==0){output=output+"Fizz";writeln("Fizz");}else{writeln("%d",i);output=output+i;}

	getstatic	FizzBuzz/i I
	ldc	15
	irem
	ldc	0
	if_icmpeq L007
	iconst_0
	goto L008
L007:
	iconst_1
L008:
	ifeq L005


	; {output=output+"FizzBuzz";writeln("FizzBuzz");}


	; output=output+"FizzBuzz";

	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	getstatic	FizzBuzz/output Ljava/lang/String;
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"FizzBuzz"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	putstatic	FizzBuzz/output Ljava/lang/String;

	; writeln("FizzBuzz");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"FizzBuzz"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop
	goto L006

L005:

	; if(i%5==0){output=output+"Buzz";writeln("Buzz");}elseif(i%3==0){output=output+"Fizz";writeln("Fizz");}else{writeln("%d",i);output=output+i;}

	getstatic	FizzBuzz/i I
	ldc	5
	irem
	ldc	0
	if_icmpeq L011
	iconst_0
	goto L012
L011:
	iconst_1
L012:
	ifeq L009


	; {output=output+"Buzz";writeln("Buzz");}


	; output=output+"Buzz";

	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	getstatic	FizzBuzz/output Ljava/lang/String;
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"Buzz"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	putstatic	FizzBuzz/output Ljava/lang/String;

	; writeln("Buzz");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"Buzz"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop
	goto L010

L009:

	; if(i%3==0){output=output+"Fizz";writeln("Fizz");}else{writeln("%d",i);output=output+i;}

	getstatic	FizzBuzz/i I
	ldc	3
	irem
	ldc	0
	if_icmpeq L015
	iconst_0
	goto L016
L015:
	iconst_1
L016:
	ifeq L013


	; {output=output+"Fizz";writeln("Fizz");}


	; output=output+"Fizz";

	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	getstatic	FizzBuzz/output Ljava/lang/String;
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"Fizz"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	putstatic	FizzBuzz/output Ljava/lang/String;

	; writeln("Fizz");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"Fizz"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop
	goto L014

L013:

	; {writeln("%d",i);output=output+i;}


	; writeln("%d",i);

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"%d"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_1
	anewarray    java/lang/Object
	dup
	iconst_0
	getstatic	FizzBuzz/i I
	invokestatic java/lang/Integer.valueOf(I)Ljava/lang/Integer;
	aastore
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	; output=output+i;

	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	getstatic	FizzBuzz/output Ljava/lang/String;
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	getstatic	FizzBuzz/i I
	invokevirtual java/lang/StringBuffer/append(I)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	putstatic	FizzBuzz/output Ljava/lang/String;

L014:

L010:

L006:

	; i=i+1;

	getstatic	FizzBuzz/i I
	ldc	1
	iadd
	putstatic	FizzBuzz/i I
	goto L001
L002:

	; writeln("\nShow string concatenation:");

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	ldc	"\nShow string concatenation:"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	; writeln(output);

	getstatic    java/lang/System/out Ljava/io/PrintStream;
	new java/lang/StringBuffer
	dup
	invokespecial java/lang/StringBuffer/<init>()V
	getstatic	FizzBuzz/output Ljava/lang/String;
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	ldc	"\n"
	invokevirtual java/lang/StringBuffer/append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	invokevirtual java/lang/StringBuffer/toString()Ljava/lang/String;
	iconst_0
	anewarray    java/lang/Object
	invokevirtual java/io/PrintStream.printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	getstatic     FizzBuzz/_runTimer LRunTimer;
	invokevirtual RunTimer.printElapsedTime()V

	return

.limit locals 32
.limit stack 32
.end method
