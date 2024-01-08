extends State

var default_max_speed: float

func _enter_state(anim: AnimationPlayer, player: Player) -> void:
	super(anim, player)
	default_max_speed = target.max_speed
	target.max_speed = 0
