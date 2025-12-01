extends Node3D

@export var y_floor: float = -50.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y < y_floor:
		fall_off() 


func fall_off() -> void:
	GrannyUtils.print_with_parent(self, "falling off")
	get_parent().queue_free()
