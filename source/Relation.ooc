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


CompType: cover {
	more := 0
	less := 1
	equal := 2
}

//id1 can be more/equaly/less someting than id2
CompareRelation: class extends Relation {
	something: ID
	type: Int
	init: func ~be(=id1,=id2,w: Double,=something,=type) {
		super()
		this rate(w)
	}
}

