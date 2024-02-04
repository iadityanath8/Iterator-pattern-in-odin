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

MAXSIZE :: 3   // this is just for test we will use the len property that we will implement later in iterator 

Vec_init :: proc($T:typeid) -> Vec(T){
    vec := Vec(T){}
    vec.data = make([]T,16)
    vec.capacity = 16;
    vec.rar_data = cast(rawptr)&vec.data[0]     // dangerous cast
    vec.size = 0

    vec.next = proc(iter:^Iterator(T)) -> ^T{
        v := iter.size
        if v >= MAXSIZE {return nil}
        vat := cast([^]T)iter.rar_data      
        
        iter.size += 1

        return &vat[v]
    }
    return vec
}


ForEach :: proc(it:^Iterator($T)){ // using generic parameter
    for {
        v := it->next()
        if v == nil{break;}
        fmt.println(v^)
    }
}

main :: proc(){
    a := Vec_init(int)
    a.data[0] = 12;
    a.data[1] = 13;
    a.data[2] = 1331;
    
    ForEach(cast(^Iterator(int))&a);
    
    b := init(121)
    b.forward = init(113)
    b.forward.forward = init(114)

    fmt.println("---------------------------------------------------")

    ForEach(cast(^Iterator(int))b);
}


// p := make([]i32,2);
// p[0] = 12;
// v:rawptr = cast(^[]i32)&p;

// t := cast(^[]i32)v

// fmt.println(t[0])