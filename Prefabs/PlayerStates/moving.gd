extends State

#var tween: Tween
var max_rotate_angle: float = 5
var max_speed: float = 25

func _enter_state(anim: AnimationPlayer, player: Player) -> void:
	super(anim, player)
	target.max_speed = 25

func _update(delta) -> void:
	var direction: float = -Input.get_axis("Left", "Right") * max_rotate_angle
	target.camera.rotation_degrees.z = lerp(target.camera.rotation_degrees.z, direction, 0.1)
