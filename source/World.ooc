import Relation,Info
import structs/[HashMap,LinkedList]
import io/FileWriter

World: class {
	infos := LinkedList<Info> new()
	relations := LinkedList<Info> new()
	
	init: func {
	}
	
	addInfo: func(info: Info) {
		infos add(info)
	}
	
	addRelation: func(relation: Relation) {
		relations add(relation)
	}
	
	searchInfo: func(name: String) -> Info {
		for(info in infos) {
			for(hname in info humanNames) {
				if(hname == name) {
					return info
				}
			}
		}
		return null
	}
	
	searchRelation: func(name: String) -> Relation {
		for(rel in relations) {
			for(hname in rel humanNames) {
				if(hname == name) {
					return rel
				}
			}
		}
		return null
	}
	
	//file format: nInfo nRelation {infos(nhuman names, {names})} {relations(nhuman names, {names})}
	save: func(filename: String) -> Bool {
		target := FileWriter new(filename)
		if(!target)
			return false
		target write(infos size toString() + " ")
		target write(relations size toString() + "\n")
		for(info in infos) {
			target write(info humanNames size())
			for(hname in info humanNames) {
				target write(hname)
			}
			target write(info relations size())
			for(hname in info relations) {
				target write(hname)
			}
		}
		
		for(rel in relations) {
			target write(rel humanNames size())
			for(hname in rel humanNames) {
				target write(hname)
			}
		}
		target close()
		return true
	}
}
