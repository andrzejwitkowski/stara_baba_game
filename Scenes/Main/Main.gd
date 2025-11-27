extends Control

var _can_press: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and _can_press:
		GameManager.load_next_level()

func _ready() -> void:
	get_tree().paused = false

func set_press_on():
	_can_press = true
