import std/strutils

echo "Control flow"

# {{## BEGIN if ##}}
var x = 10
if x < 5:
    echo "x is less than 5"
elif x > 5:
    echo "x is greater than 5"
else:
    echo "x is equal to 5"

var y = if x > 8: 9 else: 10
# {{## END if ##}}

var animal = "whale"
# {{## BEGIN case ##}}
let i = 7
case i
  of 0:
    echo "i is zero"
  of 1, 3, 5, 7, 9:
    echo "i is odd"
  of 2, 4, 6, 8:
    echo "i is even"
  else:
    echo "i is too large"
# {{## END case-1 ##}}
# {{## BEGIN case-2 ##}}
var favoriteFood = case animal
  of "dog": "bones"
  of "cat": "mice"
  elif animal.endsWith("whale"): "plankton"
  else:
    echo "I'm not sure what to serve, but everybody loves ice cream"
    "ice cream"
# {{## END case-2 ##}}
echo animal, " likes ", favoriteFood

# {{## BEGIN for ##}}
for n in 5 ..< 9: 
  echo n

for n in countup(0, 16, 4):  
  echo n

for index, item in ["a","b"].pairs:
  echo item, " at index ", index
# {{## END for ##}}

# {{## BEGIN while ##}}
var a = 1

while a*a < 100: 
  echo "a is: ", a
  inc a         

echo "final value of a: ", a
# {{## END while ##}}

# {{## BEGIN when ##}}
when system.hostOS == "windows":
  echo "running on Windows!"
elif system.hostOS == "linux":
  echo "running on Linux!"
elif system.hostOS == "macosx":
  echo "running on Mac OS X!"
else:
  echo "unknown operating system"
# {{## END when ##}}

# {{## BEGIN block ##}}
block myblock:
  echo "entering block"
  while true:
    echo "looping"
    break # leaves the loop, but not the block
  echo "still in block"
echo "outside the block"
# {{## END block ##}}

# {{## BEGIN exception-handling ##}}
var f: File
if open(f, "quote.txt"):
  try:
    echo readLine(f)
  except IOError:
    echo "IO error!"
  except CatchableError:
    echo "Unknown exception!"
    # reraise the unknown exception:
    raise
  except: # catch all other exceptions
    echo "Other error!"
  finally:
    close(f)
# {{## END exception-handling ##}}

# {{## BEGIN exception-tracking ##}}
# {{## END exception-tracking ##}}

# {{## BEGIN statement-list ##}}
a = if a > 15: (echo "Big!"; 5) else: 10
echo a
# {{## END statement-list ##}}
