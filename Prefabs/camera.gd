extends Camera3D

@export var angle: float = 150

@onready var target: Player = get_tree().current_scene.get_node("Player")

func _process(delta):
	look_at(target.global_position)
	rotation_degrees.y = clamp(rotation_degrees.y, (180 - angle) / 2, angle + ((180 - angle) / 2))
	rotation.x = 0
