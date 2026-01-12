#!/bin/bash
tac test.il > rev1.il
./dce_tool < rev1.il > rev2.il
tac rev2.il > final.il
