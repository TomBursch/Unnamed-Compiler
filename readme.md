# Unnamed programming language

Custom programming language using ANTLR4. 
Merging Java and Pascal to create a modern and more versatile version of Pascal.
The Compiler Generates Jasmin Assembly which can assembled for the Java Virtual Machine.
Created by Tom Bursch, Sai Sathyanantha, Konstantin Dimitrov, Danil Kolesnikov.
Advisor: Ron Mak


### Compile Source
run `build_grammar.sh`
make sure your CLASSPATH enviroment variable is set up right to compile grammar

compile `src/` to `bin/production/compiler-unnamed`

---
### Compile File from Example
run `build.sh [optional program name of examples]`

current examples are: ```FizzBuzz, Print```

### Compile File from Example
```
./compile.sh [optional path to file.unnamed]
./assemble.sh [optional path to file.j]
```

### Run
`run.sh [optional program name] [optional path to .class file directory]`

---
### Generate Tree
run `build_tree.sh [optional filepath]`
##### Required Components
- imagemagick (convert PostScript to png)

---
### TODO
##### Grammar
- [x] Ternary operator
- [x] Constants
- [ ] Custom Type definitions
- [x] Functions
    - [x] Function Calls
    - [x] Function Declaration
##### Intermediate Code
- [ ] Predefined char
- [ ] Predefined long
- [ ] Predefined double
##### Backend
- [ ] Import files
- [x] Function declaration
- [x] If statements
- [x] Loop statement
    - [x] loop while() {}
    - [ ] loop {} while()
- [x] Predefined function calls
    - [x] write/writeln
    - [ ] read
- [x] Function calls
    - [x] Pass1
    - [x] Pass2