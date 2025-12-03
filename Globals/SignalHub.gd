extends Node

signal on_pickup_collected(pick_up: PickUp)

signal on_pickup_scores_updated(scores: PickUpScores)
signal on_jewels_collected
signal on_key_collected
signal on_level_completed
signal on_player_died
signal on_add_new_scene(ob: Node3D, new_position: Vector3)

func emit_on_add_new_scene(ob: Node3D, new_position: Vector3) -> void:
	SignalHub.on_add_new_scene.emit(ob, new_position)

func emit_on_player_died() -> void:
	on_player_died.emit()

func emit_on_level_completed() -> void:
	on_level_completed.emit()

func emit_pickup_collected(pick_up: PickUp) -> void:
	on_pickup_collected.emit(pick_up)
	
func emit_on_pickup_scored_updated(scores: PickUpScores):
	on_pickup_scores_updated.emit(scores)
	
func emit_on_jewels_collected() -> void:
	on_jewels_collected.emit()
	
func emit_on_key_collected():
	on_key_collected.emit()
