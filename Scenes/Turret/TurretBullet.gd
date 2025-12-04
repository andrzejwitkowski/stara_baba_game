extends Node3D

class_name TurreBullet

@onready var link_player: LinkPlayer = $LinkPlayer

var _speed: float = 5.0
var _direction: Vector3 = Vector3.ZERO
var _y_offset: float = 1.0

func _ready() -> void:
	call_deferred("setup")
	
func setup() -> void:
	var grgp = link_player.granny_pos
	grgp.y += _y_offset
	look_at(grgp)
	_direction = -transform.basis.z.normalized()
	
func _physics_process(delta: float) -> void:
	position += _direction * _speed * delta
