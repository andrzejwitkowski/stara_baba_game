extends Node3D

class_name VampireModel

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play_walk() -> void:
	animation_player.play("walk")
	
