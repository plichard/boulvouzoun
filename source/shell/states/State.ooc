import ../Shell

State: abstract class {
    
    shell: Shell
    
    init: func (=shell) {}
    
    run: abstract func -> This
    
    reset: abstract func
    
}
