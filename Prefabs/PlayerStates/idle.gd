extends State

var steering_weight: float = 0.2

func _enter_state(player: Player, machine: StateMachine) -> void:
	animation = "Idle"
	super(player, machine)

func _update(delta) -> void:
	target.velocity = lerp(target.velocity, Vector3.ZERO, steering_weight)
	target.camera.rotation.z = lerp(target.camera.rotation.z, 0.0, 0.1)
	target.move_and_slide()

func _exit_state(next_state: String) -> bool:
	return true
