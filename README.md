# `unionfind`

`unionfind` is a simple, fast implementation of a disjoint set forest data
structure in Python/Cython. The module defines a single class, `UnionFind`,
whose elements are consecutive integer indices.

## Usage

Install using `pip` (cython is require to build). `import unionfind` and create
a forest over *n* elements by writing `unionfind.UnionFind(n)`. Find the root
of the point with index `i` with the `find(index)` method. Union the sets
containing `i` and `j` with the `union(i, j)` method, which also returns the
root of the resulting set as a convenience. See how many disjoint sets are in
the forest with the `n_sets` property.
