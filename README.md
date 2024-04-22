# sample argument parser bash

Cross platform example of cli argument parsing in bash.


Tested in the CI on macOS, windows and linux.

Depends on no external tools and is written in pure bash.

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
```

## how to use it

Copy the contents of `argparser.sh` into your script and add your own arguments.
The code is licensed under the permissive BSD 2-clause license. You can edit, redistribute the code freely and without charge.
For more details see the LICENSE file.

