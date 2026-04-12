#
# NimScript build file for Project X
#

let exampleCode = [
    "basics",
    "composites",
    "controlflow",
    "ffic",
    "objects",
    "pointers",
    "procedures"
]

#
# Tasks
#
task build, "build project":
    for ex in exampleCode:
        exec("nim c " & ex)

task clean, "Clean up the project":
    for ex in exampleCode:
        exec("rm " & ex)
