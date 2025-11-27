extends Node


const MAIN_SCENE = preload("res://Scenes/Main/Main.tscn")


const LEVELS: Dictionary[int, PackedScene] = {
	1: preload("res://Scenes/Level/LevelBase.tscn")
}

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _exit_tree():
	pass


func change_to_main():
	get_tree().change_scene_to_packed(MAIN_SCENE)


func load_next_level():
	get_tree().change_scene_to_packed(LEVELS[1 ])
