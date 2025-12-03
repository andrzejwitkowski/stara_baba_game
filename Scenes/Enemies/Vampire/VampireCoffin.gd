extends Node3D

const OFFSET_Y: Vector3 = Vector3(0,1,0)
const VAMPIRE_CHARACTER = preload("res://Scenes/Enemies/Vampire/VampireCharacter.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_detect: RayCast3D = $PlayerDetect
@onready var link_player: LinkPlayer = $LinkPlayer

func _physics_process(delta: float) -> void:
	if link_player.granny:
		player_detect.look_at(
			link_player.granny_pos + OFFSET_Y,
			Vector3.UP
		)
		open_coffin()

func open_coffin():
	if player_detect.is_colliding()\
	 and player_detect.get_collider() == link_player.granny:
		animation_player.play("appear")
		set_physics_process(false)

func create_character() -> void:
	var ns: VampireCharacter = VAMPIRE_CHARACTER.instantiate()
	SignalHub.emit_on_add_new_scene(ns, global_position)
