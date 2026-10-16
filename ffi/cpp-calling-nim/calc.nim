# calculator.nim

type 
  # We use a flat object to hold data
  NimCalculator* {.exportc.} = object
    value*: cdouble

# Use exportc to prevent name mangling and cdecl for standard calling convention
proc init_calculator*(initialValue: cdouble): NimCalculator {.exportc, cdecl.} =
  result.value = initialValue

proc add*(calc: var NimCalculator, amount: cdouble) {.exportc, cdecl.} =
  calc.value += amount

proc getValue*(calc: NimCalculator): cdouble {.exportc, cdecl.} =
  calc.value
