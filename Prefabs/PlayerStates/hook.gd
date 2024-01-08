extends State

var hook_pos: Vector3
var hook_speed: float = 160
var min_hook_length: float = 10

func _enter_state(anim: AnimationPlayer, player: Player) -> void:
	animation = "Attack001"
	super(anim, player)
	target.is_on_hook = true
	target.velocity = get_hook_direction() * hook_speed

func _update(delta) -> void:
	if (hook_pos - target.global_position).length() >= min_hook_length:
		return
	_exit_state()

func _exit_state() -> void:
	target.is_on_hook = false

func get_hook_direction() -> Vector3:
	var direction_to_hook: Vector3
	hook_pos = target.raycast.get_collision_point()
	
	direction_to_hook = target.global_position.direction_to(hook_pos)
	
	return direction_to_hook

func make_hook_render() -> void:
	pass
