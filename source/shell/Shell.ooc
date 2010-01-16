import text/StringTokenizer, structs/ArrayList
import Info

State: abstract class {
    
    shell: Shell
    
    init: func (=shell) {}
    
    run: abstract func -> This
    
    reset: abstract func
    
}

LoginState: class extends State {
    
    askUser = 1, askPwd = 2 : static Int
    username := ""
    password := ""
    
    state := askUser
    
    init: func ~login (.shell) { super(shell) }
    
    run: func -> This {
        
        res : This = match(state) {
            case askUser =>
                "username: " print()
                username = stdin readLine() trim('\n')
                state = askPwd
                this
            case askPwd =>
                "password: " print()
                password = stdin readLine() trim('\n')
                shell user = username
                IdleState new(shell)
        }
        return res
        
    }
    
    reset: func {
    
        username = ""
        password = ""
        
    }
    
}

IdleState: class extends State {
    
    PS1 := "\nbvz > "
    
    init: func ~idle (.shell) { super(shell) }
    
    run: func -> This {
        
        tokens := StringTokenizer new(readLine(), " ") toArrayList()
        
        match(tokens[0]) {
            case "/logout" =>
                return LoginState new(shell)
            case "/quit" =>
                "Bye!" println()
                shell running = false
            case =>
                "What's %s?" format(tokens[0]) println()
        }
        
        this
        
    }
    
    readLine: func -> String {
        PS1 print()
        stdin readLine() trim('\n')
    }
    
    reset: func {}
    
}


Shell: class {
    
    running := true
    
    state := LoginState new(this)
    user := ""
    
	init: func {
        title := " boulvouzoun - Peter Lichard & Amos Wenger, 2010 "
        lines := "=" * title length()
        lines println(); title println(); lines println(); println()
    }
    
    run: func {
        
        while(running) {
            newState := state run()
            if(newState != state) {
                state reset()
            }
            state = newState
        }
        
    }

}




