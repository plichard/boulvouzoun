include stdint

import structs/[LinkedList,ArrayList]
import Relation

ID: cover from UInt64

Info: abstract class {
	trust: Double = 0.0
	relations: LinkedList<Relation>
	humanNames: ArrayList<String>
	id: ID
	lastid: static ID = 0	//an ID of 0 is invalid
	
	init: func {
		relations = LinkedList<Relation> new()
		humanNames = ArrayList<String> new()
		lastid += 1
		id = lastid
	}
	
	rate: func(d: Double) {
		trust += d
	}
	
}



