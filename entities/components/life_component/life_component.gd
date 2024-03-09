extends Node
class_name LifeComponent

signal died
signal healed
signal damaged

@export var max_life: int = 10
@export var life: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	if life > max_life:
		life = max_life


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	died.emit()


func heal(amount: int):
	var new = life + amount

	if new>max_life:
		new = max_life

	life = new
	healed.emit()

func damage(amount: int):
	life -= amount

	damaged.emit()
	
	if life<=0:
		die()