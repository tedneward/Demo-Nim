NIMBASE="$(brew --prefix nim)"/nim
#echo "===========> $NIMBASE"

nim cpp --app:staticLib --noMain calc.nim

nim cpp --noMain --noLinking --header:calc.h calc.nim
NIMCACHE=~/.cache/nim
#echo "===========> $NIMCACHE"
#cat $NIMCACHE/calc_d/calc.h

g++ -o nimcalc calc.cpp -I$NIMCACHE/calc_d -I$NIMBASE/lib ./libcalc.a -lpthread -ldl -lm
