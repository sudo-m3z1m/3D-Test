extends Camera3D

@export var angle: float = 150

@onready var target: Player = get_tree().current_scene.get_node("Player")

func _process(delta):
#	rotation.y = global_position.signed_angle_to(to_local(target.position), Vector3.UP)
	look_at(target.global_position)
	rotation_degrees.y = clamp(rotation_degrees.y, (180 - angle) / 2, 180 - ((180 - angle) / 2))
	rotation.x = 0
