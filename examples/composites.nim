echo "Composites"

# {{## BEGIN enums ##}}
type CompassDirections = enum cdNorth, cdEast, cdSouth, cdWest

type
  Colors {.pure.} = enum
    Red = "FF0000", Green = (1, "00FF00"), Blue = "0000FF"

  OtherColors {.pure.} = enum
    Red = 0xFF0000, Orange = 0xFFA500, Yellow = 0xFFFF00

  Signals = enum
    sigQuit = 3, sigAbort = 6, sigKill = 9

echo "Go ", cdWest, ", young man!"
# echo Red                 # Error: ambiguous identifier: 'Red'
echo Colors.Red                                       # FF0000
echo OtherColors.Red                                  # Red
echo OtherColors.Orange, " ", Orange                  # Orange Orange
echo int(sigQuit), " ", sigAbort, " ", float(sigKill) # 3 sigAbort 9.0
# {{## END enums ##}}

# {{## BEGIN subrange ##}}
type Age = range[0..125]

var sra : Age
var srb = sra
var src = sra - 45  # Runtime error! (But only if checks are on)
#var srd : Age = 595 # Compile error!
echo src

type Grade = range['A'..'F']
var srg : Grade = 'F'
# {{## END subrange ##}}

# {{## BEGIN arrays ##}}
var
  a: array[3, int] = [5, 7, 9]
  b = [5, 7, 9]        
#  c = []  # error      
  d: array[7, string] 

const m = 3
let n = 5

var ba: array[m, char]
# {{## END arrays ##}}

# {{## BEGIN sequences ##}}
var
  e1: seq[int] = @[]   
  f = @["abc", "def"]  
  e = newSeq[int]()
  g = @['x', 'y']
  h = @['1', '2', '3']

g.add('z')  # x, y, z
h.add(g)    # 1, 2, 3, x, y, z

var i = @[9, 8, 7] # 3
i.add(6)    # 4
# {{## END sequences ##}}

# {{## BEGIN indexing ##}}
let j = ['a', 'b', 'c', 'd', 'e']

echo j[1]   # a
echo j[^1]  # e
echo j[0 .. 3]  # @[a, b, c, d]
echo j[0 ..< 3] # @[a, b, c]
# {{## END indexing ##}}

# {{## BEGIN tuples ##}}
let t = ("Banana", 2, 'c')  
echo t    # (Field0: "Banana", Field1: 2, Field2: 'c')

var o = (name: "Banana", weight: 2, rating: 'c')
o[1] = 7          
o.name = "Apple"  
echo o    # (name: "Apple", weight: 7, rating: 'c')

type Fruit = tuple[name: string, weight: int, rating: char]
var u = (name: "Kumquat", weight: 5, rating: 'f')
echo u
# {{## END tuples ##}}

# {{## BEGIN distinct-types ##}}
type
  Dollars* = distinct float

proc `*` *(a, b: Dollars): Dollars {.borrow.}
proc `+` *(a, b: Dollars): Dollars {.borrow.}

var usd = 20.Dollars
#usd = 25  # Doesn't compile
usd = 25.Dollars  # Works fine

usd = 20.Dollars * 20.Dollars
echo usd.float
# BTW, reminder: Never use floating-point values for money!
# {{## END distinct-types ##}}