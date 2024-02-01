extends Node3D
class_name StateMachine

@onready var target: Player = get_parent()

var states_map: Dictionary = {
	"Idle" : "res://Prefabs/PlayerStates/idle.gd",
	"Move" : "res://Prefabs/PlayerStates/moving.gd",
	"Jump" : "res://Prefabs/PlayerStates/jump.gd",
	"Dash" : "res://Prefabs/PlayerStates/dash.gd",
	"Hook" : "res://Prefabs/PlayerStates/hook.gd"
}

var current_state: String = "Idle"
var current_state_script: State = State.new()

func _physics_process(delta):
	current_state_script._update(delta)

func try_change_state(state: String) -> bool:
	if current_state == state:
		return true
	if !current_state_script._exit_state(state):
		return false
	
	current_state_script = load(states_map[state]).new()
	current_state = state
	current_state_script._enter_state(target, self)
	return true
