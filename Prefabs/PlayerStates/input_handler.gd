extends Node

class_name InputHandler

@onready var state_machine: StateMachine = get_parent().get_node("StateMachine")
@onready var target: Player = get_parent()

var inputs: Array[InputEvent]
var state_inputs: Array[String] = ["Shift", "Space", "Hook", "Mouse Left"]
var movement_inputs: Array[String] = ["Forward", "Right", "Down", "Left"]

func _unhandled_input(input_event: InputEvent) -> void:
	if input_event is InputEventMouseMotion:
		return
	add_to_motions_stack(input_event)

func add_to_motions_stack(input_event: InputEvent) -> void:
	for state_action in state_inputs:
		if input_event.is_action(state_action):
			inputs.append(input_event)

func is_event_movement() -> void:
	for move_action in movement_inputs:
		if Input.is_action_pressed(move_action):
			state_machine.try_change_state("Move")

func _process(delta):
	state_machine.try_change_state("Idle")
	is_event_movement()
	solve_inputs()

func solve_inputs() -> void:
	var new_state_name: String = "Move"
	var event: InputEvent
	if inputs.is_empty():
		return
	event = inputs[0]
	if event.is_action("Shift"):
		new_state_name = "Dash"
	elif event.is_action("Space"):
		new_state_name = "Jump"
	elif event.is_action("Hook"):
		new_state_name = "Hook"
	elif event.is_action("Mouse Left"):
		target.attack()
		inputs.pop_front()
		return
	if !state_machine.try_change_state(new_state_name):
		return
	inputs.pop_front()
