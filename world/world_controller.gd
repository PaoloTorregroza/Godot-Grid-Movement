# Keeps track of who is where [{<Goblin23211321>: (4,0,2)}]
extends Node3D
class_name WorldController

var entities: Array[Dictionary] = []

enum CELL_ACTION {ATTACK}

func _get_entity_in_cell(cell: Vector3i):
	for entity: Dictionary in entities:
		if entity.values()[0] == cell:
			return entity.keys()[0]

func get_entity(cell: Vector3i):
	var entity = _get_entity_in_cell(cell)
	print(entities)
	if entity != null:
		return entity


func register_entity(pos: Vector3i, entity: Node3D):
	entities.append({entity: pos})


func update_entity(entity: Node3D, new_pos: Vector3i):
	for el: Dictionary in entities:
		if el.keys()[0] == entity:
			el[entity] = new_pos
			return

func delete_entity(entity: Node3D):
	for el: Dictionary in entities:
		if el.keys()[0] == entity:
			entities.erase(el)
			return