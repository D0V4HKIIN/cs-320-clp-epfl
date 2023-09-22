# Lab 6: Project 5.5 Compilation to C

## Compile amy files to C
In sbt use the command `run [libraries to include] [file to compile]`. It will also try to compile to a binary using gcc.
The output will be in the folder `cout`

Examples:
```
run library/Std.amy extension-examples/Hanoi.amy

run library/Std.amy library/Option.amy library/List.amy extension-examples/TestLists.amy
```