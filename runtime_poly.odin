package runtime_poly

import "core:fmt"

SoundEmitter_interface :: struct{
    sound:int,
    make_sound:proc(inter:^SoundEmitter_interface)
}

Human :: struct{
    using inter :SoundEmitter_interface,
    is_intelligent:bool
}

Cat :: struct {
    using inter :SoundEmitter_interface,
    is_intelligent:bool
}

produce_sound :: proc(inter:^SoundEmitter_interface){
    inter->make_sound()
}

main :: proc(){
    human := Human{is_intelligent = true,make_sound=proc(inter:^SoundEmitter_interface){
        fmt.println("This is a sound of HUman")
    }}

    cat := Cat{is_intelligent = false,make_sound = proc(inter:^SoundEmitter_interface){
        fmt.println("MEOEEOW")
    }}

    // can dynaically dispatch over the make_sound using SoundEmitter_interface vtable

    produce_sound(&human)
    produce_sound(&cat)
    
}