echo "Basics"

# {{## BEGIN syntax ##}}
# This is a comment

#[ This is
    a multiline
    comment ]#
# {{## END syntax ##}}

# {{## BEGIN declarations ##}}
var a: int  # mutable integer, no value explicitly set
var b = 7   # mutable inferred integer set to 7
var 
    c = -11     # mutable inferred integer set to -11
    d = "Hello" # mutable inferred string set to "Hello"
    e = '/'     # mutable inferred character set to '/'

const g = 35    # immutable integer set to compile-time value  

var k = 27
let j = 2 * k   # immutable integer set to runtime value
# {{## END declarations ##}}

echo "a: ", a, "\nb: ", b, "\nc: ", c, "\nd: ", d, "\ne: ", e, "\ng: ", g, "\nj: ", j

# {{## BEGIN numbers ##}}
let na = 11
var nb = (na + 5 - (3 * 2)) / 3
var nc = int(5.5)
var nd = float(5)
# {{## END numbers ##}}

# {{## BEGIN strings-and-chars ##}}
let sa = "Hello"
let sb = sa & "\nworld\n"
let sr = r"Hello\tworld"    # raw string: "Hello        world"
sa.add(" the world")
echo "The sa string equals", sa

let
  i = 'a'
  j = 'd'

echo i < j

let
  m = "axyb"
  n = "axyz"
  o = "ba"
  p = "ba "

echo m < n  
echo n < o  
echo o < p  
# {{## END strings-and-chars ##}}

# {{## BEGIN booleans ##}}
let
  g = 31
  h = 99

echo "g is greater than h: ", g > h
echo "g is smaller than h: ", g < h
echo "g is equal to h: ", g == h
echo "g is not equal to h: ", g != h
echo "g is greater or equal to h: ", g >= h
echo "g is smaller or equal to h: ", g <= h

echo "T and T: ", true and true
echo "T or F: ", true or false
echo "F xor F: ", false xor false
echo "not F: ", not false
# {{## END booleans ##}}

