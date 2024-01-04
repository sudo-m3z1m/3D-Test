extends State

func _enter_state(anim: AnimationPlayer, player: Player) -> void:
	animation = "Slide"
	super(anim, player)

func _update(delta) -> void:
	pass

func _exit_state() -> void:
	pass
