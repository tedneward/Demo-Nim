#!/bin/bash

# Path to Nim installation
NIMBASE=/home/linuxbrew/.linuxbrew/Cellar/nim/2.2.8/nim

nim c --noMain --noLinking fib.nim
    # generated files go into $HOME/.cache/nim/ directory
gcc -o nimfib -I$HOME/.cache/nim/fib_d -I$NIMBASE/lib $HOME/.cache/nim/fib_d/*.c maths.c
