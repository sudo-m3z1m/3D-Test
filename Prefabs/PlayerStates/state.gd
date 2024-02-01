extends RefCounted
class_name State

var declined_states: Array[String]
var animation: String = "Idle"
var animation_player: AnimationPlayer
var state_machine: StateMachine
var target: Player

func _enter_state(player: Player, machine: StateMachine) -> void:
	target = player
	state_machine = machine
	animation_player = player.hands_player
	animation_player.play(animation)

func _update(delta) -> void:
	pass

func _exit_state(next_state: String) -> bool:
	return true
