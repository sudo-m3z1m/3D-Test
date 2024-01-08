extends Mob
class_name Driver

@export var lenght_to_the_player: float

func _physics_process(delta) -> void:
	velocity = lerp(velocity, get_direction_to_target() * max_mob_speed, 0.1)
	velocity.y -= GRAVITY
	rotate_to_target()
	move_and_slide()

func rotate_to_target() -> void:
	var target_position: Vector3 = player.global_position
	look_at(target_position)
	rotation.x = 0

func get_direction_to_target() -> Vector3:
	var direction: Vector3
	var target_position: Vector3 = player.global_position
	if (target_position - global_position).length() <= lenght_to_the_player:
		return Vector3.ZERO
	direction = global_position.direction_to(target_position)
	return direction
