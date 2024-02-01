extends State

var hooking_speed: float = 50
var min_lenght_to_hook_pos: float = 5
var raycast: RayCast3D
var hook_pos: Vector3
var hook: CSGBox3D

#var max_speed: float

func _enter_state(player: Player, machine: StateMachine) -> void:
	super(player, machine)
	raycast = target.raycast
	hook = target.spawn_hook()
	#target.generate_hook()
	set_velocity_to_hook_pos()

func _update(delta) -> void:
	if get_len_to_hook_pos().length() <= min_lenght_to_hook_pos or target.is_on_floor():
		state_machine.try_change_state("Jump")
	target.move_and_slide()

func set_velocity_to_hook_pos() -> void:
	var direction: Vector3
	hook_pos = raycast.get_collision_point()
	
	direction = (hook_pos - target.global_position).normalized()
	target.velocity = direction * hooking_speed

func get_len_to_hook_pos() -> Vector3:
	return hook_pos - target.global_position

func _exit_state(next_state: String) -> bool:
	if next_state == "Jump":
		hook.queue_free()
		return true
	return false
