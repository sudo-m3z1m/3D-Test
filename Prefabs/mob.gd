extends CharacterBody3D
class_name Mob

@export var max_mob_speed: float

@onready var player: Player = get_tree().current_scene.get_node("Player")

const GRAVITY = 5
