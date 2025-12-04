extends CharacterBody3D

class_name Granny

const GROUP_NAME = "Granny"
const FIREBALL = preload("res://Scenes/Fireball/Fireball.tscn")

@export var gravity: float = -70.0
@export var run_speed: float = 4.0
@export var rotation_speed: float = 2.7
@export var jump_velocity:float = 40.0
@export var double_jump_velocity: float = 20.0
@export var air_control_factor: float = 0.8
@export var shoot_speed: float = 10.0
@export var shoot_vertical_speed: float = 5.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var tree_sm_grounded: AnimationNodeStateMachinePlayback\
					= animation_tree["parameters/Grounded/playback"]
@onready var shoot_bone: BoneAttachment3D = $Model/Armature/Skeleton3D/ShootBone

@onready var debug_label: Label3D = $DebugLabel

var _can_doulbe_jump: bool = false
var _is_moving: bool = false
var _throwing: bool = false

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
	
	if _throwing:
		_is_moving = false
		return
	
	var rotated = _handle_rotation(delta)
	var moved = _handle_movement()
	_is_moving = rotated or moved
	
	_handle_shoot()
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
	if _throwing:
		return
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y += jump_velocity
			_can_doulbe_jump = true
		elif _can_doulbe_jump and velocity.y > 0:
			velocity.y += double_jump_velocity
			_can_doulbe_jump = false
			
func _handle_shoot() -> void:
	if Input.is_action_just_pressed("shoot") and !_throwing and is_on_floor():
		_throwing = true
		tree_sm_grounded.travel("Throw")

func _update_debug() -> void:
	
	var s: String = "floor:%s\n" % [is_on_floor()]
	s += "vel: %s\n" % GrannyUtils.formatted_vec3(velocity)
	s += "pos: %s\n" % GrannyUtils.formatted_vec3(global_position)
	debug_label.text = s

func create_fireball() -> void:
	var fb: FireBall = FIREBALL.instantiate()
	fb.setup(shoot_speed, global_transform.basis.z, shoot_vertical_speed)
	SignalHub.emit_on_add_new_scene(fb, shoot_bone.global_position)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Throw":
		_throwing = false
