use readline
import readline

import text/[StringTokenizer, StringBuffer], structs/[ArrayList, List]
import State, LoginState
import ../../[Relation, Info]

IdleState: class extends State {

    PS1 := "\nbvz > "
    buffer : String = null
    
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
                match(tokens[i + 1]) {
                    case "about" =>
                        info := getInfo(lastPart(tokens, i + 1))
                        for(relation in info getRelations()) {
                            "I know that %s" format(relation toString()) println()
                        }
                    case "is" => {
                        token2 := tokens[i+2]
                        if(token2 == "a") {
                            info := getInfo(lastPart(tokens, i + 2))
                            printAllRelations(info, IsOfTypeRelation)
                        } else {
                            info := getInfo(lastPart(tokens, i + 1))
                            printAllRelations(info, BeRelation)
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
                "  Got new relation %s (ID=%d)" format(relation toString(), relation getID()) println()
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
                        
                        if(!holds(criterion, candidate)) {
                            allHolds = false
                            break
                        }
                    }
                    
                    if(!allHolds) {
                        continue
                    }
                    
                    " - %s is a match!" format(candidate toString()) println()
                }
                return
            }
            
            i += 1
        }
        
        "  Come again?" println()
        
    }
    
    printAllRelations: func (rightOperand: Info, relationType: Class) {
        
        for(i: ID in 1..Info lastID) {
            candidate := i getInfo()
            if(candidate == null) {
                break
            }
            //"Reviewing candidate %s" format(candidate toString()) println()
            if(candidate instanceOf(relationType) && candidate as Relation getID2() == rightOperand getID()) {
                " - %s" format(candidate toString()) println()
            }
            if(relationType != IsOfTypeRelation && candidate instanceOf(IsOfTypeRelation)) {
                rel := candidate as Relation
                printRelations(rel getID1() getInfo(), rel getID2() getInfo(), rightOperand, relationType)
            }
        }
        
    }
    
    printRelations: func (origin, current, rightOperand : Info, relationType: Class) {
        
        //"Should print all relations of type %s in %s where rightOperand is %s\n" format(relationType name, current toString(), rightOperand toString()) println()
        for(rel in current getRelations()) {
            if(rel instanceOf(relationType) && rel getID2() == rightOperand getID()) {
                " - %s (because it's a %s)" format(origin toString(), current toString()) println()
            } else if(rel instanceOf(IsOfTypeRelation) && rel getID1() == current getID()) {
                printRelations(origin, rel getID2() getInfo(), rightOperand, relationType)
            }
        }
        
    }
    
    holds: func (criterion, candidate: Info) -> Bool {
        
        for(relation in candidate relations) {
            if(relation getID1() == candidate getID() && relation getID2() == criterion getID()) {
                return true
            }
        }
        
        for(relation in candidate relations) {
            if(relation getID1() == candidate getID() && relation instanceOf(IsOfTypeRelation)) {
                if(holds(criterion, relation getID2() getInfo())) return true
            }
        }
        
        return false
        
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
        if(buffer) free(buffer)
        buffer = readline(PS1)
        if(!buffer isEmpty()) add_history(buffer)
        buffer
    }
    
    reset: func {}
    
}
