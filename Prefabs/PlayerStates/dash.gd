extends State

var dash_speed: float = 200
var default_camera_fov: float
var camera_fov: float = 110
var tween: Tween

func _enter_state(anim: AnimationPlayer, player: Player) -> void:
	animation = "Dash"
	super(anim, player)
	
	default_camera_fov = target.camera.fov
	tween = target.create_tween()
	animation_player.play(animation)
	tween.tween_property(target.camera, "fov", camera_fov, 0.1)
	
	var direction: Vector3 = Vector3.FORWARD.rotated(Vector3.UP, target.camera.rotation.y)
	
	target.velocity = direction * dash_speed

func _exit_state() -> void:
	tween.tween_property(target.camera, "fov", default_camera_fov, 0.1)
