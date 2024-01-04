extends RefCounted
class_name State

var animation: String = "Idle"
var animation_player: AnimationPlayer
var target: Player

func _enter_state(anim: AnimationPlayer, player: Player) -> void:
	animation_player = anim
	target = player
	animation_player.queue(animation)

func _update(delta) -> void:
	pass

func _exit_state() -> void:
	pass
