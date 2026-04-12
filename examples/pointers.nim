echo "Pointers"

# {{## BEGIN refs ##}}
type
  Node = ref NodeObj
  NodeObj = object
    le, ri: Node
    data: int

var
  n: Node
new(n)
n.data = 9
# {{## END refs ##}}

