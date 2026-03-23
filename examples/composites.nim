echo "Composites"

# {{## BEGIN arrays ##}}
var
  a: array[3, int] = [5, 7, 9]
  b = [5, 7, 9]        
  c = []  # error      
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
let n = ("Banana", 2, 'c')  
echo n    # (Field0: "Banana", Field1: 2, Field2: 'c')

var o = (name: "Banana", weight: 2, rating: 'c')
o[1] = 7          
o.name = "Apple"  
echo o    # (name: "Apple", weight: 7, rating: 'c')
# {{## END tuples ##}}
