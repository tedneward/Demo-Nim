{.emit: """/*INCLUDESECTION*/
#include <stdio.h>
""".}
{.emit: """/*VARSECTION*/
static int cvariable = 420;
""".}

{.push stackTrace:off.}
proc embedsC() =
  var nimVar = 89
  # access Nim symbols within an emit section outside of string literals:
  {.emit: ["""printf("%d\n", cvariable + (int)""", nimVar, ");"].}
{.pop.}

embedsC()
