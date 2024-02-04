# Iterator Pattern Experiment in Odin
# In this example of odin code i implemented data structures with iterator pattern using slices odin execpt linked-list. In odin slices are like a struct involving a capacity,length and a raw pointer [^]T so due to the issue of alignment the example is quite broken but i would suggest using raw pointer for implementing any kind of data structure with working iterator pattern do not for now do not use odins buildin slices although they are very powerfull but in a very low level stuff such as vtable and etc use raw pointer.

## Overview

This is a simple experiment in implementing the iterator pattern in the Odin programming language. The iterator pattern provides a way to sequentially access elements of a collection without exposing the underlying details of its representation.

## Code Structure

### Iterator Struct

The `Iterator` struct defines an iterator with a `next` function to iterate over a collection. It holds a pointer to the current data, the next function, and the size of the collection.

### List Struct

The `List` struct represents a basic linked list. It embeds an iterator to enable iteration over its elements.

### Vec Struct

The `Vec` struct represents a dynamic array (vector) and also embeds an iterator for iteration over its elements.

### init Procedure

The `init` procedure initializes a linked list with a given value and sets up the iterator functions.

### Vec_init Procedure

The `Vec_init` procedure initializes a dynamic array with a default capacity. It also sets up the iterator functions for the dynamic array.

### main Procedure

In the `main` procedure, a dynamic array of integers is created using `Vec_init`, and some values are assigned. The iterator is then used to print selected elements from the array. Memory
