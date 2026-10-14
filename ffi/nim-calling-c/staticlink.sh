#!/bin/bash

gcc -c logic.c
ar rvs mylib.a logic.o
nim c --passL:mylib.a -r calc.nim
