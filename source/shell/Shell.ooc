Shell: class {
    
    PS1 := "bvz > "
    
	init: func {}
    
    run: func {
        
        while(true) {
            PS1 print()
            line := stdin readLine() trim('\n')
            line println()
        }
        
    }


}
