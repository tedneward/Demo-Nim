type
  CTime = int64
proc time(arg: ptr CTime): CTime {.importc, header: "<time.h>".}

type
  TM {.importc: "struct tm", header: "<time.h>".} = object
    tm_min: cint
    tm_hour: cint
proc localtime(time: ptr CTime): ptr TM {.importc, header: "<time.h>".}   #1

var seconds = time(nil)                                                   #2
let tm = localtime(addr seconds)                                          #3
echo(tm.tm_hour, ":", tm.tm_min)                                          #4
