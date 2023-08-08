BMinor Compiler - Compilers Project Fall 2022 by John Lee
---------------------------------------------------------

This repository contains the code for the BMinor compiler. Bminor is a language including expressions, basic control flow, recursive functions, and strict type checking. It has object code that is compatable with C and can use the C std libraries. More details can be found at https://dthain.github.io/compilers-fa22/bminor.html.

Please move into the main directory and run `make bminor` to compile the BMinor compiler.
The compiler is split into 5 distinct steps: Scanning, Parsing, Printing, NameResolution/Typechecking, and Code generation. 

#### Scanning
  - The Flex program is used to tokenize the words of our BMinor program using a regular expression matcher.
  - Run the scanner using `./bminor -scan sourcefile.bminor`
#### Parsing
  - Using Bison, I set up a Context Free Grammar that constructs valid phrases and sentences and tokens
  - Run the Parser using `./bminor -parse sourcefile.bminor`
#### Printer
  - Pretty prints (reformats) the bminor file
  - Run using `./bminor -print sourcefile.bminor`
#### NameResolution/TypeChecker
  - Checks that there are no type mismatches with declared types (due to strict type checking and static typing). To do so an Abstract Syntax Tree (AST) is constructed that matches names and their types
  - Run name resolution using `./bminor -resolve sourcefile.bminor` and typechecking using ./bminor -typecheck sourcefile.bminor`
#### Code Generation
  - If all previous steps pass, an x86 assembly file is generated that can be compiled via gcc
  - Run code generation using `./bminor -codegen sourcefile.bminor sourcefile.s`
#### Executable
  - A final executable can be generated by running `gcc -g sourcefile.s library.c -o myprogram`
  - This executable can be run using `./myprogram`


