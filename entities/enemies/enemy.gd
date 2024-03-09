extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var world_controller: WorldController

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()


func _on_life_component_died():
	world_controller.delete_entity(self)
	queue_free()
  