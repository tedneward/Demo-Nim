echo "Basics"

# {{## BEGIN syntax ##}}
# This is a comment

#[ This is
    a multiline
    comment ]#
# {{## END syntax ##}}

# {{## BEGIN declarations ##}}
var a: int      # mutable integer, no value explicitly set
var b = 7       # mutable inferred integer set to 7
var 
  c = -11       # mutable inferred integer set to -11
  d = "Hello"   # mutable inferred string set to "Hello"
  e = '/'       # mutable inferred character set to '/'
var f1, f2 = 37 # mutable inferred integer set to variables

const g = 35    # immutable integer set to compile-time value  
var k = 27
let j = 2 * k   # immutable integer set to runtime value
# {{## END declarations ##}}

echo "a: ", a, "\nb: ", b, "\nc: ", c, "\nd: ", d, "\ne: ", e, "\ng: ", g, "\nj: ", j

# {{## BEGIN numbers ##}}
let na = 11
var nb1 = (na + 5 - (3 * 2)) / 3
var nb2 = (na + 5 - (3 * 2)) div 3
var nb3 = (na + 5 - (3 * 2)) mod 3
var nc = int(5.5)
var nd = float(5)
# {{## END numbers ##}}

echo na, " ", nb1, " ", nb2, " ", nb3, " ", nc, " ", nd

# {{## BEGIN strings-and-chars ##}}
var sa = "Hello"
let sb = sa & "\nworld\n"
let sr = r"Hello\tworld"    # raw string: "Hello        world"
sa.add(" the world")
echo "The sa string equals", sa

let
  ci = 'a'
  cj = 'd'
echo ci < cj

let
  sm = "axyb"
  sn = "axyz"
  so = "ba"
  sp = "ba "
echo sm < sn  
echo sn < so  
echo so < sp  
# {{## END strings-and-chars ##}}

# {{## BEGIN booleans ##}}
let
  rg = 31
  rh = 99

echo "rg is greater than rh: ", rg > rh
echo "rg is smaller than rh: ", rg < rh
echo "rg is equal to rh: ", rg == rh
echo "rg is not equal to rh: ", rg != rh

echo "T and T: ", true and true
echo "T or F: ", true or false
echo "F xor F: ", false xor false
echo "not F: ", not false
# {{## END booleans ##}}

