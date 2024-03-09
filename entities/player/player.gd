extends CharacterBody3D

@onready var camera = $Camera3D
@onready var base_entity_component: BaseEntityComponent = $BaseEntityComponent
@onready var player_actions_component: PlayerActionsComponent = $PlayerActionsComponent

var world_controller: WorldController

const TURN_SPEED = 90

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var grid_scale = 0

func _input(event):
	if event.is_action_pressed("click"):
		click_3d()


func _physics_process(delta):
	if Input.is_action_pressed("turn_left"):
		rotate(Vector3(0,1,0), deg_to_rad(TURN_SPEED*delta))

	if Input.is_action_pressed("turn_right"):
		rotate(Vector3(0,1,0), deg_to_rad(-TURN_SPEED*delta))

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()


func click_3d():
	var pos = _get_clicked_mesh_cell_position()
	if pos != null:
		var entity = world_controller.get_entity(pos)
		if entity != null:
			player_actions_component.attack(entity)
		else:
			base_entity_component.move(pos)


func _get_clicked_mesh_cell_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()

	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)

	if raycast_result.has("collider"):
		var grid = (raycast_result.collider as GridMap)
		if grid != null:
			var cells = grid.get_used_cells()
			grid_scale = grid.cell_size.x
			
			return cells[raycast_result.shape]

func _on_life_component_died():
	queue_free()
