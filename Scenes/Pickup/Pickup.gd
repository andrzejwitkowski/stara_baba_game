extends Area3D

class_name PickUp

const GROUP_NAME = "PickUp"

enum PickUpType { Jewel, Key, Coin }

@export var pickup_type: PickUpType = PickUpType.Jewel

@onready var effects: AudioStreamPlayer3D = $Effects

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func _disable():
	hide()
	set_deferred("monitoring", false)

func kill():
	effects.play()
	await effects.finished
	queue_free()
	
func emitt_pickup_collected() -> void:
	SignalHub.emit_pickup_collected(self)

func _on_body_entered(body: Node3D) -> void:
	if body is Granny:
		emitt_pickup_collected()
		_disable()
		kill()
		
