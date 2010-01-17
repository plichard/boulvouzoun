import text/[StringTokenizer, StringBuffer], structs/[ArrayList, List]
import State, LoginState
import ../../[Relation, Info]

IdleState: class extends State {

    PS1 := "\nbvz > "
    
    init: func ~idle (.shell) { super(shell) }
    
    run: func -> This {
        
        tokens := StringTokenizer new(readLine(), " ") toArrayList()
        
        match(tokens[0]) {
            case "/logout" =>
                println()
                return LoginState new(shell)
            case "/quit" =>
                shell quit()
            case "/save" => {
				if(tokens size() == 2){
					shell getWorld() save(tokens[1])
					printf("Saving world to %s...\n",tokens[1])
				} else {
					printf("usage: /save [filename]\n")
				}
			}
				
            case =>
                analyze(tokens)
        }
        
        this
        
    }
    
    analyze: func (tokens: List<String>) {
        
        relation : Relation = null
        
        i := 0
        for(token in tokens) {
            
            if(token == "what") {
                info := getInfo(lastPart(tokens, i + 1))
                match(tokens[i + 1]) {
                    case "about" =>
                        for(relation in info getRelations()) {
                            "I know that %s" format(relation toString()) println()
                        }
                    case "is" =>
                        for(id: ID in 1..Info lastID) {
                            candidate := id getInfo()
                            if(candidate != null && candidate instanceOf(BeRelation)) {
                                rel := candidate as BeRelation
                                if(rel getID2() == info getID()) {
                                    " - %s" format(rel toString()) println()
                                }
                            }
                        }
                    case =>
                        "  I don't know what '%s' means!" format(tokens[1]) println()
                }
                return
            }
            
            if(token == "is") {
                relation : Relation = null
                nextToken := tokens[i + 1]
                if(nextToken == "a") {
                    relation = IsOfTypeRelation new(getID(firstPart(tokens, i)), getID(lastPart(tokens, i + 1)), 0.5)
                } else {
                    relation = BeRelation new(getID(firstPart(tokens, i)), getID(lastPart(tokens, i)), 0.5)
                }
                " Got new relation %s (ID=%d)" format(relation toString(), relation getID()) println()
                return
            }
            
            if(token == "search") {
                list := StringTokenizer new(lastPart(tokens, i), ",") toArrayList()
                for(id : ID in 1..Info lastID) {
                    candidate := id getInfo()
                    if(candidate == null) continue
                    
                    allHolds := true
                    
                    for(elem in list) {
                        elem = elem trim()
                        criterion := getInfo(elem)
                        
                        holds := false
                        for(relation in candidate relations) {
                            if(relation getID1() == candidate getID() && relation getID2() == criterion getID()) {
                                //"Well, %s!" format(relation toString()) println()
                                holds = true
                            }
                        }
                        
                        if(!holds) {
                            allHolds = false
                            break
                        }
                    }
                    
                    if(!allHolds) {
                        continue
                    }
                    
                    " - %s is a match!" format(candidate toString()) println()
                }
            }
            
            i += 1
        }
        
        "  Fiddle-dee dum!"
        
    }
    
    firstPart: func (tokens: List<String>, i: Int) -> String {
        return part(tokens, 0, i)
    }
    
    lastPart: func (tokens: List<String>, i: Int) -> String {
        return part(tokens, i + 1, tokens size())
    }
    
    part: func (tokens: List<String>, start, end: Int) -> String {
        sb := StringBuffer new(tokens[start])
        for(i in (start + 1)..end) {
            sb append(' ') .append(tokens[i])
        }
        sb toString()
    }
    
    getInfo: func (s: String) -> Info {
        info := shell getWorld() searchInfo(s)
        if(info == null) {
            info = Info new(s)
            shell getWorld() addInfo(info)
            "  Hey, '%s' is new to me! (ID=%d)" format(s, info getID()) println()
        }
        info
    }
    
    getID: func (s: String) -> ID {
        info := getInfo(s)
        return info getID()
    }
    
    readLine: func -> String {
        PS1 print()
        stdin readLine() trim('\n')
    }
    
    reset: func {}
    
}
