extends State

var max_speed: float = 15
var acceleration_weight: float = 0.3
var direction: Vector3
var max_camera_rotation: float = 3

func _enter_state(player: Player, machine: StateMachine) -> void:
	declined_states.append("Idle")
	animation = "Walk"
	super(player, machine)

func _update(delta) -> void:
	if !target.is_on_floor():
		state_machine.try_change_state("Jump")
	get_direction()
	target.velocity = target.velocity.lerp(direction * max_speed, acceleration_weight)
	target.move_and_slide()

func _exit_state(next_state: String) -> bool:
	for state in declined_states:
		if direction and next_state == state:
			return false
	return true

func rotate_camera() -> void:
	target.camera.rotation_degrees.z = lerp(target.camera.rotation_degrees.z,\
	 -direction.x * max_camera_rotation, acceleration_weight - 0.1)

func get_direction() -> Vector3:
	direction.z = Input.get_axis("Forward", "Down")
	direction.x = Input.get_axis("Left", "Right")
	rotate_camera()
	direction = direction.rotated(Vector3.UP, target.camera.rotation.y)
	
	return direction
