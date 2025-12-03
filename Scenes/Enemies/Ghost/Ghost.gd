extends Node3D

@export var chase_distance: float = 5.0
@export var speed:float = 2.0
@export var frozen_limit: float = 3.0
@export var teleport_radius: float = 10.0

@onready var effects: AudioStreamPlayer3D = $Effects
@onready var link_player: LinkPlayer = $LinkPlayer
@onready var label_debug: Label3D = $LabelDebug
@onready var model: Node3D = $Model

const EXIT = preload("res://Assets/Audio/Enemies/exit.wav")
const GHOST = preload("res://Assets/Audio/Enemies/ghost.wav")

var _on_screen: bool = false
var _frozen_timer: float = 0.0

func _process(delta: float) -> void:
	if !link_player.granny:
		return
	try_chase(delta)

func _on_screen_notifier_screen_entered() -> void:
	_on_screen = true
	GrannyUtils.play_clip(effects, GHOST)

func _on_screen_notifier_screen_exited() -> void:
	_on_screen = false
	
func try_chase(delta: float) -> void:
	var direction: Vector3 = link_player.direction_to_granny(global_position)
	var flat_position: Vector3 = link_player.granny_pos_set_y(global_position.y)
	var distance_to_player: float = global_position.distance_to(flat_position)
	
	if !link_player.granny_too_close(global_position):
		look_at(flat_position, Vector3.UP)
	
	label_debug.text = "direction:%s\ndistance: %.1f" % [
		GrannyUtils.formatted_vec3(direction),
		distance_to_player
	]
	
	if !_on_screen or (_on_screen and distance_to_player < chase_distance):
		_frozen_timer = 0.0
		position.x += speed * direction.x * delta 
		position.z += speed * direction.z * delta
	else:
		_frozen_timer += delta
		if _frozen_timer >= frozen_limit:
			teleport()
		
func teleport():
	var random_offset = Vector3(
		randf_range(-teleport_radius, teleport_radius),
		0,
		randf_range(-teleport_radius, teleport_radius),
	)
	global_position += random_offset
	_frozen_timer = 0.0
	GrannyUtils.play_clip(effects, EXIT)
