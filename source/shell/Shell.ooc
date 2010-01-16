import Info, World

import states/[State, LoginState, IdleState]

Shell: class {
    
    world := World new()
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
    
    setUser: func (=user) {}
    
    getUser: func -> String { user }
    
    getWorld: func -> World { world }

    quit: func {
        "Bye!" println()
        running = false
    }

}
