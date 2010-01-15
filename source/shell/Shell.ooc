import text/StringTokenizer
import Info

Shell: class {
    
    PS1 := "bvz > "
    running := true
    
	init: func {}
    
    run: func {
        
        while(running) {
            PS1 print()
            line := stdin readLine() trim('\n')
            tokLine := StringTokenizer new(line," ")
            while(tokLine hasNext()) {
				analyze( tokLine nextToken() )
			}
            println()
        }
        
    }
    
    quit: func {
		"Exiting..." print()
		running = false
	}
	
	
	analyze: func (word: String) {
		match(word) {
			case "quit" => {
				quit()
			}
			case => {
				printf("What is: '%s' ?\n",word)
			}
		}
		
	}

}


