
var
  a: array[3, int] = [5, 7, 9]
  b = [5, 7, 9]        
  c = []  # error      
  d: array[7, string] 

const m = 3
let n = 5

var ba: array[m, char]

var
  e1: seq[int] = @[]   
  f = @["abc", "def"]  

var
  e = newSeq[int]()

var
  g = @['x', 'y']
  h = @['1', '2', '3']

g.add('z')  
echo g

h.add(g)    
echo h

var i = @[9, 8, 7]
echo i.len

i.add(6)
echo i.len
