extends CharacterBody3D

class_name Granny

const GROUP_NAME = "Granny"

@export var gravity: float = -70.0
@export var run_speed: float = 4.0
@export var rotation_speed: float = 2.7
@export var jump_velocity:float = 40.0
@export var double_jump_velocity: float = 20.0
@export var air_control_factor: float = 0.8

@onready var debug_label: Label3D = $DebugLabel

var _can_doulbe_jump: bool = false
var _is_moving: bool = false

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_handle_input(delta)
	_update_debug()
	move_and_slide()
	
func _handle_input(delta: float) -> void:
	velocity += Vector3(0, gravity * delta, 0)
	
	var rotated = _handle_rotation(delta)
	var moved = _handle_movement()
	_is_moving = rotated or moved
	_handle_jump()

func _handle_movement() -> bool:
	var input: float = Input.get_axis("move_backward", "move_forward")
	if is_equal_approx(input, 0.0):
		velocity.x = 0.0
		velocity.z = 0.0
		return false
	
	var direction: Vector3 = transform.basis.z * input
	var speed: float = run_speed if is_on_floor() else run_speed * air_control_factor
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	return true
	
func _handle_rotation(delta: float) -> bool:
	var input: float = Input.get_axis("move_right", "move_left")	
	rotate_y(input * delta * rotation_speed)
	return !is_equal_approx(input, 0.0)
	
func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y += jump_velocity
			_can_doulbe_jump = true
		elif _can_doulbe_jump and velocity.y > 0:
			velocity.y += double_jump_velocity
			_can_doulbe_jump = false

func _update_debug() -> void:
	var s: String = "floor:%s\n" % [is_on_floor()]
	s += "vel: %s\n" % GrannyUtils.formatted_vec3(velocity)
	s += "pos: %s\n" % GrannyUtils.formatted_vec3(global_position)
	debug_label.text = s
	
