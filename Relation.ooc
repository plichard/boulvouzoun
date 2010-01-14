import Info


//the relation goes from info1 to info2
Relation: abstract class extends Info {
	id1,id2: ID
	init: func ~relation(){
		super()
	}
}

//for example: info1 has info2
HasRelation: class extends Relation {
	init: func ~has(=id1,=id2,w: Double) {
		super()
		this rate(w)
	}
}


BeRelation: class extends Relation {
	init: func ~be(=id1,=id2,w: Double) {
		super()
		this rate(w)
	}
}
