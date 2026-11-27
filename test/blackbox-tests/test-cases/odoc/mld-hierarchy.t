The files field of the documentation stanza can place pages in subdirectories.
A page installed as odoc-pages/<dir>/<name>.mld is compiled with the parent id
<pkg>/<dir>, as described by odoc's driver conventions.

  $ cat > dune-project <<EOF
  > (lang dune 3.18)
  > (package (name my_pkg) (allow_empty))
  > EOF

  $ mkdir -p doc/guide
  $ cat > doc/dune <<EOF
  > (documentation
  >  (package my_pkg)
  >  (mld_files)
  >  (files
  >   index.mld
  >   (guide/index.mld as guide/index.mld)
  >   (guide/intro.mld as guide/intro.mld)
  >   (draft.mld as guide/advanced.mld)
  >   (tuto.mld as tutorial/first.mld)))
  > EOF
  $ cat > doc/index.mld <<EOF
  > {0 Root}
  > 
  > Path reference: {!/my_pkg/guide/intro}.
  > 
  > Current package reference: {!//tutorial/first}.
  > EOF
  $ cat > doc/guide/index.mld <<EOF
  > {0 Guide}
  > EOF
  $ cat > doc/guide/intro.mld <<EOF
  > {0 Intro}
  > 
  > See {!//guide/advanced}.
  > EOF
  $ cat > doc/draft.mld <<EOF
  > {0 Advanced}
  > EOF
  $ cat > doc/tuto.mld <<EOF
  > {0 First steps}
  > EOF

Two pages named index.mld in different directories are not duplicates:

  $ dune build @doc
  Warning: Dune does not yet support building documentation for assets, and
  mlds in a non-flat hierarchy. Ignoring guide/advanced.mld, guide/index.mld,
  guide/intro.mld, tutorial/first.mld.
  File "../../../doc/index.mld", line 5, characters 27-46:
  Warning: Failed to resolve reference //tutorial/first Path '//tutorial/first' not found
  File "../../../doc/index.mld", line 3, characters 16-38:
  Warning: Failed to resolve reference /my_pkg/guide/intro Path '/my_pkg/guide/intro' not found

The odoc files of pages are placed under their parent id:

  $ find _build/default/_doc/_odoc_pages/my_pkg -name '*.odoc' | sort
  _build/default/_doc/_odoc_pages/my_pkg/page-index.odoc

Each page is rendered in its directory:

  $ find _build/default/_doc/_html/my_pkg -name '*.html' | sort
  _build/default/_doc/_html/my_pkg/index.html

References to pages in subdirectories resolve:

  $ grep -o '<p>.*</p>' \
  >   _build/default/_doc/_html/my_pkg/index.html \
  >   _build/default/_doc/_html/my_pkg/guide/intro.html
  _build/default/_doc/_html/my_pkg/index.html:<p>Path reference: <code>/my_pkg/guide/intro</code>.</p><p>Current package reference: <code>//tutorial/first</code>.</p>
  grep: _build/default/_doc/_html/my_pkg/guide/intro.html: No such file or directory
  [2]

The sidebar reflects the hierarchy. The tutorial directory has no index page:

  $ grep -o '<nav class="odoc-toc odoc-global-toc">.*</nav>' \
  >   _build/default/_doc/_html/my_pkg/index.html
  <nav class="odoc-toc odoc-global-toc"><ul><li><a href="#" class="current_unit">Root</a></li></ul></nav>

A directory of pages named after a library of the package would have the same
parent id as the library, <pkg>/<lib>:

  $ mkdir foo
  $ cat > foo/dune <<EOF
  > (library (public_name my_pkg.foo) (name foo))
  > EOF
  $ echo '{0 Root}' > doc/index.mld
  $ cat > doc/dune <<EOF
  > (documentation
  >  (package my_pkg)
  >  (mld_files)
  >  (files index.mld (draft.mld as my_pkg.foo/draft.mld)))
  > EOF
  $ dune build @doc
  Warning: Dune does not yet support building documentation for assets, and
  mlds in a non-flat hierarchy. Ignoring my_pkg.foo/draft.mld.
