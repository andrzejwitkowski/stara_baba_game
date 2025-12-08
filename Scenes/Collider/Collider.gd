@tool
extends Area3D

class_name Collider

@export_category("Shape")
@export var shape: Shape3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _notification(what: int) -> void:
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		_update_components()
		
func _update_components() -> void:
	if shape:
		collision_shape_3d.shape = shape

func _ready() -> void:
	collision_shape_3d.shape = shape
	
	
func enable():
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)
	GrannyUtils.print_with_parent(self, "DamageCollider enable()")
	
func disable():
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	GrannyUtils.print_with_parent(self, "DamageCollider disable()")
	
func die() -> void:
	GrannyUtils.print_with_parent(self, "DamageCollider die()")
	get_parent().queue_free()


func _on_area_entered(_area: Area3D) -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
