extends State

var jump_strength: float = 50
var max_speed: float = 10

const GRAVITY: float = 4

func _enter_state(player: Player, machine: StateMachine) -> void:
	#animation = "Jump"
	super(player, machine)
	if target.is_on_floor():
		target.velocity += Vector3.UP * jump_strength

func _update(delta) -> void:
	if target.is_on_floor():
		state_machine.try_change_state("Move")
	target.velocity = lerp(target.velocity, get_direction() * max_speed, 0.2)
	target.velocity.y -= GRAVITY
	target.move_and_slide()

func get_direction() -> Vector3:
	var direction: Vector3 = Vector3.ZERO
	
	direction.z = Input.get_axis("Forward", "Down")
	direction.x = Input.get_axis("Left", "Right")
	direction = direction.rotated(Vector3.UP, target.camera.rotation.y)
	
	return direction

func _exit_state(next_state: String) -> bool:
	if !target.is_on_floor():
		return false
	return true
