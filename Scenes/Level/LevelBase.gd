extends Node

@onready var music: AudioStreamPlayer = $Music

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.change_to_main()
		
func _enter_tree() -> void:
	SignalHub.on_level_completed.connect(on_level_completed)
	
func on_level_completed() -> void:
	music.stop()
