extends Mob
class_name Driver

@export var lenght_to_the_player: float

@onready var agent: NavigationAgent3D = $NavigationAgent3D

func _physics_process(delta) -> void:
	agent.target_position = player.global_position
	velocity = lerp(velocity, get_direction_to_target() * max_mob_speed, 0.1)
	if velocity.y >= 0:
		velocity.y += GRAVITY
	velocity.y -= GRAVITY
	rotate_to_target()
	move_and_slide()

func rotate_to_target() -> void:
	var target_position: Vector3 = player.global_position
	look_at(target_position)
	rotation.x = 0

func get_direction_to_target() -> Vector3:
	var direction: Vector3
	var target_position: Vector3 = agent.get_next_path_position()
	direction = (target_position - global_position).normalized()
	return direction
