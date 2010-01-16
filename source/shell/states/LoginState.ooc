import State, IdleState

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
                shell setUser(username)
                IdleState new(shell)
        }
        return res
        
    }
    
    reset: func {
    
        username = ""
        password = ""
        
    }
    
}
