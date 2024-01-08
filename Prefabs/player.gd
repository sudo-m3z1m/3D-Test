extends CharacterBody3D

class_name Player

@export var jump_strenght: float
@export var mouse_sensivity: float
@export var max_upper_angle_degress: float
@export var speed_factor: float
@export var decal_scene: PackedScene
@export var max_speed: float
@export var is_on_hook: bool = false

@onready var camera: Camera3D = $Camera3D
@onready var raycast: RayCast3D = $Camera3D/RayCast
@onready var hands: Node3D = $Camera3D/WeaponPlace/hand_with_knife
@onready var state_machine: StateMachine = $StateMachine
@onready var timer: Timer = $DashTimer

const GRAVITY: float = 5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	velocity.y -= GRAVITY
	if !is_on_hook or is_on_floor():
		velocity = velocity.lerp(get_direction() * max_speed, 0.25)

	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, max_upper_angle_degress)
	move_and_slide()

func get_direction() -> Vector3:
	var direction: Vector3 = Vector3.ZERO
	direction.z = Input.get_axis("Forward", "Down")
	direction.x = Input.get_axis("Left", "Right")

	if direction.length() > 0:
		state_machine.change_state(state_machine.States.MOVING_STATE)
	else:
		state_machine.change_state(state_machine.States.IDLE_STATE)
	
	direction = direction.rotated(Vector3.UP, camera.rotation.y)
	
	return direction

func _input(event):
	if event is InputEventMouseMotion:
		camera.rotation.x -= event.relative.y * mouse_sensivity
		camera.rotation.y -= event.relative.x * mouse_sensivity
	
	if event.is_action_pressed("Space") and is_on_floor():
		velocity.y += Vector3.UP.y * jump_strenght #Check event class

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		pass

	if event.is_action_pressed("Mouse Left"):
		attack()
	
	if event.is_action_pressed("Hook"):
		state_machine.change_state(state_machine.States.HOOK_STATE)

	if event.is_action_pressed("Shift"):
		state_machine.change_state(state_machine.States.DASH_STATE)

func spawn_decal() -> Decal:
	var decal: Decal = decal_scene.instantiate()
	
	get_tree().current_scene.add_child(decal)
	decal.global_position = raycast.get_collision_point()
	
	decal.rotation = raycast.get_collision_normal()
	decal.rotation_degrees.y = decal.global_position.y / decal.global_position.y * 90
	
	return decal

func attack() -> void:
	hands.get_node("AnimationPlayer").play("Attack001")
	spawn_decal()

func end_dash():
	state_machine.change_state(state_machine.States.MOVING_STATE)
