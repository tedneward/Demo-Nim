#!/bin/bash

# Path to Nim installation
NIMBASE=/home/linuxbrew/.linuxbrew/Cellar/nim/2.2.8/nim

nim c --app:staticLib fib.nim
gcc -o nimfib -Inimcache -I$NIMBASE/lib maths.c libfib.a
