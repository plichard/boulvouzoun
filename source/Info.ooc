include stdint

import structs/[LinkedList, ArrayList, List, HashMap]
import Relation

ID: cover from UInt64 {
    
    toString: func -> String { this as UInt64 toString() }
    
    getInfo: func -> Info { Info get(this) }
    
}

Info: abstract class {
    
    
	trust: Double = 0.0
	relations: LinkedList<Relation>
	humanNames: ArrayList<String>
    
	id: ID
    
	lastId: static ID = 0 // an ID of 0 is invalid
    map := static HashMap<This> new()
	
	init: func {
		relations = LinkedList<Relation> new()
		humanNames = ArrayList<String> new()
        
		lastId += 1
		id = lastId
        
        map put(id toString(), this)
	}
    
    init: func ~humanName (humanName: String) {
        init()
        humanNames add(humanName)
    }
    
    getRelations: func -> List<Relation> { relations }
    
    addRelation: func (r: Relation) {
        relations add(r)
    }
	
	rate: func(d: Double) {
		trust += d
	}
    
    getID: func -> ID { id }
    
    get: static func (id: ID) -> This { map get(id toString()) }
    
    toString: func -> String {
        
        if(!humanNames isEmpty()) {
            return humanNames[0]
        } else {
            return "noname"
        }
        
    }
	
}



