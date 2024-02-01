extends State

var start_time: int
var dash_time: int = 150
var dash_speed: float = 50
var dash_weight: float = 0.5
var default_fov: float

func _enter_state(player: Player, machine: StateMachine) -> void:
	super(player, machine)
	start_time = Time.get_ticks_msec()
	default_fov = target.camera.fov
	set_dash()

func _update(delta) -> void:
	target.move_and_slide()

func set_dash() -> void:
	var direction: Vector3 = Vector3.FORWARD.rotated(Vector3.UP, target.camera.rotation.y)
	target.velocity = direction * dash_speed

func _exit_state(next_state: String) -> bool:
	if Time.get_ticks_msec() - start_time <= dash_time:
		return false
	return true
