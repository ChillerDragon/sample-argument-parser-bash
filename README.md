# sample argument parser bash

```
$ ./argparser.sh foo bar baz
got positional argument: foo
got positional argument: bar
got positional argument: baz
$ ./argparser.sh -vfx
got verbose flag
got force flag
error unknown flag x
$ ./argparser.sh -- -vfx
got positional argument: -vfx
$ ./argparser.sh hello -o out.txt world
got positional argument: hello
output: out.txt
got positional argument: world
$ ./argparser.sh -- -o out.txt
got positional argument: -o
got positional argument: out.txt
$ ./argparser.sh -o out.txt
output: out.txt
$ ./argparser.sh --output=foo.txt -vo test.txt
output: foo.txt
got verbose flag
output: test.txt
``

