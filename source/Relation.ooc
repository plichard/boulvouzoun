import Info

// the relation goes from info1 to info2
Relation: abstract class extends Info {
    
	id1, id2: ID
    
	init: func ~relation(=id1, =id2, w: Double) {
        "New Relation between %d and %d with weight %.2f" format(id1, id2, w) println()
		super()
        rate(w)
        id1 getInfo() addRelation(this)
	}
    
    getID1: func -> ID { id1 }
    getID2: func -> ID { id2 }
    
}

// for example: info1 has info2
HasRelation: class extends Relation {
    
	init: func ~be (.id1, .id2, w: Double) {
		super(id1, id2, w)
	}
    
    toString: func -> String {
        id1 getInfo() toString() + " has " +id2 getInfo() toString()
    }
    
}


BeRelation: class extends Relation {
    
	init: func ~be (.id1, .id2, w: Double) {
        "New BeRelation between %d and %d with weight %.2f" format(id1, id2, w) println()
		super(id1, id2, w)
	}
    
    toString: func -> String {
        id1 getInfo() toString() + " is " +id2 getInfo() toString()
    }
    
}

CompType: class {
	more := static 0
	less := static 1
	equal := static 2
}

// id1 can be more/equally/less something than id2

CompareRelation: class extends Relation {
    
	something: ID
	type: Int
    
	init: func ~be(.id1, .id2, w: Double, =something, =type) {
		super(id1, id2, w)
	}
    
}

