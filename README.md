# IL-Dead-Code-Eliminator

## Project Overview
This repository contains a compiler optimization tool developed for **CSE 351: Programming Languages**. [cite_start]The project focuses on implementing a **Dead Code Elimination (DCE)** algorithm to optimize Intermediate Language (IL) code[cite: 5]. [cite_start]The tool identifies and removes assignment statements that do not contribute to the final program state, improving code efficiency without changing program logic[cite: 22].



## Key Features
* [cite_start]**Toolchain**: Developed using **Lex** (Lexical Analyzer) and **Yacc** (Parser Generator)[cite: 108].
* [cite_start]**Optimization Logic**: Implements backward data-flow analysis to identify and eliminate "dead" variables that are not consumed by any future operations[cite: 22, 60].
* [cite_start]**Algorithm Complexity**: Employs a robust three-step process: code reversal, liveness analysis, and final restoration [cite: 30-33].

---

## The Dead Code Elimination Algorithm
The tool processes the input through three major stages to ensure accurate optimization:

1.  [cite_start]**Reverse the Code**: The input IL is reversed to enable backward analysis starting from the final program output[cite: 31, 47].
2.  **Apply Liveness Analysis**: 
    * [cite_start]The tool initializes a `LiveSet` based on the variables explicitly listed as "live" at the end of the source code[cite: 61].
    * [cite_start]As each statement is visited in reverse, the tool checks if the destination variable is in the `LiveSet`[cite: 60].
    * [cite_start]If the variable is "dead," the entire statement is eliminated[cite: 72, 83].
    * [cite_start]If "live," the destination variable is removed from the `LiveSet`, and its source operands are added to track their future dependencies[cite: 63, 67, 69].
3.  [cite_start]**Reverse the Output**: The remaining "live" statements are reversed back to their original order to produce the optimized IL[cite: 33, 100].

---

## Language Specification
The tool handles a C-like Intermediate Language (IL) with the following syntax:
* [cite_start]**Assignments**: Supports statements with up to two source operands (e.g., `$a=b+c$`)[cite: 7, 14].
* [cite_start]**Operand Types**: Supports variables and signed integer constants[cite: 14].
* [cite_start]**Liveness Declaration**: The final line of the source file identifies variables that must be preserved (e.g., `{r, s}`) [cite: 18-20].

---

## How to Run
1.  [cite_start]**Lex and Yacc**: Compile the `.l` and `.y` files using your standard compiler tools[cite: 110].
2.  **Input**: Provide an IL source file ending with a live variable list.
3.  [cite_start]**Output**: The tool generates a optimized version of the code with all non-essential statements removed[cite: 60].

## Repository Contents
* [cite_start]**Lex & Yacc Files**: Core implementation of the DCE algorithm[cite: 110].
* [cite_start]**Sample Inputs**: Test cases demonstrating code transformation[cite: 110].
* [cite_start]**Project Report**: Comprehensive documentation on implementation and logic[cite: 109, 111].
