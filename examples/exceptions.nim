echo "Exceptions"

import system
from std/strutils import parseInt

# {{## BEGIN raises-syntax ##}}
type FileNotFound = object of Exception # Warning: use ValueError, IOError, or OSError
    # Could also use CatchableError or Defect

proc somethingFilesystem(): int {.raises: [OSError].} =
    # ... code ...
    var e: ref OSError
    new(e)
    e.msg = "the request to do something to the filesystem failed"
    raise e

proc somethingElseFilesystem(): int {.raises: [FileNotFound].} =
    raise newException(FileNotFound, "Couldn't find the file, sorry")
# {{## END raises-syntax ##}}

# {{## BEGIN catch-syntax ##}}
var f: File
if open(f, "numbers.txt"):
  try:
    let a = readLine(f)
    echo "value: ", parseInt(a)
  except OverflowDefect:
    echo "overflow!"
  except CatchableError:
    let
        e = getCurrentException()
        msg = getCurrentExceptionMsg()
    echo "Got exception ", repr(e), " with message ", msg
    raise # Re-raise the exception
  finally:
    close(f)
# {{## END catch-syntax ##}}
