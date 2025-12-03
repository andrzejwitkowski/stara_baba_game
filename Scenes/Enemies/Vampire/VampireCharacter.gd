extends CharacterBody3D

class_name VampireCharacter

@onready var running_effect: AudioStreamPlayer3D = $RunningEffect
@onready var link_player: LinkPlayer = $LinkPlayer
@onready var vampire_model: VampireModel = $VampireModel

@export var _gravity: float = -5.0
@export var speed: float = 1.0

var _vampire_ready: bool = false;
var _vampire_jumped: bool = false;

func _ready() -> void:
	vampire_model.play_walk()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	if !link_player.granny:
		return
	
	if _vampire_ready:
		if !_vampire_jumped:
			velocity.y += -_gravity
			_vampire_jumped = true
		chase_grany(delta)
		
	move_and_slide()

func _on_running_timer_timeout() -> void:
	running_effect.stop()
	running_effect.play()
	_vampire_ready = true
	
func chase_grany(delta) -> void:
	var direction: Vector3 = link_player.direction_to_granny(global_position)
	var flat_position: Vector3 = link_player.granny_pos_set_y(global_position.y)
	
	if !link_player.granny_too_close(global_position):
		look_at(flat_position, Vector3.UP)
		
	position.x += speed * direction.x * delta 
	position.z += speed * direction.z * delta
	
