include stdint

import structs/[LinkedList,ArrayList]
import Relation

ID: cover from UInt64

Info: abstract class {
    
	trust: Double = 0.0
	relations: LinkedList<Relation>
	humanNames: ArrayList<String>
	id: ID
	lastId: static ID = 0 // an ID of 0 is invalid
	
	init: func {
		relations = LinkedList<Relation> new()
		humanNames = ArrayList<String> new()
		lastId += 1
		id = lastId
	}
    
    init: func ~humanName (humanName: String) {
        init()
        humanNames add(humanName)
    }
	
	rate: func(d: Double) {
		trust += d
	}
    
    getID: func -> ID { id }
	
}



