#!/bin/bash
rm -f dce_tool lex.yy.c *.tab.c *.tab.h
bison -d parser.y
flex scanner.l
gcc -o dce_tool parser.tab.c lex.yy.c -lfl
