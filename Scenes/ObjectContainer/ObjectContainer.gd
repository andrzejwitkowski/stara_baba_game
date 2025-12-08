extends Node

const EXPLOSION = preload("res://Scenes/Effects/Explosion/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_add_new_scene.connect(on_add_new_scene)
	SignalHub.on_add_new_explosion.connect(on_add_new_explosion)

func add_with_position(ob: Node3D, new_position: Vector3):
	add_child(ob)
	ob.global_position = new_position

func on_add_new_scene(ob: Node3D, new_position: Vector3):
	call_deferred("add_with_position", ob, new_position)
	
func on_add_new_explosion(new_position: Vector3):
	var ns = EXPLOSION.instantiate()
	on_add_new_scene(ns, new_position)
