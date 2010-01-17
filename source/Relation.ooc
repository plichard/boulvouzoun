import Info

// the relation goes from info1 to info2
Relation: abstract class extends Info {
    
	id1, id2: ID
    
	init: func ~relation(=id1, =id2, w: Double) {
		super()
        rate(w)
        id1 getInfo() addRelation(this)
        id2 getInfo() addRelation(this)
	}
    
    getID1: func -> ID { id1 }
    getID2: func -> ID { id2 }
    
}

AttributeRelation: class extends Relation {
    
    attributeID: ID
    
	init: func ~be (.id1, .id2, =attributeID, w: Double) {
		super(id1, id2, w)
	}
    
    getAttributeID: func -> ID { attributeID }
    
    toString: func -> String {
        id1 getInfo() toString() + "'s " + attributeID getInfo() toString() +  " is " +id2 getInfo() toString()
    }
    
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
		super(id1, id2, w)
	}
    
    toString: func -> String {
        id1 getInfo() toString() + " is " +id2 getInfo() toString()
    }
    
}

IsOfTypeRelation: class extends Relation {
    
	init: func ~isKind (.id1, .id2, w: Double) {
		super(id1, id2, w)
	}
    
    toString: func -> String {
        id1 getInfo() toString() + " is a " +id2 getInfo() toString()
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

