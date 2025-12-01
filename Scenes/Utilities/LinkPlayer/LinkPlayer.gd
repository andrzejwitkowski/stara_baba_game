extends Node


class_name LinkPlayer


var _granny_ref: Granny


var granny: Granny:
	get: return _granny_ref


var granny_x: float: 
	get: return _granny_ref.global_position.x if _granny_ref else 0.0


var granny_y: float: 
	get: return _granny_ref.global_position.y if _granny_ref else 0.0


var granny_z: float: 
	get: return _granny_ref.global_position.z if _granny_ref else 0.0


var granny_pos: Vector3: 
	get: return _granny_ref.global_position if _granny_ref else Vector3.ZERO
	
	
func granny_pos_set_y(y: float) -> Vector3:
	return Vector3(_granny_ref.global_position.x, y, _granny_ref.global_position.z)


func direction_to_granny(our_pos: Vector3) -> Vector3:
	#return (_granny_ref.global_position - our_pos).normalized()
	return our_pos.direction_to(_granny_ref.global_position)
	

func granny_too_close(our_pos: Vector3) -> bool:
	return our_pos.distance_to(_granny_ref.global_position) < 0.2


func _ready() -> void:
	find_ref()


func _enter_tree() -> void:
	SignalHub.on_player_died.connect(on_player_died)


func on_player_died():	
	_granny_ref = null

	
func find_ref() -> void:
	_granny_ref = get_tree().get_first_node_in_group(Granny.GROUP_NAME)
