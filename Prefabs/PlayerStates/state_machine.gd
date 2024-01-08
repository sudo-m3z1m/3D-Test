extends Node3D
class_name StateMachine

@onready var self_owner: Player = get_parent()
@onready var current_state: State = preload("res://Prefabs/PlayerStates/idle.gd").new()

@export var start_state: int

var cur_state: States = States.IDLE_STATE

enum States {IDLE_STATE, MOVING_STATE, DASH_STATE, SLIDE_STATE, HOOK_STATE}

var states: Dictionary = {
	States.IDLE_STATE : "res://Prefabs/PlayerStates/idle.gd",
	States.MOVING_STATE : "res://Prefabs/PlayerStates/moving.gd",
	States.DASH_STATE : "res://Prefabs/PlayerStates/dash.gd",
	States.HOOK_STATE : "res://Prefabs/PlayerStates/hook.gd"
}

func _process(delta):
	current_state._update(delta)

func change_state(state: States) -> void:
	if cur_state == state:
		return
	current_state._exit_state()
	current_state = load(states[state]).new()
	current_state._enter_state(self_owner.hands.get_node("AnimationPlayer"), self_owner)
	cur_state = state
