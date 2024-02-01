extends CharacterBody3D

class_name Player

@export var mouse_sensivity: float
@export var max_upper_angle_degress: float
@export var mesh_packed: PackedScene
@export var hook_segment_packed: PackedScene

@onready var camera: Camera3D = $Camera3D
@onready var raycast: RayCast3D = $Camera3D/RayCast
@onready var hands: Node3D = $Camera3D/WeaponPlace/glock
@onready var hands_player: AnimationPlayer = $Camera3D/WeaponPlace/glock/AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var shot_audio_player: AudioStreamPlayer3D = $ShotAudioPlayer

const GRAVITY: float = 5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	move_and_slide()
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, max_upper_angle_degress)

func _input(event):
	if event is InputEventMouseMotion:
		camera.rotation.x -= event.relative.y * mouse_sensivity
		camera.rotation.y -= event.relative.x * mouse_sensivity

func spawn_mesh() -> void:
	if !raycast.get_collider():
		return
	var new_mesh: CSGCombiner3D = mesh_packed.instantiate()
	raycast.get_collider().add_child(new_mesh)
	new_mesh.global_position = raycast.get_collision_point()

func generate_hook() -> void:
	var direction: Vector3 = raycast.get_collision_point() - global_position
	var hook_segments: Array[RigidBody3D]
	fill_hook(direction.length(), hook_segments, direction)
	hook_segments[-1].freeze = true

func fill_hook(length: int, hook_segments: Array[RigidBody3D], direction: Vector3) -> void:
	var hook_segment: RigidBody3D
	var hook_joint: PinJoint3D
	for m in length:
		hook_segment = hook_segment_packed.instantiate()
		get_tree().current_scene.add_child(hook_segment)
		hook_segment.global_position = raycast.get_collision_point()
		hook_segment.global_position = global_position + direction.normalized() * m
		hook_segment.rotation = raycast.rotation
		if m == 0:
			hook_segments.append(hook_segment)
			continue
		hook_joint = hook_segment.get_node("PinJoint3D")
		hook_joint.node_a = hook_segment.get_path()
		hook_joint.node_b = hook_segments[m - 1].get_path()
		hook_segments.append(hook_segment)

func spawn_hook() -> CSGBox3D:
	var box: CSGBox3D = CSGBox3D.new()
	
	box.size.x = 0.5
	box.size.y = 0.5
	box.size.z = (raycast.get_collision_point() - global_position).length()
	
	get_tree().current_scene.add_child(box)
	box.global_position = (global_position + raycast.get_collision_point()) / 2
	box.look_at(raycast.get_collision_point())
	
	return box

func attack() -> void:
	hands.get_node("AnimationPlayer").play("Attack_001")
	shot_audio_player.pitch_scale = randf_range(0.6, 0.8)
	#spawn_hook()
	#shot_audio_player.play()
	#spawn_mesh()
	#generate_hook()
