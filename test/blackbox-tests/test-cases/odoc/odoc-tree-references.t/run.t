References to the page tree of a package and to the module tree of a library,
using their names. See index.mld and bar/bar.mli.

Odoc is only given the directories of the trees with -I, so none of these
references can be resolved:

  $ dune build @doc
  File "../../../index.mld", line 3, characters 33-51:
  Warning: Failed to resolve reference /my_pkg.bar/Bar Path '/my_pkg.bar/Bar' not found
  File "bar/bar.mli", line 2, characters 4-14:
  Warning: Failed to resolve reference //index Path '//index' not found
  File "bar/bar.mli", line 1, characters 42-58:
  Warning: Failed to resolve reference /my_pkg/index Path '/my_pkg/index' not found
  File "bar/bar.mli", line 1, characters 9-27:
  Warning: Failed to resolve reference /my_pkg.foo/Foo Path '/my_pkg.foo/Foo' not found
