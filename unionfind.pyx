cimport cython
from libc.stdlib cimport malloc, free

cdef class UnionFind:
    """A disjoint set forest data structure."""
    cdef int n_points
    cdef int * parent
    cdef int * rank
    cdef int _n_sets

    def __cinit__(self, n_points):
        self.n_points = n_points
        self.parent = <int *> malloc(n_points * sizeof(int))
        self.rank = <int *> malloc(n_points * sizeof(int))

        cdef int i
        for i in range(n_points):
            self.parent[i] = i

    def __dealloc__(self):
        free(self.parent)
        free(self.rank)

    cdef int _find(self, int i):
        if self.parent[i] == i:
            return i
        else:
            self.parent[i] = self.find(self.parent[i])
            return self.parent[i]

    def find(self, int i):
        if (i < 0) or (i > self.n_points):
            raise ValueError("Out of bounds index.")
        return self._find(i)

    def union(self, int i, int j):
        if (i < 0) or (i > self.n_points) or (j < 0) or (j > self.n_points):
            raise ValueError("Out of bounds index.")

        cdef int root_i, root_j
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self._n_sets -= 1
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
                return root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
                return root_i
            else:
                self.parent[root_i] = root_j
                self.rank[root_j] += 1
                return root_j
        else:
            return root_i

    property n_sets:
        def __get__(self):
            return self._n_sets
