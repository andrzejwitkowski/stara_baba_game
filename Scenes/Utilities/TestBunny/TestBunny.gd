extends Node3D

@export var fall_speed: float = 10.0
@onready var link_player: LinkPlayer = $LinkPlayer

func _process(delta: float) -> void:
	#position.y -= fall_speed * delta
	var flat_position = link_player.granny_pos_set_y(global_position.y)
	look_at(flat_position, Vector3.UP)

func _exit_tree() -> void:
	print(link_player.direction_to_granny(global_position))
	print("Test Bunny says bye bye")
