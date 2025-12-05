extends CharacterBody3D

@export var speed: float = 3.0
@export var gravity: float = -20.0
@export var jump_speed: float = 10.0
@export var jump_distance: float = 10.0

@onready var jump_timer: Timer = $JumpTimer
@onready var label_debug: Label3D = $LabelDebug
@onready var link_player: LinkPlayer = $LinkPlayer
@onready var effect: AudioStreamPlayer3D = $Effect


var _can_jump: bool = true
var _was_on_floor: bool = false

func _physics_process(delta: float) -> void:
	if !link_player.granny:
		return

	velocity.y += gravity * delta
	try_jump()
	move_and_slide()
	
	if _was_on_floor != is_on_floor():
		effect.play()
		_was_on_floor = is_on_floor()
	
func try_jump():
	var direction: Vector3 = link_player.direction_to_granny(global_position)
	var flat_position: Vector3 = link_player.granny_pos_set_y(global_position.y)
	var distance_to_player: float = global_position.distance_to(flat_position)
	
	look_at(flat_position, Vector3.UP)
	if _can_jump and distance_to_player < jump_distance:
		_can_jump = false
		velocity.y = jump_speed
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		jump_timer.start()
	elif is_on_floor():
		velocity.x = 0
		velocity.z = 0
		
	label_debug.text = "direction:%s\ndistance: %.1f\ntimer:%.1f" % [
		GrannyUtils.formatted_vec3(direction),
		distance_to_player,
		jump_timer.time_left
	]

func _on_jump_timer_timeout() -> void:
	_can_jump = true
