package main

import "core:fmt"

Iterator :: struct($T:typeid){
    rar_data:rawptr,
    next:proc(iter:^Iterator(T)) -> ^T,
    size:i32
}

List :: struct($T:typeid){
    using iter:Iterator(T),
    data:T,
    forward:^List(T)
}

Vec :: struct($T:typeid){
    using iter :Iterator(T),
    data:[]T,
    capacity:i32
}

init :: proc(val:$T) -> ^List(T){
    lit := new(List(T))
    lit.data = val;
    lit.forward = nil
    lit.rar_data = lit   // conversion 

    lit.next = proc(iter:^Iterator(T)) -> ^T{
        v := cast(^List(T))iter.rar_data;
        if v == nil{return nil}
        t := v.forward
        iter.rar_data = t;

        return &v.data
    }

    return lit
}

Vec_init :: proc($T:typeid) -> Vec(T){
    vec := new(Vec(T))
    vec.data = make([]T,16)
    vec.capacity = 16;
    vec.rar_data = cast(rawptr)&vec.data
    vec.size = 0

    vec.next = proc(iter:^Iterator(T)) -> ^T{
        v := iter.size
        
        vat := cast(^[]T)iter.rar_data
        
        fmt.println(vat)
        
        iter.size += 1

        return &vat[0]
    }
    defer free(vec)
    return vec^
}

main :: proc(){
    a := Vec_init(int)
    a.data[0] = 12;
    a.data[1] = 13;
    a.data[2] = 1331;
    p := cast([^]int)a.rar_data

    for i in 7..<10{
        fmt.println(p[i])
    }

    defer delete(a.data)
    // defer free(&a)
}


// p := make([]i32,2);
// p[0] = 12;
// v:rawptr = cast(^[]i32)&p;

// t := cast(^[]i32)v

// fmt.println(t[0])