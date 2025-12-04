extends Node3D


class_name FireBall

var _velocity: Vector3 = Vector3.ZERO
var _gravity: float = -10.0

func _physics_process(delta: float) -> void:
	if _velocity != Vector3.ZERO:
		_velocity.y += _gravity * delta
		global_translate(_velocity * delta)

func setup(speed: float, direction: Vector3, starting_speed: float = 3.0
) -> void:
	_velocity = direction.normalized() * speed
	_velocity.y = starting_speed
