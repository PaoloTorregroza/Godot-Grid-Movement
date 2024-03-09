extends Node
class_name PlayerActionsComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack(entity: Node3D):
	var life_node = entity.get_node("LifeComponent")
	if life_node != null:
		(life_node as LifeComponent).damage(10)