extends Node3D
class_name BaseEntityComponent

@export var parent: Node3D
@export var entity_name: String = "Subject"

@onready var ray_cast: RayCast3D = $RayCast3D

var already_setted_up = false
var grid_scale = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ray_cast.add_exception(parent)


func _physics_process(_delta):
	if !already_setted_up and ray_cast.is_colliding():
		var collider = ray_cast.get_collider()

		if collider is GridMap:
			collider = collider as GridMap
			var cell = ray_cast.get_collider_shape()
			grid_scale = collider.cell_size.x
			var grid_pos = collider.get_used_cells()[cell]

			parent.global_position.x = grid_pos.x*grid_scale+grid_scale/2.0
			parent.global_position.z = grid_pos.z*grid_scale+grid_scale/2.0

			parent.world_controller = collider.get_parent() as WorldController
			parent.world_controller.register_entity(grid_pos, parent)

			already_setted_up = true


## Moves the entity to the center of the desired Cell, not to a specific position
func move(to: Vector3i):
	parent.global_position.x = to.x*grid_scale+grid_scale/2.0
	# parent.global_position.y = to.y
	parent.global_position.z = to.z*grid_scale+grid_scale/2.0
	parent.world_controller.update_entity(parent, to)